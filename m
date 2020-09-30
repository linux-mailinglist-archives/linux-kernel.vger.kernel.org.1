Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6989527DDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgI3BUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgI3BUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:20:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j11so415410ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=ceFxcTCYRKLuxiHOByyD9j4jdBXW0kpXxXjKaD9WHxg=;
        b=DBxbgXYayiYwdgCUHtw8cmgK7E4F3rxLk6W7yvJ77q+SAVcL7yCMFoaBjRW3LbGxUD
         7Y72wPJpphNqkQjX8sFI1D0s32NfQLIqUDqItk4OWZNA4NeVImf3ZqOYwLKdt0W/3Xei
         /eUTntmGs/UcQijT4MgKu1zdcPxuj6EJF9JBHBNegG3z40hskBdBFyXeN18Ay2pbtsCV
         HYHm+IyYEp0zuULgqnmHTej+SaPLEr63COCMsbbFIGm78MBCMAE/ZIivjfGj2DKyT7EA
         B/ceRn094uhLjQGlCllBfqCkBsXEq3yshO8sX/B0YN6fs7DLA7hBB5mB2eNlE0jkFNwk
         dmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=ceFxcTCYRKLuxiHOByyD9j4jdBXW0kpXxXjKaD9WHxg=;
        b=hR9oi1t5OCSmfyCoOIejAM0ok7OKydh9bD297vH5EuL0ODkGBUgaT6IXgs+xReb/AW
         pfdYOksGDOTm3bfe4XVC00iahBUI+GhxPjJfoaKHHGcZ61g3tvXy6/G3icZQt/7vW5CK
         7AciVarXOHWZNcIh4eFbHC2iR8TrDlo83QZ2qRSKT30EvVxVsH0X7E23E/6E4PVnIMXi
         Zv6To4xQx4SYbeoY5vSFCm7YpRD5KU7gImquQFgVuR2X+ZShB8wxR0FMVvDksF8cI4dB
         GFsFVTAZeyF4oBB3/TRJa1yKYJfqZQBWyukeY2Up0uenpGpEB0QnNLAd2YYgEZOfB5d4
         b44g==
X-Gm-Message-State: AOAM531EE96Oa+uiOEkOtT13+RlBt0SD8ov8dom/c+V6Mapp3gLe8861
        rTNPv8m8tMTqYRyH3zjwgpiI+ViGPwyE5mXZiO1dU7MpDgc=
X-Google-Smtp-Source: ABdhPJxIukGJ1NgumS/+8d48NIsdATIpf5NHra52OAWr6P/EU6U3IDQj2RSqcmptxqHfgaPNTaVX9nfHEaSsOliJ0CI=
X-Received: by 2002:a17:907:64d:: with SMTP id wq13mr364490ejb.513.1601428800706;
 Tue, 29 Sep 2020 18:20:00 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2020 18:19:59 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 18:19:59 -0700
Message-ID: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
Subject: [PATCH 1/4] mm/gup_benchmark: Take the mmap lock around GUP
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be safe against concurrent changes to the VMA tree, we must take the
mmap lock around GUP operations (excluding the GUP-fast family of
operations, which will take the mmap lock by themselves if necessary).

This code is only for testing, and it's only reachable by root through
debugfs, so this doesn't really have any impact; however, if we want to add
lockdep asserts into the GUP path, we need to have clean locking here.

Signed-off-by: Jann Horn <jannh@google.com>
---
This series should go on top of the coredump locking series (in
particular "mm/gup: Take mmap_lock in get_dump_page()"), which is
already in the mm tree.

 mm/gup_benchmark.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index be690fa66a46..558595610650 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -71,6 +71,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	int nr;
 	struct page **pages;
 	int ret = 0;
+	bool needs_mmap_lock =
+		cmd != GUP_FAST_BENCHMARK && cmd != PIN_FAST_BENCHMARK;

 	if (gup->size > ULONG_MAX)
 		return -EINVAL;
@@ -80,6 +82,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	if (!pages)
 		return -ENOMEM;

+	if (needs_mmap_lock && mmap_read_lock_killable(current->mm)) {
+		ret = -EINTR;
+		goto free_pages;
+	}
+
 	i = 0;
 	nr = gup->nr_pages_per_call;
 	start_time = ktime_get();
@@ -119,9 +126,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 					    NULL);
 			break;
 		default:
-			kvfree(pages);
 			ret = -EINVAL;
-			goto out;
+			goto unlock;
 		}

 		if (nr <= 0)
@@ -149,8 +155,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	end_time = ktime_get();
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);

+unlock:
+	if (needs_mmap_lock)
+		mmap_read_unlock(current->mm);
+free_pages:
 	kvfree(pages);
-out:
 	return ret;
 }


base-commit: fb0155a09b0224a7147cb07a4ce6034c8d29667f
prerequisite-patch-id: 08f97130a51898a5f6efddeeb5b42638577398c7
prerequisite-patch-id: 577664d761cd23fe9031ffdb1d3c9ac313572c67
prerequisite-patch-id: dc29a39716aa8689f80ba2767803d9df3709beaa
prerequisite-patch-id: 42b1b546d33391ead2753621f541bcc408af1769
prerequisite-patch-id: 2cbb839f57006f32e21f4229e099ae1bd782be24
prerequisite-patch-id: 1b4daf01cf61654a5ec54b5c3f7c7508be7244ee
prerequisite-patch-id: f46cc8c99f1909fe2a65fbc3cf1f6bc57489a086
-- 
2.28.0.709.gb0816b6eb0-goog
