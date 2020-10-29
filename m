Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6829EA20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgJ2LJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgJ2LJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:09:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D72C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:09:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so2044218pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqDb9D/f2X2CP3Fkvj1zCMZxt9qstXFPqe7a7lWneE8=;
        b=Grnvl7CuBCAfvlzWxd3nbOUHfAwhikzkCx+olXgx09UATM/lpavPXOFURMYdII+Ni8
         tTg/3gWdwS96cnUsRcgJK93WEVVTIhY1POEo+rkE1oQd+L3u5lT/B4VqJzFpUB2Q7Esa
         Qs8l9rBv6JeHKkO583uLHywraQXmMpEaIl8MLX35eSm5DMIPP3RoiU2IvCKAGHzlXppa
         ZXfN1UhY+3fRNdtCPXpqAT9Vbwc+13M2dBUUujp8EHeUF6eogNyeXw+iC5P5QUrSXG7k
         WF9m0cecYHoqkSs/o4qIRYkaOzQvu3oKKc0FxFanrj/zcNKFO9EtLBWLH07wLKlExmjB
         840g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqDb9D/f2X2CP3Fkvj1zCMZxt9qstXFPqe7a7lWneE8=;
        b=WuknaaLnWcR2SvFuhW9RZEDjGG01H6ge0b+W7tPbW0QnAoDMeC5L109cHptDvQ/Pue
         lD2U1/fBqoqUfE1VJWb/u8aj98eK5LSCMwVVLwSWKpnRE+P55EoN1arEUd6GPSedLbNT
         WsVG4IWRFxzFa+20WtWT++OD0AnowcMmxCogkiyBjrfFoyRS5QI/8cmBPD3PFD6SJRtH
         LEbUXuihemqBLgpeQGQSsR/3cW/1j8cuBGKC+sknwOu0ZxI1d5ZIFWkUrfo9cuye14wb
         /8yPkMDgVbLIIrStrWxFnuwvGMn0sJ9iUeFcx/xiylHuLKa8qSwVyzI8aYbig2N8I3QE
         8lVQ==
X-Gm-Message-State: AOAM5310EiD8MNpq7RNzGcCdUp/reSXHpTH9p1rlu9tvNHzWWoPS0f+1
        5ZtjvGXKqGW3JqD94632ZkE=
X-Google-Smtp-Source: ABdhPJymO3U8DMeuTV/Y/5ltTePE+K+hLbGfL/aHp/YOMaxhbrrFDMPELIQGjjuCvFUevmwZ01jXcw==
X-Received: by 2002:a17:90a:34cd:: with SMTP id m13mr3930815pjf.201.1603969764443;
        Thu, 29 Oct 2020 04:09:24 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e5sm3021697pjd.0.2020.10.29.04.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:09:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: staging: rtl8188eu: Fix spelling in two comments i.e defalut to default
Date:   Thu, 29 Oct 2020 16:36:00 +0530
Message-Id: <20201029110600.3091-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two spelling in two different comments.

s/defalut/default/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Greg, I have included the driver name as you suggested.

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

