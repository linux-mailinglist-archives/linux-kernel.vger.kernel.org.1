Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16982DB576
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgLOUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgLOUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:50:01 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90438C061282;
        Tue, 15 Dec 2020 12:49:03 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so490100wml.1;
        Tue, 15 Dec 2020 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PwNZTg9LKWSdxdKsvEzj/MNEwX1EMlLrbEaIJnpo7o=;
        b=D1mUxIJU9LScpQN8gbk7h1zH4Hv3DMKJpHX4p16LNkDCJ3jfPWY8pfFO9x93x+AK3h
         mwWt7iasis7/h/62xzHGoksgSBz2L+WezgMcDBmDx/Ts9oFqaPaHMYPKhxA7CLD4Mgta
         iJNSwXMkw3kIBvWVOb95W2qzAZK7ucoURWeAvLh4FmlOgZu+wvY5D+/zrqUK1ug4Mi0G
         mi69OtmkSLyYxl7qvZJy29yO76XdNwiCbjLTkxWDXf6kN4xbCqPl0M8nfoImK+B38P/F
         1fLtdoHIHe8OoKyvqqwSTEOFJxW3Ds4pWeM+wcUyjZUGiZNmUfybbCiDkiBUDpymVMn7
         BDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PwNZTg9LKWSdxdKsvEzj/MNEwX1EMlLrbEaIJnpo7o=;
        b=hvQ4Bk61An/0O8dXOPmIZo5lyLw0WD7sD41SgsnC++pfSCVplyFRCi5WB0eUs2XIZa
         qIm9FE3/Qkd/+J/OLMiBQQ+NLhBMVdJMRzKtJW4Lw1cI5lbPeu2YQGC4YkBMMDL7lDYA
         1j51Rb2/FKVN/vr6jrSOqV1Wga9ctM3DSyWgi0JXf5Z8ohcMuSq5DMfLZ3hG470aRRbq
         BsOiFOb4WX1kS2SF+qMM7XAxVQCnhw1vBxth3CJ9zsvUuAYqqMxbpDA3WFmHjuTIHdGg
         Q62c0EPb1YPvbH1p7zzfsM0kvmGfOV7lXftbUynJgZ53Rdbl4npZTbY/RR122WHTOuwn
         v9MA==
X-Gm-Message-State: AOAM532PBbIdS0VlcgSNHyDoEuRFZqprL5e6LtyZ2EQqpSpFRJdcMfru
        ZaUwjHj1HXbf50gZ6H7vrfM=
X-Google-Smtp-Source: ABdhPJxlsJUvszlJhVwegajuG/KApGNtUqGf+lokTW4+NfRDLs2xWu3o2/0fzRihUkhPh5Fi4Xii2g==
X-Received: by 2002:a7b:c24d:: with SMTP id b13mr554871wmj.151.1608065342267;
        Tue, 15 Dec 2020 12:49:02 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:01 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/6] regulator: pf8x00: add a doc for the module
Date:   Tue, 15 Dec 2020 21:48:54 +0100
Message-Id: <20201215204858.8186-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215204858.8186-1-adrien.grassein@gmail.com>
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

