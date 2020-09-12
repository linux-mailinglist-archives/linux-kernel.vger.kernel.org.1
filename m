Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC8267C48
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgILUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgILUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:48:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9CC061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so9396419lfr.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+vO3aXanl1nFthl3D75DmV+OYAyLES0i5j4W9OxAc0=;
        b=efg1UOI+FZRyM3b2QOAcXOibtQw/e5eTwnpfi64urVq5niHiX6Z3AAFzimcaJLlywR
         WZ1Iqs/cJ7a7r2Us7qNoTk1UbJxjevlTYDACWl3aIiL9hvtdmYTJ2uH3TRySQi2Z3gjq
         0f7AdtrwEMxsQb+dyxg243kkxOK+5Rv+M0xuhmhZDEbeERnc9FdDkjqli2aEigAbMfPG
         lLw5JHFNcVGICwaAdHy7RFH/mE0iwKo1X4m6TmyMgDXzbZ4OFA4UWv+QFRaesj0NNc2t
         r/97Bu+IetnOskuISnDhrE/VDX+D9wWHl98F/ub8fw0tVZYAsTxoskJBqglgJ/CZPQ7g
         twZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+vO3aXanl1nFthl3D75DmV+OYAyLES0i5j4W9OxAc0=;
        b=Oiuzwu85W3ktUApKjbn/3LTaRg467RXAhdqNMYhh6jZLPCsXYFYBayoYOE1dHmYDh2
         94RH08Q58MArwabe3T5uiYFsocMIoPXySuC/EYapHAFLWxtf2dBkZN6TzflpWFyBhYD2
         aj3znH6Jw0+ceLB91FKjByEa+gPDtE2UEUqeBs917XkPaEMNBa+5/W7dOvlleL/BAz+p
         ZP9NfDilYXhsSbWZHmmMFhmDoXUE/IUv/q2Hu36XdnS/QD3zRSH6oLb+mm7OfSxbq58F
         9d0yr4o7OsNmugUVuXysoNYjzEmjGuE9O1VhP5mV+SVxmMXOY7VFHDtrAMOOo+oHzsMM
         KimA==
X-Gm-Message-State: AOAM532oVB4uHmVEOYpYOaCPgpgiEplrcgn+2T0xcBc6OqtWWPh5XO7+
        7ZfitCxnKDqejseEmTvOVcc=
X-Google-Smtp-Source: ABdhPJxENQh43gHrpNCWOhxMJCKepku5trU+mDzrdtSTJkiZXOx9YmcxdHlPCdzrDODIrITwDt5YAA==
X-Received: by 2002:a19:89d7:: with SMTP id l206mr2811958lfd.110.1599943730715;
        Sat, 12 Sep 2020 13:48:50 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r7sm1729753lfn.84.2020.09.12.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 13:48:50 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] phy: cadence: salvo: Constify cdns_nxp_sequence_pair
Date:   Sat, 12 Sep 2020 22:46:38 +0200
Message-Id: <20200912204639.501669-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
References: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns_nxp_sequence_pair[] are never modified and can be made const to allow
the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 8c33d3215f2d..88e239adc3b8 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -97,7 +97,7 @@ struct cdns_reg_pairs {
 
 struct cdns_salvo_data {
 	u8 reg_offset_shift;
-	struct cdns_reg_pairs *init_sequence_val;
+	const struct cdns_reg_pairs *init_sequence_val;
 	u8 init_sequence_length;
 };
 
@@ -126,7 +126,7 @@ static void cdns_salvo_write(struct cdns_salvo_phy *salvo_phy,
  * Below bringup sequence pair are from Cadence PHY's User Guide
  * and NXP platform tuning results.
  */
-static struct cdns_reg_pairs cdns_nxp_sequence_pair[] = {
+static const struct cdns_reg_pairs cdns_nxp_sequence_pair[] = {
 	{0x0830, PHY_PMA_CMN_CTRL1},
 	{0x0010, TB_ADDR_CMN_DIAG_HSCLK_SEL},
 	{0x00f0, TB_ADDR_CMN_PLL0_VCOCAL_INIT_TMR},
@@ -217,7 +217,7 @@ static int cdns_salvo_phy_init(struct phy *phy)
 		return ret;
 
 	for (i = 0; i < data->init_sequence_length; i++) {
-		struct cdns_reg_pairs *reg_pair = data->init_sequence_val + i;
+		const struct cdns_reg_pairs *reg_pair = data->init_sequence_val + i;
 
 		cdns_salvo_write(salvo_phy, reg_pair->off, reg_pair->val);
 	}
-- 
2.28.0

