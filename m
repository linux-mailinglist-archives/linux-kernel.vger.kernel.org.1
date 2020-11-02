Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CC2A295C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKBL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgKBLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB8C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:38 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so9016059wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgKtNmQfGnZeeFNwZJm+JSbHcTG8sEx1i9uktjmVfHw=;
        b=i3uJLVTT+f1uHk778AEbxWbp76ef0Zolzm5KhEUJI9JMCrAutQejRy3I8vLNlEeQMa
         7QsPuO7mYdtDdQPy5te+frEyNqP4eOg9FSoB1FxNCQwIu/5SMAFrABvUWPXVMPdw+tM6
         IIByy21e8J0g+HlK1QLEppXXgKNueApiZGeVkQXQ249AvgfuLGTd8wEKwL+ynaX6/Bfl
         vKaIQQB33RZhn28DxarVzKPBnF7qRhG/6oSaLMeV/bpkUGonKIbcZgJ5SVF2/TM9/lNv
         ogtDfWzmSUa2V7A9IC4dcbfww2TZ8o7UR8tJhfohL8kuIxfnngeDbCewvWl12nI1MwQN
         qbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgKtNmQfGnZeeFNwZJm+JSbHcTG8sEx1i9uktjmVfHw=;
        b=YAGdLZY59H8h8s9lXEvZn6Fx68Enx3H1VcspqrAy6VBO2XOSX5u7f+7GT9flOoUsQv
         PP01ELo9B1483mFnxwUDosXeoOHwgKJh2rm/XUyZw7ncYVLoiI8lbqzOi5rSQ+7YjC9E
         QvPPmkFq7q06uOqqmnlAXRdZPBxkgrWwTxVR0pWtpd7leHqtw9uzKKaGpMjci0twNznO
         uQ39X45cv70wrFuYQ/v3Zd1Mq3mx+6GQKVId9gZ88B300SEb0qhVRBvMTX5MamXyHh7W
         vhxiaxYIBHKAg8cca2DvPJ9ArOqfxfTn2HVTNoKdfb0rKIFQS6NPs+WEA7e16EfMOXzH
         ocmg==
X-Gm-Message-State: AOAM533zWQ/Tt1ahAVEjBcDfU4QvKyr+6Jpy1w3yUyJUJqhB/xEEZwur
        zAAQoJICsqk2cji8TqcVbdi9GQ==
X-Google-Smtp-Source: ABdhPJyAOYg9hMZPlI3j1Yh7cVoiGhT7yXwb4qjsxPf/PAekthok34p1zg7w7Ge5Mj8+HqUqIhCyLw==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr17006821wms.130.1604316277548;
        Mon, 02 Nov 2020 03:24:37 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 16/41] iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's header
Date:   Mon,  2 Nov 2020 11:23:45 +0000
Message-Id: <20201102112410.1049272-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c:340: warning: cannot understand function prototype: 'struct iwl_eeprom_enhanced_txpwr '

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
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index cf7e2a9232e52..f29d5758c8dff 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -324,15 +324,15 @@ enum iwl_eeprom_enhanced_txpwr_flags {
 };
 
 /**
- * iwl_eeprom_enhanced_txpwr structure
+ * struct iwl_eeprom_enhanced_txpwr
  * @flags: entry flags
  * @channel: channel number
- * @chain_a_max_pwr: chain a max power in 1/2 dBm
- * @chain_b_max_pwr: chain b max power in 1/2 dBm
- * @chain_c_max_pwr: chain c max power in 1/2 dBm
+ * @chain_a_max: chain a max power in 1/2 dBm
+ * @chain_b_max: chain b max power in 1/2 dBm
+ * @chain_c_max: chain c max power in 1/2 dBm
  * @delta_20_in_40: 20-in-40 deltas (hi/lo)
- * @mimo2_max_pwr: mimo2 max power in 1/2 dBm
- * @mimo3_max_pwr: mimo3 max power in 1/2 dBm
+ * @mimo2_max: mimo2 max power in 1/2 dBm
+ * @mimo3_max: mimo3 max power in 1/2 dBm
  *
  * This structure presents the enhanced regulatory tx power limit layout
  * in an EEPROM image.
-- 
2.25.1

