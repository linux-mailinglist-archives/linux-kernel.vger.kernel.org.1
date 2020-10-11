Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D128A6FB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgJKK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJKK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:28:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F33C0613CE;
        Sun, 11 Oct 2020 03:28:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so10797990pfb.4;
        Sun, 11 Oct 2020 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7mBbC6+mTqe++L9wrnVUKIMogpJ8L60knmXuK08frY=;
        b=O5XX40Gwz5NOfU4DYz01q0GZCGrMjhamVWg/YJogO1wiIoejGMsqHi9PbXOkS2MkAi
         xCi7UeL1yC3s4r6rapAXEOvCk/htxdAoxlqrve+gEP9N/DNGtZwH3Xy0Cc/ZzOEKjyxp
         yUpKO18sddLdQZwU2spmZkffUpP0Al5R93hAAv5q9mYDEAdAlA2vHQI4T3s3q7Npo7Jg
         lZaLVqRmN9x5/zvgs2EfWhOuIRFllJpWgE3RQLAJ2SqXMKq4ozu04N+O/LUR+jmPwe7b
         UTY8aAeTjkod/K7KEk4je/CzwkWw7evq19Jjm0T5N4GGpcRlnb3KZu52kzZRiWToTG5L
         xPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7mBbC6+mTqe++L9wrnVUKIMogpJ8L60knmXuK08frY=;
        b=GgLfzpnw0IABo9PH7SVAUpbp2cODooHk7BxFA3R2ISidl179aNsQK3l6/aAtI2rPxI
         D/u7ocMW5EOKHzERQ9tKWr4G7pTYNTBZWPcZ/tfEwLkS5Si2vpP0SE069SNBhUPpMvj9
         Qw4K6nyhYkQ5Z0FNzRejZKNY/HdPI9AtILJVqiaapyr02zPq30rDB0Va7oVaeMDp3PWQ
         1A4zRNF2TMXGISBS9vyrFB7MYBvh/UwznCjrRoSTZBZZFxa+pFq/OfS0LUOQ4UVjze6b
         Z49K42F6YRQGG0c0iIP6C5wVchXergiYDVYjZSSPt+qthfYkOyfzHOh3VGW0D6Sx7Pro
         LP/Q==
X-Gm-Message-State: AOAM533++Egs3AnMkGF+flY47x+ylDkKQCK5p2W1pd4cVKSCKVCmxiyB
        bX7lbxJDt4fk8hdKfffAkK0=
X-Google-Smtp-Source: ABdhPJwobw6Sc3tEqdMoLLqczAJos/HMXyFYZC5d+DZlAKgO3nQIOBe+WceRF/EAWbry+W9LMeBoFA==
X-Received: by 2002:a17:90a:db82:: with SMTP id h2mr14530648pjv.145.1602412129182;
        Sun, 11 Oct 2020 03:28:49 -0700 (PDT)
Received: from adolin ([49.207.215.73])
        by smtp.gmail.com with ESMTPSA id m22sm15434027pfk.214.2020.10.11.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:28:48 -0700 (PDT)
Date:   Sun, 11 Oct 2020 15:58:43 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 1/3] scripts: coccicheck: Add quotes to improve portability
Message-ID: <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While fetching the number of threads per core with lscpu,
the [:digit:] set is used for translation of digits from 0-9.
However, using [:digit:] instead of "[:digit:]" does not seem
to work uniformly for some shell types and configurations
(such as zsh).

Therefore, modify coccicheck to use double quotes around the
[:digit:] set for uniformity and better portability.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 6789751607f5..d67907b8a38b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -76,7 +76,7 @@ else
     fi
 
     # Use only one thread per core by default if hyperthreading is enabled
-    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
 	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
-- 
2.25.1

