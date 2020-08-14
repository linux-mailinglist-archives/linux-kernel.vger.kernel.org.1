Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5B244E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgHNRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:34:28 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35118 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgHNReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:34:21 -0400
Received: by mail-il1-f194.google.com with SMTP id q14so5670246ilm.2;
        Fri, 14 Aug 2020 10:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3l69ln56x0NYyOcK12UG1i2L2ctArBHsZcQkVLntWAw=;
        b=JvZNKUX7ajrYA2652rREivlZ8aaAX3pVh7wumpmDnTZb40OA7x8phwhSmG4eeSnTia
         gZCr0hUWwNQuLCXgq2110bz0t213BGc1QD44r8vUh0I4+hyLm0XhmbpERI8e8r1xJF5x
         XlCxaczngeGZoziPqtYs5Sph/uy7veLEN9xXQwQ5lwrIBcJ7IALpMupV0JeHyRqpvWfH
         8YyUP4FH8ssudqW4vICc/gftQtApg4hAtCRHVatQipcp763TXtNfp0owMKSQCPmNNft+
         LrarsoZkmfEc7V5+eOMQX0JZNg+GnKoCd/tJiv/lHIEMFAuzaFXUt7j6KtyaGdWFATx7
         Y7DA==
X-Gm-Message-State: AOAM532m3RX7ZCFuGd2xh4DMdG0Jdnp7DZuUMd7QI1FmBGSa7PFH0K+p
        Nf9rGAAbh/ujFF5pzm6i2TGWu7fRpw==
X-Google-Smtp-Source: ABdhPJxxLL7yRNC36Ygm+ALbPdp7Nw/SGCafVwq2SvEv8AZIF9Noh/jTuBedxyPaerDZjL+LJs1TIg==
X-Received: by 2002:a92:874a:: with SMTP id d10mr3423940ilm.273.1597426460524;
        Fri, 14 Aug 2020 10:34:20 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id x185sm4637575iof.41.2020.08.14.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 10:34:20 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] dt-bindings: Bump minimum version of dtschema to 2020.8
Date:   Fri, 14 Aug 2020 11:34:15 -0600
Message-Id: <20200814173417.2322509-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814173417.2322509-1-robh@kernel.org>
References: <20200814173417.2322509-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtschema release 2020.8 gained several additions to help performance.
dt-doc-validate can now take a list of files and directories, and
dt-mk-schema can store the processed schema in JSON which is much faster
to parse than YAML. Utilizing both of these changes results in a 4-5x
speed improvement in running dt_binding_check.

There's also additional meta-schema checks which binding schemas should
be checked against.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 91c4d00e96d3..6a678eb5b5cd 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,7 +3,7 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
-DT_SCHEMA_MIN_VERSION = 2020.5
+DT_SCHEMA_MIN_VERSION = 2020.8
 
 PHONY += check_dtschema_version
 check_dtschema_version:
-- 
2.25.1

