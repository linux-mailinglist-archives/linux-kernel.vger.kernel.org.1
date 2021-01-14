Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA342F59C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhANEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbhANEII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:08:08 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D4C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:07:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so2904693pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2Xl39y4Q4WYR391MlcCTCVyfvuGNcf13HwTIUJuHYU=;
        b=Qb6XObXve5bZJco/bp7C8Mjv/jUKToZR7oH0hrrN2m1NNs2nsHtpYaKPU8fp/cA+20
         bLvRGonHREkJib6ytNaAoIqyHFr2XurADR8NF0iNI1VXLBEVJYw76gRnsD/grgJgr9G2
         gbNuEJF/9cLexUS9ligs4J8FqBnWPDLG7wp8txFacdnwuQ2/wWk6l3Se5UC95be8hoX7
         Rc9cO7J4SFemacU7exfa8XDg2ruPhqFS4Di1vdhES6ue6g8kZWPhKPB+drMoQHXIAfDf
         yHUCExT3lAW9QXVZXLtx9LHQUsoOkFjL75qrSa2KSvzeKIo9ow4Aeik9xn6qrm887Zta
         iB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2Xl39y4Q4WYR391MlcCTCVyfvuGNcf13HwTIUJuHYU=;
        b=FlAXd8l1c39NZO1/mv9QmqXZY303SX0B92gkDo4vgK/Av31MMwhtL2AquTGtZPm8rU
         G7gcCo/kSrXsE6pFsSYUlKe2rlGIysqvwyvqIIVAsmZgC5ojrY9WacjuwnhexQCWJboQ
         /j7r2oBwOIuhNDR9MbsoiZxPR4ZbgWSniI5Uo5UAiGomSdWc8AiQXlmDXwaxlvQdZztQ
         MNHawfuAbCxAlRXlUPyTgc+qq4F0SrQ5Cem80B2r3acyaK3c1HXLPBuwjQT3GlBUtl/d
         9zyKR8KAgyLYPLBZrxZkNVLCIew3JOvja1llUuFqsuVHXiAI9yfO8kPSxw6/wE3Nwgs5
         BhvQ==
X-Gm-Message-State: AOAM533bqxVUfvcQQqQy4eRAGMBCh61FwckPVA5d4c3FWuUxYXMjZhxB
        2GdIvo9XXXgLtUaWLAE7S+U1bsUs06RRq/XIX5Le9PE6EwZ/pQ==
X-Google-Smtp-Source: ABdhPJweqXyNdG41CizOvJ+7nIJrbD+fB/8boMpyXoL1a0C896awy91uQFO6JUsSaWfp+KbH5/IpEmP/QY+ntvhF6/0=
X-Received: by 2002:a63:5701:: with SMTP id l1mr5424394pgb.381.1610597242082;
 Wed, 13 Jan 2021 20:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20210112053113.4180271-1-morbo@google.com> <20210113061958.886723-1-morbo@google.com>
 <20210113205547.GA21653@Ryzen-9-3900X.localdomain>
In-Reply-To: <20210113205547.GA21653@Ryzen-9-3900X.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jan 2021 20:07:10 -0800
Message-ID: <CAKwvOd=0wWz4o652EoZNvfu1L+fuhuGZusqpxiJ+561DtCh7Eg@mail.gmail.com>
Subject: Re: [PATCH v4] pgo: add clang's Profile Guided Optimization infrastructure
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bill Wendling <morbo@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> However, I see an issue with actually using the data:
>
> $ sudo -s
> # mount -t debugfs none /sys/kernel/debug
> # cp -a /sys/kernel/debug/pgo/profraw vmlinux.profraw
> # chown nathan:nathan vmlinux.profraw
> # exit
> $ tc-build/build/llvm/stage1/bin/llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> warning: vmlinux.profraw: Invalid instrumentation profile data (bad magic)
> error: No profiles could be merged.
>
> Am I holding it wrong? :) Note, this is virtualized, I do not have any
> "real" x86 hardware that I can afford to test on right now.

Same.

I think the magic calculation in this patch may differ from upstream
llvm: https://github.com/llvm/llvm-project/blob/49142991a685bd427d7e877c29c77371dfb7634c/llvm/include/llvm/ProfileData/SampleProf.h#L96-L101

vs this patch:

+ * Note: These internal LLVM definitions must match the compiler version.
+ * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
+ */
+
+#ifdef CONFIG_64BIT
+ #define LLVM_PRF_MAGIC \
+ ((u64)255 << 56 | \
+ (u64)'l' << 48 | \
+ (u64)'p' << 40 | \
+ (u64)'r' << 32 | \
+ (u64)'o' << 24 | \
+ (u64)'f' << 16 | \
+ (u64)'r' << 8  | \
+ (u64)129)
+#else
+ #define LLVM_PRF_MAGIC \
+ ((u64)255 << 56 | \
+ (u64)'l' << 48 | \
+ (u64)'p' << 40 | \
+ (u64)'r' << 32 | \
+ (u64)'o' << 24 | \
+ (u64)'f' << 16 | \
+ (u64)'R' << 8  | \
+ (u64)129)
+#endif

-- 
Thanks,
~Nick Desaulniers
