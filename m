Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B42B0370
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgKLLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgKLLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD1C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:18 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so5099774wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptuCzI/J/pK9IazFF47wcnYE5/wwDz9k/tG2ZC99w5I=;
        b=S88QmjUnNDZeCsyETNSmZySh+Xaxhs4CRH6sB6GJSY1DSznnz7bt9ghkTHRhAh0TLn
         BkM+vR6W06OtSum8nppStkpiiqRaeR9TCpjhvs+j9txHemmPUgV4FYSzwg860LqJ6Cr/
         sF4meh0dFzqZesoi600iC+FHeaHQ5dglk9beVgL6ToV4rtSS2/e7r0j6S6gDLMqgrKRO
         fU6hP9QLV0Hb0s3MNfV7NkpveH+QABSfEPg4hsYlfTOTAU4eLe20s3u5E1GMISFtBT8m
         AjRkC4bwbsgThL1CjoTe3s5sphwQhjpV/w+VOooMmtcX/caV9R39763GY2NMVP97t2GN
         U/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptuCzI/J/pK9IazFF47wcnYE5/wwDz9k/tG2ZC99w5I=;
        b=OATD+U/11dWb25kci8ffyerYkGjqdilmMtZFwDmekmyohAu0q+6+BBR2SyWFd2pgJW
         UyaSiGbHt/t24GjfcREcJE/IuUV2T9wvvMhRPkJaiU3rTYvEYsQCykpAAjIiQKU1qslT
         Df1iiSHt5lDIoioJszRaxwcIgkyAdun0YAlou/E3yqlfzAClcs7NogR1Vgg++eN+hSSu
         2UlhIkOs4+oL2E4QspIeiwY9pn4Tu8yqrpxYDbu9Gv0I61Ll9UUca9k6+h581Ip949va
         hL1UILI+L/z3hpyEu0ZFXC6kWFzUCL+Oval7CNLklz9rKQp+V1kNKwmdhmhU2pCdca42
         hOeQ==
X-Gm-Message-State: AOAM531+BF8Rv3KMj2MAz7jzonpWwK6mWCpkCNhHNg2AcmG8VRD5Brbo
        i4wOSvOaMEGVVXP5+ALEqe/BrA==
X-Google-Smtp-Source: ABdhPJxTRgilLM/FjlLiQ1ZsOBcH2s9gUfdLNN/bU2pb/97TwO9nWNbbW1J8uTtBkUr128N53mduCA==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr2954963wmj.26.1605178937333;
        Thu, 12 Nov 2020 03:02:17 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Daniel Ritz <daniel.ritz@gmx.ch>, linux-input@vger.kernel.org
Subject: [PATCH 07/15] input: touchscreen: usbtouchscreen: Remove unused variable 'ret'
Date:   Thu, 12 Nov 2020 11:01:56 +0000
Message-Id: <20201112110204.2083435-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/usbtouchscreen.c: In function ‘nexio_read_data’:
 drivers/input/touchscreen/usbtouchscreen.c:1052:50: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 397cb1d3f481b..c3b7130cd9033 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1049,7 +1049,7 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 	unsigned int data_len = be16_to_cpu(packet->data_len);
 	unsigned int x_len = be16_to_cpu(packet->x_len);
 	unsigned int y_len = be16_to_cpu(packet->y_len);
-	int x, y, begin_x, begin_y, end_x, end_y, w, h, ret;
+	int x, y, begin_x, begin_y, end_x, end_y, w, h;
 
 	/* got touch data? */
 	if ((pkt[0] & 0xe0) != 0xe0)
@@ -1061,7 +1061,7 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 		x_len -= 0x80;
 
 	/* send ACK */
-	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
+	usb_submit_urb(priv->ack, GFP_ATOMIC);
 
 	if (!usbtouch->type->max_xc) {
 		usbtouch->type->max_xc = 2 * x_len;
-- 
2.25.1

