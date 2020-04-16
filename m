Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E11ACFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDPSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:54:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35848 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgDPSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:54:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id s202so14243385oih.3;
        Thu, 16 Apr 2020 11:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FLSr4kGPuEbJKY+QTV34jKwDu9jUTkSr4T17fQnzqY=;
        b=buQ4mrR3vr6KK9Zp+4zVkqP9QxDiGNzjbFXp8bOwBoilKahdBqLE8QDSTrtP4es/um
         w8clua1hNLTXQr0+L97EuQIknV7rEy4QxWaz4P4ZaBSAWDlpph2H9WRSY7tj3Rgr1DbT
         FD2ax++t0sE+HfTc8RItRXxwgWAqo/8fyGxkYNugfNvkIG+G5AZ5cYWFqSwaz4R91CbB
         YpWN5F+Y1gPN4h6GXsfqAeMyXTL2307Zluw8tHjowbyXxF9t6fKKvj2hDTdaK99h6PLT
         zvD/wGs1AquoBW+7ps6lafg981wjugssML2eVaFN/08jXkdI655NeMQ6Gf0U0JyliSKz
         FmUQ==
X-Gm-Message-State: AGi0Puax6xeE5Ujb/tIO1f7Eufsp4HQu16ih5QwJ1v1ykJh4IJl16iCb
        auNuaLy1rfAzVgp07NPZBUztHdY=
X-Google-Smtp-Source: APiQypIT2vfeNc7zeTZYkSNiKr/fFh5/pKjrLBS+5zsvIsVjvPxMO/G5m6OscuE+a/UISomJPO9BLA==
X-Received: by 2002:aca:62d5:: with SMTP id w204mr3661413oib.119.1587063261583;
        Thu, 16 Apr 2020 11:54:21 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d84sm7339910oig.33.2020.04.16.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:54:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] dt-bindings: Add a minimum version check for dtschema
Date:   Thu, 16 Apr 2020 13:54:20 -0500
Message-Id: <20200416185420.20192-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema package must be somewhat up to date as the tools and
meta-schema checks are still evolving. Implement a version check,
so this can be enforced. This will help ensure new schema submissions
get checked against the latest meta-schemas.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1df680d07461..9f2e64e29d79 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,6 +3,16 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
+DT_SCHEMA_MIN_VERSION = 2020.04
+ifeq (1,$(shell \
+	printf "%s\n" \
+		$(DT_SCHEMA_MIN_VERSION) \
+		$$($(DT_DOC_CHECKER) --version 2>/dev/null || echo 0) | sort -VC; \
+		echo $$? \
+	))
+$(error dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION))
+endif
+
 quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
       cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
                         $(DT_EXTRACT_EX) $< > $@
-- 
2.20.1

