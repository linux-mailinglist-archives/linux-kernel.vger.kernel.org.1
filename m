Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662AC2D49F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbgLITRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733106AbgLITRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607541356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjbYSkTUKJTra9F+rU4vKjR/ApBdCFoCJ6AA7j7gnIY=;
        b=UCGeKEzliNliiuGDVp8uOIWIw9n6OznEVbUJRMA1ePZaeKHfZXf2U89VYRyDvc0QfbVcot
        x5JjJ+zXmVor0KoYQ0rSfzfM+TbOP3qfFMI5lZ51LU3ScPmYSGWZgZuPQ4wniM8f/8QRDg
        jRDOjfTjX3dFvljzJRgYZNaDlwYXHEM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-GUDrdtb-M9CtiR62oaMt3Q-1; Wed, 09 Dec 2020 14:15:54 -0500
X-MC-Unique: GUDrdtb-M9CtiR62oaMt3Q-1
Received: by mail-lj1-f199.google.com with SMTP id z26so2564198ljm.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjbYSkTUKJTra9F+rU4vKjR/ApBdCFoCJ6AA7j7gnIY=;
        b=mIq//zpLsYsei6vqxx377qfSH3Sh+m1vOhX0lYtoiuUt8u1BXaP0Pv2cm3my4vRCLh
         dZ22MX97rOSGtj5xHlZzIzyh7aq1Y0Gbafct0ZpVxgFQA370S2688TM6psJ94/di/x8o
         YKpVCWZly3sME/BZWc1cJrxgQxHqX35XO6+Imi58HBF0sMGa++zjXzT8bf6HfeVGcT+6
         jLBr3A8L32UU9opEpChA2KGGnJq7nnV3yD3UriMw58uP10W9Kt/BqTnl7aybmALieQHr
         jiAB0oQTFNbBqxXoT1/TiEwNLrPscU35SYnO3zumXRhLRx+I4giUVVMmhDbxnFdqphOj
         lbWQ==
X-Gm-Message-State: AOAM533c0GhMRPGoEzkzfiplSBxFpUTk85ZRUReY7LKjHpqL16pizaXc
        w3pmp6VotpI7tggIL6PEW5FmP3yp92X7YxH2rvri8Qd1CBxC4PXzjxD1Y3kMC1cnJt+uL5v5IfH
        vgttFPzyOPbQyE6x3nnCNkNRPU6FF2rBeoldbvFqn
X-Received: by 2002:a05:651c:10c:: with SMTP id a12mr1658535ljb.414.1607541352071;
        Wed, 09 Dec 2020 11:15:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9/CimOc3N+72fFhCbbXRSFzpfZduUqobE3ByMI+lzkU6larzWtaAlzRFEmIhhoEYzS/VQ4tAHzGnleY0WZpw=
X-Received: by 2002:a05:651c:10c:: with SMTP id a12mr1658530ljb.414.1607541351897;
 Wed, 09 Dec 2020 11:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck> <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com>
In-Reply-To: <87tusulrog.fsf@redhat.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Wed, 9 Dec 2020 12:15:25 -0700
Message-ID: <CALzcdduYs4dng6R9j_dFFE5O13Kbpq9Rg05EFaQS1RSCHebYqg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:12 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
>
> Will Deacon @ 2020-12-09 11:50 MST:
>
> > On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
> >> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
> >> >
> >> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
> >> > for a fix, where the size of the interrupt remapping table was increased
> >> > but a related constant for the size of the interrupt table was forgotten.
> >>
> >> Pulled.
> >
> > Thanks.
> >
> >> However, why didn't this then add some sanity checking for the two
> >> different #defines to be in sync?
> >>
> >> IOW, something like
> >>
> >>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
> >>
> >>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
> >>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)
>
> Since the field in the device table entry format expects it to be n
> where there are 2^n entries in the table I guess it should be:
>
> #define DTE_IRQ_TABLE_LEN 9
> #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)
>
No, ignore that. I'm being stupid.


> >>
> >> or whatever. Hmm?
> >
> > This looks like a worthwhile change to me, but I don't have any hardware
> > so I've been very reluctant to make even "obvious" driver changes here.
> >
> > Suravee -- please can you post a patch implementing the above?
> >
> >> That way this won't happen again, but perhaps equally importantly the
> >> linkage will be more clear, and there won't be those random constants.
> >>
> >> Naming above is probably garbage - I assume there's some actual
> >> architectural name for that irq table length field in the DTE?
> >
> > The one in the spec is even better: "IntTabLen".
> >
> > Will
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

