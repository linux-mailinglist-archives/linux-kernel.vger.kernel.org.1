Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9089B2B063A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgKLNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgKLNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:20:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F6C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:20:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so6003271wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7iFgNzjupYbkhuJ8ppUAnhnD6gEMwq5fnIgnkH5hQg=;
        b=xraKgwigr/3WOJ5/Z6ypYZXDmivlx16frB+i1AcULwNtfPPaL2QkclE4D9d6xSDk+y
         KtX84j8cy3C8188Z56CgA2Ec4qtJL/w0pADmaA3TXMIRDJOF2yF1+4XG+X383rojWTeF
         Pw/SMd+y6waKOyHZ+5xSamHLhCWDAKRO+cKNGC+uREUoNQHAq+1EZnAcD+bO5Ivx65tP
         pELabNcfICfoyJLlHJHKfWqLa+0bD91R80sjfp104cukICbWR0tgLtD5kmvMwSrhsajC
         Cgklf98XLad3yOrLH2qTWFBvWW6Z7eLJ8wiJWY/4wrLkh9Y0YB5FJo2MWLcWofw/fHXu
         D1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7iFgNzjupYbkhuJ8ppUAnhnD6gEMwq5fnIgnkH5hQg=;
        b=sC+ktkWAJuSGiZcBz8wAlB3lNUO2h16X1ESu6sBdbFVv2S7UR9zltH9c7ObNb/9DfI
         s4NgSTyM4zVDsqJggpMhxGuFpmrVRXAa2SbZI18iP/wgNrS3uJdp6vOa5FgDf7c4yFtu
         JWNLfXtjbOSnG9qle8kwaSMnu/JG0yXUMR1+dIe9kJPdmlZ0vdDzr0dHA43hvdksAWBj
         AD1O4otNtFjE0jtOx0TqFqoFholFB3IYvG0jaWAszp7wO25cXjlqriulQoTJ7MAn9SKw
         QZn/cc671uGlFnHly6hjIwVZlLV5Xk0HhZL6dVd7mJQh76HzlN5/idpdCWXS8/n89E5s
         uXxw==
X-Gm-Message-State: AOAM532b/ELUMOY0m8M3vtNTY1lXvgvJ+K4OmirHmGrTbNKuZn2Qbvy/
        2T/fGab6CFa7SGBeVX819nGhzg==
X-Google-Smtp-Source: ABdhPJzuIs7PpfSu/WiiGoB50ZqQyuxz+iEHv+8tsyK0usK3trHVokWiSyVgGqFbYbfBWpMw7zyczQ==
X-Received: by 2002:adf:f347:: with SMTP id e7mr25933848wrp.183.1605187210191;
        Thu, 12 Nov 2020 05:20:10 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t136sm2806326wmt.18.2020.11.12.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:20:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yanir Lubetkin <yanirx.lubetkin@intel.com>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 5/6] staging: net: wimax: i2400m: tx: Fix a few kernel-doc misdemeanours
Date:   Thu, 12 Nov 2020 13:19:58 +0000
Message-Id: <20201112131959.2213841-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112131959.2213841-1-lee.jones@linaro.org>
References: <20201112131959.2213841-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wimax/i2400m/tx.c:715: warning: Function parameter or member 'i2400m' not described in 'i2400m_tx'
 drivers/net/wimax/i2400m/tx.c:964: warning: Function parameter or member 'i2400m' not described in 'i2400m_tx_setup'
 drivers/net/wimax/i2400m/tx.c:1005: warning: Function parameter or member 'i2400m' not described in 'i2400m_tx_release'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: linux-wimax@intel.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Cc: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/wimax/i2400m/tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/tx.c b/drivers/staging/wimax/i2400m/tx.c
index 1255302e251e4..e9436212fe54d 100644
--- a/drivers/staging/wimax/i2400m/tx.c
+++ b/drivers/staging/wimax/i2400m/tx.c
@@ -681,6 +681,8 @@ void i2400m_tx_close(struct i2400m *i2400m)
 /**
  * i2400m_tx - send the data in a buffer to the device
  *
+ * @i2400m: device descriptor
+ *
  * @buf: pointer to the buffer to transmit
  *
  * @buf_len: buffer size
@@ -955,6 +957,8 @@ EXPORT_SYMBOL_GPL(i2400m_tx_msg_sent);
 /**
  * i2400m_tx_setup - Initialize the TX queue and infrastructure
  *
+ * @i2400m: device descriptor
+ *
  * Make sure we reset the TX sequence to zero, as when this function
  * is called, the firmware has been just restarted. Same rational
  * for tx_in, tx_out, tx_msg_size and tx_msg. We reset them since
@@ -998,7 +1002,7 @@ int i2400m_tx_setup(struct i2400m *i2400m)
 }
 
 
-/**
+/*
  * i2400m_tx_release - Tear down the TX queue and infrastructure
  */
 void i2400m_tx_release(struct i2400m *i2400m)
-- 
2.25.1

