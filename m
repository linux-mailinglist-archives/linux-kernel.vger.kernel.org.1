Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2272F1A08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbhAKPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbhAKPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:49:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F54C061795;
        Mon, 11 Jan 2021 07:49:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jx16so217914ejb.10;
        Mon, 11 Jan 2021 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nz26EZl1RkGwNrj+jl1mlbQS25uGeULWaJt/pXKSpos=;
        b=JMYloT24XZRubnrYbb4kzHKZeABih23xp+oHB4mXtwx5KyoAGI5VbXtESK6CB0OVDd
         kOEVGD4CPtdEHCYEGr6q7E8yyV7ioWwnQ/IC9Y1V67KQkT/Q0IqEp+GgQCJ3TfHTfoD9
         hf97c3DF0VOJelc5Fy+eVNdYTBLCeHvkCi1V4MXKzvwiMSdojlqbXDc96YdenroUn1Ga
         Me0nQfSFIOL4K6EmJAu74JzJ+uJNl+xRQrMyeHmWhCWiUQY9lQfJKQaiSBVMHl73HLGO
         AnEdOytSF6Ys/5pC/NGzd4h7BvaFxZNm8+oXfwTu1FLfz/ZfyRD/Hv0XYv8eowyby67Q
         tQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nz26EZl1RkGwNrj+jl1mlbQS25uGeULWaJt/pXKSpos=;
        b=Cr3CZsHdIbFJ+wotRWL1Z1Z09zcxCHgEXZIwpiYj3fn04qfR7w/UNBp89arpwgBj5P
         Qy1Ie2ZUTvGe9MPyx/zRxlRyCNVBMm290MyyEwoEbfu6o1+v+tV2h/RNZ2dgV0sL1b/G
         ReEQ7iYYFXXV4lmlHGekvYKAz7cvtacZu2I7y+LE9dgA3rFKJOSnWvyfgDNpFap3+DTl
         1SkHVy2vASzeW5pQnKL4/w3+MgfP3ECBBVHsbnFqRs5MJKVCu0b0wzacomO5z22Cv4gN
         vg7vvGXs+Ljzqvbq4WMIjBTvhiPbdiv5iOiFhwB3pcQd8UhNwei7aH+aIU937MjG4xH5
         nR1Q==
X-Gm-Message-State: AOAM532Y7TcGbhmxK/yg2xjbCCjyxeGoMDuscojGfXrTjzVhmAw90u8K
        m7xqaNtzdrE2xMZozSCDynfNHMxd3ls=
X-Google-Smtp-Source: ABdhPJwTyQXbCG+Sg5KV4dlnCCvjR70KHtMkG2IqmwrvqiOl5cYFEu9WZMCxsCBEhbmfuWO7Nqsthw==
X-Received: by 2002:a17:906:d62:: with SMTP id s2mr66990ejh.61.1610380142626;
        Mon, 11 Jan 2021 07:49:02 -0800 (PST)
Received: from xws.localdomain (pd9ea3126.dip0.t-ipconnect.de. [217.234.49.38])
        by smtp.gmail.com with ESMTPSA id d22sm7182671eja.72.2021.01.11.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:49:01 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 1/2] platform/surface: aggregator_cdev: Fix access of uninitialized variables
Date:   Mon, 11 Jan 2021 16:48:50 +0100
Message-Id: <20210111154851.325404-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111154851.325404-1-luzmaximilian@gmail.com>
References: <20210111154851.325404-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When copy_struct_from_user() in ssam_cdev_request() fails, we directly
jump to the 'out' label. In this case, however 'spec' and 'rsp' are not
initialized, but we still access fields of those variables. Fix this by
initializing them at the time of their declaration.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 178f6ab77e61 ("platform/surface: Add Surface Aggregator user-space interface")
Addresses-Coverity: ("Uninitialized pointer read")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 340d15b148b9..979340cdd9de 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -66,8 +66,8 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 {
 	struct ssam_cdev_request __user *r;
 	struct ssam_cdev_request rqst;
-	struct ssam_request spec;
-	struct ssam_response rsp;
+	struct ssam_request spec = {};
+	struct ssam_response rsp = {};
 	const void __user *plddata;
 	void __user *rspdata;
 	int status = 0, ret = 0, tmp;
-- 
2.30.0

