Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743DD2929FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgJSPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729546AbgJSPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603119916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=u7a+QTs7KK/u/ERH7j5xA9SS8bPqHeGvDR9yK7S64mA=;
        b=L4dgDQ0BSu160C1+uZUGyyAycamnRIvJg4qUjxf/2nzvrRXnsMpFSCCW0nSiOY/uuzW0mg
        IhjQvUOZPaPacVkEJf2ZfadslOqET/aG1A1eC8g1RctnycWmpqj7ndyHitlFbQkFcia1qc
        W5dVDvdSWgtOtS/pnv0ybe7iQBrKzD4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ywMKi1itO56BGnUPoIn_Ag-1; Mon, 19 Oct 2020 11:05:15 -0400
X-MC-Unique: ywMKi1itO56BGnUPoIn_Ag-1
Received: by mail-qk1-f200.google.com with SMTP id u16so7383685qkm.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u7a+QTs7KK/u/ERH7j5xA9SS8bPqHeGvDR9yK7S64mA=;
        b=c2v+cY5sy/8GFHC39441LDdl7bCAGOzVN5AaSoUxPwtjNCQp+RkXCkNloo4o/kEqK8
         i4kSV/XvLxcXesEU80kbNrwR7eBNRtMGDRn8VMMh+Q4TIcgO/zDPzZDeY0TOcb04aQMv
         L1X7dQ+QpKJHPhop1PuFGyQInI2MFKIQmUZV8Ofv55ncZPCjR6jipv3TUBNZIZWscgLY
         rdIYTRD/GyuBUkTz/nP48YHiJM56SgcRV1MhKe0Kpgqf45JipmL4NWsoUA0HbXcevaI4
         4RThhSP6i4FPWOT2znotDKZgZIXJuYfWO8CO+wvXzQS+DLykWvvOOgVwKVSs3cskTjKJ
         oyYw==
X-Gm-Message-State: AOAM532bqKo6QakhEgZ62sDb5l4TBMf1v8zfsR9AvG23ZNys5OEsX94t
        4klUyKmR5cAbd5tTwTR0EzwQXTIKlgNqgLYHsPPYHcTNhLoNocJhqHpBBeCY6LI96BwuvHsQZYi
        unE5K8C1utc9W5/Oq1kr70Qqa
X-Received: by 2002:a37:c441:: with SMTP id h1mr17142594qkm.298.1603119914410;
        Mon, 19 Oct 2020 08:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9EpuyV+FOQcDIlLURPRb83MEHY+24QKbvxUas2gGKvh9VVGfUlDCjyG2/R4+31wwf3KJuwA==
X-Received: by 2002:a37:c441:: with SMTP id h1mr17142567qkm.298.1603119914140;
        Mon, 19 Oct 2020 08:05:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k64sm117193qkc.97.2020.10.19.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:05:13 -0700 (PDT)
From:   trix@redhat.com
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        ath9k-devel@qca.qualcomm.com, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, luciano.coelho@intel.com,
        linuxwifi@intel.com, chunkeey@googlemail.com, pkshih@realtek.com,
        sara.sharon@intel.com, tova.mussai@intel.com,
        nathan.errera@intel.com, lior2.cohen@intel.com, john@phrozen.org,
        shaul.triebitz@intel.com, shahar.s.matityahu@intel.com,
        Larry.Finger@lwfinger.net, zhengbin13@huawei.com,
        christophe.jaillet@wanadoo.fr, yanaijie@huawei.com,
        joe@perches.com, saurav.girepunje@gmail.com
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] wireless: remove unneeded break
Date:   Mon, 19 Oct 2020 08:05:07 -0700
Message-Id: <20201019150507.20574-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c             | 1 -
 drivers/net/wireless/ath/ath6kl/testmode.c           | 1 -
 drivers/net/wireless/ath/ath9k/hw.c                  | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c    | 2 --
 drivers/net/wireless/intersil/p54/eeprom.c           | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c  | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c  | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 3 ---
 8 files changed, 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 5c1af2021883..9c4e6cf2137a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3878,7 +3878,6 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 		return ath10k_htt_rx_proc_rx_frag_ind(htt,
 						      &resp->rx_frag_ind,
 						      skb);
-		break;
 	}
 	case HTT_T2H_MSG_TYPE_TEST:
 		break;
diff --git a/drivers/net/wireless/ath/ath6kl/testmode.c b/drivers/net/wireless/ath/ath6kl/testmode.c
index f3906dbe5495..89c7c4e25169 100644
--- a/drivers/net/wireless/ath/ath6kl/testmode.c
+++ b/drivers/net/wireless/ath/ath6kl/testmode.c
@@ -94,7 +94,6 @@ int ath6kl_tm_cmd(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 		return 0;
 
-		break;
 	case ATH6KL_TM_CMD_RX_REPORT:
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 6609ce122e6e..b66eeb577272 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2308,7 +2308,6 @@ void ath9k_hw_beaconinit(struct ath_hw *ah, u32 next_beacon, u32 beacon_period)
 		ath_dbg(ath9k_hw_common(ah), BEACON,
 			"%s: unsupported opmode: %d\n", __func__, ah->opmode);
 		return;
-		break;
 	}
 
 	REG_WRITE(ah, AR_BEACON_PERIOD, beacon_period);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cbdebefb854a..8698ca4d30de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1202,13 +1202,11 @@ static int iwl_mvm_mac_ctx_send(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return iwl_mvm_mac_ctxt_cmd_sta(mvm, vif, action,
 						force_assoc_off,
 						bssid_override);
-		break;
 	case NL80211_IFTYPE_AP:
 		if (!vif->p2p)
 			return iwl_mvm_mac_ctxt_cmd_ap(mvm, vif, action);
 		else
 			return iwl_mvm_mac_ctxt_cmd_go(mvm, vif, action);
-		break;
 	case NL80211_IFTYPE_MONITOR:
 		return iwl_mvm_mac_ctxt_cmd_listener(mvm, vif, action);
 	case NL80211_IFTYPE_P2P_DEVICE:
diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 5bd35c147e19..3ca9d26df174 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -870,7 +870,6 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 			} else {
 				goto good_eeprom;
 			}
-			break;
 		default:
 			break;
 		}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index 63f9ea21962f..bd9160b166c5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -1226,7 +1226,6 @@ static int _rtl88ee_set_media_status(struct ieee80211_hw *hw,
 	default:
 		pr_err("Network type %d not support!\n", type);
 		return 1;
-		break;
 	}
 
 	/* MSR_INFRA == Link in infrastructure network;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index a36dc6e726d2..f8a1de6e9849 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1132,7 +1132,6 @@ static int _rtl8723e_set_media_status(struct ieee80211_hw *hw,
 	default:
 		pr_err("Network type %d not support!\n", type);
 		return 1;
-		break;
 	}
 
 	/* MSR_INFRA == Link in infrastructure network;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index f41a7643b9c4..225b8cd44f23 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -2085,12 +2085,10 @@ bool rtl8812ae_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		return __rtl8821ae_phy_config_with_headerfile(hw,
 				radioa_array_table_a, radioa_arraylen_a,
 				_rtl8821ae_config_rf_radio_a);
-		break;
 	case RF90_PATH_B:
 		return __rtl8821ae_phy_config_with_headerfile(hw,
 				radioa_array_table_b, radioa_arraylen_b,
 				_rtl8821ae_config_rf_radio_b);
-		break;
 	case RF90_PATH_C:
 	case RF90_PATH_D:
 		pr_err("switch case %#x not processed\n", rfpath);
@@ -2116,7 +2114,6 @@ bool rtl8821ae_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		return __rtl8821ae_phy_config_with_headerfile(hw,
 			radioa_array_table, radioa_arraylen,
 			_rtl8821ae_config_rf_radio_a);
-		break;
 
 	case RF90_PATH_B:
 	case RF90_PATH_C:
-- 
2.18.1

