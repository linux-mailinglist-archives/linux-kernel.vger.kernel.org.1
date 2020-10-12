Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA33D28BC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbgJLPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389542AbgJLPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602516915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgksmDOGwr6afSR53HTSWyXq3O/b7foD0uOmXQAzfs0=;
        b=DBmH8riI/E/0hIPkKg+6n0cZfJbxVWcVy/bq1q6gt28QVN+TWzP6Iyl46h0+wexS/XqF/O
        a68oTln6Toyfgwr+m6ik2U+lkS2peNziYq3ZmGdXKQBE0oEFWiMefsAE7+h1gM052zIEAj
        QkqEYLFkFTxsIIjEOxGRPWiO0ttWkyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-EM2I-47CNBWzt9j6uEtG0g-1; Mon, 12 Oct 2020 11:35:06 -0400
X-MC-Unique: EM2I-47CNBWzt9j6uEtG0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F4638015A8;
        Mon, 12 Oct 2020 15:35:04 +0000 (UTC)
Received: from treble (ovpn-118-167.rdu2.redhat.com [10.10.118.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34E8C60C13;
        Mon, 12 Oct 2020 15:35:03 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:35:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 1/3] objtool: check: Fully validate the stack frame
Message-ID: <20201012153500.owcyvgjv4m3t3nh3@treble>
References: <20200928093631.210610-1-jthierry@redhat.com>
 <20200928093631.210610-2-jthierry@redhat.com>
 <20200929191834.7daofidv6b5aef3y@treble>
 <5540c2a9-db13-e05e-713c-22ec00f21aa6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5540c2a9-db13-e05e-713c-22ec00f21aa6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:21:49AM +0100, Julien Thierry wrote:
> On 9/29/20 8:18 PM, Josh Poimboeuf wrote:
> > "Stack frame" has more than one meaning now, I suppose.  i.e. it could
> > also include the callee-saved registers and any other stack space
> > allocated by the function.
> > 
> > Would "call frame" be clearer?
> > 
> >    CALL_FRAME_BP_OFFSET
> >    CALL_FRAME_RA_OFFSET
> > 
> > ?
> 
> I would've thought that the call-frame could include the stackframe + other
> callee saved regs.

Hm, probably so.

> Whereas stackframe tends to used for the caller's frame pointer +
> return address (i.e. what allows unwinding). Unless I'm getting lost
> with things.

I've always seen "stack frame" used to indicate the function's entire
stack.

> And if call frame is associated with the region starting from the stack
> pointer at the parent call point (since this is what CFA is), then it
> shouldn't be associated with the framepointer + return address structure
> since this could be anywhere on the call frame (not at a fixed offset) as
> long as the new frame pointer points to the structure.

I suppose "call frame" and "stack frame" probably mean the same thing,
in which case neither is appropriate here...

In fact, maybe we could forget the concept of a frame (or even a struct)
here.

If cfa.base is CFI_BP, then is regs[CFI_BP].offset always the same as
-cfa.offset?  i.e. could the BP checks could it just be a simple

  regs[CFI_BP].offset == -cfa.offset

check?

And then is RA at regs[CFI_BP].offset + 8?

-- 
Josh

