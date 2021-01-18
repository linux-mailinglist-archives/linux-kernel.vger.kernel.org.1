Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0A2FA20E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392447AbhARNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404804AbhARNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4UKy1ZlErLNFqSWKqt0fMjDDkpt5JLUt2TOmRC3MUA=;
        b=RaJKSMMXT4M4vyynURCu+J8D0PIAY7GHEA9onY8pgVnhDwPW24WM0FFmFYS8o97mz/Db9E
        TNmgGvj2hfoL5u0Urk6PFIhTup/wlcnNwa4qGwauj+gYxfLsxYkUNAXilbkjNpuaEEriGa
        U3k9EomI+evmR+05PQsySOvPXG2dYUo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-7RE-Uw4wPli5WwUc9WI9qg-1; Mon, 18 Jan 2021 08:46:17 -0500
X-MC-Unique: 7RE-Uw4wPli5WwUc9WI9qg-1
Received: by mail-qt1-f199.google.com with SMTP id n22so440734qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4UKy1ZlErLNFqSWKqt0fMjDDkpt5JLUt2TOmRC3MUA=;
        b=k93ecitC4GPz8uXjejjLda/paRL9EUaNMJmszzyK82Uqp47VQuGZb0gBHO7XQXEYaB
         L8HfJdawZSvPbLFBFnPLX9zlNO2chWhCPCh/8n7jpK2im/NsVQ6/rklaQgTREDypIfD2
         lvmyZRHhZes0U5ppyiv52JmBqKyS//dgydF/TsQJnxZzxyoxdbgj7iffagmWAh6uSna8
         lv6BIKa+pTjK0yvEpbOhlZ4hREiRVOpTFNEIRFQpYHWwOtCM28dJHcUwije9Pn6LE24R
         A6E7g0CQntHx/bMPd5YKkGz9fz6HbD7tytL7VL7rNhsEZdrJgt0B6RpshwYMcdqQzdLD
         Y0rg==
X-Gm-Message-State: AOAM530nRkerFgsN8sG/vemNzWr4c4eFGAAdp0OKRMzWDCu5WUKjRT/i
        zgwkg8+ASI8yzz8RXE3h+8y/jG1UaJ5KuxK6BhqebTezc4SUSx7mJ5OjKFYhWPT5jUhSFT+JQpL
        oSSNd8BbJqae4/K6gfY5Xuv/f
X-Received: by 2002:a0c:8304:: with SMTP id j4mr24266747qva.18.1610977575147;
        Mon, 18 Jan 2021 05:46:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfTxYTWOMK1FOKD7X9onRCJISzmAUfQaJXpGwZwHEk8ttsMbuo7RxaMz2e+7c5NBGily/iGQ==
X-Received: by 2002:a0c:8304:: with SMTP id j4mr24266551qva.18.1610977571564;
        Mon, 18 Jan 2021 05:46:11 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o21sm11026169qko.9.2021.01.18.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:46:10 -0800 (PST)
From:   trix@redhat.com
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        peter.ujfalusi@ti.com, robert.jarzmik@free.fr,
        romain.perier@gmail.com, jacopo+renesas@jmondi.org,
        allen.lkml@gmail.com, dan.carpenter@oracle.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: pxa_camera: declare variable when DEBUG is defined
Date:   Mon, 18 Jan 2021 05:45:13 -0800
Message-Id: <20210118134513.613097-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/media/platform/pxa_camera.c:1410:7: error:
  ‘i’ undeclared (first use in this function)
  for (i = 0; i < vb->num_planes; i++)
       ^
The variable 'i' is missing, so declare it.

Fixes: 6f28435d1c15 ("[media] media: platform: pxa_camera: trivial move of functions")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/platform/pxa_camera.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index b664ce7558a1..75fad9689c90 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1386,6 +1386,9 @@ static int pxac_vb2_prepare(struct vb2_buffer *vb)
 	struct pxa_camera_dev *pcdev = vb2_get_drv_priv(vb->vb2_queue);
 	struct pxa_buffer *buf = vb2_to_pxa_buffer(vb);
 	int ret = 0;
+#ifdef DEBUG
+	int i;
+#endif
 
 	switch (pcdev->channels) {
 	case 1:
-- 
2.27.0

