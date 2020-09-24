Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229D3276FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIXL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIXL0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:26:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44AC0613CE;
        Thu, 24 Sep 2020 04:26:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so1701672pfa.10;
        Thu, 24 Sep 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
        b=t++PTP8tPJ+iwEph9QoBFhWCTUyYV2fQkZ2iBSq57pAwmIbTUx0kPCQf09yfu2fq1F
         OIxpMxl3aj1ZGzDHGG5NZihgM9UA/3OS8Y6ZM/3iVpmurVHkaR5WPgWIiHHmQbSllJeQ
         VyPf1Juwtf6kH3E36/xgegEkrj/jBafH3vmQ2LH+gdTai0FDVcSP6NEDtRuh9bzq3lsJ
         pCVJ9wI0tCSJ9UTaaaOw9ShuA8aP7OwEWUpJUWHt7nlJyB0o++EwiKnj8kZQz5bDBleI
         lbn/bV+bWac3y+oAzXhcTcGqEFd3ovKWzBaz9fbotXf6vdQj9lxo+dT4MEb7BpQLDtgl
         2dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
        b=ry4bpfYadARHYYRr9XOe8/DUgqVJS+vn2Y+9Qzk6i2gxzHOcaNuxiWOaoEiKOFRnUs
         uvR+an9K0Kq7Fdps948xBTdzsBedvHjvl4P70Disqy6fofmN43UC50J/27z7LQm8xF56
         wl+U1FTpdIj7U523hXAN98IZ8ZkxBqZxy5lpjA8aEeO2bVSl2PYODpAVfyjBX1yePiAO
         vc2xY4LIHIy+i9yeLr9lJPfiUxUMMuqkeNTr39llzAxInkI9iJb5eo2wCacx7A7uXsX2
         2CNu7gNqlkPovuMoXc49C9EUG5/aQh4UMXgufHxSYaaDnHM8rHvGqSwy609lGcR7uq6B
         LYXw==
X-Gm-Message-State: AOAM532L7UtEzLUh7EPufzM2exGtLNiKY9k8VnjMot7PDyNrpZEmAobs
        M9zBjsFo597ONg2g/5MFX/o=
X-Google-Smtp-Source: ABdhPJx/zQj0vFpIP5uEVYYgXRSvDmLS2gwhxhLt6NsgVR9TjnOA6keppJ0CV589fNd4/sIsy3SKoQ==
X-Received: by 2002:a62:dd02:0:b029:142:2501:398c with SMTP id w2-20020a62dd020000b02901422501398cmr3958291pff.81.1600946773777;
        Thu, 24 Sep 2020 04:26:13 -0700 (PDT)
Received: from adolin ([49.207.208.43])
        by smtp.gmail.com with ESMTPSA id br22sm2146559pjb.35.2020.09.24.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:26:13 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:56:08 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: coccicheck: Change default value for parallelism
Message-ID: <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
References: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600945451.git.sylphrenadin@gmail.com>
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

