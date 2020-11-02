Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140682A2950
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgKBL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgKBLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEADC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i16so8725673wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcBd80NlVbn3uGSdfGXvocYKOP7aRNETXFKMl2YiPGc=;
        b=TuQtao6p6GFiEVg6JEmLlKgf0D49U9VNmQ4ReLha2879SpnKSDPyH9euAO02gE1yKf
         f5uN+SxO3aZQiyAcxMKHEH5mLrEPIvx36/Va40Vnm/yBPXj+5ZYIj//8tAzCOGV5bS/z
         LZ/KBRyN5OWHznYhKUj3qnkXMRd4/Q8LQ17xM1xjKXYBWJNId5acNlg6BkGTChNR5sxD
         XX0QcYhXsd6NIl00/mG1dTsdx1XfUVbzV/8mHesihcvklchsFOLlAk8otYKJqscyS+pv
         jnWUOgs+P7yK7RPfAA2PiPaSjFd/5JzTgfi4es+zl3tYcu3KgsxRsbC3LcJErsVNFYRC
         Q9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcBd80NlVbn3uGSdfGXvocYKOP7aRNETXFKMl2YiPGc=;
        b=URjsG6uTsf3kblaEiriOtoekBTB39xihd/uNMnAr8EzdAC5JehDzfIGN/K+TpIMKMp
         60x/FJSwzRYIGj7fOZMarZpQEUQAZu01i+W3QXPmHjzsXU/Hhl7C+DB9pXzptBNRXJZM
         GZtV4DnQ/ibsruMYel+ULaZefu6q5aAFDzYrybiG1Q8FFBiQM22MD/LibizYNp6DYma3
         oTl2xtmGvvZUAjIlHloaxExqE2KXgSF2LzgDCfjY9a9HyA4TS+F9LjSB9KnCL5P7lYXm
         Fr6RDTnHaWcZ3DLBjZjMpypamMMEJiQFfVgNYbg6og07bJRHHsYXZoxjip10fazo+Tjb
         QVQA==
X-Gm-Message-State: AOAM531TlLXSyMZKmPKm8jzfc5tCBaVLHDfoZvI7S9WJczNFqqMlGTm7
        yLPpGmFaxdfMP3rPKmHlFPXfcg==
X-Google-Smtp-Source: ABdhPJxg1nc4dmX5MjDufhqqTExnyiFLhhTFkmUc8dGkb00hCvUBR2eKgcQZt8OUc7WUWUfi6p97lg==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr19138513wrv.49.1604316287835;
        Mon, 02 Nov 2020 03:24:47 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 21/41] ath: dfs_pattern_detector: Fix some function kernel-doc headers
Date:   Mon,  2 Nov 2020 11:23:50 +0000
Message-Id: <20201102112410.1049272-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/dfs_pattern_detector.c:34: warning: Function parameter or member 'region' not described in 'radar_types'
 drivers/net/wireless/ath/dfs_pattern_detector.c:141: warning: Function parameter or member 'region' not described in 'get_dfs_domain_radar_types'
 drivers/net/wireless/ath/dfs_pattern_detector.c:239: warning: Function parameter or member 'dpd' not described in 'channel_detector_get'
 drivers/net/wireless/ath/dfs_pattern_detector.c:239: warning: Function parameter or member 'freq' not described in 'channel_detector_get'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/dfs_pattern_detector.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
index 0813473793df1..80390495ea250 100644
--- a/drivers/net/wireless/ath/dfs_pattern_detector.c
+++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
@@ -23,7 +23,7 @@
 
 /**
  * struct radar_types - contains array of patterns defined for one DFS domain
- * @domain: DFS regulatory domain
+ * @region: regulatory DFS region
  * @num_radar_types: number of radar types to follow
  * @radar_types: radar types array
  */
@@ -133,8 +133,9 @@ static const struct radar_types *dfs_domains[] = {
 
 /**
  * get_dfs_domain_radar_types() - get radar types for a given DFS domain
- * @param domain DFS domain
- * @return radar_types ptr on success, NULL if DFS domain is not supported
+ * @region: regulatory DFS region
+ *
+ * Return value: radar_types ptr on success, NULL if DFS domain is not supported
  */
 static const struct radar_types *
 get_dfs_domain_radar_types(enum nl80211_dfs_regions region)
@@ -227,9 +228,10 @@ channel_detector_create(struct dfs_pattern_detector *dpd, u16 freq)
 
 /**
  * channel_detector_get() - get channel detector for given frequency
- * @param dpd instance pointer
- * @param freq frequency in MHz
- * @return pointer to channel detector on success, NULL otherwise
+ * @dpd: DPD instance pointer
+ * @freq: freq frequency in MHz
+ *
+ * Return value: pointer to channel detector on success, NULL otherwise
  *
  * Return existing channel detector for the given frequency or return a
  * newly create one.
-- 
2.25.1

