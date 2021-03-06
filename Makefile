MSI_JSON_UTILS = msi_json_arrayops msi_json_objops
MSI_HTTP_UTILS = msi_http_send_file
MSI_ADMIN_UTILS = msi_unmount msi_getenv

MAKEFLAGS += --no-print-directory

LIBS = $(MSI_ADMIN_UTILS) \
       $(MSI_JSON_UTILS) \
       $(MSI_HTTP_UTILS)

IRODS_INSTALL_DIR = /var/lib/irods

.PHONY: all $(LIBS) clean

all: $(LIBS)

$(LIBS):
	@echo "--> building $@ ..."
	@$(MAKE) -C $@;

install: $(LIBS)
	@$(foreach libdir,$(LIBS), cp $(libdir)/*.so $(IRODS_INSTALL_DIR)/plugins/microservices;)
	
clean:
	@$(foreach libdir,$(LIBS), $(MAKE) -C $(libdir) clean;)
