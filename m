Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD728520D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgJFTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:06:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78CC061755;
        Tue,  6 Oct 2020 12:06:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x16so8534903pgj.3;
        Tue, 06 Oct 2020 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
        b=TdIMjj/NUNBepEvRubaDe/8GfKw3Icn3ZwxMrBQ+s3FhE1276H18es7JR3AViuYt4c
         C2aY8JdPuYlha7hXD2PX4XG1o30zQI2+Q3hPNAxbhOKlUUCawmxOhvx+Z+oka7Mh4Ugp
         is8efVZ9wELJgYTqVTMmLaNmJXlJpkcZ2u8JwrVsf0FXzgVcbrlsMK0CzPSMCHSmHDQK
         nnaQwX5EinZGBM8UKc6MlvVYkAr1RtRNcdDgjGyIY++2WkpQ/I8LAabk010LvgzNtTl2
         0qFfIZ91n/oDQlZti6wdPJz/g4TH+4RrNcNk+7XpRkwXwkqTY46MJzhU5WPHLz11Lk93
         be8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
        b=D+5yHeOeptGJV9C97oqVv3WoLpKSGObZFuaUqmZU6fYxDPCvPDCoiEdPIqw8IFIwlQ
         aY2CYRQcCijBx8QmJ6CbOlipWdz3ZPQeqPJl5ONhxox8z/I/ct+nnINjBIfkCsPpfy7+
         nfnQd7f7Kkpxck9QDriJiZZX0e5Eymv70LimJzWOtTpJdzwfvbFK9e9SPR5xdEfAz1Gj
         eMT8drQJZOgmwvmlOtECpHitQib2GsbnxwWNRDgycMWhM7D3DZzjcKPYbi2Wkt/ycRJL
         Q5mz0PKjfL0HhqoE2Xvf8uLk0RVfWLGnDigeVJdVrMnQXAmWVf184UvN0p3jRQ61QfIO
         ir3g==
X-Gm-Message-State: AOAM530WJf6n+0/6kob95qx55fEyEVH+q+LYFlFVO7BOXU0zxVz7FiZ3
        AAOgtiqEAqkpKy+bMmAN0LM=
X-Google-Smtp-Source: ABdhPJxyTXhwK+locjTAlQWxxM1VFrei2oZGqCjlKqd35PRuWS4DiDMdUQvecKz3LS7h3FUIJXSRGA==
X-Received: by 2002:aa7:9afc:0:b029:152:9d45:6723 with SMTP id y28-20020aa79afc0000b02901529d456723mr5918408pfp.35.1602011175862;
        Tue, 06 Oct 2020 12:06:15 -0700 (PDT)
Received: from adolin ([49.207.211.213])
        by smtp.gmail.com with ESMTPSA id i1sm3476625pjh.52.2020.10.06.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:06:15 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:36:10 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2 V2] scripts: coccicheck: Change default value for
 parallelism
Message-ID: <bfda3151b26c8e16c67bd8ab32057e248540de42.1602010816.git.sylphrenadin@gmail.com>
References: <cover.1602010816.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602010816.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
than 8 hyperthreads as well.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..a72aa6c037ff 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		NPROC=$((NPROC/2))
+	fi
     else
         NPROC="$J"
     fi
-- 
2.25.1

