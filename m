Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5B2BB875
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKTVil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:38:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46615 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgKTVil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:38:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id q206so12028292oif.13;
        Fri, 20 Nov 2020 13:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYV2kk3tvpuQCVqfVzLK8l6soHLO9jULYGr+komGn8Q=;
        b=ApOg0bbKKaD6pkkokk8c25+rVjVJlv2pgBgjoE/2o0vZfgoQYiiqBT2k8U9vlRABJH
         +VTzM16MtbWK/GSbhv6mm62oA9pYhqsvgKLR6hDL2G9tgimI80VmR9FCpanVB49Esbvp
         3W7Yo/5w7hPZrt0HN+dngOkr84vQNo6kGwP/OtiDpYW4TUgGE9emzWv+ELqpy8B/TFIf
         XXZgKEefkZSA1zI9Ql03icNaYx1ry6DdwCs87UMGLHr6iz06uVRBYOLrwM4DyfuF7qmV
         qC3c2z/tG8vfHTzz5xEb5si4gGV1NNUnyfOhx5oVmqbZLJmq6RvLq4eWTZSNJ2MPzLnS
         TipQ==
X-Gm-Message-State: AOAM532IUmR53/bLrpatwnaletf4JqoQ6QpPtpIlAs7qOkTuEcrYM1Ss
        LSqjSGZNjYlhEmIQt0zVAuEO2xYyMw==
X-Google-Smtp-Source: ABdhPJzGL8+jfmjxt6ehwi6wn00PI4PNomaGZkg7GNzCMHyWglCpZg2OSC6ArbJ1NaUmYhpBlrw9Mw==
X-Received: by 2002:aca:3a43:: with SMTP id h64mr7447050oia.73.1605908319708;
        Fri, 20 Nov 2020 13:38:39 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c18sm2175620oob.45.2020.11.20.13.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:38:39 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Don't error out on yamllint and dt-doc-validate errors
Date:   Fri, 20 Nov 2020 15:38:38 -0600
Message-Id: <20201120213838.1801556-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A broken schema file now causes make to exit and 'make -k' no longer works
now that dt-doc-validate is called from a single make rule.

As yamllint is optional, we shouldn't stop on yamllint errors either. Also,
it seems some old versions of yamllint don't work.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index f50420099a55..285d814369db 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -27,12 +27,12 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name '*.example.dt.yaml' \)
 
 quiet_cmd_yamllint = LINT    $(src)
-      cmd_yamllint = $(find_cmd) | \
-                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint
+      cmd_yamllint = ($(find_cmd) | \
+                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
-      cmd_chk_bindings = $(find_cmd) | \
-                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)
+      cmd_chk_bindings = ($(find_cmd) | \
+                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
-- 
2.25.1

