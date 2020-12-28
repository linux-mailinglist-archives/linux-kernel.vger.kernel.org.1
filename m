Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF92E6740
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgL1NL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbgL1NLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:11:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82104C061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 05:10:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k10so10315953wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zftq0G0O7QGXq9h4glxWYJpeeRtUvNit+ou+JTWbY3g=;
        b=OELhWxcuL53FNsdC6+tcvBdGBwCtiwHpUcARzk9hyAswemPyZAGkZ7Q7hDnvwzUu/K
         fuVSkNQpP7wFpf/0EqMLIG5qPRBqhOBoEEiNPetdKbdZtDwuPAyoTD72Sgg8Y/FI0M36
         bpzCBCcnrk0d+JltV1DQ90m+9470gutUpGDJn/iO4wN8lFvJm5L1vgyxFNZczeiqTBfL
         9DUhQELJ7+06CvPU1y8oJj1KUoOPxKU6sNXTwDxXI6C1TLG6wYsLNVpjzLIN704RkZWk
         Sob8LihCUI8GAk2T+zVem5lFC4Qinixa1CHOQvg6P44gwtPAEm0Inb6lH+UeLSBzhE3w
         89Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zftq0G0O7QGXq9h4glxWYJpeeRtUvNit+ou+JTWbY3g=;
        b=Bmrpdmwj8XxjFyUV9de2Ev1FTQLno3RUrGDtiYWvsF/SaQCX7mgb/EGHiZKCTNGaQg
         uW2PV+1QRAHos/qTXx3ZROyNwWdZGpVmWEfHW682qXbL8aTLi7SOzl9yPlHpM6vY30oi
         d/6gJDB5+RnHBob1VxvTNrHfSattTnqnFZwOFnZa8et9zNgMxTvnJ8dziwn9IYgsArX6
         z/DFuSgD9dfCPq0M4lSUvAniINX5TSLQNylBq9zFpLHZg1Juy2ONkjnJvGNQHuIcRsfe
         IbvfuIe2Gm34EaFU9so4Un5J9dA2jBPOQIXMMD5BxSOGxyzEztzRa93AcsC+XM8vQGA4
         PDcA==
X-Gm-Message-State: AOAM533XX9fs3rR7nTR9osfaiJK4CUTKKXEJfFQPcysbbsFCJOi7rzrK
        0xD7KZAY1ixvx0PMh0/vDZEWtg==
X-Google-Smtp-Source: ABdhPJzpQFEgHuV56rvoENm0o2TMz62ZmYZzx2qPmRPQyU4imjso2CB9zz8eCjqqBcmuNiFqO+/3kA==
X-Received: by 2002:a1c:186:: with SMTP id 128mr20370509wmb.176.1609161037060;
        Mon, 28 Dec 2020 05:10:37 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id a62sm21401461wmh.40.2020.12.28.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 05:10:36 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, slub: Consider rest of partial list if acquire_slab() fails
Date:   Mon, 28 Dec 2020 14:08:53 +0100
Message-Id: <20201228130853.1871516-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acquire_slab() fails if there is contention on the freelist of the page
(probably because some other CPU is concurrently freeing an object from the
page). In that case, it might make sense to look for a different page
(since there might be more remote frees to the page from other CPUs, and we
don't want contention on struct page).

However, the current code accidentally stops looking at the partial list
completely in that case. Especially on kernels without CONFIG_NUMA set,
this means that get_partial() fails and new_slab_objects() falls back to
new_slab(), allocating new pages. This could lead to an unnecessary
increase in memory fragmentation.

Fixes: 7ced37197196 ("slub: Acquire_slab() avoid loop")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0c8b43a5b3b0..b1777ba06735 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1974,7 +1974,7 @@ static void *get_partial_node(struct kmem_cache *s, s=
truct kmem_cache_node *n,
=20
 		t =3D acquire_slab(s, n, page, object =3D=3D NULL, &objects);
 		if (!t)
-			break;
+			continue; /* cmpxchg raced */
=20
 		available +=3D objects;
 		if (!object) {

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
--=20
2.29.2.729.g45daf8777d-goog

