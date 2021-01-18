Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E572FA85E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407412AbhARSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407394AbhARSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:04:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB817C061757
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:03:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dj23so16007123edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VE5dS/K6+mlA/xDSWx/xrkP+6TV7zHaZLCQABHwVPBc=;
        b=niIgAQftt+iRc9Z5Rd0ZBVUIJw+UnBiAL1ORdEAfqHO9a3jOkKW/kVL/UQJf3qOkiT
         aQuAMpm4E8xW0tAf+FTZhBcS8TpfwbxbMHmtQvV6ox9DjnFFkpHa/JKdk+xwsHj9Qj+D
         cM8SLBciAm3LEIcZKQpCr1tQ/WaAlYG2wKbkB04LYXwoxacAgZLi7VtgwrRAKD2A7HrS
         7S7FGTCZuhB1FIMEgUg4dvnL9kt3D/cvHKofVbYo8nGxBBGMEk2Gc/u/YoVJ9MHfSQnp
         Nhf/onJWCx/BAjrrtB5CaACnqxsTPDzlW8F0r4mH5Z40zPMQtA99bhdLoFeHYjDZ4ego
         e1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VE5dS/K6+mlA/xDSWx/xrkP+6TV7zHaZLCQABHwVPBc=;
        b=sC85dg8cWwQmkkdV2ZzB2QdVTPCpzZ+LOjSUZd8QJ6UuK8UHI7ZSSZPDDt4t0U+gau
         3vcuxf71f6K84qR/z1+xrC4E1g7ws3i4665gsX+OfTS1Mr7F77bGwwbkns9yEFjYFh5N
         9My2iksV1I20SqDPBAsb+KvHtKjG7SHIFlwq1achax6t+tl9HLw/6Is6fNhZ8h3KSa16
         cKL0IVxfeJZs2gDCkEjxr17L6sIpbfMaYK3k0fxaaA+1bRBTv1x/t/5BkYxKJW4Ta5nJ
         fviUi82+/E7wr8rFgdZqtWdIsJQ34yGAxFTtzAxDy4MEvI1jTKxIGenODmOPh9JfBXDV
         QqGA==
X-Gm-Message-State: AOAM5334TjIy+vKiTGE3cBdvOmf7WmnKTOlU31Op7Y0dd31yaBbHypnW
        8QUQ+xwzN4bOUGKB0N57v4A=
X-Google-Smtp-Source: ABdhPJzjLHgUaYzajBP6OisVZojLERChVEt+qJ0CvomcPa+ueUUtHlwwBcFkDZX4N3CTwjnZZqvZ3w==
X-Received: by 2002:a05:6402:3116:: with SMTP id dc22mr480138edb.325.1610993020444;
        Mon, 18 Jan 2021 10:03:40 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:4449:7b65:bfa0:95f5])
        by smtp.gmail.com with ESMTPSA id x5sm10651160edi.35.2021.01.18.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 10:03:39 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v2
Date:   Mon, 18 Jan 2021 19:03:34 +0100
Message-Id: <20210118180334.43714-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118180334.43714-1-christian.koenig@amd.com>
References: <20210118180334.43714-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT can't be used when we hold locks
since we are basically waiting for userspace to do something.

Holding a lock while doing so can trivial deadlock with page faults
etc...

So make lockdep complain when a driver tries to do this.

v2: Add lockdep_assert_none_held() macro.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_syncobj.c | 7 +++++++
 include/linux/lockdep.h       | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 6e74e6745eca..f51458615158 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -387,6 +387,13 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	if (!syncobj)
 		return -ENOENT;
 
+	/* Waiting for userspace with locks help is illegal cause that can
+	 * trivial deadlock with page faults for example. Make lockdep complain
+	 * about it early on.
+	 */
+	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
+		lockdep_assert_none_held_once();
+
 	*fence = drm_syncobj_fence_get(syncobj);
 	drm_syncobj_put(syncobj);
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b9e9adec73e8..6eb117c0d0f3 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -310,6 +310,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
+#define lockdep_assert_none_held_once()	do {				\
+		WARN_ON_ONCE(debug_locks && current->lockdep_depth);	\
+	} while (0)
+
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
@@ -387,6 +391,7 @@ extern int lockdep_is_held(const void *);
 #define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
+#define lockdep_assert_none_held_once()	do { } while (0)
 
 #define lockdep_recursing(tsk)			(0)
 
-- 
2.25.1

