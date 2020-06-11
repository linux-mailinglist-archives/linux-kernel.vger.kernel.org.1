Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F281F6425
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 10:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFKI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgFKI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:59:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A89C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:59:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so5301496wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYF1qLiVcqC5+ofUdD+N961rSzft8TLHXK3pdCiJAf4=;
        b=cNtnL98yUbK2MCL+1+RKeOROIoB5KILcEmhKmzVSQ0JHP2sFlFMpJK5x2EyYKhMjev
         UWYHxlDYULDROij0/0uRsiQ7ejZvFyVLTCtOnTXZOy6SFSZgP/Um0CgXGUjh7L2HZZzD
         fxpqR3Hc6bXw3PHPrSq/6JElnTuXsntnW7cB3rappNwxzCynIC+beZ119+lurecYIHfz
         DUDRypO35acuvv2rERRb1XWP0578Z+NQGLRsa2VyEQ4cWvO3hFaYL39RyrPgjfUzY+2P
         +ILv81nreYMMHTMpuoJ+R43utIyD2ldbbWuPkOYdZsGJSWeMQSL3WzQ667IWnPZJ50Ph
         tEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yYF1qLiVcqC5+ofUdD+N961rSzft8TLHXK3pdCiJAf4=;
        b=YcWtATxGRbsUrrKP5DfHBgjLKfpY14s5kERHx5sZto0VgpuwbN3JxNW5BOPHlis3Up
         NEGKGuuJ4ojoTAHtXBk9EOm1iTg5Jl8gDcsh7UxrmqC1y3puG+VUCwRHHInWz+H7uSic
         e/hcGpbjFZVzClFhffFxhPQApMiRl55shPBO5CCLz3lJuJE0tmoRfgSL2aPxyiqAsRTR
         XA+IseHgFgb8T110XBB5ElqULwMWM1pdCtXnGCzUJ8YxkbtC0rpF8w1mntNKp/rT+ltO
         4VzjvecRLfR1JVbnJkGM6HngwQqSn9iwrYk3dJdX3PAsYzy4GZi24s7PGG2Oe4b41Jqq
         zMjw==
X-Gm-Message-State: AOAM533xjMKzhHqRMFifvGOtajllb8ntaa+e173aDZFNjz8P7OjA3qGB
        hJ2QHTj+1OBij9ooMAqFj6a5v1fu
X-Google-Smtp-Source: ABdhPJzO7ZN5HbQmNp6JjblxAuLk8K1tfrLxFTX4g+Bjh4JseUCjO7OPQwFC79X7Kj44jaFBkZmWUw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr8137121wrm.93.1591865973844;
        Thu, 11 Jun 2020 01:59:33 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.141])
        by smtp.gmail.com with ESMTPSA id o20sm4205023wra.29.2020.06.11.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:59:33 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] panfrost: Add compatible string for bifrost
Date:   Thu, 11 Jun 2020 10:58:44 +0200
Message-Id: <20200611085900.49740-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mesa now supports some Bifrost devices, so enable it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 882fecc33fdb..8ff8e140f91e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -677,6 +677,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t830", .data = &default_data, },
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
+	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.21.0

