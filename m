Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209322B34D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKOMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgKOMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:13:29 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1941C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 04:13:27 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so10975932pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5dZPl7jXnSFSYbfTyaVyvZNj6EIinzWYJTxmMOjfqKI=;
        b=AmjbtqgWmKKCvYlY5nlZsx3YB7DVAURWQ6z7fq9CrG29/TKoN6e09hCexb/cdRqUf4
         Up5zP7BtG2S9GL4M5cSNlSkyvmxEyVJkS5zo1difzwlV6jJ/2ncgFG1fP4K1FzliJDbG
         wI3AZMc1Qr1PzobQ8QXzXYUJJrExfU5tzDUSM9/3hZmBFwsVG2988YtafPCXMgsZQHzc
         YSZ12ay2lnsrWNXKuNmAko7s+IQ83XID5cgpUWvNN1RU4iuwPbjg8M09c5Fk2GP0Jfio
         AG1pNCf8TuDiNqilNGSpI5NkBBMcF6PAGddsRgv/cq33OuiWA/Q2QP/o0Hb3u6cX0NwP
         QMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5dZPl7jXnSFSYbfTyaVyvZNj6EIinzWYJTxmMOjfqKI=;
        b=Ns1xH/TtAQs/pozXSS74xmIubjj2XdK5W49wQe4zJ7IvkNrl2idKDvI8XTymklWA4U
         llRxF+eTLn8RnTxBwIReUanuojaDejSA7SH3UMGtXDuGUmKIe3i3DgOWG0EgraXEE8mF
         GeR8QacYZNH2dG4g2uyjP0Rva2KwcrXJzmQl1lwSdyirpjYppqwa3JNP/hvCSctXtvt4
         Uodfm0BrfDc5GOCb/ZVdyi+tpwI514t5VDyyjfvGr5etsnkqhrozTXbrWTfHzaPPLw/l
         2n8m1Awp1yWicdh8mkmwaqpx0LZwYbK/UOx37jIjPmO/V5oeL3w43i3AqUGWnM9InkiL
         YSHw==
X-Gm-Message-State: AOAM533iIPPZwsCLrcbLtEvQsXaJpU5PfZ+pglSEoVmdghm8BahOyfU5
        D0MfGjvgpoembr+Wm5hG8w==
X-Google-Smtp-Source: ABdhPJzrrP74in/fbuKbtE4HOXgwOnLrAKZjDfD/+Glyj10kaybl4dedO5OByyKX2fKJv8yk1QE86g==
X-Received: by 2002:a62:d11b:0:b029:18b:b3e:95aa with SMTP id z27-20020a62d11b0000b029018b0b3e95aamr9781427pfg.3.1605442407242;
        Sun, 15 Nov 2020 04:13:27 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id h8sm991456pjc.54.2020.11.15.04.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2020 04:13:25 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, shreeya.patel23498@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] staging: rtl8188eu: clean up the useless code
Date:   Sun, 15 Nov 2020 20:13:20 +0800
Message-Id: <1605442400-16108-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The two bool variables singletone and carrier_sup are always false
and the following if statement can't be true, these code are useless,
so remove them.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/staging/rtl8188eu/hal/phy.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index a970189ba8c6..a664bff370bb 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -1200,7 +1200,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 	bool pathaok, pathbok;
 	s32 reg_e94, reg_e9c, reg_ea4, reg_eb4, reg_ebc, reg_ec4;
 	bool is12simular, is13simular, is23simular;
-	bool singletone = false, carrier_sup = false;
 	u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
 		rOFDM0_XARxIQImbalance, rOFDM0_XBRxIQImbalance,
 		rOFDM0_ECCAThreshold, rOFDM0_AGCRSSITable,
@@ -1214,9 +1213,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
 
-	if (singletone || carrier_sup)
-		return;
-
 	if (recovery) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD,
 			     ("phy_iq_calibrate: Return due to recovery!\n"));
@@ -1312,14 +1308,11 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 
 void rtl88eu_phy_lc_calibrate(struct adapter *adapt)
 {
-	bool singletone = false, carrier_sup = false;
 	u32 timeout = 2000, timecount = 0;
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
-	if (singletone || carrier_sup)
-		return;
 
 	while (*dm_odm->pbScanInProcess && timecount < timeout) {
 		mdelay(50);
-- 
2.20.0

