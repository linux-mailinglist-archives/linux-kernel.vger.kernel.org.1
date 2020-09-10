Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B880726523E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIJVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:12:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731133AbgIJOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599748336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSWFx/cofNH1Si60n2IPG1OZBCpHlootSbq1tR7ZiH4=;
        b=GkZ1RzxRumXzA60Pr9RhtXueGukrQ4OqRKuXBZomIxqNboQg9z0F2FptI4a+AMbNagJaUv
        dXjPJW2oaC5G1HxkYlq0VOPTZkQLLN4rW1rQtJvGJ3NaIinlSrE8naIeXpjDoncSf4zFja
        +FZ2pk1CAYki8kckHXeC2H+NxaMA0TQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-FLFqHds8Mi23NWWVl2_QoQ-1; Thu, 10 Sep 2020 09:56:28 -0400
X-MC-Unique: FLFqHds8Mi23NWWVl2_QoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E42B1084C80;
        Thu, 10 Sep 2020 13:56:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DECB81C51;
        Thu, 10 Sep 2020 13:56:20 +0000 (UTC)
Date:   Thu, 10 Sep 2020 15:56:18 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Peter Maydell <Peter.Maydell@arm.com>,
        linux-kernel@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        qemu-devel@nongnu.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910135618.cvnlrgvhuy3amv6s@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <857566df-1b98-84f7-9268-d092722dc749@arm.com>
 <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
 <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:21:04AM +0100, Steven Price wrote:
> On 10/09/2020 07:29, Andrew Jones wrote:
> > But if userspace created the memslots with memory already set with
> > PROT_MTE, then this wouldn't be necessary, right? And, as long as
> > there's still a way to access the memory with tag checking disabled,
> > then it shouldn't be a problem.
> 
> Yes, so one option would be to attempt to validate that the VMM has provided
> memory pages with the PG_mte_tagged bit set (e.g. by mapping with PROT_MTE).
> The tricky part here is that we support KVM_CAP_SYNC_MMU which means that
> the VMM can change the memory backing at any time - so we could end up in
> user_mem_abort() discovering that a page doesn't have PG_mte_tagged set - at
> that point there's no nice way of handling it (other than silently upgrading
> the page) so the VM is dead.
> 
> So since enforcing that PG_mte_tagged is set isn't easy and provides a
> hard-to-debug foot gun to the VMM I decided the better option was to let the
> kernel set the bit automatically.
>

The foot gun still exists when migration is considered, no? If userspace
is telling a guest it can use MTE on its normal memory, but then doesn't
prepare that memory correctly, or remember to migrate the tags correctly
(which requires knowing the memory has tags and knowing how to get them),
then I guess the VM is in trouble one way or another.

I feel like we should trust the VMM to ensure MTE will work on any memory
the guest could use it on, and change the action in user_mem_abort() to
abort the guest with a big error message if it sees the flag is missing.
 
> > > > 
> > > > If userspace needs to write to guest memory then it should be due to
> > > > a device DMA or other specific hardware emulation. Those accesses can
> > > > be done with tag checking disabled.
> > > 
> > > Yes, the question is can the VMM (sensibly) wrap the accesses with a
> > > disable/renable tag checking for the process sequence. The alternative at
> > > the moment is to maintain a separate (untagged) mapping for the purpose
> > > which might present it's own problems.
> > 
> > Hmm, so there's no easy way to disable tag checking when necessary? If we
> > don't map the guest ram with PROT_MTE and continue setting the attribute
> > in KVM, as this series does, then we don't need to worry about it tag
> > checking when accessing the memory, but then we can't access the tags for
> > migration.
> 
> There's a "TCO" (Tag Check Override) bit in PSTATE which allows disabling
> tag checking, so if it's reasonable to wrap accesses to the memory you can
> simply set the TCO bit, perform the memory access and then unset TCO. That
> would mean a single mapping with MTE enabled would work fine. What I don't
> have a clue about is whether it's practical in the VMM to wrap guest
> accesses like this.
> 

At least QEMU goes through many abstractions to get to memory already.
There may already be a hook we could use, if not, it probably wouldn't
be too hard to add one (famous last words).

Thanks,
drew

