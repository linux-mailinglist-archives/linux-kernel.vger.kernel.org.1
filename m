Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DDD29ABE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440525AbgJ0MSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:18:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40297 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411738AbgJ0MRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:17:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id k18so1201997wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2L3lr/8sLf7Z5y8Aim//8p5VZua449ayHzLh+PHsAEM=;
        b=I6NX/4rt5CDmPWW1saFsLZWRkPzrAH2KBDwRbhX67CXdUXPPBiQxknBpev7HNopX7v
         T4hCqsqEQ+8slSjg9oVsWiouDFBCjUxT2tQhZ7IsbEhntldfWt0pGCC18RYKkF8HyqJx
         9RTh6mcLw4a5t85mWwIRiBjPnX8DfWDpwoFyv2x3tXDUqIcE4ydx14krTVgwR7Mujyzi
         c7FeX7rajI1jIGSq0UFLTHM/eXW6rmNIQ+ewJ8tVOZErdCBzyF6pzeFt8JKoMnrfmiqh
         HH4RQszopE21d3R0VoR6twetVnWG7wRPJVw9OB9Ugbj6v6iDFbcVtXVpkFtNwEVIqDq0
         2QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2L3lr/8sLf7Z5y8Aim//8p5VZua449ayHzLh+PHsAEM=;
        b=eyrg8JxXSNWf2mqiazaFCCYniL6j0RHAVTeTE1bpJN+4GJe9uClOAEUtsczRl8K0mI
         3Hs5YyaMVfFU1RGFcGTU/p6emBj/JNP32ePCMY3UsriCFWf5Z1t81beeztFMeJ86cVpf
         1nex9v7CyOhuXlYg1nD+5ETRzVfqtGzm7/bODxp5dU/D2e80In4d5+mjk7IRUZtybgda
         k9SnZfTCwqEB9SDwUv4w43sXgUFATEg4vKaB5De4wzUu9dYL0dWhJNUUj88V1QDCb8VG
         ieTxIwsJxgO4Hv5svHFsZGTHQnD8njSN8OINymwgOv9ZgOUKa7R2J10fpaZaZlxQQ0sZ
         w9nA==
X-Gm-Message-State: AOAM531VTJ3LMK3XygAC/q6YUTFq+E73lLXHBpmX8ZXZrPK6az1aAlzr
        PZQqOkAqHS5QWBmp5A1xnZ8yrw==
X-Google-Smtp-Source: ABdhPJwnQfDZtXuM3jzzK38lXBwCGy/kfsjXsJcKEg+cED0SodtStCj40BizmPHJbimBDnnjg0sfuQ==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr2463834wmc.4.1603801057987;
        Tue, 27 Oct 2020 05:17:37 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id a2sm1731908wrs.55.2020.10.27.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:17:37 -0700 (PDT)
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
Subject: [PATCH 1/8] mm: slab: provide krealloc_array()
Date:   Tue, 27 Oct 2020 13:17:18 +0100
Message-Id: <20201027121725.24660-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027121725.24660-1-brgl@bgdev.pl>
References: <20201027121725.24660-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When allocating an array of elements, users should check for
multiplication overflow or preferably use one of the provided helpers
like: kmalloc_array().

There's no krealloc_array() counterpart but there are many users who use
regular krealloc() to reallocate arrays. Let's provide an actual
krealloc_array() implementation.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/slab.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index dd6897f62010..0e6683affee7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -592,6 +592,17 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 	return __kmalloc(bytes, flags);
 }
 
+static __must_check inline void *
+krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return krealloc(p, bytes, flags);
+}
+
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
  * @n: number of elements.
-- 
2.29.1

