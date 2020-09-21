Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4372B27295B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgIUPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:04:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbgIUPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600700642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWq9zL8GIZrZPfPETbGBWQ7SMIA4wQyXTldEU2XQH7g=;
        b=LxpF4KHUQmOWr6mhxeMwnuyfrIoahx792vpOT7jdYIZKSE1InipMZyol7uPpYPunZeT7/U
        d/hnUqHeJJxAoP6Cj+PHMWzOmFcErSDwU9+WdpdoOJc85z3PlwXvOo7q+4gIaKhq0q71Ul
        SXraPjNX0MiUK8uFKCewis4BLzkG+FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-6SiifYBFP0Cy306bybUIbw-1; Mon, 21 Sep 2020 11:03:53 -0400
X-MC-Unique: 6SiifYBFP0Cy306bybUIbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8069802B77;
        Mon, 21 Sep 2020 15:03:51 +0000 (UTC)
Received: from treble (ovpn-119-131.rdu2.redhat.com [10.10.119.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E9210013DB;
        Mon, 21 Sep 2020 15:03:50 +0000 (UTC)
Date:   Mon, 21 Sep 2020 10:03:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] objtool: check: Fully validate the stack frame
Message-ID: <20200921150348.egfsznskrpebuyri@treble>
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-2-jthierry@redhat.com>
 <20200918205641.6nvnsib2paqa6xyn@treble>
 <9a40f898-8f6a-2ba0-1954-0d06be5e2ef8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a40f898-8f6a-2ba0-1954-0d06be5e2ef8@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:31:23AM +0100, Julien Thierry wrote:
> > > +++ b/tools/objtool/arch/x86/include/cfi_regs.h
> > > @@ -22,4 +22,8 @@
> > >   #define CFI_RA			16
> > >   #define CFI_NUM_REGS		17
> > > +#define CFA_SIZE	16
> > 
> > If I remember correctly, CFA (stolen from DWARF) is "Caller Frame
> > Address".  It's the stack address of the caller, before the call.
> > 
> 
> Ok, so maybe I'm mixing Call Frame and Stack Frame (frame pointer + return
> address).
> 
> > I get the feeling CFA_SIZE is the wrong name, because CFA is an address,
> > and its size isn't 16 bytes.  But I'm not quite sure what this is
> > supposed to represent.  Is it supposed to be the size of the frame
> > pointer + return address?  Isn't that always going to be 16 bytes for
> > both arches?
> > 
> 
> For arm64 and x86_64 it is. Maybe it is a bit early to consider it might
> differ for other arches (e.g. 32bit arches?).

I'd rather not consider other arches yet.  Even in the 32-bit case it
wouldn't necessarily have to be an arch-specific value since it would
presumably be 'size(long) * 2'.

> 
> > >   static bool has_valid_stack_frame(struct insn_state *state)
> > >   {
> > >   	struct cfi_state *cfi = &state->cfi;
> > > -	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
> > > -	    cfi->regs[CFI_BP].offset == -16)
> > > +	if (cfi->cfa.base == CFI_BP && cfi->cfa.offset >= CFA_SIZE &&
> > 
> > Why '>=' rather than '=='?
> > 
> 
> Because on arm64 the stack frame is not necessarily the first thing put on
> the stack by the callee. The callee is free to create the stack frame where
> it wants (on its part of the stack of course) as long as it appropriately
> sets the frame pointer before making a call.
> 
> You could have something like:
> 
> +------------+
> |            |
> |            |
> +------------+----> f1() called
> |            |
> | some callee|
> | saved regs |
> |            |
> +------------+
> |     RA     |
> +------------+
> |     BP/FP  |
> +------------+----> Set new BP/FP value

I see, thanks.

-- 
Josh

