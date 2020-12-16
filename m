Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2872DC4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgLPRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgLPRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608137956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sNFVXafiayafPS9imi0xLPruhUop010Ho9E+FyWmUAQ=;
        b=eWYAsrEKgg/MXVX5vW+wO8v+FKycqeSH09WdQYR6W+Xzr5SYixlnSmvUYeQJrrrPcNaHx6
        E3HOMpmG5fRjEnzql50oh/DoUC20n9VwOSTvsriHqP1APISNbjedz/O3f4QK1uKo/SKhWr
        TQAkvm7lL8mkf0DyIv1hujWLp7EseTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-hQ5TIgDoMj-rw1B1uaiSsg-1; Wed, 16 Dec 2020 11:59:08 -0500
X-MC-Unique: hQ5TIgDoMj-rw1B1uaiSsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65D9800135;
        Wed, 16 Dec 2020 16:58:57 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 440FD62A25;
        Wed, 16 Dec 2020 16:58:57 +0000 (UTC)
Date:   Wed, 16 Dec 2020 10:58:55 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New objtool warning..
Message-ID: <20201216165855.7qrlt3eqszizmp4o@treble>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
 <6c4054c4fa3a4f6ab381411ffc9a8f01@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c4054c4fa3a4f6ab381411ffc9a8f01@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:46:31AM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 16 December 2020 04:49
> > 
> > On Tue, Dec 15, 2020 at 08:22:23PM -0800, Linus Torvalds wrote:
> > > I only see this on my laptop, but that's probably because my desktop
> > > is built using clang. So it's a gcc code generation interaction, I
> > > suspect..
> > >
> > > Anyway, the new warning is
> > >
> > >     drivers/gpu/drm/drm_edid.o: warning: objtool: do_cvt_mode() falls
> > > through to next function drm_mode_detailed.isra.0()
> > >
> > > and googling around a bit I see that 0day ended up reporting it on the
> > > linux-next lists, and blames commit 991fcb77f490 ("drm/edid: Fix
> > > uninitialized variable in drm_cvt_modes()").
> > >
> > > That presumably then makes gcc generate that odd code.
> > >
> > > That "unreachable()" is because the compiler isn't smart enough to see
> > > that yes, there really are case statements for every single possible
> > > case. Oh well. Maybe the code should just make one of the possible
> > > cases also be the "default:" case, and that might fix it.
> > >
> > > But maybe this is worth looking into for objtool too?
> > >
> > > Anyway, I see it with gcc-10.2.1 as per current F32. Holler if you
> > > can't reproduce it, I can send the object file around.
> > 
> > I can't recreate with my compiler, but I think I've seen one like this
> > before.  I suspect s/unreachable()/BUG()/ would fix it?
> 
> Then a smart(er) compiler will report that the BUG() is unreachable.

It shouldn't, BUG() already has unreachable().

-- 
Josh

