Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCFF2B0375
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgKLLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgKLLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCBC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:14 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so4865454wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMYg6E1kdXm+yD+hzGnKjz5iwy/O1uttWSB8VdrwJX0=;
        b=FvWUQgKMGClbxDUBdDyFjYlNDA1equD1xQMofMZntHFfIbfP4hqtgwFLYvsptlVHFp
         Aa1NGY3qFY0Jl10yCtnWfMq+ZoBMV4QLooxXfoCOy7mnrXWc7Urytan4kp5KKKwb9Usu
         LQCmz5T/bOg/MxxcYK5bq/HlGRONtHdo8DdjAsIf/gWDsqyENToN6DlsU+BL9Ol4Y5xO
         zTz9QsOGi30CLJ7jVaoddpKsC1cxoevAlUDfazrWUQs+TKJ+JJH56sepfrWKDi31VXiI
         qE5yzjYN3ApWdzebtlLXQ96ZKNunUjbulNfTxUr4TA0fAT6M3Ar/VFNlIBuOfXBC0PrH
         pIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMYg6E1kdXm+yD+hzGnKjz5iwy/O1uttWSB8VdrwJX0=;
        b=XNc6MkARSOdx2qhqQLQrpyDkmMp/TsX67NED/j4U3rDr6sfLOTF9OfR+6wXZUTUNeQ
         acG5IFpAW5pTeAbGYcrjPd6c0FH8ksd2F31qmlnHW4LrHZGlKh5g8cLjSOzVQvhW7WVU
         XnnfBdmghjfKFamQsb4xuI2Tr/o11JbzXNxNGbZ1iH1bmf9cVfgLuRm6knlkaWsI1QB0
         /59KYk27TKSWycCqXp+HNw1SV9NOCpfwyOwhljul8iUOJIyG8ZT7WuDb+AMMNBqfJ3WW
         ba2yeZogrbFyZJY2Irdg/rYV8Bz1aAdvRW+WvvsCOiTYc9r0t1maigJjwVwY/+eeLCD2
         hIEw==
X-Gm-Message-State: AOAM532C2dUf8Y4ZvjoPqRIMLqIeMVEfW0XE9ah0yzUGSUmwJHnh+0Q2
        wDskj1AYaUjJOLjwKPFPbrPNpg==
X-Google-Smtp-Source: ABdhPJwBy4vJJPHYddsslHAtikZiVZvUMKoIPiPFJReFQlJnDyFpYrjp1YGMR4WyhQAI+S+Zth578w==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr8918637wmg.3.1605178933396;
        Thu, 12 Nov 2020 03:02:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "K. Merker" <merker@debian.org>, authored by <andrew@goodix.com>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 04/15] input: touchscreen: goodix: Provide some missing function parameter descriptions
Date:   Thu, 12 Nov 2020 11:01:53 +0000
Message-Id: <20201112110204.2083435-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/goodix.c:569: warning: Function parameter or member 'len' not described in 'goodix_check_cfg'
 drivers/input/touchscreen/goodix.c:587: warning: Function parameter or member 'len' not described in 'goodix_send_cfg'
 drivers/input/touchscreen/goodix.c:1165: warning: Function parameter or member 'cfg' not described in 'goodix_config_cb'
 drivers/input/touchscreen/goodix.c:1165: warning: Function parameter or member 'ctx' not described in 'goodix_config_cb'
 drivers/input/touchscreen/goodix.c:1165: warning: Excess function parameter 'ts' description in 'goodix_config_cb'

Cc: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: "K. Merker" <merker@debian.org>
Cc: authored by <andrew@goodix.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/goodix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 02c75ea385e08..80a82a66a0f3b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -564,6 +564,7 @@ static void goodix_calc_cfg_checksum_16(struct goodix_ts_data *ts)
  *
  * @ts: goodix_ts_data pointer
  * @cfg: firmware config data
+ * @len: config data length
  */
 static int goodix_check_cfg(struct goodix_ts_data *ts, const u8 *cfg, int len)
 {
@@ -582,6 +583,7 @@ static int goodix_check_cfg(struct goodix_ts_data *ts, const u8 *cfg, int len)
  *
  * @ts: goodix_ts_data pointer
  * @cfg: config firmware to write to device
+ * @len: config data length
  */
 static int goodix_send_cfg(struct goodix_ts_data *ts, const u8 *cfg, int len)
 {
@@ -1156,6 +1158,7 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 /**
  * goodix_config_cb - Callback to finish device init
  *
+ * @cfg: firmware config
  * @ts: our goodix_ts_data pointer
  *
  * request_firmware_wait callback that finishes
-- 
2.25.1

