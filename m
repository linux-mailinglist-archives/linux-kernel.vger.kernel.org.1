Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26D27CBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbgI2MbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:31:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42572 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgI2MaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:30:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id j2so6117693eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5K1RsZycD7BnQ8mECakiQ/2HzkXZ73MXqfcF+5Rj0bo=;
        b=HFt5RdjD6i6vc6tkpxZ5d2DLIrB/OIAGVVkSencqLGlH68p4aro0SuuJan80uoiK13
         PrnnoNiWccUITb/KXGstW776YLEPabeY9An3dktHnQLzTBRay8gkKJty3T0SGDGKcItL
         M2CtnZNQp87zjvvVavtL7RkKZGN0X3UweaWlT6+gOS910egjcInxORxtGmt9Lm6kwX2K
         nvUTENxDL4vjyMn5zQTMcZCtQtWbnT25DAEQ98MPr/HAh1ubv2+zfpt8ggeaVU/df8Tn
         xwT5NeOCoAReV1fEfdWbMsOMjPZlT6weme5Y4H5Ulw5fEkv6+rcqmxh+Ra0hMp+162Bg
         5A1Q==
X-Gm-Message-State: AOAM533F/tNIOM5ML6SL/ZOD7482mw2dP4PUEO1DadCYKRiHApzBKVaU
        HdiIqCA9GkFD9OT6nAoHZek=
X-Google-Smtp-Source: ABdhPJx1UQvfenHa4EGvDQpqkY2w+8j7N45V2SRB3alkbRagkD9tkMPOaHYeOYcfUwDHVnNr9p1Cow==
X-Received: by 2002:a05:6402:b9a:: with SMTP id cf26mr2852464edb.375.1601382616592;
        Tue, 29 Sep 2020 05:30:16 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-253-123.eurotel.cz. [37.188.253.123])
        by smtp.gmail.com with ESMTPSA id b20sm5389568ejv.9.2020.09.29.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 05:30:15 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: clarify usage of GFP_ATOMIC in !preemptible contexts
Date:   Tue, 29 Sep 2020 14:30:10 +0200
Message-Id: <20200929123010.5137-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

There is a general understanding that GFP_ATOMIC/GFP_NOWAIT are
to be used from atomic contexts. E.g. from within a spin lock or from
the IRQ context. This is correct but there are some atomic contexts
where the above doesn't hold. One of them would be an NMI context.
Page allocator has never supported that and the general fear of this
context didn't let anybody to actually even try to use the allocator
there. Good, but let's be more specific about that.

Another such a context, and that is where people seem to be more daring,
is raw_spin_lock. Mostly because it simply resembles regular spin lock
which is supported by the allocator and there is not any implementation
difference with !RT kernels in the first place. Be explicit that such
a context is not supported by the allocator. The underlying reason is
that zone->lock would have to become raw_spin_lock as well and that has
turned out to be a problem for RT
(http://lkml.kernel.org/r/87mu305c1w.fsf@nanos.tec.linutronix.de).

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..2e8370cf60c7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -238,7 +238,9 @@ struct vm_area_struct;
  * %__GFP_FOO flags as necessary.
  *
  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
- * watermark is applied to allow access to "atomic reserves"
+ * watermark is applied to allow access to "atomic reserves".
+ * The current implementation doesn't support NMI and few other strict
+ * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
  *
  * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
-- 
2.28.0

