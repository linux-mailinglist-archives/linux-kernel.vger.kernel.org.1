Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5302D17C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLGRpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgLGRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607363067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CxERT4u5MDQXm5Jldr8EFPIiLsHrezNO76Dqv+04UU=;
        b=EpH1IcSnQwM7xzC6qsDRe24aecl/7ZFiKVqLTrn8cbqX2HixhfgZKtdQ1sJS9SJjNe37eK
        a78G/kQvYf49j2YMnCm0ESEhyN0F4KtlHVbVf3m9MFNd6RwArUM52IZPPtxt693/M1wkcM
        //VIZBl455iiKIhFokl3yqSKQAw7JAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-1LUvcVXBNISK6Oz0QmAItQ-1; Mon, 07 Dec 2020 12:44:25 -0500
X-MC-Unique: 1LUvcVXBNISK6Oz0QmAItQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF75804024;
        Mon,  7 Dec 2020 17:44:23 +0000 (UTC)
Received: from work-vm (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F6C60636;
        Mon,  7 Dec 2020 17:44:20 +0000 (UTC)
Date:   Mon, 7 Dec 2020 17:44:18 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Steven Price <steven.price@arm.com>,
        David Gibson <dgibson@redhat.com>,
        Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201207174418.GF3135@work-vm>
References: <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <20201207164428.GD3135@work-vm>
 <CAFEAcA9mq0xh1CNvw9UZoNwcOBuoVnCNcBkRDSUv7UK27qdESg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mq0xh1CNvw9UZoNwcOBuoVnCNcBkRDSUv7UK27qdESg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Mon, 7 Dec 2020 at 16:44, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Steven Price (steven.price@arm.com) wrote:
> > > Sorry, I know I simplified it rather by saying it's similar to protected VM.
> > > Basically as I see it there are three types of memory access:
> > >
> > > 1) Debug case - has to go via a special case for decryption or ignoring the
> > > MTE tag value. Hopefully this can be abstracted in the same way.
> > >
> > > 2) Migration - for a protected VM there's likely to be a special method to
> > > allow the VMM access to the encrypted memory (AFAIK memory is usually kept
> > > inaccessible to the VMM). For MTE this again has to be special cased as we
> > > actually want both the data and the tag values.
> > >
> > > 3) Device DMA - for a protected VM it's usual to unencrypt a small area of
> > > memory (with the permission of the guest) and use that as a bounce buffer.
> > > This is possible with MTE: have an area the VMM purposefully maps with
> > > PROT_MTE. The issue is that this has a performance overhead and we can do
> > > better with MTE because it's trivial for the VMM to disable the protection
> > > for any memory.
> >
> > Those all sound very similar to the AMD SEV world;  there's the special
> > case for Debug that Peter mentioned; migration is ...complicated and
> > needs special case that's still being figured out, and as I understand
> > Device DMA also uses a bounce buffer (and swiotlb in the guest to make
> > that happen).
> 
> Mmm, but for encrypted VMs the VM has to jump through all these
> hoops because "don't let the VM directly access arbitrary guest RAM"
> is the whole point of the feature. For MTE, we don't want in general
> to be doing tag-checked accesses to guest RAM and there is nothing
> in the feature "allow guests to use MTE" that requires that the VMM's
> guest RAM accesses must do tag-checking. So we should avoid having
> a design that require us to jump through all the hoops.

Yes agreed, that's a fair distinction.

Dave


 Even if
> it happens that handling encrypted VMs means that QEMU has to grow
> some infrastructure for carefully positioning hoops in appropriate
> places, we shouldn't use it unnecessarily... All we actually need is
> a mechanism for migrating the tags: I don't think there's ever a
> situation where you want tag-checking enabled for the VMM's accesses
> to the guest RAM.
> 
> thanks
> -- PMM
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

