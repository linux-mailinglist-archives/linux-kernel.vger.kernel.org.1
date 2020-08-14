Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7624491C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHNLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgHNLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4181FC061389
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so7207389wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gG0Q+CBV6XzXkxYgZy4yYbCI9O+7sDv4xpcBiJiFnN8=;
        b=XHuCB48hrXtTdiGZTFxB5RtS0CpIeu4tXXhCdwYRL152X5UX5mEtc3dR8P2tFlUV/j
         /cBC8T+oF80UTw3ioC4EsFWIZKiSgjSHDgmeipG3H/Ki8dP5RMKUXKobqkWI7skyOLs8
         RqhHxMe2VEITUmf6Pla02RAoKxLuGBkXmjgFC/INiR3yCPvWFcZKio+o2q2VnvHVvWRg
         FRQpBTvIzPEFUmVoqzNhmoPkCwmheXgB/zDICLB7hECVt2yvhe0xcitAQkNcMaOBAXis
         lwmlcMA5ZoZ0DIy4x05N4YTlVefIDDFqyhN5QnQ4eazVB3e1tfZKKe2sRaDLkxoDaIpu
         NAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gG0Q+CBV6XzXkxYgZy4yYbCI9O+7sDv4xpcBiJiFnN8=;
        b=HuPm2CFBwQ9DX4QUmLsPB1XGudrDIoRAh3Cz6DxupHcAs0bwtxNWJCkmYB4bN+SYtN
         MntQcBKA07V9S3My8Tc07syX65L9Y1nbtjvFEifer5ed3apRI7yaPK75p7ZvFI63Rf3U
         QSXX3oKRXFL58O6PhGeHgFzTXfx6UlTqdkfkvpmr6PT39cjRecG7e7RIoRxp0ITng+pP
         HfnIKNTYNKOCD7h2tsG0eeXt//xKFEAaz+85ktzuo4HJ+NvDK+055n85W9OEULl2tIDP
         8G5ulbNV8fouzAdbsT5sjxXs6MSjslV5P4xapLwLkqW8RZcr4wjWX4Add7oWifobt4oQ
         i+RQ==
X-Gm-Message-State: AOAM5329g7I1rghPCby2nzARrlbILTuXZfi9MDLMxGMvkUVI2q0agSlB
        XAIzxCpCy36aoP/15JuZue5lMw==
X-Google-Smtp-Source: ABdhPJylV7FjEHL4awdxmvDih66p+3WF1/+lPG47jF2qJp4rVPPFyUF/djeWznbOEDvSXTIVGL0epA==
X-Received: by 2002:a7b:cf0c:: with SMTP id l12mr2252326wmg.77.1597405202279;
        Fri, 14 Aug 2020 04:40:02 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: [PATCH 13/30] net: wireless: ath: wil6210: cfg80211: Demote non-kerneldoc headers to standard comment blocks
Date:   Fri, 14 Aug 2020 12:39:16 +0100
Message-Id: <20200814113933.1903438-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No effort has been made to document any of the function parameters here.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/cfg80211.c:1749: warning: Function parameter or member 'ies' not described in '_wil_cfg80211_find_ie'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1749: warning: Function parameter or member 'ies_len' not described in '_wil_cfg80211_find_ie'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1749: warning: Function parameter or member 'ie' not described in '_wil_cfg80211_find_ie'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1749: warning: Function parameter or member 'ie_len' not described in '_wil_cfg80211_find_ie'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'ies1' not described in '_wil_cfg80211_merge_extra_ies'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'ies1_len' not described in '_wil_cfg80211_merge_extra_ies'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'ies2' not described in '_wil_cfg80211_merge_extra_ies'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'ies2_len' not described in '_wil_cfg80211_merge_extra_ies'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'merged_ies' not described in '_wil_cfg80211_merge_extra_ies'
 drivers/net/wireless/ath/wil6210/cfg80211.c:1780: warning: Function parameter or member 'merged_len' not described in '_wil_cfg80211_merge_extra_ies'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 0851d2bede891..1c42410d68e1a 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1739,7 +1739,7 @@ static int wil_cancel_remain_on_channel(struct wiphy *wiphy,
 	return wil_p2p_cancel_listen(vif, cookie);
 }
 
-/**
+/*
  * find a specific IE in a list of IEs
  * return a pointer to the beginning of IE in the list
  * or NULL if not found
@@ -1766,7 +1766,7 @@ static const u8 *_wil_cfg80211_find_ie(const u8 *ies, u16 ies_len, const u8 *ie,
 				       ies_len);
 }
 
-/**
+/*
  * merge the IEs in two lists into a single list.
  * do not include IEs from the second list which exist in the first list.
  * add only vendor specific IEs from second list to keep
-- 
2.25.1

