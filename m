Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E252C55AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbgKZNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390311AbgKZNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982EEC061A48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:13 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so2164793wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6+Wy4iFDi+o50ayVR/RzqW4RGQ8DgYcSYBAfri+vWM=;
        b=YznWFMVFnrL3SHRm/qzlOafIUlBxNuihoIkIF7OlhyVT4+9ZeyqW9cBmOoMgt7pLyw
         T7hKhHI/quPJlot8cNCu+3XvV04sD7ckvL4b5ap7US4iZezEuhlRmDYVJ7SoTvOp5qLO
         7xEHAZ4XtVDbwKVxICGgNttf3FdsRCRnwDnX9hvuMOXcBxi3c3uBNe/g9coM24UfPtcu
         K6yMTfbLfoEfj5XCdAEZJUvl9hNlWfTWyTwrBvrdPfpgoDLTKHB2/LFDnyF1GTiTZICM
         LqzrCSx4XukGOReSH+dhFXc+XF4vYzetV7RVAW1KexiAbrOKDlH6EAHyOsmRvV8BHtsZ
         cVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6+Wy4iFDi+o50ayVR/RzqW4RGQ8DgYcSYBAfri+vWM=;
        b=LXg4+f8rNdn28j+SPmq0XutZVthp7fajf/0RqqsZm5qzDnCu48TZ8zq5Yhhh3niDWc
         XgSZgtpC0XSn0by/wB6W+UPLgtYiubhgroSMlHsU6Z7z4DgN9okRSikIcPlI5CF8rxZ0
         GNFmFd2hvvTPTQpIWhtmkKCdtW9BnlnacXk6g1X9v5XU8JlVrHUoWfXuwZ7CIsKk10Wc
         qjoXWfsq8Hka9zJPDeIKyq50PYEfLHI5IKbfSuhs877aAA6S1RgEqFgqEJfRVyNquiOZ
         1eXDvpCyfCSzUWvFrpKrIFAY/5JKv4zwSis4A3/AZYW4y58S2RDwDdqxXb3IwPrRRy4e
         VWiQ==
X-Gm-Message-State: AOAM532s2BrQZVkj/JpK4cHsdGo6CtXImOWUsjlCG0drBMVIGLXlG5T0
        lulDteQXfNZmUT9KQE652x7hQA==
X-Google-Smtp-Source: ABdhPJyuWp5WvGRoZZgxkoG9Oq62kxy/bru//LJwk7blbiQxWqPZlJHwxTOooVtaPi4kfalsFWJUAQ==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr3396548wmf.37.1606397532313;
        Thu, 26 Nov 2020 05:32:12 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 13/17] iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
Date:   Thu, 26 Nov 2020 13:31:48 +0000
Message-Id: <20201126133152.3211309-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c:97: warning: Function parameter or member 'trans' not described in 'iwl_phy_db'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
index ae83cfdb750e6..c9ce270ceee07 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
@@ -79,11 +79,11 @@ struct iwl_phy_db_entry {
  *
  * @cfg: phy configuration.
  * @calib_nch: non channel specific calibration data.
- * @calib_ch: channel specific calibration data.
  * @n_group_papd: number of entries in papd channel group.
  * @calib_ch_group_papd: calibration data related to papd channel group.
  * @n_group_txp: number of entries in tx power channel group.
  * @calib_ch_group_txp: calibration data related to tx power chanel group.
+ * @trans: transport layer
  */
 struct iwl_phy_db {
 	struct iwl_phy_db_entry	cfg;
-- 
2.25.1

