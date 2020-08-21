Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEF24CF09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgHUHVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgHUHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A071C06136A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b17so229795wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFEv542Lhp8Q0f61EAB5CHsxrkFJGeJ0ctv6xlXdr9A=;
        b=Ky93DjY3FSfpFv0Y7UcE/Js9RnV2MLxj3X3KnrbnWBMm7iZl+THnGWjjc6/N1ipLm4
         q7tML5psB7vPbh/O3XlWj+uVmgRN2Rp6PiIMSqN/S2KIteNB48OvCPsEZCcZQ5myzBB6
         YJNmi61X3xTB7kfwPYMJ1m+7wPGVrS5O/HU/fojJyQGTSycw8ED0xtSdJ64iD9RJS9YS
         U/0xsKR6+a0Xmo9xSm762Qs+OWYszUmHmgLZu0uLKoXL+WEn7IwmPSCe8hdav87j7npt
         gkdWFFQ3fmNh03afFO/9sURAQBrCZkZll62ybPIZCoM/Yw/nqQL2qxzFsXscfal05iPx
         uojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFEv542Lhp8Q0f61EAB5CHsxrkFJGeJ0ctv6xlXdr9A=;
        b=Xn+TIiqjXNFVFhkuVnI7HL/ChcdL+84mxpKS+9IL+fpgjI5MNSXZ4F1G8Gcm0bsDrL
         Lo4EIQhIhaIxWJNE3Lr8X1fiMSNFSxUmwlQP2wt90l2QYTPmECrHkE7dbljmAbbXDVSE
         ic7JEyXZ9sRUK+adWcNZ41wyTF1ObJv+WDW/FqIF86WlIIJvNxR/T9xGT8jkR0sFo5hS
         +AwKyH5jAaHE/MzE+EP0TeMu8INz9XAlY7YLQF2bl4HOe4FS5UHHdgMebA1r+AWPv3Q0
         7swzL9yie7srg/vqSM4hszZN+pMiqcv5wZDrChijQHmNoJSNC+P39PNAgcb2GmRpEtSK
         HsIg==
X-Gm-Message-State: AOAM532Pxvc4dv5DFKNEge7HmYfb/7QgzO4LTjjIebgyi7AmbujNaCj2
        GpOY6OlIopasvK0gMabSBm0gtg==
X-Google-Smtp-Source: ABdhPJzgKxtK2z0RTPC3f80JykT6rZ2wpR3uT6n9e2Z5Vd3aTmeUJjMG3O5PTc+782jWoRNf6gTX6w==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr1470661wrs.9.1597994230857;
        Fri, 21 Aug 2020 00:17:10 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 18/32] wireless: intel: iwlwifi: mvm: tx: Demote misuse of kernel-doc headers
Date:   Fri, 21 Aug 2020 08:16:30 +0100
Message-Id: <20200821071644.109970-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1379: warning: Function parameter or member 'rate_n_flags' not described in 'iwl_mvm_hwrate_to_tx_status'
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1379: warning: Function parameter or member 'info' not described in 'iwl_mvm_hwrate_to_tx_status'
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1431: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_get_scd_ssn'

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
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2f6484e0d726c..82ebf264de397 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1371,7 +1371,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 	}
 }
 
-/**
+/*
  * translate ucode response to mac80211 tx status control values
  */
 static void iwl_mvm_hwrate_to_tx_status(u32 rate_n_flags,
@@ -1413,7 +1413,7 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
-/**
+/*
  * iwl_mvm_get_scd_ssn - returns the SSN of the SCD
  * @tx_resp: the Tx response from the fw (agg or non-agg)
  *
-- 
2.25.1

