Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3E2D342F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgLHUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgLHUcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:32:11 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F7C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:31:31 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y8so1586357plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpPpi8VoMtsoCPIRy8jenvKh8eCrXui01GBoXCmAibc=;
        b=Gje8dhYAHnzmhozDV6nyAB+eibl0NgYpORU05kDPkIsFQm37tYrnN4/L5WpaA6uvS+
         +dHvy4ZXN5zo4qJlmIohacYz1zhwiR/rtYyTWwJJkoG/BYkpxYe4DqDiHWO1G0udLWou
         1SE763ZcU8jYBPs4Sw8FnjLo5u6/kP+LatT4YlexzoE/lP6uul6Bwq7qCPg8w9eQDohr
         GADmErF1mrU4ZhcphF1gcZDAHe1M4sEMEjXCsCP6RDQPv+yg+Ad6+iXiDc+OU9sLeEGp
         f10bwiv7KZrCdvjE52W3zNx8L0cQ8XX6FbT+jBECaVlKTrFlaRkYVNHsf/Nozqzzrro7
         qBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpPpi8VoMtsoCPIRy8jenvKh8eCrXui01GBoXCmAibc=;
        b=ShUJsbzL9kNRNrIb8UG6k6uRdTwr32ULFG3k5BDxbEYhwI2nf0+4O2kEeEZe4J0MRT
         XRKmnM6uz/LWtIPSRB+1bkcrMdk6WskF280Wzh/wDFV5Al0toLLODLcl6mo73Z/BvMAX
         Iz+Uvsc+18IU4JBUdTRfVe/J18OznsosgZANdjTWqVNU2jC9+TsavfHvlbGuLJSRRKVG
         STlkoiREQF5TT4+ZH2P0st3tXM0d0SRd6UvkSvc/tl5IkN9jGKqM+fiOCvh2p9va6E1W
         uB+Sw5Xuiri1fjoNZsySb/Spc7dV/IDnoCHLVZiQ5Q+tIYm+p/KxawuEOnQlyBn7C1Tp
         INsw==
X-Gm-Message-State: AOAM5326XlO16y3y5bwdS4w5tok/U6L6DR+hQM4JmCdigQPJGNQni9jb
        E2nCVb9/eZau0vffnchbz+USJYc3rF7I5LocZi1gs4A9YGseXg==
X-Google-Smtp-Source: ABdhPJwfAM3wWeibHv8RrcoIhrJYGQjLkXIowS5Q4MiQJ6CrIMru6ycDzCbJFu7Uh1Oc0y/LYVfq5je68a5SrPqTFLM=
X-Received: by 2002:ad4:59d2:: with SMTP id el18mr22835717qvb.35.1607457778234;
 Tue, 08 Dec 2020 12:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain> <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org> <20200911085841.GB562@jagdpanzerIV.localdomain>
In-Reply-To: <20200911085841.GB562@jagdpanzerIV.localdomain>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 8 Dec 2020 15:02:47 -0500
Message-ID: <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, yezengruan <yezengruan@huawei.com>,
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

On Fri, Sep 11, 2020 at 4:58 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> My apologies for the slow reply.
>
> On (20/08/17 13:25), Marc Zyngier wrote:
> >
> > It really isn't the same thing at all. You are exposing PV spinlocks,
> > while Sergey exposes preemption to vcpus.
> >
>
> Correct, we see vcpu preemption as a "fundamental" feature, with
> consequences that affect scheduling, which is a core feature :)
>
> Marc, is there anything in particular that you dislike about this RFC
> patch set? Joel has some ideas, which we may discuss offline if that
> works for you.

Hi Marc, Sergey, Just checking what is the latest on this series?

About the idea me and Sergey discussed, at a high level we discussed
being able to share information similar to "Is the vCPU preempted?"
using a more arch-independent infrastructure. I do not believe this
needs to be arch-specific. Maybe the speciifc mechanism about how to
share a page of information needs to be arch-specific, but the actual
information shared need not be. This could open the door to sharing
more such information in an arch-independent way (for example, if the
scheduler needs to know other information such as the capacity of the
CPU that the vCPU is on).

Other thoughts?

thanks,

 - Joel
