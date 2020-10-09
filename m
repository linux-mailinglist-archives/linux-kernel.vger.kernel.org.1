Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53292288F90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389963AbgJIRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:06:02 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43400 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389529AbgJIRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:06:02 -0400
Received: by mail-ot1-f47.google.com with SMTP id n61so9603520ota.10;
        Fri, 09 Oct 2020 10:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hahw4Z+pkoPGKYqMxdiIRA4sO3mk0rSthtnfTsKHy7k=;
        b=UdeL3tGFgx8Kvmz08I3+m4QfCRologaggI9T5ZDlD68vjXAnge6k0YWrouUPzx+R/I
         EuduGG0WQJx6dJxsmTXVADkY52wIbxkfGUvklcLdRwjT6qqDiytm/aX39+bckZlpw72U
         Ae+QhDSc6SuvQdvJQ263NvpJWvTfJVh2PLLcHaLaqomrbU/hIAs5eyFRES8Hpvqa41Fd
         FPIIL93uu1lx5AG7NApb+sF+MfSPmMNe33Zr5jawTzhj6tgKj4fJ0EtejVVn+m9KiWdr
         NKbdcpubJIYiZSjojShaDTnN3ryrWhOONqAexPoR3V1KNNhOnDoA6Xv8W+XMYg8UbdEV
         +Zyg==
X-Gm-Message-State: AOAM530VTA5zIUcDYAzbt8ZktNZFvfRM438my0fZ+cbXgP6em9YzXpWo
        HK9UQsVDK6GkSPzUjdRcXeQ3xWQXC/cd
X-Google-Smtp-Source: ABdhPJywwcCYWZfZPtwXKX6Rg4+wSmBerOuOFejivO7kYf/2E44i9IRn8BCFPP9dYkJL9fi1kgovhw==
X-Received: by 2002:a05:6830:1f4d:: with SMTP id u13mr9075478oth.184.1602263159959;
        Fri, 09 Oct 2020 10:05:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r188sm167207oia.13.2020.10.09.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:05:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Add running yamllint to dt_binding_check
Date:   Fri,  9 Oct 2020 12:05:57 -0500
Message-Id: <20201009170557.168785-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a yamllint config file and support for running yamllint on DT
binding schema files. This runs on the whole tree as yamllint is Python
and suffers from Python's slow startup times.

Users can run on individual files doing:

yamllint -c Documentation/devicetree/bindings/.yamllint <binding file>

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/.yamllint | 39 +++++++++++++++++++++
 Documentation/devicetree/bindings/Makefile  |  9 ++++-
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/.yamllint

diff --git a/Documentation/devicetree/bindings/.yamllint b/Documentation/devicetree/bindings/.yamllint
new file mode 100644
index 000000000000..214abd3ec440
--- /dev/null
+++ b/Documentation/devicetree/bindings/.yamllint
@@ -0,0 +1,39 @@
+extends: relaxed
+
+rules:
+  line-length:
+    # 80 chars should be enough, but don't fail if a line is longer
+    max: 110
+    allow-non-breakable-words: true
+    level: warning
+  braces:
+    min-spaces-inside: 0
+    max-spaces-inside: 1
+    min-spaces-inside-empty: 0
+    max-spaces-inside-empty: 0
+  brackets:
+    min-spaces-inside: 0
+    max-spaces-inside: 1
+    min-spaces-inside-empty: 0
+    max-spaces-inside-empty: 0
+  colons: {max-spaces-before: 0, max-spaces-after: 1}
+  commas: {min-spaces-after: 1, max-spaces-after: 1}
+  comments:
+    require-starting-space: false
+    min-spaces-from-content: 1
+  comments-indentation: disable
+  document-start:
+    present: true
+  empty-lines:
+    max: 3
+    max-end: 1
+  empty-values:
+    forbid-in-block-mappings: true
+    forbid-in-flow-mappings: true
+  hyphens:
+    max-spaces-after: 1
+  indentation:
+    spaces: 2
+    indent-sequences: true
+    check-multi-line-strings: false
+  trailing-spaces: false
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index ec8073cb2e71..f50420099a55 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,6 +3,8 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
+DT_SCHEMA_LINT = $(shell which yamllint)
+
 DT_SCHEMA_MIN_VERSION = 2020.8.1
 
 PHONY += check_dtschema_version
@@ -24,6 +26,10 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
+quiet_cmd_yamllint = LINT    $(src)
+      cmd_yamllint = $(find_cmd) | \
+                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint
+
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = $(find_cmd) | \
                          xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)
@@ -37,6 +43,7 @@ quiet_cmd_mk_schema = SCHEMA  $@
 		      rm -f $$f
 
 define rule_chkdt
+	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
 	$(call cmd,chk_bindings)
 	$(call cmd,mk_schema)
 endef
@@ -48,7 +55,7 @@ override DTC_FLAGS := \
 	-Wno-graph_child_address \
 	-Wno-interrupt_provider
 
-$(obj)/processed-schema-examples.json: $(DT_DOCS) check_dtschema_version FORCE
+$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
 	$(call if_changed_rule,chkdt)
 
 ifeq ($(DT_SCHEMA_FILES),)
-- 
2.25.1

