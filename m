Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3124974A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHSH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHSHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:25:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED9C06137E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so20430890wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glqW/Gnt3wlpIqCq2zLjhjH68Neg4Dhca059SWlN3nQ=;
        b=I017K99G8el9gEBEXvnAP53d5myjKGGOVqLyQjAqTWA1X9ON1mGBYobJt/kuBxImv4
         lSM9TN5GCAkXid9e8qhjJq5DRL1N1zAD3y0eJrsugDpKRv0wRYg0e8fg1C/O+7ta4ZY4
         K+kW128w6e71/ORZToYQ0ZMsw3mj7RpT+ESpWFIJ/GtdYjSGZM0AvgKUwkD0JiFoJUUr
         LBKL3G8UEKUMeiy5Qkua8kG5meEQ+W7uCEWO157BEJsd1a+BysHghtKu/u+1qeREky69
         V8Lnk++BgKM6Jdk1L5gwQX+nNMmCkRKh87PeiRBgYNacBBR19Qr08G8GamrJGFAVFPWI
         UFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glqW/Gnt3wlpIqCq2zLjhjH68Neg4Dhca059SWlN3nQ=;
        b=Q199o3t0/m4NXIM2odzk92wr4aBsDvi7BrsZ/NtQiMAyZg5cGeFzr63sPY1ERjNUqT
         bbBUGEllsEg3CQl3SxFDf9ZiDi7O92h9KAJ7o1rdBgyJ8PEIDEpCRJbg0Wpzmfcx/AzE
         QGL01MvjWyJSfgmzdAyFJ557jsva9oZChaHV/UhkhYCSBUcR4xng9gRfEBwhe0fcXbKb
         jhQKtWd4lcOYhEGy0YHbEXAi0b7ovSnINA9BtxX00t1Sh33DYYFJtEu7UvH+sEqV1DdP
         mYmKCAK3ztd+HkseylVGvu2txwgOoCSoX19Cch6qBLQcw5r5q9AVg2o/KX35vEaFBdIL
         IeNQ==
X-Gm-Message-State: AOAM531FRYo9ZNhzwOxLNSq+UfbzgD1zzZJ4k9aqDbm7RScoLB3FHI4K
        3l95t0RYUjy4WjBjneVJlJ4lug==
X-Google-Smtp-Source: ABdhPJydd6ADFG4m5WStcOCSVzjAFmjvijPB/X8rRMCSUp7sP9B3G5muyTERElHI21Bj9s3eq2FS1A==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr2710634wrv.405.1597821872851;
        Wed, 19 Aug 2020 00:24:32 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 22/28] wireless: intel: iwlwifi: dvm: sta: Demote a bunch of nonconformant kernel-doc headers
Date:   Wed, 19 Aug 2020 08:23:56 +0100
Message-Id: <20200819072402.3085022-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:244: warning: Function parameter or member 'priv' not described in 'iwl_prep_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:244: warning: Function parameter or member 'ctx' not described in 'iwl_prep_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:244: warning: Function parameter or member 'addr' not described in 'iwl_prep_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:244: warning: Function parameter or member 'is_ap' not described in 'iwl_prep_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:244: warning: Function parameter or member 'sta' not described in 'iwl_prep_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'priv' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'ctx' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'addr' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'is_ap' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'sta' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:332: warning: Function parameter or member 'sta_id_r' not described in 'iwl_add_station_common'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:390: warning: Function parameter or member 'priv' not described in 'iwl_sta_ucode_deactivate'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:390: warning: Function parameter or member 'sta_id' not described in 'iwl_sta_ucode_deactivate'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:459: warning: Function parameter or member 'priv' not described in 'iwl_remove_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:459: warning: Function parameter or member 'sta_id' not described in 'iwl_remove_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:459: warning: Function parameter or member 'addr' not described in 'iwl_remove_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:614: warning: Function parameter or member 'priv' not described in 'iwl_clear_ucode_stations'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:614: warning: Function parameter or member 'ctx' not described in 'iwl_clear_ucode_stations'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:648: warning: Function parameter or member 'priv' not described in 'iwl_restore_stations'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:648: warning: Function parameter or member 'ctx' not described in 'iwl_restore_stations'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:790: warning: Function parameter or member 'priv' not described in 'is_lq_table_valid'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:790: warning: Function parameter or member 'ctx' not described in 'is_lq_table_valid'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:790: warning: Function parameter or member 'lq' not described in 'is_lq_table_valid'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:822: warning: Function parameter or member 'priv' not described in 'iwl_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:822: warning: Function parameter or member 'ctx' not described in 'iwl_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:822: warning: Function parameter or member 'lq' not described in 'iwl_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:822: warning: Function parameter or member 'flags' not described in 'iwl_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1270: warning: Function parameter or member 'priv' not described in 'iwlagn_alloc_bcast_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1270: warning: Function parameter or member 'ctx' not described in 'iwlagn_alloc_bcast_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1309: warning: Function parameter or member 'priv' not described in 'iwl_update_bcast_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1309: warning: Function parameter or member 'ctx' not described in 'iwl_update_bcast_station'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1348: warning: Function parameter or member 'priv' not described in 'iwl_sta_tx_modify_enable_tid'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1348: warning: Function parameter or member 'sta_id' not described in 'iwl_sta_tx_modify_enable_tid'
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1348: warning: Function parameter or member 'tid' not described in 'iwl_sta_tx_modify_enable_tid'

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
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index 51158edce15b0..e622948661fa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -234,7 +234,7 @@ static void iwl_set_ht_add_station(struct iwl_priv *priv, u8 index,
 	priv->stations[index].sta.station_flags |= flags;
 }
 
-/**
+/*
  * iwl_prep_station - Prepare station information for addition
  *
  * should be called with sta_lock held
@@ -323,7 +323,7 @@ u8 iwl_prep_station(struct iwl_priv *priv, struct iwl_rxon_context *ctx,
 
 #define STA_WAIT_TIMEOUT (HZ/2)
 
-/**
+/*
  * iwl_add_station_common -
  */
 int iwl_add_station_common(struct iwl_priv *priv, struct iwl_rxon_context *ctx,
@@ -383,7 +383,7 @@ int iwl_add_station_common(struct iwl_priv *priv, struct iwl_rxon_context *ctx,
 	return ret;
 }
 
-/**
+/*
  * iwl_sta_ucode_deactivate - deactivate ucode status for a station
  */
 static void iwl_sta_ucode_deactivate(struct iwl_priv *priv, u8 sta_id)
@@ -451,7 +451,7 @@ static int iwl_send_remove_station(struct iwl_priv *priv,
 	return ret;
 }
 
-/**
+/*
  * iwl_remove_station - Remove driver's knowledge of station.
  */
 int iwl_remove_station(struct iwl_priv *priv, const u8 sta_id,
@@ -601,7 +601,7 @@ static void iwl_sta_fill_lq(struct iwl_priv *priv, struct iwl_rxon_context *ctx,
 	link_cmd->sta_id = sta_id;
 }
 
-/**
+/*
  * iwl_clear_ucode_stations - clear ucode station table bits
  *
  * This function clears all the bits in the driver indicating
@@ -636,7 +636,7 @@ void iwl_clear_ucode_stations(struct iwl_priv *priv,
 			       "No active stations found to be cleared\n");
 }
 
-/**
+/*
  * iwl_restore_stations() - Restore driver known stations to device
  *
  * All stations considered active by driver, but not present in ucode, is
@@ -773,7 +773,7 @@ static inline void iwl_dump_lq_cmd(struct iwl_priv *priv,
 }
 #endif
 
-/**
+/*
  * is_lq_table_valid() - Test one aspect of LQ cmd for validity
  *
  * It sometimes happens when a HT rate has been in use and we
@@ -807,7 +807,7 @@ static bool is_lq_table_valid(struct iwl_priv *priv,
 	return true;
 }
 
-/**
+/*
  * iwl_send_lq_cmd() - Send link quality command
  * @init: This command is sent as part of station initialization right
  *        after station has been added.
@@ -1258,7 +1258,7 @@ int iwl_set_dynamic_key(struct iwl_priv *priv,
 	return ret;
 }
 
-/**
+/*
  * iwlagn_alloc_bcast_station - add broadcast station into driver's station table.
  *
  * This adds the broadcast station into the driver's station table
@@ -1298,7 +1298,7 @@ int iwlagn_alloc_bcast_station(struct iwl_priv *priv,
 	return 0;
 }
 
-/**
+/*
  * iwl_update_bcast_station - update broadcast station's LQ command
  *
  * Only used by iwlagn. Placed here to have all bcast station management
@@ -1341,7 +1341,7 @@ int iwl_update_bcast_stations(struct iwl_priv *priv)
 	return ret;
 }
 
-/**
+/*
  * iwl_sta_tx_modify_enable_tid - Enable Tx for this TID in station table
  */
 int iwl_sta_tx_modify_enable_tid(struct iwl_priv *priv, int sta_id, int tid)
-- 
2.25.1

