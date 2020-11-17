Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2436B2B6A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgKQQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727147AbgKQQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605630718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxDt74PLhWGBodZNX7JaAIeh6BN7s3VRDIqoAirYccw=;
        b=QeyhHA4/H3COXzWR0Dya3Vw30KFg9EWGBgPH5VkAV7nTGbbGot9rKhmpjoBdnMnM4+0Rfn
        UZsLwN4LVtMkpV3xJavZPNrijchK2YlIsKf7ynlxJ9l15RUIqRhwWTE42EyePx6e2ECw6P
        4hh82Icx5Q9z1MRu7JqTiYixbLrRX4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-RcfOoVoSMN6ynhrMIpuCvg-1; Tue, 17 Nov 2020 11:31:54 -0500
X-MC-Unique: RcfOoVoSMN6ynhrMIpuCvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75F71868427;
        Tue, 17 Nov 2020 16:31:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AA145D9E8;
        Tue, 17 Nov 2020 16:31:48 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:31:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201117163147.GA27243@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at  6:00pm -0500,
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/15/20 11:30 PM, Christian Borntraeger wrote:
> > 
> > 
> > On 13.11.20 23:52, Randy Dunlap wrote:
> >> Building on arch/s390/ flags this as an error, so add the
> >> __noreturn attribute modifier to prevent the build error.
> >>
> >> cc1: some warnings being treated as errors
> >> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
> >> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]
> > 
> > ok with me, but I am asking why
> > 
> > the unreachable macro is not good enough. For x86 it obviously is.
> > 
> > form arch/s390/include/asm/bug.h
> > #define BUG() do {                                      \
> >         __EMIT_BUG(0);                                  \
> >         unreachable();                                  \
> > } while (0)
> > 
> 
> Hi Christian,
> 
> Good question.
> I don't see any guidance about when to use one or the other etc.
> 
> I see __noreturn being used 109 times and unreachable();
> being used 33 times, but only now that I look at them.
> That had nothing to do with why I used __noreturn in the patch.

But doesn't that speak to the proper fix being needed in unreachable()?
Or at a minimum the fix is needed to arch/s390/include/asm/bug.h's BUG.

I really don't think we should be papering over that by sprinkling
__noreturn around the kernel's BUG() callers.

Maybe switch arch/s390/include/asm/bug.h's BUG to be like
arch/mips/include/asm/bug.h?  It itself uses __noreturn with a 'static
inline' function definition rather than #define.

Does that fix the issue?

Thanks,
Mike

p.s. you modified dm-writecache.c (not dm-writeback, wich doesn't
exist).

