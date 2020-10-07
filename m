Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF5285A51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgJGIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:21:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDBC061755;
        Wed,  7 Oct 2020 01:21:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so901186pfa.10;
        Wed, 07 Oct 2020 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aXnHj21ZmRdqQHlnOGk32CfFVQqD9hJbuHRNZwNWv5Q=;
        b=IcVquq9tiNM3mLjKsREiRFhZvIisIITSrOCJtY8jrZ2man5vXVeSyxu8YB/T9/Pvd5
         TwM6tuIUIZ7o8EdX39mRQQDbJY0qrWby4GxuIJDmbKwp5FuJSev9y3VmojyMMkv5cGVL
         LuHtXVLYRt+SIXS155qW6bmPBrSIKQH8rhTeF/jlSSET18x7HO4c3eTTtWEq28eWtfBn
         IK7a2kAAHnDrW4b7PDv+bNqdGL2U+iiYynHHbRR+HbtBqwATPZiguVCpAlfz2jQ1CZl9
         SNN35G4Q3hwl85DJiEI9cJ19x+nRunZTWWZyM6TNVtqOuiVHBgzd/LlHFJZ/rWUpEZ7f
         0FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXnHj21ZmRdqQHlnOGk32CfFVQqD9hJbuHRNZwNWv5Q=;
        b=Mt8l8ZJeK3KQ15bbhRDgFiOX1IqNwwKIEa+qMkoWuZg+5/EZ1OPjJ9Kjw1Hbset3lB
         kgF4bbE9DYKl1X5bM9XOr/jsDzsTVepRV8aLCqd0ddU8oZPazXHphDoNVybx5d0cEDR7
         0nPlEBkN3nvNU2N0AQGkqOv2PKmBHhyqk6jd3nfPrwkuWcBDIv957lvwPi7CEKHWpoc8
         vdMmRy6JyPL4tgCF6wqDqMy2K+G/RJ2aYfmAqxlr6eU4dlrRI+86y+0lL1/9W4P/kZ3k
         brvAirXCxLV759jiXFu151s5tKKCM6A/bFLgPjhbVr0eiFQqWBW//Wr+FDf3G3wh0wc6
         +jbw==
X-Gm-Message-State: AOAM531wrSgfRtBTdR/J1aMmAmRL7/UersL3cQs9Ue1Y0dMzC8vjUzXd
        AhsXPD4HLPD7eQiAQqVqJN0KQHqrpnNNOfdZ
X-Google-Smtp-Source: ABdhPJyOkeJ3jHOKbW9nrka/ScKbv790DtBRHOuaOCYkW/97v7VP3QvoMXNO6wEFWBSJwnBLP8yu3w==
X-Received: by 2002:a62:84c7:0:b029:152:2f5b:aa8 with SMTP id k190-20020a6284c70000b02901522f5b0aa8mr1939411pfd.3.1602058870547;
        Wed, 07 Oct 2020 01:21:10 -0700 (PDT)
Received: from adolin ([49.207.194.78])
        by smtp.gmail.com with ESMTPSA id o134sm1874244pfg.134.2020.10.07.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:21:09 -0700 (PDT)
Date:   Wed, 7 Oct 2020 13:51:04 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2 V3] scripts: coccicheck: Change default value for
 parallelism
Message-ID: <c5642af8c966e1e4bbe4158ea02009f6db0af932.1602054065.git.sylphrenadin@gmail.com>
References: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602054065.git.sylphrenadin@gmail.com>
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
one thread per core by default in machines with more than 4
hyperthreads.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
	than 8 hyperthreads as well.
Changes in V4:
	- Use J as optimal value for machines with less than or
	equal to 4 hyperthreads.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..bafc55141a73 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
+		NPROC=$((NPROC/2))
+	fi
     else
         NPROC="$J"
     fi
-- 
2.25.1

