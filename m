Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C22F575E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbhAMWb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbhAMWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:21:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DCAC061786;
        Wed, 13 Jan 2021 14:20:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so3746255wrb.12;
        Wed, 13 Jan 2021 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=qB1AqFISSnQ4XVQAnERYtklKDmYAuzzTq3KK7dYax4/RSzrWXePRReHZTFP3kJc25q
         wnafc1VxATDfLPHttUxPXKU0474oFoyLeb9nG/pn1UzNOnTY7ux/oW3KHCOsmLrSfZ98
         Fy8RMdardHim/IcLYGDEJYKd7D3u7fJCOHoKSfZlsIgx7KDp3qBTcxF76+0vQ3yc8/nb
         SIzsdffYzIxY0VxgPdGlzJng3RQzOzdvuFa+daKum/IYh3MLT8Vcsymg5FLx0oHeTBqI
         UiNJTWjGngsEtJaI7b8bSp5zqWp/FptZDDWBzjdRRnDZJuemx8d6eKLHczWWFfUZEQCJ
         n6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=YbyGz5RNYtJyOW/cU5DrXza0eMApMeoYYpbg3TjeAnHbr0Ku4h/nx2DunWAGRjTFzX
         1QfIpksqjFtXeyK5gMEZHyWZakO7sQRXj91y9ouksSYV1T/owZR/7s8Up9GUd2zEEdvc
         9nmL6Gay+60ydiD02gcLUfaBFEY9RQbncQkFy0W/nu4i1vdaH6u2g/G8jm5WY7qWbrCy
         Y63aZe1qe0DiuMWbVczwFFRiRMgsuEQAbt/eDz/LJVlTXQUQYtoIxw7s+mpe0P3YyeOP
         PwJ+PAuW/yeibNCW3CKmq0hau3kp8If4RCKR7UwxS1IfPjwi3G42V6hHL4dKS5esOQzv
         QvBA==
X-Gm-Message-State: AOAM530DtChOzfAIiDyVFsewbD9LTnovhmWkU1aK1ahO0JGq5jIh0Yqf
        XUz+VN+cIGzt14AuWG9wajDRdDOawTM=
X-Google-Smtp-Source: ABdhPJzlkwd4LnPR8AMzxeXYoNePumKZK7rPFnb4by2DgtM02PqWsNG2wPSXerYIG32W0nVXK+uqjw==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr4620379wrp.116.1610576420235;
        Wed, 13 Jan 2021 14:20:20 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:19 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 1/6] regulator: pf8x00: add a doc for the module
Date:   Wed, 13 Jan 2021 23:20:11 +0100
Message-Id: <20210113222016.1915993-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113222016.1915993-1-adrien.grassein@gmail.com>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
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

