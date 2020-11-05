Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2380B2A762E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbgKEDsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgKEDsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:13 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA402C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:11 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x20so151209ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5f5BTIPme4ikP9+zfLnqigWbwnM0CQmfkQuYPkT+kSQ=;
        b=Y6dM+PyXrN1z0I+jPyi4us2CYcNDgW3IpbwtPVDDZhBmASMbGNf9euRATLRkI0E8LS
         Uggu5B2W4x4r/GVnoVgxK+97K1BXojW4F4eO5aJ1Czri/2ldHwUggcH065PrWs1yxWWJ
         GWQycbCVZMKPQF8XjrTqCS7D5K3OSR8bZ/16oBbfZH/7ck7X1HTm3aF5RuwPfPDayjrQ
         QrcORZXjCJim70ULW19PecJE4gl0CO2ZIz2fOLwdPkW2lcS6kHztebbusSoByvm3I572
         VCN1K3e/aQdkpN/NeiTzcAbOOU7yCYwfA3plTgOjncO3BvLy4V+6se+uS70st3PWhgze
         JyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5f5BTIPme4ikP9+zfLnqigWbwnM0CQmfkQuYPkT+kSQ=;
        b=YbL0QXgarn1V08u54akyOlBgnmsB7sLIu7xsoY3UjrHfaBVy9qQw1p2Uhc0sL/CEQt
         NrV66NGx8ikT4m+T3buKxcWe6jo4DlH8btlPPzx+q/nY3xjPlYSqk+qo2GyPv/I/BnSS
         jKq/KfdYYnq7tefSRZB5PVI0D1gs928Hyvk8qp1diepbIiN9/t/SG4MAEw5STNGL5Jt/
         D1nMgB8IafQkstVy5ciwIaVsXsCSI1OG6U8tnTOmFNq363IAcOdT1tgjVJLq4N77ex6o
         qVHTGtt67BjzOH5flBROB6Iz6+oRGLsr0cWk7CZMPD/9Leh9VKAx8fQLvJUhRJT6m18E
         BVMA==
X-Gm-Message-State: AOAM533AaDBmOXtJIgCSw0tQXEtxuDYbUlJ3gTk1Lc6V40NmO5wGA6Fy
        UEJAbIYJE2rvGCftDxX6rrzxQ0VBZEY=
X-Google-Smtp-Source: ABdhPJxMjdLDRJ/Eynb00o7q+dA54IKGrLuxUpkMN482+T2MMQv8M6jlK9Ho4GE0Bx+hHu83g8Q1UA==
X-Received: by 2002:a92:b656:: with SMTP id s83mr477295ili.280.1604548091362;
        Wed, 04 Nov 2020 19:48:11 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:10 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 4/9] staging: rtl8723bs: remove NDEV_FMT macro
Date:   Wed,  4 Nov 2020 21:47:49 -0600
Message-Id: <20201105034754.12383-4-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary macro for %s and call it directly.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 1 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 498d5474010c..24386aa9ee1b 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -123,7 +123,6 @@ static inline void rtw_netif_stop_queue(struct net_device *pnetdev)
 
 #define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)), (sig), 1)
 
-#define NDEV_FMT "%s"
 #define NDEV_ARG(ndev) ndev->name
 #define ADPT_FMT "%s"
 #define ADPT_ARG(adapter) adapter->pnetdev->name
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 5dfa2fa24c76..736f1a6ac118 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2574,7 +2574,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	}
 
 	if (pwdev_priv->pmon_ndev) {
-		DBG_871X(FUNC_ADPT_FMT" monitor interface exist: "NDEV_FMT"\n",
+		DBG_871X(FUNC_ADPT_FMT" monitor interface exist: %s\n",
 			FUNC_ADPT_ARG(padapter), NDEV_ARG(pwdev_priv->pmon_ndev));
 		ret = -EBUSY;
 		goto out;
-- 
2.25.1

