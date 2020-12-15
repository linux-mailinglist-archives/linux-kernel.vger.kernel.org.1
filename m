Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544C2DB7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLPABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLOX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:57:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF5C0613D3;
        Tue, 15 Dec 2020 15:57:09 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y17so21469094wrr.10;
        Tue, 15 Dec 2020 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PwNZTg9LKWSdxdKsvEzj/MNEwX1EMlLrbEaIJnpo7o=;
        b=P8yULOSUCS1hNrt1IF0H0hEmCw9Y3Fq1SOD3wDbGd+G7J20rundflaBIJOShHB7M9Z
         4qru4LCz/69pBMpf+uOXyE16s/KEcr6ZWhQS02oeTXya1LjNeXMk330NY3lC08GzsW1A
         HwgNw98Fp3VR1UfWP6ysX7qv6lu2XOvqcm+/wt1cH1qTm+6JVPjxqFitfu3RhFsXAQn8
         gaOOgo7GeRQ1KH5Wu7F/SDNjwbv/Web5dLJDPb8HCRSyRsxRSzonMka2VexKVZT3VqDr
         qWpH/S7WZLMVVaJ97zaqY78o1UVvy1aOo6jxVBOBUACTqex/Cb5XA1d5YPnMofvgvaex
         EDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PwNZTg9LKWSdxdKsvEzj/MNEwX1EMlLrbEaIJnpo7o=;
        b=Y8LtRgJMObfnxNZNUlIa5KAI3It7xRAdQ3fU8G7MoArJe5Na8rC6k/f1HY2caoosiT
         amF3Z17frptRN62b98svJ49raDeqas+SoG4oMsXdH9YaJabPZ9vEfDXh8pGAeWT2C0XM
         hjy2BOgJYWcGrlRP8mVg42buIURa23387A7pxM0WC2dLlbqbTdUwPuWS9I1SNIRQe8Er
         ms5vKiguqE6xBiMnhUJjPXppLb6kHDGrdlJ+unzY7jftoWOPlhjK/GLTozC4sR4Fl99i
         15v0mfvstvSWuCm+ExljkvW3Ycgt1PvoKvSdJH5ENl4J3C+7i5Zdkje9b9xVkL2HxrfN
         4hug==
X-Gm-Message-State: AOAM533KpE/4Btfs+RMBMyFdqPHwNVaMAylP9auJpqXcR77//En+dpJs
        LVP6qgo7cm1TwUmN7oXrjn8=
X-Google-Smtp-Source: ABdhPJyuC7lr1pGWXcEnDUcwWt5qbLChqyxbux0HocSSi1K14HODn7vYa5f3Qp4RS1RzxjqDpctSrg==
X-Received: by 2002:adf:916e:: with SMTP id j101mr36041850wrj.55.1608076628675;
        Tue, 15 Dec 2020 15:57:08 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:08 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 2/7] regulator: pf8x00: add a doc for the module
Date:   Wed, 16 Dec 2020 00:56:34 +0100
Message-Id: <20201215235639.31516-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pf8x00 module build was not documented.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 53fa84f4d1e1..9c6508e99fdd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -828,6 +828,10 @@ config REGULATOR_PF8X00
 	  Say y here to support the regulators found on the NXP
 	  PF8100/PF8121A/PF8200 PMIC.
 
+	  Say M here if you want to support for the regulators found
+	  on the NXP PF8100/PF8121A/PF8200 PMIC. The module will be named
+	  "pf8x00-regulator".
+
 config REGULATOR_PFUZE100
 	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
 	depends on I2C && OF
-- 
2.20.1

