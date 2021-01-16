Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9619F2F8B67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 06:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbhAPFMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 00:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAPFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 00:12:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 21:11:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md11so6241721pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 21:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PXzS8aDWu6xxUoSTQEQCGpy3cWp/RHPt68K5SBPTpHU=;
        b=f6u9NKw6hlB4+gXP3wa9Vu/V1R+SfR0yaU/Nfda14ttnWZ7ytHOxjIksewCb/W+KjA
         bGIZcyadotyKfsdLdNnqZdk1oDG4AG5MEQ0691U0XAak4FBuMVHLrph9us+g2AaLJWOd
         +YrD1pIJAPMxAe+/MQv6cjGSv+jW8Bgwj8pRmdG3MxpkwSjQ0rW4fo+DRIofFlO6CYrC
         EyEQCCrvKOUlrwrNdGELpg+JjZCwJddM7e9gubVOLEtgP/QQeAmjyxhwhbOvZufFZOX1
         6jLgUiUKB7zvwVQsp7GYIRv2KRGN4g5cNG5TErOekEYC8x/PQBkQYWqn9ytpppdfpgC2
         ly0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PXzS8aDWu6xxUoSTQEQCGpy3cWp/RHPt68K5SBPTpHU=;
        b=HcOy2qgOtINhpEE8xpxt/XORpA9n1FFJB3HbLnLXQbyRQvl0Hv78k6VNdnVe3CWmNw
         SpOXX4YaIDXD+XhDiunTyvXPEAn4LTwVNtr3srzpV5y0nNxX427WuhXb2RDQQhgPazi8
         rS5Mbv1tyrI+5AyYQ6YTGLOCAIO6o07qNFzKT+5+3mPdAK0x3zBjsJQMPGLY7rnyWRgL
         19YL8KjBB7T90bmV2Q0hm2F+ninBcTwMIo5RHUNRAl5tKnUuGufV79vp6GXP8j6lP2Vd
         hlIZAby+YBqkl7mA2rfTRPmivxy/EQrAbScNXDCPqUURKOKL1WbA1ZhcB9QOH5tM5Q7j
         p/6g==
X-Gm-Message-State: AOAM531NiZSglHI8GiVeu7i7zI+F6sAdsGkY5cQ0i2o46vUveIbAY2Cg
        prXWoEAlbSwYTX9DRRc6cnSEpyOm+CXHlbYZ
X-Google-Smtp-Source: ABdhPJxB+QocAYEUnaEzCn9prdchvObT7nXTPWNr7kqcqRpt50UbpIRTL0K1obB3JmklJQn923zzOg==
X-Received: by 2002:a17:90a:2e83:: with SMTP id r3mr13736820pjd.112.1610773899773;
        Fri, 15 Jan 2021 21:11:39 -0800 (PST)
Received: from [127.0.0.1] ([14.33.99.107])
        by smtp.gmail.com with ESMTPSA id o83sm2285975pfd.158.2021.01.15.21.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 21:11:39 -0800 (PST)
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <c742707e-eb6d-6a22-3006-52dc3bf458d8@gmail.com>
 <161072980241.18103.11713889922046524226@build.alporthouse.com>
 <161073047349.18103.16410031184146072179@build.alporthouse.com>
From:   Jinoh Kang <jinoh.kang.kr@gmail.com>
Autocrypt: addr=jinoh.kang.kr@gmail.com; keydata=
 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
 Nv8WeK9sQ0q6RmWqnT1HwyCBsVRR18k6XBM=
Subject: Re: [PATCH] drm/i915/userptr: detect un-GUP-able pages early
Message-ID: <e3ef8af7-f3fb-a6aa-9838-a90b6d5516ac@gmail.com>
Date:   Sat, 16 Jan 2021 05:11:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <161073047349.18103.16410031184146072179@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 5:07 PM, Chris Wilson wrote:
> Quoting Chris Wilson (2021-01-15 16:56:42)
>> Quoting Jinoh Kang (2021-01-15 16:23:31)
>>> If GUP-ineligible pages are passed to a GEM userptr object, -EFAULT is
>>> returned only when the object is actually bound.
>>>
>>> The xf86-video-intel userspace driver cannot differentiate this
>>> condition, and marks the GPU as wedged.
>>
>> The idea was to call gem_set_domain on the object to validate the pages
>> after creation. I only did that for read-only... I did however make mesa
>> use set-domain for validation.
> 
> Hmm, I remember a reason why we wanted to be lazy in populating the
> pages was that we would often be called to create a map that was never
> used. So the additional gup + bind was measurable, and we would rather
> just have a probe.
> -Chris
> 

try_upload__blt uses the map immediately, so I guess that would be an
appropriate place to patch.

> Basically XShmAttachFd, which is not exposed on libX11.

To clarify: privcmd pages cannot actually be passed by fd, since it's
tightly bound with current->mm.  There's some sysv shmop hooking hack
involved, which is injected in Xorg side.

---

Besides, is there an equivalent code path that lets you eagerly *unpin*
pages when closing an userptr object without waiting for the worker?

This is actually more of a problem in drivers/xen/grant-table.c side,
since it hangs the current task until all page refs are released, and
it didn't even use ZONE_DEVICE pages until recently (while still not
using dev_pagemap_ops::page_free, since the unpopulated-alloc pgmap
is not MEMORY_DEVICE_FS_DAX apparently).

(You could say that we should switch to DMA-BUF instead and that would
be a valid criticism.  I'm merely figuring out what the best workaround
for the current status quo would be.)

I'm using something like the following:
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c       | 8 ++++++++
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c      | 3 ++-
 drivers/gpu/drm/i915/i915_params.c               | 3 +++
 drivers/gpu/drm/i915/i915_params.h               | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 00d24000b5e8..4352a5788fd8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -167,6 +167,14 @@ static void i915_gem_close_object(struct drm_gem_object *gem, struct drm_file *f
 		i915_lut_handle_free(lut);
 		i915_gem_object_put(obj);
 	}
+
+	if (i915_modparams.gem_userptr_close_immediate &&
+	    i915_gem_object_type_has(obj, I915_GEM_OBJECT_IMM_RELEASE) &&
+	    i915_gem_object_is_shrinkable(obj) &&
+	    !atomic_read(&obj->mm.shrink_pin) &&
+	    i915_gem_object_unbind(obj, I915_GEM_OBJECT_UNBIND_ACTIVE |
+					I915_GEM_OBJECT_UNBIND_TEST) == 0)
+		__i915_gem_object_put_pages(obj);
 }
 
 static void __i915_gem_free_object_rcu(struct rcu_head *head)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index e2d9b7e1e152..0ac1dfed0b91 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -36,6 +36,7 @@ struct drm_i915_gem_object_ops {
 #define I915_GEM_OBJECT_IS_PROXY	BIT(3)
 #define I915_GEM_OBJECT_NO_MMAP		BIT(4)
 #define I915_GEM_OBJECT_ASYNC_CANCEL	BIT(5)
+#define I915_GEM_OBJECT_IMM_RELEASE	BIT(7)
 
 	/* Interface between the GEM object and its backing storage.
 	 * get_pages() is called once prior to the use of the associated set
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index f2eaed6aca3d..baa91daf43a1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -705,7 +705,8 @@ static const struct drm_i915_gem_object_ops i915_gem_userptr_ops = {
 	.flags = I915_GEM_OBJECT_HAS_STRUCT_PAGE |
 		 I915_GEM_OBJECT_IS_SHRINKABLE |
 		 I915_GEM_OBJECT_NO_MMAP |
-		 I915_GEM_OBJECT_ASYNC_CANCEL,
+		 I915_GEM_OBJECT_ASYNC_CANCEL |
+		 I915_GEM_OBJECT_IMM_RELEASE,
 	.get_pages = i915_gem_userptr_get_pages,
 	.put_pages = i915_gem_userptr_put_pages,
 	.dmabuf_export = i915_gem_userptr_dmabuf_export,
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 7f139ea4a90b..4d056fd1b6e7 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -197,6 +197,9 @@ i915_param_named_unsafe(fake_lmem_start, ulong, 0400,
 	"Fake LMEM start offset (default: 0)");
 #endif
 
+i915_param_named(gem_userptr_close_immediate, bool, 0600,
+	"Immediately release pages when userptr GEM object is closed (default:false)");
+
 static __always_inline void _print_param(struct drm_printer *p,
 					 const char *name,
 					 const char *type,
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915_params.h
index 330c03e2b4f7..a94367a0345b 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -79,6 +79,7 @@ struct drm_printer;
 	param(bool, disable_display, false, 0400) \
 	param(bool, verbose_state_checks, true, 0) \
 	param(bool, nuclear_pageflip, false, 0400) \
+	param(bool, gem_userptr_close_immediate, false, 0600) \
 	param(bool, enable_dp_mst, true, 0600) \
 	param(bool, enable_gvt, false, 0400)
 
-- 
Sincerely,
Jinoh Kang
