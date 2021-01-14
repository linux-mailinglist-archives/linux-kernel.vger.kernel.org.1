Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87BE2F646E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbhANPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbhANPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:23:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB06C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:22:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h16so6092305edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDiw0Eb4xl1qF//Pb3TXsca/MjYdq3TONkBKPeZe8Cg=;
        b=1Cb4ioaHuRGiieQdZlf/1QqgfoHXXG4h1gtjUVbkDKamIgHsIKzmvlT3LELHXSDDD+
         jL4r06FBy80TLTjUF7gyyTlwIpfznuUnZbR0t9UyYCmP0NzomrI8mqcZ990FN1V3b1Sw
         H018piSNecxU2ahmyFjf3Ye5CURe/83mLGf//1CTB9sBNvoWxLy2e4UfvStEbRt0Q8Bm
         UBuspQOz5lN0USjlTmBWKyge3qw06IOs4ymzvoqwICRdXGGIcz6NSxHQkWSFAzKH91QD
         8G9K0ly6sAY4PB2wjOe0ZK2jhsdKnCalTi28lHWuSb0CCGRfhxnlYqIMqDBtsO8/RU/K
         MOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDiw0Eb4xl1qF//Pb3TXsca/MjYdq3TONkBKPeZe8Cg=;
        b=Dg+DpFWU6f7DU570m4ofbR026/gOTHPe3qMecBT2NociZGYU0LNF6ujodBysr9FIWd
         EZ711hwoLUEpnZcROxEHiHYOF4yGbzjYFySUsmr6XjyqH6Gvr6r4ODPOl5YLv+yOwLO9
         ooUdj2pHNXhDqyDqCD0GD/QnZnFoWuAAvSJUNJGE0BtP2dRzj8xVnPx7+L/+5Mp8DOPN
         DA97WJ28FaSM5UYxoVc4d43/UMJL5xCNHqJtekK7p4Cx42htdBImNPsCE7Gq/L38F/AV
         EIDLlI7BfrjNCLrfZ3saZhJVeElDcJMjbFgT+ABxj/S+kDwZdbYKy9gAJfFnkXxKFMh2
         wyiA==
X-Gm-Message-State: AOAM532E6l3kzEtKQv6apj87w8K+aB3buP3rFoPRrwVrWcagm4sdqBgM
        fv8oJLLRL+LHWSxKAVkwwTCJZFOkZ3vNQfrd+UOXILlgIg==
X-Google-Smtp-Source: ABdhPJyV59NKAh4E0zWqslpwmhaYLEMm7IumyRUG73CvA8pRa2E1iYwW6LGLMXN4mlGlo02BPrpz342U6rsnokOLYq8=
X-Received: by 2002:a05:6402:ca1:: with SMTP id cn1mr6088321edb.128.1610637758780;
 Thu, 14 Jan 2021 07:22:38 -0800 (PST)
MIME-Version: 1.0
References: <202101142125016321850@zte.com.cn>
In-Reply-To: <202101142125016321850@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Jan 2021 10:22:27 -0500
Message-ID: <CAHC9VhS=FWMWeTmLHtpVOrjL=j-89cjH+rYktcUZd8rj_fSc=w@mail.gmail.com>
Subject: Re: Fw:Re:[RFC,v1,1/1] audit: speed up syscall rule match while
 exiting syscall
To:     yang.yang29@zte.com.cn
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 8:25 AM <yang.yang29@zte.com.cn> wrote:
>
> Performance measurements:
> 1.Environment
> CPU: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> Linux kernel version: 5.11-rc3
> Audit version: 2.8.4
>
> 2.Result
> 2.1 Syscall invocations
> Test method:
>     Run command "top" with no-load.
>     Add rule likes "auditctl -a always,exit -F arch=b64 -S chmod -F auid=[number]" which doesn't hit audit.
>     User command "perf record -Rg -t [top's pid] sleep 900" to get audit_filter_syscall()'s execute time ratio.

Thanks for providing some performance numbers so quickly, a few
comments and thoughts below ...

> audit_filter_syscall() ratio with 100 rules:
>     before this patch: 15.29%.
>     after this patch: 0.88%, reduce 14.41%.
> audit_filter_syscall() ratio with CIS[1] rules:
>     before this patch: 2.25%.
>     after this patch: 1.93%%, reduce 0.32%.
> audit_filter_syscall() ratio with 10 rules:
>     before this patch: 0.94%.
>     after this patch: 1.02%, increase 0.08%.
> audit_filter_syscall() ratio with 1 rule:
>     before this patch: 0.20%.
>     after this patch: 0.88%, increase 0.68%.

If we assume the CIS rules to be a reasonable common case (I'm not
sure if that is correct or not, but we'll skip that discussion for
now), we see an performance improvement of 0.32% correct, yes?  We
also see a performance regression with small number of syscall rules
that equalizes above ten rules, yes?

On your system can you provide some absolute numbers?  For example,
what does 0.32% equate to in terms of wall clock time for a given
syscall invocation?

> Analyse:
>     With 1 rule, after this patch performance is worse, because mutex_lock()/mutex_unlock(). But user just add one rule seems unusual.
>     With more rule, after this patch performance is improved.Typical likes CIS benchmark.
>
> 2.2 Rule change
> Test method:
>     Use ktime_get_real_ts64() before and after audit_add_rule()/audit_del_rule() to calculate time.
>      Add/delete rule by command "auditctl". Each test 10times and get average.

In this case I'm less concerned about micro benchmarks, and more
interested in the wall clock time difference when running auditctl to
add/remove rules.  The difference here in the micro benchmark is not
trivial, but with a delta of 4~5us it is possible that it is a
small(er) percentage when compared to the total time spent executing
auditctl.

> audit_add_rule() time:
>     before this patch: 3120ns.
>     after this patch: 7783ns, increase 149%.
> audit_del_rule() time:
>     before this patch: 3510ns.
>     after this patch: 8519ns, increase 143%.
>
> Analyse:
>     After this patch, rule change time obviously increase. But rule change may not happen very often.
>
> [1] CIS is a Linux Benchmarks for security purpose.
> https://www.cisecurity.org/benchmark/distribution_independent_linux/

-- 
paul moore
www.paul-moore.com
