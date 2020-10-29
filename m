Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB829E89F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgJ2KKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgJ2KKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:10:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E50C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:10:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b19so1078507pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGMOrUlHOVv3WQBDnsetUi78s6Nj3dKezBdxOEfVgM8=;
        b=mA9kePlJBabjPKZbIb/EDJcnKDwa/GKf2lKIY+ctV6dJzO2POuInVg+nEnghRSQJEw
         PA9u0oVoWKX3y813bAoiYzgQaNmIIP2zKPOLTIvO+52FjiptiLz+ZKZvxvD8HL6UUuvQ
         D2dMrHc/YUiszoGDwZCvRMLHGXevOApX6oUt7zVQdjUapTno9elFz9GxJ3wAFY5nDSTr
         xLQlaX7aLe0Y96znGsqIFBk/MaNZm6hf4lxyHE5smNY+5UIBIkKTQIEJ6hrK5KG51fc8
         159qYZYPK1IJiWRkg8ntCtd6GwM1qlR7yakseHT8jGudcN0CGopy35GiDKvdNmY+ndPE
         eoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGMOrUlHOVv3WQBDnsetUi78s6Nj3dKezBdxOEfVgM8=;
        b=pK2rq53wKHKAMxt8QQAu7wQZrKTbVVd/fJM/RBXl46Wgt8whSmkmsIRqmIFOS23d5S
         C+MRyronIulY1wvVi42zWiObY/4lZfsYCRsHqUCh6NMb0DynXGOPN/QGoQIhEqA2bBnX
         sxbM5LN/NRLY86GOnbLHct1b8okeT1bbYZgmo1CO5ApdAERtcOaZZQGeR4S5rip1U27B
         HwUuDRhVEcP73/NAItdVpmwTguhbv16KKzOyZaGskPW/L3dwNjit+LhOhgYPDkzi/ttG
         BKUz4FbnkMor6UEG0Af91mJMYMFJ5KdYXynSLjt63VN0Ab1YeQ6IXlmwv6cD3Qlp4hCu
         XbAA==
X-Gm-Message-State: AOAM530fMOifENlU+xZB1L101NiEH0a1JDAKaub1952bT/iWZTlaIPHF
        5Dl3soagsXB6CEd2jtfbon/ToI18hNPdgHfX
X-Google-Smtp-Source: ABdhPJzt/r4B0ato3PHpYtx7uy5beaRoLXMyQZ9M8TL2Ce0RCul+HLT5I2qs5uJfSt8oe1v9ExENOA==
X-Received: by 2002:a17:902:fe0a:b029:d6:aa7:5220 with SMTP id g10-20020a170902fe0ab02900d60aa75220mr3235196plj.16.1603966238352;
        Thu, 29 Oct 2020 03:10:38 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id n6sm2059684pjj.34.2020.10.29.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:10:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: staging: Fix spelling in comments
Date:   Thu, 29 Oct 2020 15:37:59 +0530
Message-Id: <20201029100759.21668-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two spelling in two different comments.

s/defalut/default/p

This is in linux-next.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 1af919ff6d93..391c59490718 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -52,7 +52,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 	 * The base index =
 	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
 	 */
-	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
+	dm_odm->BbSwingIdxOfdm = 12; /*  Set default value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;

@@ -109,7 +109,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	 * The base index =
 	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
 	 */
-	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
+	dm_odm->BbSwingIdxOfdm = 12; /*  Set default value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;

--
2.26.2

