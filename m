Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5542C5562
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbgKZNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbgKZNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:31:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97554C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:31:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so2156701wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FjyZA9I7yFOBEtCbfXIU5SHh6pLoJjT44roAa80KCLE=;
        b=kui+NaCLN8lc8tkXHcRKVcWIXN1GenHm8MR/KyQxUoqmwBQASP6Wzz4F+S98Gbww6S
         uMkaVbYtvpQhdcfRATgZj3RtNAV1dF3sN5HKSbW4D6F/DCOQ6f35lr/WVFT1BL3JRiLl
         TjIqW/pcucuIAO4/d6VaM7dpUfbdGrKOvJfYAVhwKxizQ6P57pWbpGdLcQIf1ZG3V9QB
         TpbMc5QtXYKmej4JoRVX73e696RaoK0BV+Ne+LBq5koGtg1nsWNHhbOdoiE6aoCc4IjZ
         iNSQsZD71qbJCXSwno6zDHNoPpP73ZMZa7CxfuTxIYIrtQ1FKq75+uWCl7O0KcpVOZg8
         JSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FjyZA9I7yFOBEtCbfXIU5SHh6pLoJjT44roAa80KCLE=;
        b=dqpDtNeY17No0BSjFYUsye+59HcDEbspBlmha6t6A0zxsjMRq2h4DxSuxKYb9bIEvA
         GWDIF5Lpv1dLjc6EQvBUCUBfN56AFKiELE/7rcWl5Y169mth4vaTz4pO6phM3e3G+eeJ
         9kcQI1X1KCVj0GmTx9tFoyL8gWhSepwe+PbmR365yOZYfU8cuXXl65nm9bbFr13fQHWm
         mBXsVquPGXJavZYxFG+hOVS7/bRUhaXYIWmgxQhA43Quw7YDPfPfLkVciop8WwXGm9MT
         6JaLFBmfAjJ5x9AEBAiXAofIjagosKvdwSaIl1OZYmqpFqqqU1BH1Zgd4hK+sY6eZUVd
         WY+A==
X-Gm-Message-State: AOAM530oEw5Qj0+KcVcefofSyy9j53KZBOcJed2SJEvMtcPG6Vy0zebz
        6YPUieQx6CZZ1iVzb0UsEsb4lqKZui5d4QOS
X-Google-Smtp-Source: ABdhPJy+4ikTycM8ES5sSh18sX7zJcCpn462tjHqy3xH4ycrddEim8OyKqRzwP/kujYArGxZN2fefQ==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr3936515wrb.228.1606397516281;
        Thu, 26 Nov 2020 05:31:56 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:31:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Maya Erez <merez@codeaurora.org>, netdev@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        wil6210@qti.qualcomm.com, Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: [PATCH v2 00/17] [Set 4] Rid W=1 warnings in Wireless
Date:   Thu, 26 Nov 2020 13:31:35 +0000
Message-Id: <20201126133152.3211309-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Last batch!]

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

v2:
 - Unify rtw_pci_(probe,remove,shutdown}() prototypses
   - Suggested-by: Brian Norris

Lee Jones (17):
  wil6210: wmi: Correct misnamed function parameter 'ptr_'
  iwlwifi: mvm: rs: Demote non-conformant function documentation headers
  ath9k: ar9330_1p1_initvals: Remove unused const variable
    'ar9331_common_tx_gain_offset1_1'
  ath9k: ar9340_initvals: Remove unused const variable
    'ar9340Modes_ub124_tx_gain_table_1p0'
  ath9k: ar9485_initvals: Remove unused const variable
    'ar9485_fast_clock_1_1_baseband_postamble'
  ath9k: ar9003_2p2_initvals: Remove unused const variables
  iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
  iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
    header
  ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
    param
  ath9k: ar5008_phy: Demote half completed function headers
  ath: dfs_pattern_detector: Fix some function kernel-doc headers
  ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
  iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
  iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
  ath9k: dynack: Demote non-compliant function header
  iwlwifi: fw: acpi: Demote non-conformant function headers
  realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown

 drivers/net/wireless/ath/ath9k/ar5008_phy.c   |  15 +--
 .../wireless/ath/ath9k/ar9003_2p2_initvals.h  |  14 ---
 .../wireless/ath/ath9k/ar9330_1p1_initvals.h  |   7 --
 .../net/wireless/ath/ath9k/ar9340_initvals.h  | 101 ------------------
 .../net/wireless/ath/ath9k/ar9485_initvals.h  |   7 --
 drivers/net/wireless/ath/ath9k/dynack.c       |   3 +-
 .../net/wireless/ath/dfs_pattern_detector.c   |  14 +--
 drivers/net/wireless/ath/dfs_pri_detector.c   |   9 +-
 drivers/net/wireless/ath/regd.c               |   1 +
 drivers/net/wireless/ath/wil6210/wmi.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  12 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  12 +--
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-phy-db.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  10 +-
 drivers/net/wireless/realtek/rtw88/pci.h      |   8 ++
 .../net/wireless/realtek/rtw88/rtw8723de.c    |   1 +
 .../net/wireless/realtek/rtw88/rtw8723de.h    |   4 -
 .../net/wireless/realtek/rtw88/rtw8821ce.c    |   1 +
 .../net/wireless/realtek/rtw88/rtw8821ce.h    |   4 -
 .../net/wireless/realtek/rtw88/rtw8822be.c    |   1 +
 .../net/wireless/realtek/rtw88/rtw8822be.h    |   4 -
 .../net/wireless/realtek/rtw88/rtw8822ce.c    |   1 +
 .../net/wireless/realtek/rtw88/rtw8822ce.h    |   4 -
 25 files changed, 50 insertions(+), 191 deletions(-)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Maya Erez <merez@codeaurora.org>
Cc: netdev@vger.kernel.org
Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc: wil6210@qti.qualcomm.com
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
-- 
2.25.1

