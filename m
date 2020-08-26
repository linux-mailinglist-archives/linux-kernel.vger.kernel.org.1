Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D97252A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHZJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHZJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B1C0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so1109638wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXzMFpauZUbIvXTpTjTk511d7rH3VOBZcuLvH1EPh6E=;
        b=JXl7Wb1TDc4vtCMn0jU7O2QGXjAE5ZmvNt2UgRowQia4ULjEjnVwFgycqO/xL1xiQL
         mGwTh6TOAaoCjozXj2v0shvbn57oE3Xbb5yL1zNlrF02tx8FgyqJdJSQ9UBUE7iHQ8Pq
         WPWeG8MVNOmVmdJCNGy5SV7kEgbOq+/qq+Y0NJ3svO09zeXVLiYNEIt/AkpRr1P8ZkiO
         NPuBH1yw62bbpTY/ejBsGMKIcy4LOtPiy05IcYX7RwnO3KH9go0bveQTm87bM8i6nI16
         rKTfoHx+Xm08R/jH66MdPo3S/AnpzzllpPwufZZhnxpsr6fKuaunZX44bkkmzYRGHhVG
         S0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXzMFpauZUbIvXTpTjTk511d7rH3VOBZcuLvH1EPh6E=;
        b=CgmoDagGU2UcZ7e86/lXudAu82yHPebfoN+xeFcMAdYmhnduPRpZa/iB0OReldJF42
         y7BNB6SFu63DQwH/c/FrgfSN4tdsNI4BidfZ4/V4rPi2HXfCQIeKNDvBvsLae2/dySnc
         HzNaa0Oxutn9aE2RRjCW7M10D+l/gqeb6B37nL0Oavg5vXBAiOC/ZyjAXdll5X81D/rJ
         6diC+CzT8eN32nl2ogCdlk/VvJQCjljTaSG4hWuIIsXOYMDaywo4VNxclTB6C8EXq0/D
         b34srL3cofQksYTWEtej7unbIkS0pjd2SETtjdhdnpVx+wLSfDnZDqxYwQ3o0K5xjq2K
         11nQ==
X-Gm-Message-State: AOAM533xfOMy5KUB3RoCj3j2wosvC5Ik5lW8zcCH3mQ7i4+9daYdg8un
        hyoUo/O/Z2sgcyUyhQrnDpcVNg==
X-Google-Smtp-Source: ABdhPJwKh1AxTI50soH4xYZxFKCweoABWiKp0VX8Td9mesJOaxcHs7pQEGqY4QhzIJmpdZwz5LGtNg==
X-Received: by 2002:adf:f041:: with SMTP id t1mr7808292wro.314.1598434450993;
        Wed, 26 Aug 2020 02:34:10 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Linux Wireless <ilw@linux.intel.com>
Subject: [PATCH 05/30] wireless: intel: iwlegacy: 3945: Remove all non-conformant kernel-doc headers
Date:   Wed, 26 Aug 2020 10:33:36 +0100
Message-Id: <20200826093401.1458456-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/3945.c:104: warning: Function parameter or member 'il' not described in 'il3945_disable_events'
 drivers/net/wireless/intel/iwlegacy/3945.c:273: warning: Function parameter or member 'il' not described in 'il3945_tx_queue_reclaim'
 drivers/net/wireless/intel/iwlegacy/3945.c:273: warning: Function parameter or member 'txq_id' not described in 'il3945_tx_queue_reclaim'
 drivers/net/wireless/intel/iwlegacy/3945.c:273: warning: Function parameter or member 'idx' not described in 'il3945_tx_queue_reclaim'
 drivers/net/wireless/intel/iwlegacy/3945.c:299: warning: Function parameter or member 'il' not described in 'il3945_hdl_tx'
 drivers/net/wireless/intel/iwlegacy/3945.c:299: warning: Function parameter or member 'rxb' not described in 'il3945_hdl_tx'
 drivers/net/wireless/intel/iwlegacy/3945.c:637: warning: Function parameter or member 'il' not described in 'il3945_hw_txq_free_tfd'
 drivers/net/wireless/intel/iwlegacy/3945.c:637: warning: Function parameter or member 'txq' not described in 'il3945_hw_txq_free_tfd'
 drivers/net/wireless/intel/iwlegacy/3945.c:686: warning: Function parameter or member 'il' not described in 'il3945_hw_build_tx_cmd_rate'
 drivers/net/wireless/intel/iwlegacy/3945.c:686: warning: Function parameter or member 'cmd' not described in 'il3945_hw_build_tx_cmd_rate'
 drivers/net/wireless/intel/iwlegacy/3945.c:686: warning: Function parameter or member 'info' not described in 'il3945_hw_build_tx_cmd_rate'
 drivers/net/wireless/intel/iwlegacy/3945.c:686: warning: Function parameter or member 'hdr' not described in 'il3945_hw_build_tx_cmd_rate'
 drivers/net/wireless/intel/iwlegacy/3945.c:686: warning: Function parameter or member 'sta_id' not described in 'il3945_hw_build_tx_cmd_rate'
 drivers/net/wireless/intel/iwlegacy/3945.c:838: warning: Function parameter or member 'il' not described in 'il3945_txq_ctx_reset'
 drivers/net/wireless/intel/iwlegacy/3945.c:1003: warning: Function parameter or member 'il' not described in 'il3945_hw_txq_ctx_free'
 drivers/net/wireless/intel/iwlegacy/3945.c:1044: warning: Function parameter or member 'new_reading' not described in 'il3945_hw_reg_adjust_power_by_temp'
 drivers/net/wireless/intel/iwlegacy/3945.c:1044: warning: Function parameter or member 'old_reading' not described in 'il3945_hw_reg_adjust_power_by_temp'
 drivers/net/wireless/intel/iwlegacy/3945.c:1053: warning: Function parameter or member 'temperature' not described in 'il3945_hw_reg_temp_out_of_range'
 drivers/net/wireless/intel/iwlegacy/3945.c:1069: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_txpower_get_temperature'
 drivers/net/wireless/intel/iwlegacy/3945.c:1107: warning: Function parameter or member 'il' not described in 'il3945_is_temp_calib_needed'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'scan_tbl_idx' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'rate_idx' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'clip_pwrs' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'ch_info' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1328: warning: Function parameter or member 'band_idx' not described in 'il3945_hw_reg_set_scan_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1383: warning: Function parameter or member 'il' not described in 'il3945_send_tx_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1460: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_set_new_power'
 drivers/net/wireless/intel/iwlegacy/3945.c:1522: warning: Function parameter or member 'ch_info' not described in 'il3945_hw_reg_get_ch_txpower_limit'
 drivers/net/wireless/intel/iwlegacy/3945.c:1552: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_comp_txpower_temp'
 drivers/net/wireless/intel/iwlegacy/3945.c:1712: warning: Function parameter or member 'il' not described in 'il3945_commit_rxon'
 drivers/net/wireless/intel/iwlegacy/3945.c:1845: warning: Function parameter or member 'il' not described in 'il3945_reg_txpower_periodic'
 drivers/net/wireless/intel/iwlegacy/3945.c:1889: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_get_ch_grp_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:1889: warning: Function parameter or member 'ch_info' not described in 'il3945_hw_reg_get_ch_grp_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:1924: warning: Function parameter or member 'il' not described in 'il3945_hw_reg_get_matched_power_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:1924: warning: Function parameter or member 'requested_power' not described in 'il3945_hw_reg_get_matched_power_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:1924: warning: Function parameter or member 'setting_idx' not described in 'il3945_hw_reg_get_matched_power_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:1924: warning: Function parameter or member 'new_idx' not described in 'il3945_hw_reg_get_matched_power_idx'
 drivers/net/wireless/intel/iwlegacy/3945.c:2055: warning: Function parameter or member 'il' not described in 'il3945_txpower_set_from_eeprom'
 drivers/net/wireless/intel/iwlegacy/3945.c:2313: warning: Function parameter or member 'il' not described in 'il3945_init_hw_rate_table'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/3945.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index fd63eba47ba22..0597d828bee1e 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -90,7 +90,7 @@ il3945_get_prev_ieee_rate(u8 rate_idx)
 #define IL_EVT_DISABLE (0)
 #define IL_EVT_DISABLE_SIZE (1532/32)
 
-/**
+/*
  * il3945_disable_events - Disable selected events in uCode event log
  *
  * Disable an event by writing "1"s into "disable"
@@ -261,7 +261,7 @@ il3945_rs_next_rate(struct il_priv *il, int rate)
 	return next_rate;
 }
 
-/**
+/*
  * il3945_tx_queue_reclaim - Reclaim Tx queue entries already Tx'd
  *
  * When FW advances 'R' idx, all entries between old and new 'R' idx
@@ -291,7 +291,7 @@ il3945_tx_queue_reclaim(struct il_priv *il, int txq_id, int idx)
 		il_wake_queue(il, txq);
 }
 
-/**
+/*
  * il3945_hdl_tx - Handle Tx response
  */
 static void
@@ -627,7 +627,7 @@ il3945_hw_txq_attach_buf_to_tfd(struct il_priv *il, struct il_tx_queue *txq,
 	return 0;
 }
 
-/**
+/*
  * il3945_hw_txq_free_tfd - Free one TFD, those at idx [txq->q.read_ptr]
  *
  * Does NOT advance any idxes
@@ -675,7 +675,7 @@ il3945_hw_txq_free_tfd(struct il_priv *il, struct il_tx_queue *txq)
 	}
 }
 
-/**
+/*
  * il3945_hw_build_tx_cmd_rate - Add rate portion to TX_CMD:
  *
 */
@@ -828,7 +828,7 @@ il3945_tx_reset(struct il_priv *il)
 	return 0;
 }
 
-/**
+/*
  * il3945_txq_ctx_reset - Reset TX queue context
  *
  * Destroys all DMA structures and initialize them again
@@ -993,7 +993,7 @@ il3945_hw_nic_init(struct il_priv *il)
 	return 0;
 }
 
-/**
+/*
  * il3945_hw_txq_ctx_free - Free TXQ Context
  *
  * Destroy all TX DMA queues and structures
@@ -1035,7 +1035,7 @@ il3945_hw_txq_ctx_stop(struct il_priv *il)
 	}
 }
 
-/**
+/*
  * il3945_hw_reg_adjust_power_by_temp
  * return idx delta into power gain settings table
 */
@@ -1045,7 +1045,7 @@ il3945_hw_reg_adjust_power_by_temp(int new_reading, int old_reading)
 	return (new_reading - old_reading) * (-11) / 100;
 }
 
-/**
+/*
  * il3945_hw_reg_temp_out_of_range - Keep temperature in sane range
  */
 static inline int
@@ -1060,7 +1060,7 @@ il3945_hw_get_temperature(struct il_priv *il)
 	return _il_rd(il, CSR_UCODE_DRV_GP2);
 }
 
-/**
+/*
  * il3945_hw_reg_txpower_get_temperature
  * get the current temperature by reading from NIC
 */
@@ -1096,7 +1096,7 @@ il3945_hw_reg_txpower_get_temperature(struct il_priv *il)
  * Both are lower than older versions' 9 degrees */
 #define IL_TEMPERATURE_LIMIT_TIMER   6
 
-/**
+/*
  * il3945_is_temp_calib_needed - determines if new calibration is needed
  *
  * records new temperature in tx_mgr->temperature.
@@ -1315,7 +1315,7 @@ il3945_hw_reg_fix_power_idx(int idx)
 /* Kick off thermal recalibration check every 60 seconds */
 #define REG_RECALIB_PERIOD (60)
 
-/**
+/*
  * il3945_hw_reg_set_scan_power - Set Tx power for scan probe requests
  *
  * Set (in our channel info database) the direct scan Tx power for 1 Mbit (CCK)
@@ -1372,7 +1372,7 @@ il3945_hw_reg_set_scan_power(struct il_priv *il, u32 scan_tbl_idx, s32 rate_idx,
 	    power_gain_table[band_idx][power_idx].dsp_atten;
 }
 
-/**
+/*
  * il3945_send_tx_power - fill in Tx Power command with gain settings
  *
  * Configures power settings for all rates for the current channel,
@@ -1439,7 +1439,7 @@ il3945_send_tx_power(struct il_priv *il)
 
 }
 
-/**
+/*
  * il3945_hw_reg_set_new_power - Configures power tables at new levels
  * @ch_info: Channel to update.  Uses power_info.requested_power.
  *
@@ -1510,7 +1510,7 @@ il3945_hw_reg_set_new_power(struct il_priv *il, struct il_channel_info *ch_info)
 	return 0;
 }
 
-/**
+/*
  * il3945_hw_reg_get_ch_txpower_limit - returns new power limit for channel
  *
  * NOTE: Returned power limit may be less (but not more) than requested,
@@ -1537,7 +1537,7 @@ il3945_hw_reg_get_ch_txpower_limit(struct il_channel_info *ch_info)
 	return min(max_power, ch_info->max_power_avg);
 }
 
-/**
+/*
  * il3945_hw_reg_comp_txpower_temp - Compensate for temperature
  *
  * Compensate txpower settings of *all* channels for temperature.
@@ -1699,7 +1699,7 @@ il3945_send_rxon_assoc(struct il_priv *il)
 	return rc;
 }
 
-/**
+/*
  * il3945_commit_rxon - commit staging_rxon to hardware
  *
  * The RXON command in staging_rxon is committed to the hardware and
@@ -1830,7 +1830,7 @@ il3945_commit_rxon(struct il_priv *il)
 	return 0;
 }
 
-/**
+/*
  * il3945_reg_txpower_periodic -  called when time to check our temperature.
  *
  * -- reset periodic timer
@@ -1873,7 +1873,7 @@ il3945_bg_reg_txpower_periodic(struct work_struct *work)
 	mutex_unlock(&il->mutex);
 }
 
-/**
+/*
  * il3945_hw_reg_get_ch_grp_idx - find the channel-group idx (0-4) for channel.
  *
  * This function is used when initializing channel-info structs.
@@ -1912,7 +1912,7 @@ il3945_hw_reg_get_ch_grp_idx(struct il_priv *il,
 	return group_idx;
 }
 
-/**
+/*
  * il3945_hw_reg_get_matched_power_idx - Interpolate to get nominal idx
  *
  * Interpolate to get nominal (i.e. at factory calibration temperature) idx
@@ -2035,7 +2035,7 @@ il3945_hw_reg_init_channel_groups(struct il_priv *il)
 	}
 }
 
-/**
+/*
  * il3945_txpower_set_from_eeprom - Set channel power info based on EEPROM
  *
  * Second pass (during init) to set up il->channel_info
@@ -2305,7 +2305,7 @@ il3945_manage_ibss_station(struct il_priv *il, struct ieee80211_vif *vif,
 				 vif->bss_conf.bssid);
 }
 
-/**
+/*
  * il3945_init_hw_rate_table - Initialize the hardware rate fallback table
  */
 int
@@ -2520,7 +2520,7 @@ il3945_eeprom_release_semaphore(struct il_priv *il)
 	return;
 }
 
- /**
+ /*
   * il3945_load_bsm - Load bootstrap instructions
   *
   * BSM operation:
-- 
2.25.1

