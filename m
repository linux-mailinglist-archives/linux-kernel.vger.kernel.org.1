Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5962678F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgILItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgILIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:49:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE365C061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t16so12667653edw.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSthICaxogmtYPZILEJBq63RkXJbSw500dA6isem7pI=;
        b=Jkuy6aY7YCzAdzLWshANNuiqPg1ToOPWlzBSlvOjyUwbwbW1qz4naHcfIKkQUguJxJ
         chKkIbCtGTq4/+9XOTKtbfIeWnSInsxdZMlm+XGJepKMmb81IEqcUt2LLuOQrwcvMQxt
         LZGRbsBrgjdRODQcAWuofhZ2iDfuxWxXbgl1Sh7fUxmOv+oSkJNxzYMO1UzUhXRYUBGN
         p3ekd6oCiNwrwPI5eHqRDShPi0z127iSe10jO/AEvpmf+a7UgGeOhyD13cad3wGdBVS7
         kjmu0jMHRyscYQfnuP1ABiaJ+lheV3yFl1i3lNuxQkMaoysdGNnh+vAZtnbNGuPKAzu9
         e0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSthICaxogmtYPZILEJBq63RkXJbSw500dA6isem7pI=;
        b=g85fANzeNJZw864yGJXjiZio3XksknMOBXiVey6CXmZDVDlz5yOv/9E6zCNW7sd9aE
         WvSp3/1r6T+lBduxtk5e25sJeWgmzcKvNogOtTcdC5DTWYM0clqGnSowLcxxG44CQe9K
         XKzOTaRyJ3kukiBWOHoHkfnr41J/bZfHoUpG94T5bIPxF/zf2XwvzNXfCed/uAK5O5sj
         vMAuifeFzc5A+NuwZBH8dc/CtExKQoWytiIkuNSeXPhuH7KfpZJQUx/pSR6Ak4wiYXMj
         0YmMY9qIU50EIaPdLF8TiEXEP2RYS1mlnJoS7UeiKFjPL9frgZqPSdsLrG8HMaxaS7vG
         fvig==
X-Gm-Message-State: AOAM533W6/GVnakeKTGK/fcNvUp16UPGuCoyvZLealR38r+187HPFH+e
        daCwxMpn+TJWS/dfJb2KWrA=
X-Google-Smtp-Source: ABdhPJz3ddQfeeIQumdSV7kdW/fmchul1r1nb8YkIgNFKa2fxAVMn4ZZht4d/MTbF/JVUuQlW+lgUw==
X-Received: by 2002:a50:bb65:: with SMTP id y92mr7074411ede.53.1599900566531;
        Sat, 12 Sep 2020 01:49:26 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id s23sm4009598edt.10.2020.09.12.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:49:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: make cckrates{only}_included static
Date:   Sat, 12 Sep 2020 10:45:17 +0200
Message-Id: <20200912084520.8383-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912084520.8383-1-straube.linux@gmail.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions cckrates_included() and cckratesonly_included() are used only
in the file core/rtw_wlan_util.c. Make them static and remove extern
declarations from include/rtw_mlme_ext.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 4 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 4e0d86b2e2e0..22e4305d70a2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -54,7 +54,7 @@ static u8 rtw_basic_rate_ofdm[3] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-int cckrates_included(unsigned char *rate, int ratelen)
+static int cckrates_included(unsigned char *rate, int ratelen)
 {
 	int i;
 
@@ -68,7 +68,7 @@ int cckrates_included(unsigned char *rate, int ratelen)
 	return false;
 }
 
-int cckratesonly_included(unsigned char *rate, int ratelen)
+static int cckratesonly_included(unsigned char *rate, int ratelen)
 {
 	int i;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 14583799039f..1567831caf91 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -716,8 +716,6 @@ void sa_query_timer_hdl(struct timer_list *t);
 		DBG_871X("%s set_sa_query_timer(%p, %d)\n", __func__, (mlmeext), (ms)); \
 		_set_timer(&(mlmeext)->sa_query_timer, (ms)); \
 	} while (0)
-extern int cckrates_included(unsigned char *rate, int ratelen);
-extern int cckratesonly_included(unsigned char *rate, int ratelen);
 
 extern void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
-- 
2.28.0

