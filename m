Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045BF2A28F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgKBLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F9C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1043853wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfCY59oNjggvF0pXnEdWdUr+3BwEi6Y/3P8DecThe14=;
        b=uvqiBJUtr1Y8S2jtjRl3aIarqDpan9LCk86rgKPo8rAt6zbob8QDqIlo668wn8bYAB
         VSaf8xR2nQ2Qoayi9wblr4So+rnl/tm02qpa0/r2wHDrd6qPWehHbWS+UUNT8bQstkYA
         YJZ2Jip4hMzzvue7lv++JwK++yjO5iquHNEBasRaQumPN5wF8Q5Asad5DLxhwCcM686R
         Du6UBsQ44cBPuBQMG//e2CeyLCGPDpSpjQgYM83OU5IpPlgeIcJu4cSGgB6cTUwj7UYk
         yI1cvNqMKnQh7RmKdBo0/pF4Wbt44uEm2fxV7kbPGUNUWAIikVIe0iP+xpV+yo47nYzo
         LE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfCY59oNjggvF0pXnEdWdUr+3BwEi6Y/3P8DecThe14=;
        b=lN0NJI2WdQvw0cXeRgp8l6NxtB2JnNW4TXm7B51BFlHLsE+MWmEnzigRxjgeqzhFJ4
         7CIUYZ6h3URWmeLhlgH/df6AuI4HlTdPpYP9r5vHZ4FAcIBbDw31TwVH+XhR62Kwx6ML
         N0Or/2wyP/lnNdsLHJr/as1raR5qQY3wkRJLLP+vlMEWpOSQ8gHCBpOprPvupUwBWSe5
         5+huxPiC65+2uBZrAJBXqsfH5oL3vHh1C+1yqjXH2L7QAz2fAf5bPVygJp1zcn70MyfO
         QvIX0FqtbcP7KjFWSpN62HfSldBKdjyIxdFDwvFUUu7fgvP/WufvhrknMXIZ52d/mzRn
         4A3A==
X-Gm-Message-State: AOAM532vW901g4oxZfxkBuxwlKLx20HqGy0XKF7hL8hsh56d0/AnLlDm
        410pRzeZUW1Pm9hwCwPcKsGoMPQADPGR2A==
X-Google-Smtp-Source: ABdhPJxwkaZx6wLhk8G0L+vx/gm+rQBseHGAsK2n8C3fqXrqDHHf+EzqVgUzxMq+Z9Z7I1isNlanSQ==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr2066568wmb.162.1604316258130;
        Mon, 02 Nov 2020 03:24:18 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/41] [Set 4] Rid W=1 warnings in Wireless
Date:   Mon,  2 Nov 2020 11:23:29 +0000
Message-Id: <20201102112410.1049272-1-lee.jones@linaro.org>
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

Lee Jones (41):
  wil6210: wmi: Correct misnamed function parameter 'ptr_'
  rsi_91x_usb: Fix some basic kernel-doc issues
  rtl8192cu: mac: Fix some missing/ill-documented function parameters
  rsi_91x_usb_ops: Source file headers are not good candidates for
    kernel-doc
  rtl8192cu: trx: Demote clear abuse of kernel-doc format
  brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
  brcmfmac: pcie: Provide description for missing function parameter
    'devinfo'
  iwlwifi: mvm: rs: Demote non-conformant function documentation headers
  wl1251: cmd: Rename 'len' to 'buf_len' in the documentation
  ath9k: ar9330_1p1_initvals: Remove unused const variable
    'ar9331_common_tx_gain_offset1_1'
  ath9k: ar9340_initvals: Remove unused const variable
    'ar9340Modes_ub124_tx_gain_table_1p0'
  ath9k: ar9485_initvals: Remove unused const variable
    'ar9485_fast_clock_1_1_baseband_postamble'
  ath9k: ar9003_2p2_initvals: Remove unused const variables
  prism54: isl_ioctl: Fix one function header and demote another
  iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
  iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
    header
  intersil: hostap_hw: Prevent incompatible function type cast
  brcm80211: fweh: Add missing description for 'gfp'
  ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
    param
  ath9k: ar5008_phy: Demote half completed function headers
  ath: dfs_pattern_detector: Fix some function kernel-doc headers
  ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
  iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
  wl3501_cs: Fix misspelling and provide missing documentation
  rtlwifi: halbtc8723b2ant: Remove a bunch of set but unused variables
  rtlwifi: phy: Remove set but unused variable 'bbvalue'
  rtlwifi: halbtc8821a1ant: Remove set but unused variable
    'wifi_rssi_state'
  rtl8723be: phy: Remove set but unused variable 'lc_cal'
  rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
  rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
  mwifiex: pcie: Remove a couple of unchecked 'ret's
  rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
  rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
  rtl8821ae: phy: Place braces around empty if() body
  wlcore: spi: Demote a non-compliant function header, fix another
  rtw8822b: Return type is not const
  iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
  realtek: rtw8822c: Remove unused variable 'corr_val'
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
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |   2 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   1 +
 .../broadcom/brcm80211/brcmfmac/pcie.c        |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  12 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  12 +--
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-phy-db.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  10 +-
 .../net/wireless/intersil/hostap/hostap_hw.c  |  19 ++--
 .../net/wireless/intersil/prism54/isl_ioctl.c |   5 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c   |   6 +-
 .../rtlwifi/btcoexist/halbtc8723b2ant.c       |  48 ++++-----
 .../rtlwifi/btcoexist/halbtc8821a1ant.c       |   4 +-
 .../rtlwifi/btcoexist/halbtc8821a2ant.c       |  27 +++--
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c  |   4 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/mac.c  |   7 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  |   2 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/phy.c  |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723be/phy.c  |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  |   4 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  |   8 +-
 drivers/net/wireless/realtek/rtw88/pci.h      |   4 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   4 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c        |   6 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c    |   2 +-
 drivers/net/wireless/ti/wl1251/cmd.c          |   2 +-
 drivers/net/wireless/ti/wlcore/spi.c          |   3 +-
 drivers/net/wireless/wl3501_cs.c              |   8 +-
 40 files changed, 120 insertions(+), 270 deletions(-)

-- 
2.25.1

