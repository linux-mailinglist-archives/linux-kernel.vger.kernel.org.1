Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC42B8128
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKRPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgKRPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605714596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQ3atbt49o/FeEWNxZ+RfU8ToGXg/yRCCUXrGgUjXe4=;
        b=eUx4eYF2CIPcR4/HxCE9CPgfcbgZuwdOnCkQoB6GdmZmY95FUpj1UVaUB9ZHpur9uhoKVV
        DROTfrby3vflpfNbzT8fnomoxx4AK6bF1M5+1swXsWOhS94I5GkXj/ioaMAjwFdics5h0o
        BzftRAGgLSiSWAeEgaMP2XlpeGwGWyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-_VdeTqYPOoqSMsJBHrnhAg-1; Wed, 18 Nov 2020 10:49:54 -0500
X-MC-Unique: _VdeTqYPOoqSMsJBHrnhAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39860873114;
        Wed, 18 Nov 2020 15:49:53 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DE655D9D2;
        Wed, 18 Nov 2020 15:49:45 +0000 (UTC)
Date:   Wed, 18 Nov 2020 10:49:44 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201118154944.GB545@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117163147.GA27243@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17 2020 at 11:31am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, Nov 16 2020 at  6:00pm -0500,
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 11/15/20 11:30 PM, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 13.11.20 23:52, Randy Dunlap wrote:
> > >> Building on arch/s390/ flags this as an error, so add the
> > >> __noreturn attribute modifier to prevent the build error.
> > >>
> > >> cc1: some warnings being treated as errors
> > >> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
> > >> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]
> > > 
> > > ok with me, but I am asking why
> > > 
> > > the unreachable macro is not good enough. For x86 it obviously is.
> > > 
> > > form arch/s390/include/asm/bug.h
> > > #define BUG() do {                                      \
> > >         __EMIT_BUG(0);                                  \
> > >         unreachable();                                  \
> > > } while (0)
> > > 
> > 
> > Hi Christian,
> > 
> > Good question.
> > I don't see any guidance about when to use one or the other etc.
> > 
> > I see __noreturn being used 109 times and unreachable();
> > being used 33 times, but only now that I look at them.
> > That had nothing to do with why I used __noreturn in the patch.
> 
> But doesn't that speak to the proper fix being needed in unreachable()?
> Or at a minimum the fix is needed to arch/s390/include/asm/bug.h's BUG.
> 
> I really don't think we should be papering over that by sprinkling
> __noreturn around the kernel's BUG() callers.
> 
> Maybe switch arch/s390/include/asm/bug.h's BUG to be like
> arch/mips/include/asm/bug.h?  It itself uses __noreturn with a 'static
> inline' function definition rather than #define.
> 
> Does that fix the issue?
> 
> Thanks,
> Mike
> 
> p.s. you modified dm-writecache.c (not dm-writeback, wich doesn't
> exist).

I don't think my suggestion will help.. given it'd still leave
persistent_memory_claim() without a return statement.

Think it worthwhile to just add a dummy 'return 0;' after the BUG().

Mike

