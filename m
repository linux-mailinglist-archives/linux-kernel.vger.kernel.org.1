Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B408C2678F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgILIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:49:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F52C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so2146073edq.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dw1Ylfivm/LIakXCeDCNCtbBlPy2BWgjC2cncXDgSg=;
        b=d3HDGUqFafr8t93XAAI+a3kLTsBxW6oIx1OhNIJCkF0UxTwVgwDsXrm6AkPQqdR8X0
         rHVn2HdhYXGifeBm14S0S6dswREBL46Yl61//96LzZWKKtmER0ZkTZAGPSUS+jJCv59N
         CEoCHSyPZlYSAzp0pRTrYUocL3RqUWbBIniLENhPwIhKx50jw4lE6UAlgc/5D6FYz/Rg
         dCv88Dc6Bn+tkWxKua90lV6QLTCBmx1lJhGKv+lChFApJyIbiSOg9zcgJgiUAwFkMf9W
         srPgiDOKaouFblAKVrTI9hCONvCwA8nfCKDDE5YMO2uguWbNOgMDSGlVTFz8NKC8Z40R
         cbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dw1Ylfivm/LIakXCeDCNCtbBlPy2BWgjC2cncXDgSg=;
        b=PxmGLBRg4lINlyd2/51DBirhYnNAeCQ09EzFx7lYTJOQtrabLuYR1FZ0KSseUd1t0b
         hWZJya4wFhi5VfDJ57JdbXXg2glFOPwnRhdAEG4nv9UPT6jGuLntcNEaV9uf5XFfjCfK
         /9CqBbc1LEB3paJw4gY4cf9tPzTe88BukO4GOW6DYIlH6l4NP8GgynyKhDTqKF7vDtNS
         xiDJd7d2xcwUyFWMJJA4LJ9DhMxRjiHDgf2hdxtmGJt0VEmoK3TlB6vEgDJvvugnUrt2
         lY0xCHPbtUM+QbL0J2ZpCMAIebYzHi4qet1Qe3epOOclUeK2maOX5FSzyZff1pkrAH3M
         bJyQ==
X-Gm-Message-State: AOAM533MYolA2ANSFEvCHWlITctTFqSP8LGlihhM0S5DHR1yacxOknZY
        yiXQdRdIx4NCSkyFecr9clQ=
X-Google-Smtp-Source: ABdhPJw3xgnvxAXdFIW3LzAlTSB2CRn6WLSdF04mUQb2Sgubl0bhtJrael0ti7sdzPTGm9JXmErQ9g==
X-Received: by 2002:a50:fd87:: with SMTP id o7mr6981205edt.180.1599900567615;
        Sat, 12 Sep 2020 01:49:27 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id s23sm4009598edt.10.2020.09.12.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:49:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: convert cckrates{only}_included to bool
Date:   Sat, 12 Sep 2020 10:45:18 +0200
Message-Id: <20200912084520.8383-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912084520.8383-1-straube.linux@gmail.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions cckrates_included() and cckratesonly_included() return
boolean values. Convert the return type from int to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 22e4305d70a2..7733d076af85 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -54,7 +54,7 @@ static u8 rtw_basic_rate_ofdm[3] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-static int cckrates_included(unsigned char *rate, int ratelen)
+static bool cckrates_included(unsigned char *rate, int ratelen)
 {
 	int i;
 
@@ -68,7 +68,7 @@ static int cckrates_included(unsigned char *rate, int ratelen)
 	return false;
 }
 
-static int cckratesonly_included(unsigned char *rate, int ratelen)
+static bool cckratesonly_included(unsigned char *rate, int ratelen)
 {
 	int i;
 
-- 
2.28.0

