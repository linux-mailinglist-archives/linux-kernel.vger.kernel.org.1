Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5628E7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgJNUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:04:29 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E29C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:04:29 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n142so303759ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGovuSkrqe3VpGrjEQXbflGvhILsF7fMmDOvOv0HZ20=;
        b=DmMNN2qmYsS4IUMJxDlpsTT/dyttCIlI2O/iRpGPsOoMVgY2VUB3FsKzLAdAllhOw6
         4WpXo9010agGLYSz5jufxNIum4wr/kq84c5wHHPZrFisDReUBtp/cNN7QU66pCr7twnU
         9qnOBQ966moAM6YTleIjUmrgQIKq+R9JM6DsNuqVDnKlPYpxYV/GLN9xC3Usg9hkTWKY
         H3aCOH+sgNsWBj+4p2m2RpM4iMEkCHBoAvLAf+yDq0Q+UHO6trWQ5RWvtf/Aw+0Mk5vK
         KCe3y8+0Bv23QOqUlh+X27SX0Uq2vvPEQ4nplyk9EwzpkLyA1Nq4ff6WPPlHSb+BZkZy
         pnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGovuSkrqe3VpGrjEQXbflGvhILsF7fMmDOvOv0HZ20=;
        b=VGypH2pwjq7EEmFBcbFV8WnnRPXPKZXdH5qm+p6WNr7EDWoZxHB95+AtRp0Fr6vvCK
         GTluH4CHsMmnN0nErU1x5L7iMqH16RFyaLGvYSH3/+IQf7iqpMw4mOAXv4sVspVEGqj6
         21yTQxgj+tj3lNfWwZRGrF6Rzx8E6Tn9YWp38oJJwrYMQUWkIdvX0/KY7M20Bk3zNY6C
         Xis6aZnDmx0Xa+uXWWFOPDtAEKD+Ym6SG4k3R7NJCo8fbgsROXf0msgwSgHfBbx75w8T
         G4W8/bqyDYV8zCrX5b+I1qETcNFaSzyVj0iMiMQUCPDha5rSwKvzMUa4fUdg8YuImqLT
         gGPA==
X-Gm-Message-State: AOAM531r23F8NSJy/kO9eWOyQ+KSOtCDJMooJb6rdGl4DvT+4E7dK1+E
        NRTCFwDU54yeejuMUsjQmdJJpm+ycwCj9gr7UBvh5g==
X-Google-Smtp-Source: ABdhPJyEzfM9Ywu3QG2apMCdipxoXOO58m8ggHr0w0quLiQI/TLNpmE4HyYz3y8+OuT7tRmbBNkVGKUJhwp1vvzO8ds=
X-Received: by 2002:a25:d6c7:: with SMTP id n190mr584642ybg.75.1602705868286;
 Wed, 14 Oct 2020 13:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net> <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
 <20200804142344.GM2674@hirez.programming.kicks-ass.net> <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
 <CAFd5g46DzWRzp9yXkpHbtyJuv236E=z7OaWeqXnfuiy6CTBL4A@mail.gmail.com>
 <CAP-5=fXhFG9sTMcfd1qJmMDNJWqOGky=jFtWNWg8U8-dkRp=dQ@mail.gmail.com> <20201014195948.GE2974@worktop.programming.kicks-ass.net>
In-Reply-To: <20201014195948.GE2974@worktop.programming.kicks-ass.net>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 14 Oct 2020 17:03:52 -0300
Message-ID: <CADQ6JjX+Hqw7Lm61BfMHrELya81boaYRrYmGH-o8xTBAgD_KSA@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 5:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 14, 2020 at 11:16:10AM -0700, Ian Rogers wrote:
>
> > There were some issues in the original patch, they should be easy to
> > fix. I'm more concerned that Peter's issues are addressed about the
> > general direction of the patch, verbosity and testing frameworks. I
> > see Vitor followed up with Peter but I'm not sure that means the
> > approach has been accepted.
>
> I kinda lost track, as long as it doesn't get more verbose I suppose I'm
> fine.


Ok. I'll send the v2 later with Ian's suggestions.
