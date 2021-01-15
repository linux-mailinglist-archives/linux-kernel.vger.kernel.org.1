Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E052F80AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbhAOQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAOQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:24:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FCAC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:23:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq1so5336404pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0bWLsMzRrkvBTIGz2qcs1q3qe/AihEtVALbGuZhphZQ=;
        b=Uahn2aILaF+kfuhg1e3jaEezXEZxAqy3IQJHTMJcv+dpWdO3H6ZkZgkgpAdDGEps53
         w4b2SUnUVeRhxgDVYCqAEPNyFxJnzylyw4dLV2Rlg/3+eVDsCts6Mkjh6sK58ogR7zVm
         DUstZa/eUdtYgFnC2Td9n+Ao1fghTX6QAOdP3vU6bHZ/OlpfcrssEIAcg1BWq8jc4pei
         ZYZHRlqgzCZPk2+fo79v7QAMH7zdAd1aqHImuUh8QhadV3nxiofgLTfUK7IKhEey4B+9
         5SsKrUjwIqp030tmTEHn4mYnMPoFeVRmccu8tEOmBoshRHe6w5Wah67QOQZFs782qSt7
         9a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=0bWLsMzRrkvBTIGz2qcs1q3qe/AihEtVALbGuZhphZQ=;
        b=fXM8L5NSN/fVEPV+rxdyYqN/+nuIVXKXu4by5eXOrqDDl/mMYOROxRk7Fti1i4nxu8
         tGy8bVokf846Uic92/EZ/KqkwdUaPtD9GxQIM4RHNBAiSZGuljfPemZC85cfDoT3+ibb
         vNvUEENZ27ALmSyaNO2QAKR+jHA25JcBpRAQ1uyCE1ZlpKDfQ1eheqDPkWYVMSkGsip0
         zI7YuIogHPE5WyTtqlN86BfdRqHm6pf2YP/Jvv6YGVUMebtbCO1Oc+xegKCzbzlyxQ0p
         FZSnhrC9SrYYPcs/mly8MTIUjY4vcaCmPfElbXGTSNhxtxCVyKw/HRP/m82sX4WpjnuO
         bY3w==
X-Gm-Message-State: AOAM532vVOFikV6QDh6nOb8t5kpY+Lfy8E7Q4+v6WxWeFRFJmAaWOtRt
        ZdSqSW1wqH4rweNSnZTu0KcAuuGqLnV6EkyA
X-Google-Smtp-Source: ABdhPJyR9jUdD0f5T0RcVxpMXHdIVprpMgj01Ne22eCwIcE74dzujRUMYWw3xAL6AuuQbgVPi/7NsQ==
X-Received: by 2002:a17:902:8b8b:b029:de:3a7f:299d with SMTP id ay11-20020a1709028b8bb02900de3a7f299dmr11839024plb.16.1610727835637;
        Fri, 15 Jan 2021 08:23:55 -0800 (PST)
Received: from [127.0.0.1] ([14.33.99.107])
        by smtp.gmail.com with ESMTPSA id x1sm8521064pfc.112.2021.01.15.08.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 08:23:54 -0800 (PST)
From:   Jinoh Kang <jinoh.kang.kr@gmail.com>
Subject: [PATCH] drm/i915/userptr: detect un-GUP-able pages early
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Autocrypt: addr=jinoh.kang.kr@gmail.com; keydata=
 xsFNBF/Q7MUBEADVIU6g5ui3gcTQV9jbneUb6xdUQJtEDOWG6pThD+nKAwQFYtZpCUSWgGVg
 osMQTyZu7HpEMvxoYNmO+1ZHtARugq2tl6BH11vEJgTsoF8IFrgyXNlinS+Kq6I8s6py96Pl
 Fk2b9Y3ok64DJUrmFjfgCAxO0RY/ZFS1vXMqibExzMLODTChrXal0Z9tjxQBkARPXeDmVg8c
 qW0121/3ODyi04jri34f5luRQe2PMJsqKAmd6Ok9zNkvc3wQZw7t3MiMEJjf1/eZa/He4OoI
 CO0zQY9dRhQBqgO67lnVziCRfRb4WCHxO03zE7C8ud/UOmuMM4Qh8rAyW3sJ2TbIqwvQepuc
 vC/Q+Av0GtuUCArUw4GbOibUDxhe1eTZViIYAghkzOxUWeDs1PXRPVnRu6PAGsQP39/2ZPAB
 wune9t2SEs4o2Js0Vx0c2O/vMXt3uHqtaGNdCJgqlBkNXHlrv47wF7bBMQSf4SepAg+1ZqfI
 wGgEWmWhBV+8Kqyb1zYIAPsqyvl/2E//XcvKk/70q0QhASGkUvEI8AWAGDdkVPrBfwIqhvWY
 ycMnOl12k5e161uvL1NiUIbvG41/lCzQqhmaDfYznwsC1YRfx/STNaoIdBqR+niUhJbEGpfy
 z1BqOYMHpFx1sKFfJesMDyLBDaQBuO5X2mKmpHvCyfy9ouBNmQARAQABzSRKaW5vaCBLYW5n
 IDxqaW5vaC5rYW5nLmtyQGdtYWlsLmNvbT7CwZQEEwEIAD4WIQRCo/a4eJTkYSJv2ktDGVOB
 YOvS5gUCX9DsxQIbLwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBDGVOBYOvS
 5mhUEACHpb/kXi02ED27HYHk0j4QFokIFSBx4gdMueu86OQzQuJ4LqOZQmX0IsvedmLuECot
 kNE7uhpINj9qNFUZjkD26N2kpnh1EUiHHhGnPAi0KCjsF4t9IR7NgwyeFgScmKAGvDQeLSHZ
 V3A9/ZIuo2cwp9nJKFkljE4P+ADmTpOv2j0XM8o+y7VILnNwanDXuyKh8T37oyecgP0y4aiN
 QcsCfCKgyomFuDomNrj8CwyIS36oyYJwXxl34KBaNLmXRmLFIleApcFkqBewSdAqBWqbu3yt
 V/zbK5uTwx4JKatPk1zgvJKfdHuQW//+H0Rufvosk7JUNkft5T9Cx7Fihts+4HWzvLFU97h8
 E0Tby5paW3/Z8UGRHf+1eYfS39/9hN/Wphw4eoXpN9GDkgMpzKauquHEuKNKwpQ3LuGM4cO7
 TXJLF3Zyx0vwMTu/v4gvILBhppc2MlGDeW48eKH4i4oJhpvjwFku7rh8IG/d0F4I0RpaiqYb
 l3lw0niIVbTKguoMXxhmZLGn8uRuo7CLpqFZyaGOFgPEV889sHE78+FqrXv6cT00cOh6a6p5
 2XlLC6TphePZ56HCcr9n5E2elEI3eCOsGp6UnOPV9mxjmZ/fd512B3goflgq+T9TgOOUSnX7
 ioz/igRhHwjSZd3nlocCmHvWpQ6RaGBH/Bi5lOorts7BTQRf0OzFARAAx8fgWCVxM1CZWKGj
 5HKYV5IJy4D5/YVvi2ob05I18a5lz1dXLOu598rL9gX3V9bZ1k6Q7lh5glNyITnTnlAnpVNu
 zXbPlbJb35Bwmns3OgGi0tCPWxlsn5GZacXUnByVylwcR0OKA9ekWB2CJk0BVpBzKf3c/JgS
 bLNKNG9lpDlypJGMZBWbwODK5HdKKridfUJiFHdE6wErdryjTT75NDTzQoKTeMG/TgyBTLY5
 Ebc6AXryTGGi2THU/ufC+m7/NMhXQGR1dc1dZsPUELXR4XfE36HVfKi3lHT6jY+ylQqIhiQr
 haAun5mpitoOCWyeMvQCrXB+Qe1JzpVHQB2mPZ2RAMD82+wZE3kGh3XiOheY+NFb2ahTvZMe
 otf3/uH6k0LehKt2jVbVjaxAelqCMjBzOlPeaYlD1NTXXX9RGRUUQThfJezcCt/iOv64wayV
 N6ua8dMCrFWzS66bsrsdSmlucB/S7VvNLCFStSJnoW1s4MdQ387NVK3NC41tpx9qVzwIc4X/
 0jS2xA2EHC/+HMx8CXQiXPV98WP2Hd4TEmX4SAiIXuiXrN84ANJx/bPn/iS3QXBiY1YNI787
 oinlL4BJTM+rpZgTgsQk3M0QfenrVIqn7c/L+vk7r0TV4oq/+w2mKLAQX3co00+mrRfANajb
 xA4oODN5wd649jV7NZUAEQEAAcLDsgQYAQgAJhYhBEKj9rh4lORhIm/aS0MZU4Fg69LmBQJf
 0OzFAhsuBQkB4TOAAkAJEEMZU4Fg69LmwXQgBBkBCAAdFiEEzGktrvc/U3kFXd9AGlqQRGyE
 q/UFAl/Q7MUACgkQGlqQRGyEq/WMqBAAhGe/MaK0zyYkMD7ZPgg7rCBhkFAqZg7/UiQE4l1S
 0vZ9HJjV6QhK9MJknzTKWr+r7G1xvfCfVTEubKmFfdgTXXEM61EEGOnGbptwoKVzmYLJpoo3
 WvEHfGoF+vnc4r58GSxfKZCnhn7wRrRs8toGP3FNh6V3wQ2JEXhaT098IpUSo2RnuULzUvFU
 GG0NxB6e9nCoppLF3JUDnf6DdN00gkBgGVd2iKuK8P3Zzy/GJPp4GSw0Y1sFglab71/e9mtQ
 /QZ3z+PgFyAH1vPzmPh0hC5thbdhBoJWrHDpYM7RzcfJOnAyPmo9FufEB9wREESK0yy+2h9l
 fq56H5aBch3TSb23cIiA4x7OhHgkaTmsURiSSh9eP2/eXedClRXvvGMoc/LP837qtZz52eDD
 HcLy7AA2+hPbDqIy+ZxmYOw9bjbLH6QGv2hKGvDwtEF12r4MaYHiae/vbbIOjkQ21m9bc6gO
 5kPqWanl2rpka4PdDmg125MTNyBOZk+83exMY+56eTViccMHs+vUmtqxluR539B8sCHalcci
 3Udb4vUWRNFweYM85utgbSR3MCdsA6r/wuLwIA/vsKzaSTjg2I7KO4/KiNV3AUChafXjAkZM
 hPs3OPukWRSAfHSixxyygLTB52irbfhV/qVsS5RKe2nL6PClmumU9eOdljrZ6FW8mxt93A//
 YocGSec7S3LeWzxauzcQn1TMtuLLMAUs/CTYHBhQDf2UMprHd2O9cpwNULtedXtRSkug/lA4
 BsGzSJsbgoGkR4/D9PQK2FeqzvAkrOmuQqz6iCMxOnaJLAROzTaKlpAqf+h7kP7979RkXttw
 Ax75QQO2oUKhqehvYo1MRZJBVUa4Oq7gBZAe7kmRI78fKAOGUZDQtOpGuvAawR+U6MubgB8O
 8ZP/4DV8x0uzpWugpuCj2+d2heaqrsMumomWt7w4utfz8LFETaK4eIbswwEgB1PpT9nA+0vr
 03mgjzWiW7D5jDPCegZ9a2JcIwKhWTdNR1uayj5hG7rdvScL5zMXlMHGK6Jb9EvBTnmnW/Bh
 mBRUTfAckuZP2GGvcnIv86pcVbLfRsENgN9XVjfn+I+r3pTMjhSIb/B0q2acaINe3GUWIq9V
 o01sX4DgkHW6wE6hlMfxxBq5Avu180VZ96rCilkf8abWidtPn/7IP31CSLz5JNL0x2OQC+WD
 tvgog5utx5uRL5mZPJmMTVD1t/FKGaIR1PpGy4e0g15Y9EkpFEYBYZl3ttXQM456ZqifB/Wb
 pgaToX5LrY7TCHQe9skAN/RsppjrL8HCxF0rz6/LKnUCPC71/dfBIrIigYeBdK9UkNXAq/5c
 Nv8WeK9sQ0q6RmWqnT1HwyCBsVRR18k6XBM=
Message-ID: <c742707e-eb6d-6a22-3006-52dc3bf458d8@gmail.com>
Date:   Fri, 15 Jan 2021 16:23:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If GUP-ineligible pages are passed to a GEM userptr object, -EFAULT is
returned only when the object is actually bound.

The xf86-video-intel userspace driver cannot differentiate this
condition, and marks the GPU as wedged.  This not only disables graphics
acceleration but may also cripple other functions such as VT switch.

Solve this by "prefaulting" user pages on GEM object creation, testing
whether all pages are eligible for get_user_pages() in the process.
On failure, return -EFAULT so that userspace can fallback to software
blitting.

This behavior can be enabled via a new modparam "gem_userptr_prefault",
which is false by default.

Known use cases:

- As a debugging aid, invalid pointers and/or wrong pages passed to
  userptr could be caught much earlier.
- Qubes OS R4.0 uses VM_PFNMAP pages from drivers/xen/privcmd.c, in
  order to map framebuffers from Xen guest to dom0.  These pages are not
  GUP-able, but they cannot be exposed via DMA-BUF either.  Previously
  this issue had gone somehow undetected, until some patch between
  v4.14 and v4.19 triggered it.

Signed-off-by: Jinoh Kang <jinoh.kang.kr@gmail.com>
Cc: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 35 +++++++++++++++++++++
 drivers/gpu/drm/i915/i915_params.c          |  3 ++
 drivers/gpu/drm/i915/i915_params.h          |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index f2eaed6aca3d..5d653df2f759 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -712,6 +712,33 @@ static const struct drm_i915_gem_object_ops i915_gem_userptr_ops = {
 	.release = i915_gem_userptr_release,
 };
 
+static int i915_gem_userptr_prefault(unsigned long start,
+				     unsigned long nr_pages,
+				     bool readonly)
+{
+	unsigned int gup_flags = (readonly ? 0 : FOLL_WRITE) | FOLL_NOWAIT;
+	int err = 0;
+
+	mmap_read_lock(current->mm);
+	while (nr_pages) {
+		long ret;
+
+		ret = get_user_pages(start, nr_pages, gup_flags, NULL, NULL);
+		if (ret < 0) {
+			err = (int)ret;
+			break;
+		}
+		if (ret == 0)
+			ret = 1;  /* skip this page */
+
+		start += ret << PAGE_SHIFT;
+		nr_pages -= ret;
+	}
+	mmap_read_unlock(current->mm);
+
+	return err;
+}
+
 /*
  * Creates a new mm object that wraps some normal memory from the process
  * context - user memory.
@@ -796,6 +823,14 @@ i915_gem_userptr_ioctl(struct drm_device *dev,
 	if (!access_ok((char __user *)(unsigned long)args->user_ptr, args->user_size))
 		return -EFAULT;
 
+	if (i915_modparams.gem_userptr_prefault) {
+		ret = i915_gem_userptr_prefault((unsigned long)args->user_ptr,
+						args->user_size >> PAGE_SHIFT,
+						args->flags & I915_USERPTR_READ_ONLY);
+		if (ret)
+			return ret;
+	}
+
 	if (args->flags & I915_USERPTR_READ_ONLY) {
 		/*
 		 * On almost all of the older hw, we cannot tell the GPU that
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 7f139ea4a90b..b5e0a88c059f 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -197,6 +197,9 @@ i915_param_named_unsafe(fake_lmem_start, ulong, 0400,
 	"Fake LMEM start offset (default: 0)");
 #endif
 
+i915_param_named(gem_userptr_prefault, bool, 0600,
+	"Prefault pages when userptr GEM object is created (default: false)");
+
 static __always_inline void _print_param(struct drm_printer *p,
 					 const char *name,
 					 const char *type,
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915_params.h
index 330c03e2b4f7..323f60298b05 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -79,6 +79,7 @@ struct drm_printer;
 	param(bool, disable_display, false, 0400) \
 	param(bool, verbose_state_checks, true, 0) \
 	param(bool, nuclear_pageflip, false, 0400) \
+	param(bool, gem_userptr_prefault, false, 0600) \
 	param(bool, enable_dp_mst, true, 0600) \
 	param(bool, enable_gvt, false, 0400)
 
-- 
2.26.2

