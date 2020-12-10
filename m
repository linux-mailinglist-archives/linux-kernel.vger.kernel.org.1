Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F182D506B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 02:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLJBke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 20:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLJBkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:40:33 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 17:39:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so3412368qkq.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 17:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkkzP/3Zui9Zv09UQ8xwBLPz4oeTJ7sNlMALQGeGM70=;
        b=hCANu9k4ewHIF7sm5Uv/kEc/lz/9YpR/XMKI5w/v0gDeaUr9s2G3suJ+K31I9aK4ke
         GpbwzxUQd2O9XsJ5ZFD8daBsFSjz7gxo0faf8kjkYNxhH279uSM6U84NC32MIjJ+QfXh
         T/XWR0E9bxf2f8kCvbN38k2SSSh2H4AEY6f6jIOgxDrBAeJTTMic3owOqzu+XfP6b+1Q
         IHdsAAvj0Uu3zkEPHUqkaypul6c96gmzXhhKztpKXAp4jIvwIxq6q4DM9kTAW1zUiW2l
         6JIdGjevbyBTvKXoMO6Y+41+zX7sakqulVCN3Jt81e1jxiYesfoq1vXj2vUpUIbDDOmF
         IAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkkzP/3Zui9Zv09UQ8xwBLPz4oeTJ7sNlMALQGeGM70=;
        b=r0u1tgVuKo2KKD2A5Gj9/csznObQ49OQLrBtV8TF+WQnCqmS4EaI58TdY11foY7b6d
         9JTKUV+mfHuG9l889Gvlp/sUl6oiET1xlJoYuAurVrrI/uZxiOTPbP4kk3XueLu+/gNN
         HdE85i907zE9YjnhMqoQRNgP1OWljSb3QOqTvmpI+ucEeN5MCGyYBeU68ifJMcjjUs8M
         tX9VFUBM8d678yqok1CV1ojf8NnCeLSUZn7DegbUA3XdFbrK92935+qf0nKefkpiwtOs
         +/xJPhHAsvhKTxxCpL1rGVPShj0mJ0etKAUB5m6FAqyRxI4jViqoX4BZVogevM+OsHII
         BGGg==
X-Gm-Message-State: AOAM530ARMPxXn5YnM4sIjHKhXCPUt9e+ihXjoUfD3ZTMO/30cwYJCQj
        7PppY1R/jFOscxNMjITFpnOthhdLpcdQDlRaQ6nCpA==
X-Google-Smtp-Source: ABdhPJwwtzbyx8dv0A/bOYjE3eOzs3Dzd25CeqEwi5hkYuP378MTpDXYUPC+uMy3SAH/E3OYSul0Sai4Dwdkz425wO0=
X-Received: by 2002:a05:620a:805:: with SMTP id s5mr6444986qks.80.1607564392357;
 Wed, 09 Dec 2020 17:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain> <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org> <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com> <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
In-Reply-To: <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 9 Dec 2020 20:39:41 -0500
Message-ID: <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yezengruan <yezengruan@huawei.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvmarm@lists.cs.columbia.edu,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, nice to hear from you.

On Wed, Dec 9, 2020 at 4:43 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi all,
>
> On 2020-12-08 20:02, Joel Fernandes wrote:
> > On Fri, Sep 11, 2020 at 4:58 AM Sergey Senozhatsky
> > <sergey.senozhatsky@gmail.com> wrote:
> >>
> >> My apologies for the slow reply.
> >>
> >> On (20/08/17 13:25), Marc Zyngier wrote:
> >> >
> >> > It really isn't the same thing at all. You are exposing PV spinlocks,
> >> > while Sergey exposes preemption to vcpus.
> >> >
> >>
> >> Correct, we see vcpu preemption as a "fundamental" feature, with
> >> consequences that affect scheduling, which is a core feature :)
> >>
> >> Marc, is there anything in particular that you dislike about this RFC
> >> patch set? Joel has some ideas, which we may discuss offline if that
> >> works for you.
> >
> > Hi Marc, Sergey, Just checking what is the latest on this series?
>
> I was planning to give it a go, but obviously got sidetracked. :-(

Ah, that happens.

> > About the idea me and Sergey discussed, at a high level we discussed
> > being able to share information similar to "Is the vCPU preempted?"
> > using a more arch-independent infrastructure. I do not believe this
> > needs to be arch-specific. Maybe the speciifc mechanism about how to
> > share a page of information needs to be arch-specific, but the actual
> > information shared need not be.
>
> We already have some information sharing in the form of steal time
> accounting, and I believe this "vcpu preempted" falls in the same
> bucket. It looks like we could implement the feature as an extension
> of the steal-time accounting, as the two concepts are linked
> (one describes the accumulation of non-running time, the other is
> instantaneous).

Yeah I noticed the steal stuff. Will go look more into that.

> > This could open the door to sharing
> > more such information in an arch-independent way (for example, if the
> > scheduler needs to know other information such as the capacity of the
> > CPU that the vCPU is on).
>
> Quentin and I have discussed potential ways of improving guest
> scheduling
> on terminally broken systems (otherwise known as big-little), in the
> form of a capacity request from the guest to the host. I'm not really
> keen on the host exposing its own capacity, as that doesn't tell the
> host what the guest actually needs.

I am not sure how a capacity request could work well. It seems the
cost of a repeated hypercall could be prohibitive. In this case, a
lighter approach might be for KVM to restrict vCPU threads to run on
certain types of cores, and pass the capacity information to the guest
at guest's boot time. This would be a one-time cost to pay. And then,
then the guest scheduler can handle the scheduling appropriately
without any more hypercalls. Thoughts?

- Joel
