Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2E2665C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIKRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgIKRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599844157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfQ5cvgBj9DCEpY6quvn1kwK45qI2deGpfvYYbFQhqY=;
        b=On4ForORHmJz1dc2iGD9bUAt/OdajVqnDYcZfM3WBIh/SXUmd1rQRrEJXzcYxKRKzOhH3B
        uEKLO4x32cATONIKPaSuGzKDci/L71qkn31kikI6B34YwKzgwJqv1aKG2h6hCTsKJciNZ6
        jo+pYiUOyYRK+59wxr9db7KvIpjCfhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-edZUCXHpPuW925tcahNYxw-1; Fri, 11 Sep 2020 13:09:15 -0400
X-MC-Unique: edZUCXHpPuW925tcahNYxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D41CD801AAF;
        Fri, 11 Sep 2020 17:09:13 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41A310027A6;
        Fri, 11 Sep 2020 17:09:12 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:09:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: WARNING: Kernel stack regs has bad 'bp' value
Message-ID: <20200911170911.mrkorgsplrrwp4rv@treble>
References: <c0ba7077-7977-0155-d7be-d4133ebaee5c@deltatee.com>
 <20200911160053.w66xit3imcqsn33g@treble>
 <5a66f512-960b-7f24-068a-01c043ca9877@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a66f512-960b-7f24-068a-01c043ca9877@deltatee.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:14:41AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-11 10:00 a.m., Josh Poimboeuf wrote:
> > Hi Logan,
> > 
> > Thanks for the bug report.  (Sorry I missed the first one, Naresh.)
> > 
> > The problem is that ret_from_fork() is no longer in .entry.text, so the
> > following check in the FP unwinder doesn't work when ret_from_fork()
> > gets interrupted.
> > 
> > 	/*
> > 	 * Don't warn if the unwinder got lost due to an interrupt in entry
> > 	 * code or in the C handler before the first frame pointer got set up:
> > 	 */
> > 	if (state->got_irq && in_entry_code(state->ip))
> > 		goto the_end;
> > 
> > If you have the ability to recreate, can you try the following patch?
> 
> Sorry, but I can not reliably hit this bug. I hit it randomly twice last
> week however, despite doing a bunch more runs this week, I haven't hit
> it again.
> 
> I can add the patch to my testing next week but I ca not give you a
> definitive answer on whether this fixes the bug.
> 
> Perhaps Naresh's test is a better reproducer.

That's ok.  I forced a reproducer by putting an infinite loop in
ret_from_fork to force an APIC interrupt with lockdep unwind.

The patch fixes it, I'll post an official version after some more
testing.

-- 
Josh

