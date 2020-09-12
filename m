Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCA2678F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgILItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:49:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E2C061786
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so16566449ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jdgvmur4zZ45shy8MlKtlFT8bpQMj/q3VfHaj2WJNPE=;
        b=eDU5O/puhfGxnYze7xTkXajmPZf3EA56I+qWGnb8jHZRBEya/uIol/2yMjcO0pl6lR
         UFg0RuOko3bON5y5dmyXzvWrAVxsrR+S5b9Uip6KBoZAgeZI8PyTrxG23pHjdvLHkT1y
         0nmHW9ZYjs0nFF9x0jigf0Rpl8bb6giL5DTbF5jI8bMphBFjqpFW6s4Y2R9C/PBHme27
         rXdH6sePNa5DN2qalcm+ovBp9MwoFAL774MoR3jFewfFrlt7SHT/aDiVZpoKykpUHg7Q
         Ml7kIIsepbXXDMZ+DsGYihI5ZbdcAiRoaYY+2/oKGBKRFuSCHlzRS+3j4P3lJbkS7rFL
         r28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jdgvmur4zZ45shy8MlKtlFT8bpQMj/q3VfHaj2WJNPE=;
        b=SsrHSEVc5UEgVbi7EWLEuSTqzB9xQFpne2WUiFQmz3gzl0NPpIPZbbJ6q1wx7OPwLy
         Y54FEq2kf7AIgO0KyHFAfb9w0eVhCXEFIi2zV9AmsiTHket68rn/zo4hUa+/ekqdidjr
         yJOpjDNbN5UtpMabMGA+doZNK5fAXB8i05fn4BnehzP9F72bBiNfUNRs0Vp8sjoIZU34
         1ZJDmc3kQKyU/dOpWSAJurWHvMWjSMpBMjpVJpBso/6KotDQT+TtDaCxEvuBg/j3ag2y
         CK0/Pz5QSdPu8OHYeMn23Yy+/ssmtN1wSbjg11rcQNZX/K+K+RHDDwpR6Zz2todbAbTB
         s+Sg==
X-Gm-Message-State: AOAM531SBKqCVuJsq/nL6CfjIK6WWGZlghYbHuRzf9GyoEMAbwmvBwHv
        SkvvG8Uv9lZQ7K8ribBq7Xo=
X-Google-Smtp-Source: ABdhPJzUwttHfYX1XD5UBc5FEBwkFlOIgJRwOQRm1RCTq4pLc5e4kkR4FYD0oBkRmdx1llR/HqAqdg==
X-Received: by 2002:a17:906:1e11:: with SMTP id g17mr5061731ejj.298.1599900570219;
        Sat, 12 Sep 2020 01:49:30 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id s23sm4009598edt.10.2020.09.12.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:49:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: remove 5 GHz code
Date:   Sat, 12 Sep 2020 10:45:20 +0200
Message-Id: <20200912084520.8383-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912084520.8383-1-straube.linux@gmail.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acoording to the TODO code valid only for 5 GHz should be removed.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Remove code path only valid for channels > 14.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 31 +++++++------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index cad35ce0c21a..fdb5a6b51c03 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1754,26 +1754,17 @@ void update_wireless_mode(struct adapter *padapter)
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
 
-	if (pmlmeext->cur_channel > 14) {
-		if (pmlmeinfo->VHT_enable)
-			network_type = WIRELESS_11AC;
-		else if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_5N;
-
-		network_type |= WIRELESS_11A;
-	} else {
-		if (pmlmeinfo->VHT_enable)
-			network_type = WIRELESS_11AC;
-		else if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_24N;
-
-		if (cckratesonly_included(rate, ratelen))
-			network_type |= WIRELESS_11B;
-		else if (cckrates_included(rate, ratelen))
-			network_type |= WIRELESS_11BG;
-		else
-			network_type |= WIRELESS_11G;
-	}
+	if (pmlmeinfo->VHT_enable)
+		network_type = WIRELESS_11AC;
+	else if (pmlmeinfo->HT_enable)
+		network_type = WIRELESS_11_24N;
+
+	if (cckratesonly_included(rate, ratelen))
+		network_type |= WIRELESS_11B;
+	else if (cckrates_included(rate, ratelen))
+		network_type |= WIRELESS_11BG;
+	else
+		network_type |= WIRELESS_11G;
 
 	pmlmeext->cur_wireless_mode = network_type & padapter->registrypriv.wireless_mode;
 
-- 
2.28.0

