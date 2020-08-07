Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7A23E514
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHGAWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 20:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHGAWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:22:51 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC1122CA1;
        Fri,  7 Aug 2020 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596759770;
        bh=pkcY1cimNMDbQ9RVzs4TpVS5NVc1IMyxBAvdaany3Ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CBY5GhyfGS56YW17PsneEppDyAsgHKiXTuc4R6MJRFpNeCl4vnKNXGZq4BDlX4UvG
         vZ0FVCF8FV76orHhhKOfPpGRploLz4Hsn/gfykUNLZ5mZ/Fqq9eZEzB4LOUDrLPmpM
         Nu/Ac/qbC1DEg+/xTIAUmqz1pGsnE6HyHvNDiXc4=
Received: by mail-lf1-f51.google.com with SMTP id j22so104228lfm.2;
        Thu, 06 Aug 2020 17:22:49 -0700 (PDT)
X-Gm-Message-State: AOAM5321kAYb12fjSqpBSnXpoW7oBL1+8Z8KlSCuSEdnN+Tefb5eYdaK
        bFcCS/TDYrCYT7MPY8VPRCUUjDTIRUC3yQqepUU=
X-Google-Smtp-Source: ABdhPJyvyRLn9ReqXtclDsN0AdxBbUGkzogNbRrTyBVZBSevpv0l7yNHrrJvXec12YOi9ul/FEn/LKGODqJ0zC26mI4=
X-Received: by 2002:ac2:44d4:: with SMTP id d20mr5041848lfm.137.1596759767874;
 Thu, 06 Aug 2020 17:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Aug 2020 08:22:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRqi-HuxJsMOjHTpaf33f1L9LypF-FkWo8OZm4SP12Hnw@mail.gmail.com>
Message-ID: <CAJF2gTRqi-HuxJsMOjHTpaf33f1L9LypF-FkWo8OZm4SP12Hnw@mail.gmail.com>
Subject: Re: csky: smp_mb__after_spinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ren Guo <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Aug 6, 2020 at 3:53 AM <peterz@infradead.org> wrote:
>
> Hi,
>
> While doing an audit of smp_mb__after_spinlock, I found that csky
> defines it, why?
>
> CSKY only has smp_mb(), it doesn't override __atomic_acquire_fence or
> otherwise special cases it's atomic*_acquire() primitives. It has an
> explicit smp_mb() in its arch_spin_lock().

Yes, csky didn't implement ACQUIRE/RELEASE in spinlock.h. So it is a
redundant and side-effect wrong macro, we should remove it to fixup.

TODO:
 - implement csky's ACQUIRE/RELEASE barrier

> Also, why have two implementations of all the locking?

I just kept my baby's codes :P. Now, we could remove it and just keep
the ticket's one.

BTW, I want to change the spinlock to qspinlock, but csky only has
32-bit atomic operation in hardware.

Any plan to deal with this in spinlock?

Maybe for the embedded scenario, qspinlock seems a bit heavy, are any
tickets-like comm spinlock infrastructures in the plan?

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
