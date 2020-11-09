Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6182AB5F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgKILHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgKILHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:07:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF05C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:07:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so1125117wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J57Co4keOJLPpkOAtm30WeNaGboSbDo7KGbxSzSraLw=;
        b=HhaZo+nOQzKzvbAFydHzhq/fvxbfXxDfWyMZKdv59I7MN/VIBjySEDnQMe/RJ80TcA
         NqPHcZzpiT9Vl9Yv9IKKm9MwVsxWHCkStLHrUf+NXGH1EdedBhImimOgYD1RGc+hVmS7
         w0LenYwK8h9OxuojkNtPP/U49HQw6iHdNr1gHrLWaakhF3wjn2TLICq+r+Fvsy9Kj7WT
         gmAKJGEedbXEoO0msCfLubbx9HXBW+3H7tEdvhbVHTF26G/FKgFsRpd/Awh3sW7fPLGz
         7w8aHtYKHTSY1GKa52i0+6eq6D3dhx5U74J+YXZObagUWKCdgL97HF3UpwbYvvsgC9kA
         GnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J57Co4keOJLPpkOAtm30WeNaGboSbDo7KGbxSzSraLw=;
        b=c/5Bcv9WRJGLRFW0EKXMmsaYdxSdCSyeMIpKgtMLlDWQb+L53PLt83faQHujGNaixo
         +odVSS7XmhikW2fkba9QKLEChOVB9n94WRPpGg6IMWgvZJcrsUMmCZF5TbyImhGMwzL0
         y3B5vWLjmBtN09b15LzbbL+sKP+FTQj4crlUQVdf7nYqLz86061ammC97GUZVRwc+nVS
         TKelBxbVyR5UUZSb21cILkMA6L9wtZxgrJM2bVtQrtVI7Uib4ke5Wr3X1mmxR2hd/SHs
         61yZwUh83g9iAoUYe7IiMKCe9/VtoLw6ZZi7dXnfRZbc0vmqeoUoqxaCsPJSzMVr0UKc
         gSLg==
X-Gm-Message-State: AOAM532npuzAOr5GQQ3T5sEZ3lFvDnLGUdnwiQjXZ/uspo1R1tOSEY11
        BeOErDQ8MYzUirr8HeCGIMLtRw==
X-Google-Smtp-Source: ABdhPJzNywkuCE6gKvE4DqCuDXqgftMItDHnLcQ5bFuAdPNNL+1SS5MLyT2l3jA/w7yub/ZI0a6q7A==
X-Received: by 2002:a5d:438f:: with SMTP id i15mr17558818wrq.121.1604920033391;
        Mon, 09 Nov 2020 03:07:13 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id d3sm12815582wre.91.2020.11.09.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:07:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        alsa-devel@alsa-project.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 8/9] hwtracing: intel: use krealloc_array()
Date:   Mon,  9 Nov 2020 12:06:53 +0100
Message-Id: <20201109110654.12547-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110654.12547-1-brgl@bgdev.pl>
References: <20201109110654.12547-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 3a77551fb4fc..7d95242db900 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -2002,7 +2002,7 @@ nr_pages_store(struct device *dev, struct device_attribute *attr,
 		}
 
 		nr_wins++;
-		rewin = krealloc(win, sizeof(*win) * nr_wins, GFP_KERNEL);
+		rewin = krealloc_array(win, nr_wins, sizeof(*win), GFP_KERNEL);
 		if (!rewin) {
 			kfree(win);
 			return -ENOMEM;
-- 
2.29.1

