Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4C2A2A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgKBL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgKBL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF337C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:42 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w14so14236522wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctr9VhfYZ+AJvPi8dDIyaqu3jXLLFUsXnVaAd6HF3ME=;
        b=QH8dWp8SvwcdS7PW9KSex6cBdPO1kG8lYYBwvmO0rJnp+6bMm3YoDRdFNXMWoI9ynT
         6qIIeaVyx7owH10PdUe10ygEx6rbYIHdScuVV2egLUD+EQ40mM3z9P9qc+oHosiiKZkQ
         TyfyXKAZDyP5+xm671pEh2Q0JJx3pxHyxnvvph3d/nQhits7loRM5e6fqfkpR1OIEH03
         sH6BH3hhHTnmFYaNfrUH2meSGRet79UF0LD//4aOdjwfi64AvA72HtA3ZnF3YDaFuy1p
         rhHNsN98ATYDX/9L2RHD49srnPmpgH0/ppAXn4fQ/+8B+n0icFADUcqsiR+f384wqvO8
         wjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctr9VhfYZ+AJvPi8dDIyaqu3jXLLFUsXnVaAd6HF3ME=;
        b=fyribwlDAYjrF9sZEjs7PtwHasPsIjBq2SSmLyVI418O4FmVRFgm8m7OFTF5HlkR+8
         5i5SOZt40Iy5KxqK7B8Vut+Wwy4lr7OS2TDbzJs933YB+/T5UC1m0kOB2KRQJBtA8uny
         CDjt22EyjBobzp44O+2Bq3QqlHFqz4v2FPNxB7cEZzMmctXTnD42T1xGLfI+HvRbDrQO
         VfsCVNqptog39Gf2EqquI+hhTgczCmkW4ABd+2kkFT/SaQXuGU+IlbwNQesPhaQxw3K3
         IFD/+54tNoPI+Fvy6OvN/6Pin9N4y2YhuGOe1gq+xxjQnJN/+VuI6Ta1nsosfD6fukuP
         N73Q==
X-Gm-Message-State: AOAM533ztOXxCUyAZqDYpAv5620FbZMsDEnUfHx02qcQ7ZUJJcuu8xZr
        dy6oj0HZXxaTM6W6vvB971uiVg==
X-Google-Smtp-Source: ABdhPJyRZuSKSSFZGyYRL2cwEibxig4zr9s5zu9Zcbz/39vqTgl1m7IX0+ePKa6LPCSdHo1RNbbpVA==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr19296642wru.375.1604318261487;
        Mon, 02 Nov 2020 03:57:41 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [PATCH 08/19] scsi: esas2r: esas2r_disc: Place brackets around a potentially empty if()
Date:   Mon,  2 Nov 2020 11:57:17 +0000
Message-Id: <20201102115728.1077697-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_disc.c: In function ‘esas2r_disc_get_phys_addr’:
 drivers/scsi/esas2r/esas2r_disc.c:1035:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_disc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_disc.c b/drivers/scsi/esas2r/esas2r_disc.c
index 1c079f4300a56..ba42536d1e87a 100644
--- a/drivers/scsi/esas2r/esas2r_disc.c
+++ b/drivers/scsi/esas2r/esas2r_disc.c
@@ -1031,8 +1031,9 @@ static u32 esas2r_disc_get_phys_addr(struct esas2r_sg_context *sgc, u64 *addr)
 {
 	struct esas2r_adapter *a = sgc->adapter;
 
-	if (sgc->length > ESAS2R_DISC_BUF_LEN)
+	if (sgc->length > ESAS2R_DISC_BUF_LEN) {
 		esas2r_bugon();
+	}
 
 	*addr = a->uncached_phys
 		+ (u64)((u8 *)a->disc_buffer - a->uncached);
-- 
2.25.1

