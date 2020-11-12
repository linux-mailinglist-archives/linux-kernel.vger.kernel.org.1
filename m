Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EE2B0632
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgKLNUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgKLNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:20:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BCC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:20:12 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so5998868wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bT6NBr573z4dRmUGzdy7vOSo0LG9hQOBgI7J9L19n0=;
        b=mgsPSO4Vv1I0HLl+/EpK+bO64s6O30aHTiVXWSNkXtrWiKVu0TONIobdV8BewmbFoU
         gmKhJSfyHbxWuLsrWBbzord4ktUmXpF/JfK8W7GPrkQpwdmHOCV99d8/+u7G6rslcGi4
         T7UW3lD2hbNoZmZOzUqmApvnILA+G/TnMnWP9S6Fb06hjZ+dXQJLn9aSiGrAPx5fGakG
         W8pK1mZW+Frwk+3qur8oKSxcbaZ9gHPuCo6A+OdWIrnZZab8C+2zIpftvjynOTmNKUNw
         JwbYgaKPc/iqYVbpiSRhuVSUKBDzj1++R3rOQjwnVHgJo4nJXLSIHVdqHdgJiPjH6K/o
         DZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bT6NBr573z4dRmUGzdy7vOSo0LG9hQOBgI7J9L19n0=;
        b=nvZPNzB0d/pPq8VX2IUK/GepgPqNpjXptMzF6p25kWl7ITynx7vvcNZ9qg2FnTJcMy
         g4s7uyZwTo/IeywHGCZy17c3pG6fFEPs7FB+PXvAly8GAZK1MsV/CcA1/xTS5OmN5BTq
         55jIuXGR8UVganuOwJaPaKpIPVSh3u5btQZRfMM5knOl9NGNqTyBcKZT6rdA7zqtKnO/
         WKheUqzJE4cCRLQ/S7Cw3VXzuK3A5DdVxSxZmzZeadtTMd3hNce5HC656z6xCVTRVWHA
         HAEERiOd1WfpZuZYDU4651tzuvqxbfiWBU1J4AxnwPQZ8thhljiU+8y3nUpXTkKZDynb
         2VYQ==
X-Gm-Message-State: AOAM532mW/EE3FiV4n4wLSLpSfdWYFOh+/vxEJsDL26fd9q6N0hqw2DO
        oikkXBE8sAkMdG2qKgcog/KwMoTHEP7CVNcj
X-Google-Smtp-Source: ABdhPJyI+2L0X57vYtQloasVb3OMTpYuD6fawy7Bq6HwXGcJSYZ6xpBDXg1Jb9tIfoXKnZ4Ww4pnvw==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr35129463wrn.408.1605187211647;
        Thu, 12 Nov 2020 05:20:11 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t136sm2806326wmt.18.2020.11.12.05.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:20:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yanir Lubetkin <yanirx.lubetkin@intel.com>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 6/6] staging: net: wimax: i2400m: fw: Fix incorrectly spelt function parameter in documentation
Date:   Thu, 12 Nov 2020 13:19:59 +0000
Message-Id: <20201112131959.2213841-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112131959.2213841-1-lee.jones@linaro.org>
References: <20201112131959.2213841-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wimax/i2400m/fw.c:647: warning: Function parameter or member '__chunk_len' not described in 'i2400m_download_chunk'
 drivers/net/wimax/i2400m/fw.c:647: warning: Excess function parameter 'chunk_len' description in 'i2400m_download_chunk'

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
 drivers/staging/wimax/i2400m/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
index 9970857063374..edb5eba0898b0 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -636,7 +636,7 @@ ssize_t i2400m_bm_cmd(struct i2400m *i2400m,
  *
  * @i2400m: device descriptor
  * @chunk: the buffer to write
- * @chunk_len: length of the buffer to write
+ * @__chunk_len: length of the buffer to write
  * @addr: address in the device memory space
  * @direct: bootrom write mode
  * @do_csum: should a checksum validation be performed
-- 
2.25.1

