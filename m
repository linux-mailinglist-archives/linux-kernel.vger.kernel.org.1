Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8902A3C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgKCGHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE1C0617A6;
        Mon,  2 Nov 2020 22:07:49 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id w13so8987270eju.13;
        Mon, 02 Nov 2020 22:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wZzzP42oR1wFOjbR/obXzKPXtaESFvyqabAu+OtZP9c=;
        b=ORxsZIWa28SAoCoDem+FxE1zCcXRCU998CQABTj9MmvAD58e8Cgp4vIzXDwLq5de9l
         RXAnRYLQVMN0d5oazb7ocAE/O09/Jbyh/XTmc6vWh6NOVd/FltYTX4AxRCRsMzn57uod
         7B2EQWbuJ96bf3m1DVAG//kKVrBnzGq0141czX3ZZ58IlU0CkOc9Fz06WILLHkfjJP+3
         +WSy2fzWnT8ynnPOc55vw7rHl1NEnvY/5o8ZWaZKKvjEx0l08ID0Gb33ane01c9Bnhs+
         iEguvoYIvjz+ft/GPM0SZbLLY/P9TRKZTNzR9z3mBzI6sSefEFtS/YVnMSNbwcktRSvK
         FYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wZzzP42oR1wFOjbR/obXzKPXtaESFvyqabAu+OtZP9c=;
        b=heMXXU99i5SBlIqAcA2IUvKY9SdbFSbEG1ZXRJteihS4Hv5ciCukJjfrpRzcPMTxu8
         kdBJValJ6src0FQT1tZjfKcPWIr1w3tv21+UJcnvyvG8GOPf3YflRpfEpdaMPh42qTZQ
         PfiPzY8gFX5rTu99pTc9RBkk5AmmBUJXmOe+Te2gsdYz1pOcFsuvQwYMQzrSIgegJFTc
         bo5snsIBkgxcWn9Gl6wPWk2HwDxshYn8ZqMWTOwG7mR3rKbRH0lq+wv5aIoDLXZ0PUyB
         +23h7FMU4Z1aj2ZcSFYZ4JrTOumSFpN5KFpapklOWhalIf4o+5dbUT9VkS9LWQBXhahT
         kUCw==
X-Gm-Message-State: AOAM532igLcbJXHgL6LehoSsKbO1DdArJjqh8SEmLw2YkjRUQX+NDh0a
        3URT2wIXCNSPBe8UEOCk2xE=
X-Google-Smtp-Source: ABdhPJzOiWqr2Yv/cL1jcFKDWfQYoYaT/YVgEF+7QuQOl8M7DHQFeGynUF+PNxlme7kY2EB7BuXQ0g==
X-Received: by 2002:a17:906:f296:: with SMTP id gu22mr13176896ejb.475.1604383668551;
        Mon, 02 Nov 2020 22:07:48 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dfb:4300:898f:a1f0:a069:8253])
        by smtp.gmail.com with ESMTPSA id f16sm4491478edw.15.2020.11.02.22.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:07:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: assign mediatek headers to Mediatek SoC support
Date:   Tue,  3 Nov 2020 07:07:33 +0100
Message-Id: <20201103060733.25729-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./include/soc/mediatek/smi.h and ./include/linux/soc/mediatek/infracfg.h
are currently not assigned to a specific section in MAINTAINERS.

./include/soc/mediatek/smi.h is the header file for definitions in
./drivers/memory/mtk-smi.c, which is assigned to the section ARM/Mediatek
SoC support in MAINTAINERS.

./include/linux/soc/mediatek/infracfg.h is the header file for definitions
in ./drivers/soc/mediatek/mtk-infracfg.c, which is assigned to the section
ARM/Mediatek SoC support in MAINTAINERS.

Hence, assign those header files to ARM/Mediatek SoC support as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Matthias, please pick this minor non-urgent cleanup patch.

This patch is part of an initial experiment to assign all files to
specific sections in MAINTAINERS. At the moment, about 3200 files are
currently not assigned to specific sections and maintainers.

If you think these cleanup patch cause more churn than value, please let
me know. Thanks.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4197e9da495..1703c7d2e146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2066,6 +2066,8 @@ F:	arch/arm/boot/dts/mt8*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm64/boot/dts/mediatek/
 F:	drivers/soc/mediatek/
+F:	include/linux/soc/mediatek/infracfg.h
+F:	include/soc/mediatek/smi.h
 N:	mtk
 N:	mt[678]
 K:	mediatek
-- 
2.17.1

