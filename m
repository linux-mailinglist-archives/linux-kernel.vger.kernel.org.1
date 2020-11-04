Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0153F2A6980
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgKDQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbgKDQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF795C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:25:07 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e2so2902051wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUgG9h/tqc78+buLe1wAWz/4+Vyvpx2KQ686RNHflno=;
        b=gQK/xp857nk6m1GRx6GUgrGDA+ULtaOWWxe8LqhpsySyUVzL5isfOvta12JVHGrOJi
         gzBr4aR2aznK/K+av2uj6BCAZCJNtzWBsQqjFjtp6dh0FLh1MhVneHsELlJiU7Ih9dUk
         FKTIqlsTU/SYXYkqDlpwcuf3ZqNxQhPwOwmnyu180LS7IiFEz/iG+niRZdPqyM9XFa9y
         xRGeC2Vzg26JaeztJ6SM5pIj6YPKOxEoyad7HJFWZZlp8ZD5wrR1u8GSb2/bXLIRBguK
         gWWDG+1zfCdjrgaQyjm1rPrJxyPGuIO+GSPa4vDVX3sbVw8pQEOuOxkm/1ByPEO3n090
         YUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUgG9h/tqc78+buLe1wAWz/4+Vyvpx2KQ686RNHflno=;
        b=YsSrroXCh8XVXrQmpmyAoS0FT3Pabf7JMb21X5ZJqy7X05zDbKVTtvi0zmTZC51uwM
         RTtfZQgGAMD1bTIKNHlYtCjiLQIESQiBqyOmfj3STxCZ7N8hRNKAZRlor0v4BBBmiXVU
         jjcjCcqQNRQB81ULh5DX1D8KTSgfEbXSQ2o35GjTZlg+/trdVHIwQw4Git10C8/wGV5s
         A2cTO1k+Kc326malZMNzgXRILOPc9obG6LqIBofXDXF/9Wy0bhDI81O6zwycJr/RPUnj
         c1Et+iTT5JKKLaU+OHqV/ZbFgxlieO2Ru/rZm1G2/ozWemphat3BMmmOCIHu9ynqa1G+
         1Nvg==
X-Gm-Message-State: AOAM5324H7nZYq+t5AOTEkFsM1qYjM3TOfE/yC0VFGZ807yyCpxRviqE
        ZMQBLSQFtRubWnAjkB1ZJ/DRhA==
X-Google-Smtp-Source: ABdhPJxVaASBytTSgq8ExCJqrw3ThXNu25G6bOifGtb0/Nz2b6YDRxmAq3xZ/yDVcMCCuomPSAvHhg==
X-Received: by 2002:a1c:9c51:: with SMTP id f78mr5726303wme.189.1604507106433;
        Wed, 04 Nov 2020 08:25:06 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org
Subject: [PATCH 20/20] input: keyboard: pmic8xxx-keypad: Fix kernel-doc formatting
Date:   Wed,  4 Nov 2020 16:24:27 +0000
Message-Id: <20201104162427.2984742-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'num_rows' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'num_cols' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'input' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'regmap' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'key_sense_irq' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'key_stuck_irq' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'keycodes' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'dev' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'keystate' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'stuckstate' not described in 'pmic8xxx_kp'
 drivers/input/keyboard/pmic8xxx-keypad.c:106: warning: Function parameter or member 'ctrl_reg' not described in 'pmic8xxx_kp'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 91d5811d6f0e1..36bee6f5a8af0 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -76,17 +76,17 @@
 
 /**
  * struct pmic8xxx_kp - internal keypad data structure
- * @num_cols - number of columns of keypad
- * @num_rows - number of row of keypad
- * @input - input device pointer for keypad
- * @regmap - regmap handle
- * @key_sense_irq - key press/release irq number
- * @key_stuck_irq - key stuck notification irq number
- * @keycodes - array to hold the key codes
- * @dev - parent device pointer
- * @keystate - present key press/release state
- * @stuckstate - present state when key stuck irq
- * @ctrl_reg - control register value
+ * @num_cols: number of columns of keypad
+ * @num_rows: number of row of keypad
+ * @input: input device pointer for keypad
+ * @regmap: regmap handle
+ * @key_sense_irq: key press/release irq number
+ * @key_stuck_irq: key stuck notification irq number
+ * @keycodes: array to hold the key codes
+ * @dev: parent device pointer
+ * @keystate: present key press/release state
+ * @stuckstate: present state when key stuck irq
+ * @ctrl_reg: control register value
  */
 struct pmic8xxx_kp {
 	unsigned int num_rows;
-- 
2.25.1

