Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323522F6815
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbhANRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhANRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:47:59 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68377C061575;
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so1469050wry.2;
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=svdu84/ElnlYtSiLtNgvB6KYAmxG2LhyvWU8NfyNke8coNVPKn3hW4YGJUTPRQQgUq
         OfG66nAI/Oldk8ptAE7zXfx6BHknix0rKlXYbXwekj/WFAUPYM0xs1CwpZRT6xlsBHEI
         HZx0nnLFyFB8OAMr5nIFe9Lfi1jg1tmdq1cmFIoyUurX8zNOdWL2oenyY+DLsexSy0xE
         WTK3FwxKKSJ87aAD4P9LZZFVsJXHruUr7hOYj1yL6fHN/RcOdiwmQr5/I4lMl/m0VJJE
         N4n+iHM6iO/A88P0WkqWYbcI1KH8gwACBjjUZlAhPsZ9uhUi3U1L+NYfjfgldWddhGNb
         2ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=l41Pj0QhZxwkQnZkxO2o4q8iDpDO+V4i8OFRmEgyMonwQKvc0rgutTBG03nUYfO1Qd
         W+sICxMRPtCtiM70tg5SD0Hac+KzyQ07xi9+GzAkczftaHem9t+UJisTwZugLAfzCmx1
         MVcgcsfrIVNI9v/5mYZn9FSpGZ5sUd4ldz9RNWP2elSzfjptsXssRa8RCYWKaT00Z6ck
         sR7TXr4hzPg2sj8XJDV7KrsDmJy8YEoHovmH77P198jpcibR6mnT0Gl3mqfNKugELV+U
         SQrY46tgugzsIFlNeJPtbD7pG8ulNauv7wsRubqC3Jz6Hj0mKEcfZuykEW07W08CHrdw
         wOsQ==
X-Gm-Message-State: AOAM530NQ5pj5Jl7dtWYcbPCyy/CCAgF8ueTLrVU7JMnDqfmmUFma0oB
        SmJRmmiQ7YJhaseMG8gkjrKRFRsrJUI=
X-Google-Smtp-Source: ABdhPJx8he/bKYBiu8rz/RLo8/zqjalIgYcXP5SKDmgtYC46+hFLUlE2jl9v+KPgn7wXrnAx86ZMdQ==
X-Received: by 2002:adf:d085:: with SMTP id y5mr9333000wrh.41.1610646437811;
        Thu, 14 Jan 2021 09:47:17 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:16 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 1/6] regulator: pf8x00: add a doc for the module
Date:   Thu, 14 Jan 2021 18:47:09 +0100
Message-Id: <20210114174714.122561-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pf8x00 module build was not documented.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/regulator/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eafa13be6e3e..ba8c09d90701 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -846,6 +846,10 @@ config REGULATOR_PF8X00
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
2.25.1

