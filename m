Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C428063D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgJASJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:09:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634AC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:09:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so7822442iow.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYyLL8/5sTCIqw3c2AOtgstQUUljt/etSnN5D+fO0uY=;
        b=Wzssz5fTJS9vvZ2ypkoGhiI+koyTl7pvaRONIvAdV8ZIhy+2BNj4z+zfiNA1glezsm
         C50ZoyCscM7qSZNF3Qmr5ISeX2ZXcW2185mYm/U/eBlt/DMZBI+UaWN16f+ba76jbPYL
         q4VexChWOdrzYr4OLseC0ogYE9VaeS9VByVPyB5SWU8autJFBrdRP0X0Pg2gHpXGE9LL
         8+659IorxM/GxV8Ynytoio0HZJjAeMEbpo37KGkPgYe4Yw9L/5Z86JnAAWs4jn9etwaO
         /AoCizLXBbHaI511apTYq/YFE6miXPetCawdl4gRiwRT0ABPLfASVpyQjDNICK1ifpYE
         iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYyLL8/5sTCIqw3c2AOtgstQUUljt/etSnN5D+fO0uY=;
        b=V7GyhVWgaeQLvt4zpZTnwbkGF6NZAU3l+l6XkmyuXb9mV1+n43FAWPCQjUZRP9lO1k
         fm7DpvUNw1SmTvE2+DtcsuvGhAS9afTZcf4QU57NDEjgoT/rYEuqOa9lZeVbf1jIJ+2T
         AGZangIZlG3uEhmIaExDZl9vQ1ARzf+zcHWLxCFHQdL8p5PTwznaQne0gOvVm2RolnDC
         5ZVoQs3lOia062H9va7Bfb5K7TSRWA3MF2qpOJCRhQNng1ofslxYzGUiopXDO4VFT7ji
         6s3HIgq84PaSlpMZrTGIq+qqKwdh0PfunMOL7/fr4gZ+NLqTCxXbPcnS6xyxLKZy2Dmu
         TldA==
X-Gm-Message-State: AOAM530j/ulpih7eQYbvCqV60M5gY0wGQ/txaaeLd7H39l4wRm0xl8xY
        QkGE3vqApUxPzWEqEl/inwZYdbqbhmv4vpvLro8fCA==
X-Google-Smtp-Source: ABdhPJxvHgh4I8y6d8KgrIpb3bycChN66g8zti9jALO364IlRnc6OjCOSgFqu7DNUn0tqHzUl0VobVjNTevVq7c19L4=
X-Received: by 2002:a05:6638:210f:: with SMTP id n15mr6948049jaj.41.1601575746451;
 Thu, 01 Oct 2020 11:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200922004024.3699923-1-vipinsh@google.com> <20200922014836.GA26507@linux.intel.com>
 <20200922211404.GA4141897@google.com> <20200924192116.GC9649@linux.intel.com> <cb592c59-a50e-5901-71fe-19e43bc9e37e@amd.com>
In-Reply-To: <cb592c59-a50e-5901-71fe-19e43bc9e37e@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 1 Oct 2020 12:08:55 -0600
Message-ID: <CAMkAt6oX+18cZy_t3hm0zo-sLmTGeGs5H9YAWvj7WBU7_uwU5Q@mail.gmail.com>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tj@kernel.org,
        lizefan@huawei.com, Joerg Roedel <joro@8bytes.org>, corbet@lwn.net,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, eric.vantassell@amd.com,
        Matt Gingell <gingell@google.com>,
        David Rientjes <rientjes@google.com>,
        kvm list <kvm@vger.kernel.org>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 1:55 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 9/24/20 2:21 PM, Sean Christopherson wrote:
> > On Tue, Sep 22, 2020 at 02:14:04PM -0700, Vipin Sharma wrote:
> >> On Mon, Sep 21, 2020 at 06:48:38PM -0700, Sean Christopherson wrote:
> >>> On Mon, Sep 21, 2020 at 05:40:22PM -0700, Vipin Sharma wrote:
> >>>> Hello,
> >>>>
> >>>> This patch series adds a new SEV controller for tracking and limiting
> >>>> the usage of SEV ASIDs on the AMD SVM platform.
> >>>>
> >>>> SEV ASIDs are used in creating encrypted VM and lightweight sandboxes
> >>>> but this resource is in very limited quantity on a host.
> >>>>
> >>>> This limited quantity creates issues like SEV ASID starvation and
> >>>> unoptimized scheduling in the cloud infrastructure.
> >>>>
> >>>> SEV controller provides SEV ASID tracking and resource control
> >>>> mechanisms.
> >>>
> >>> This should be genericized to not be SEV specific.  TDX has a similar
> >>> scarcity issue in the form of key IDs, which IIUC are analogous to SEV ASIDs
> >>> (gave myself a quick crash course on SEV ASIDs).  Functionally, I doubt it
> >>> would change anything, I think it'd just be a bunch of renaming.  The hardest
> >>> part would probably be figuring out a name :-).
> >>>
> >>> Another idea would be to go even more generic and implement a KVM cgroup
> >>> that accounts the number of VMs of a particular type, e.g. legacy, SEV,
> >>> SEV-ES?, and TDX.  That has potential future problems though as it falls
> >>> apart if hardware every supports 1:MANY VMs:KEYS, or if there is a need to
> >>> account keys outside of KVM, e.g. if MKTME for non-KVM cases ever sees the
> >>> light of day.
> >>
> >> I read about the TDX and its use of the KeyID for encrypting VMs. TDX
> >> has two kinds of KeyIDs private and shared.
> >
> > To clarify, "shared" KeyIDs are simply legacy MKTME KeyIDs.  This is relevant
> > because those KeyIDs can be used without TDX or KVM in the picture.
> >
> >> On AMD platform there are two types of ASIDs for encryption.
> >> 1. SEV ASID - Normal runtime guest memory encryption.
> >> 2. SEV-ES ASID - Extends SEV ASID by adding register state encryption with
> >>               integrity.
> >>
> >> Both types of ASIDs have their own maximum value which is provisioned in
> >> the firmware
> >
> > Ugh, I missed that detail in the SEV-ES RFC.  Does SNP add another ASID type,
> > or does it reuse SEV-ES ASIDs?  If it does add another type, is that trend
> > expected to continue, i.e. will SEV end up with SEV, SEV-ES, SEV-ES-SNP,
> > SEV-ES-SNP-X, SEV-ES-SNP-X-Y, etc...?
>
> SEV-SNP and SEV-ES share the same ASID range.

Where is this documented? From the SEV-SNP FW ABI Spec 0.8 "The
firmware checks that ASID is an encryption capable ASID. If not, the
firmware returns INVALID_ASID." that doesn't seem clear that an SEV-ES
ASID is required. Should this document be more clear?
