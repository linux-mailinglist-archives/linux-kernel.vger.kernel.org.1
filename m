Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFD1CD493
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgEKJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgEKJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:11:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so1042572wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CinOkbYS8oPgPVLI49BKt2JzQLqGPZqhctItxxwelA=;
        b=h4rIFRGn0yKy4FgF2CPDHTuSqgim5fjp6Ly9Ueas+XY00rIljDAeF2fRgJ3GyRmMva
         juSun8H2JFb0tKhLNykj5s7WbdhQtMrb6yKjQ3/EG1CrxrYWGuMXykVRWcToDMvHyZWd
         kwRsJAkax1d6Xmna3tnM/71z6J0ExhjpOI7pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CinOkbYS8oPgPVLI49BKt2JzQLqGPZqhctItxxwelA=;
        b=GJw26BVatspKL/eEFhKDETty1xwfqRpT9LRqxM9FrwzH4OkTgxb8RISWJu3KmYsAKf
         KoyL3xEhzpxm9zqpAGh2eJ3GcnnYtFP5f+VAN/TLdythF5CfWz0tiRcQTcAHaY1o5VQl
         mCQoHsl/JjA7zVf2pge160xBCyJC1RzcNpQren4sB7Cc2kgXGRGm5gVf8+9OlG7MEgjA
         q/kXkU4GOBQERsLuAipW9csLrasMusl54MQXUYfBiMx6fBWAk/nlBQxbIC00BmrGJCHP
         7gs43SSBrP9agn5ElEvKtHJ73BPFU60qQP6H6UFeF+If/s2ZQ93IGEmvg+8UV4YGVn2Y
         9nBw==
X-Gm-Message-State: AGi0PuYCRWd7As5JQAUmh059OBw+ICNCTY/g5G8ooRDGnDHsdzZAxjxh
        jca10cXzEQlkVcPCL96jli3ZXd+RBsc=
X-Google-Smtp-Source: APiQypIe/NcTRB7OjwoRrwiqdLysAONSgQ8XmUpqQiiFNg4nNfp3xqmACL1LU9lULCHwhJ4moMYGIg==
X-Received: by 2002:adf:e582:: with SMTP id l2mr18950634wrm.392.1589188315492;
        Mon, 11 May 2020 02:11:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t4sm17506299wri.54.2020.05.11.02.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:11:54 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 3/3] misc/habalabs: don't set default fence_ops->wait
Date:   Mon, 11 May 2020 11:11:42 +0200
Message-Id: <20200511091142.208787-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's the default.

Also so much for "we're not going to tell the graphics people how to
review their code", dma_fence is a pretty core piece of gpu driver
infrastructure. And it's very much uapi relevant, including piles of
corresponding userspace protocols and libraries for how to pass these
around.

Would be great if habanalabs would not use this (from a quick look
it's not needed at all), since open source the userspace and playing
by the usual rules isn't on the table. If that's not possible (because
it's actually using the uapi part of dma_fence to interact with gpu
drivers) then we have exactly what everyone promised we'd want to
avoid.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 	Olof Johansson <olof@lixom.net>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/misc/habanalabs/command_submission.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 409276b6374d..cc3ce759b6c3 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -46,7 +46,6 @@ static const struct dma_fence_ops hl_fence_ops = {
 	.get_driver_name = hl_fence_get_driver_name,
 	.get_timeline_name = hl_fence_get_timeline_name,
 	.enable_signaling = hl_fence_enable_signaling,
-	.wait = dma_fence_default_wait,
 	.release = hl_fence_release
 };
 
-- 
2.26.2

