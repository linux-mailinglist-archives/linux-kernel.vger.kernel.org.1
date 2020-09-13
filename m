Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD526803C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgIMQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgIMQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:25:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BAC061787
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:25:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n22so15270269edt.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3zCmgxorbQQmGIZIsq6TgsZ3TNFWxay30dLGKDvyQo=;
        b=KhMFRZ9YRS4UjN4jRA/2rdCl8MKC2fzGsFZuAtLIh2rXnvVaTjwnpId4hbKagB01MR
         rcF65+LTAHOJhUH60Vkw23rrOLqAW3ZcmGSYIAZN1sx/9n4pIsltKZ13eZVVBZVxJZMY
         FLi/hBOd7DrcLzTLvJCmrXQqe0OHa7Xur//F5ojWqnmr28gS8TM+xIWo09mZoev7+OoT
         ENuhrDiUkvTIeAno2iW1Wi5OD/TglhObymR8j4wmyFDiblYJ1EU0jvFrhNyqRrYN9jLs
         KE6GSM59MyZQLjU/PF7EU63Rwzu45l8C752GDFfc31ytxpQZ30+/Ws85jeEJRroYPEy8
         LisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3zCmgxorbQQmGIZIsq6TgsZ3TNFWxay30dLGKDvyQo=;
        b=sOuPNvx8EEsWQ7bITxxzsqbkSpjoyn+aUPYmUktBG2TW/l428l6D4o29tk+kiFoZb0
         FMG3DkJJPNLKNGlPUMJMmD3GcVPc4nvpVD9CKIqp6fvMxKgZcD7oL7WChQjBc7bPKWRz
         vn0f9GsyS2fdqJ9WnB7UjmNP0MwNc61gKAyEVmZhMQye+N7HJGwL1gH6rI55Qi4uxsyn
         wltaDIenSI3O5/p5p+vnP+NoVoCU7U3ggqFFY4M21b7hzmTogWVFVIfDBYyPHW2TAf0E
         60otrIfAUhkZLI5BVn8ms0hFbAmxQSKiKvzaTY/GJJRqxjKqOz0YYbkxPSjtiQ9EkUhV
         uIXA==
X-Gm-Message-State: AOAM533Nj3jSI2j2iqRFT92y8RFoF8vGGjn2L5qPGiokBgQVgFT5XhJx
        akwqqJI7HX90XZd0MEKEvEM=
X-Google-Smtp-Source: ABdhPJxNpX5Be7RNrtUkOOK5UyxwDgZBIQpgUbEbitlrdEcVOKwvw/UP8hjgSP+F2BeV4iRNRBfk8A==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr13482556edq.149.1600014340198;
        Sun, 13 Sep 2020 09:25:40 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-100.092.219.pools.vodafone-ip.de. [92.219.207.100])
        by smtp.gmail.com with ESMTPSA id w19sm7163505edt.22.2020.09.13.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:25:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: remove 5 GHz code
Date:   Sun, 13 Sep 2020 18:22:06 +0200
Message-Id: <20200913162206.19477-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913162206.19477-1-straube.linux@gmail.com>
References: <20200913162206.19477-1-straube.linux@gmail.com>
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
index 6cb779bc9410..372ce17c3569 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1724,26 +1724,17 @@ void update_wireless_mode(struct adapter *padapter)
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
-		if (rtw_is_cckratesonly_included(rate))
-			network_type |= WIRELESS_11B;
-		else if (rtw_is_cckrates_included(rate))
-			network_type |= WIRELESS_11BG;
-		else
-			network_type |= WIRELESS_11G;
-	}
+	if (pmlmeinfo->VHT_enable)
+		network_type = WIRELESS_11AC;
+	else if (pmlmeinfo->HT_enable)
+		network_type = WIRELESS_11_24N;
+
+	if (rtw_is_cckratesonly_included(rate))
+		network_type |= WIRELESS_11B;
+	else if (rtw_is_cckrates_included(rate))
+		network_type |= WIRELESS_11BG;
+	else
+		network_type |= WIRELESS_11G;
 
 	pmlmeext->cur_wireless_mode = network_type & padapter->registrypriv.wireless_mode;
 
-- 
2.28.0

