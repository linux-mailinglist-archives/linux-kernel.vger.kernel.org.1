Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B442B9AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKSSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgKSSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605811382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y55OZ3OjAK2zbBI3eJj5fJ3qrb+J/+b/r6JS6Ay9OF4=;
        b=PGj5ON1YIwu4CCBba6wY92guzFiRQaWXUGgdcHwxLwoatJ27Emofe+s6dfH27I/MX+6hqR
        Ln/yeG60OYl7Tg5p+I1KTNyGIcjyaUHRKtgARmx080v3uCHux9B7pz0uqmeUsMLwhi5ygR
        MhbVezhNWCbILJeJsGOAUIrQA0MdZLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-S6ZPH1jbP6WK2oA8bMO-Nw-1; Thu, 19 Nov 2020 13:42:59 -0500
X-MC-Unique: S6ZPH1jbP6WK2oA8bMO-Nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAA36107ACE3;
        Thu, 19 Nov 2020 18:42:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19EA060BE2;
        Thu, 19 Nov 2020 18:42:50 +0000 (UTC)
Date:   Thu, 19 Nov 2020 19:42:48 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:45:40PM +0000, Peter Maydell wrote:
> On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
> > This series adds support for Arm's Memory Tagging Extension (MTE) to
> > KVM, allowing KVM guests to make use of it. This builds on the existing
> > user space support already in v5.10-rc1, see [1] for an overview.
> 
> > The change to require the VMM to map all guest memory PROT_MTE is
> > significant as it means that the VMM has to deal with the MTE tags even
> > if it doesn't care about them (e.g. for virtual devices or if the VMM
> > doesn't support migration). Also unfortunately because the VMM can
> > change the memory layout at any time the check for PROT_MTE/VM_MTE has
> > to be done very late (at the point of faulting pages into stage 2).
> 
> I'm a bit dubious about requring the VMM to map the guest memory
> PROT_MTE unless somebody's done at least a sketch of the design
> for how this would work on the QEMU side. Currently QEMU just
> assumes the guest memory is guest memory and it can access it
> without special precautions...
>

There are two statements being made here:

1) Requiring the use of PROT_MTE when mapping guest memory may not fit
   QEMU well.

2) New KVM features should be accompanied with supporting QEMU code in
   order to prove that the APIs make sense.

I strongly agree with (2). While kvmtool supports some quick testing, it
doesn't support migration. We must test all new features with a migration
supporting VMM.

I'm not sure about (1). I don't feel like it should be a major problem,
but (2).

I'd be happy to help with the QEMU prototype, but preferably when there's
hardware available. Has all the current MTE testing just been done on
simulators? And, if so, are there regression tests regularly running on
the simulators too? And can they test migration? If hardware doesn't
show up quickly and simulators aren't used for regression tests, then
all this code will start rotting from day one.

Thanks,
drew

