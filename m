Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717502DE9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbgLRTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733261AbgLRTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:47:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32155C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 11:47:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q22so2125694pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yg7MsJ706SbGSnOta6LMLPM0AHpDF071o+e8GGkKZg8=;
        b=MmZc/KovMFwoplkadFGMaox8iCBzd4feey0XKRQQeUKfkxGVDdJ8XqmymSiZkcfiZj
         Hs9uHSwN2IiqYE6wlEk2FJT0FPzYqQTBP3bwa8OF5UbBc4ArZvUECBYhuP9vJXPCbHwg
         uss+tj7Bj/m53hp1dUCizS1vCS20ZubPt8XnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yg7MsJ706SbGSnOta6LMLPM0AHpDF071o+e8GGkKZg8=;
        b=QgXnyikb2bNLP5Oz8XQypwRwd8K6d0i8NtMVNUrz+rvW08ohy41FZl1BTjPmKG/8g0
         8P5Ubc2hYN78IFdRYwKF3DYNEUb2o5qOMjWNvgbwio892IKxN7rnDaHlbRql8l1reblS
         NIPj0fL+5EVcXc6gSrUjyCpu7e7phsLt1iuy6wsEImTQfYzy6ZXFLjWAOPVnWeuao0j3
         6MTbUn+HrvVkQOAe+Av6DGbWlXsKNyxXmDaOAo/G/58+NIgS8xj4+PViXjv/daE+8ck8
         EsZcELDd421b0G9jFmlnvP67m+6pD5X9CnX9m0v68RAA6bhM3RXV1HvLTrTSOoiBx9Yo
         c4sA==
X-Gm-Message-State: AOAM531zWLWDcfasGqpObeKOvxyAtdsNPd7khpa1wvdHFjUb13gAnBoa
        1R7eSMBc+f9+PFi/S2QXHZPV1w==
X-Google-Smtp-Source: ABdhPJy717r6dsRuH1Jj7QxMmKipllOb0j2Wah/uZFjOeYQ1zQicv7sNnkUOzI5HpY2uspOqq+zTMA==
X-Received: by 2002:a63:5004:: with SMTP id e4mr5607622pgb.338.1608320834644;
        Fri, 18 Dec 2020 11:47:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm9493002pgv.30.2020.12.18.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:47:13 -0800 (PST)
Date:   Fri, 18 Dec 2020 11:47:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: upstream boot error: UBSAN: null-ptr-deref in corrupted
Message-ID: <202012181131.A231B861@keescook>
References: <000000000000b6cd8d05b6a640ae@google.com>
 <CACT4Y+a2itFzrrE63s0E0zEYzWRhg3eRy+zUishW2dqYrywsnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a2itFzrrE63s0E0zEYzWRhg3eRy+zUishW2dqYrywsnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:38:30AM +0100, Dmitry Vyukov wrote:
> On Thu, Dec 17, 2020 at 11:14 AM syzbot
> <syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    accefff5 Merge tag 'arm-soc-omap-genpd-5.11' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14567b7f500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6efc730c219bd4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=73d662376f16e2a7336d
> > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com
> 
> +Kees
> 
> Not sure if it's related to UBSAN or not, but we didn't used to get
> empty stack traces.
> Either way syzbot can't boot the upstream kernel anymore.

_none_ of them? :(

Are you able to see which UBSAN config is tweaking this?

-- 
Kees Cook
