Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF992DBA36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgLPEux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:50:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgLPEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608094167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTNHlRWuRB7n7Es+tRDxWo7Kh2q9exi13kesr0h8Pb4=;
        b=EcUlQDBFyiG9+H53siHYkN+WbWxJFplOe40kOlPwBB2FsH9WmfBTkmbR25oEESs+C7eJDR
        Z420n0f6QlhlLHXLWECzPj1MgO3sU0ChwyhODvxXYemhqa9DUSncJDROJfbknXBDkRJPk6
        Epef4dN8oqgVMrBn4nmtzh58A8Y1Hx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-FopJyAKQPh23qai1W3RHKg-1; Tue, 15 Dec 2020 23:49:23 -0500
X-MC-Unique: FopJyAKQPh23qai1W3RHKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368FC800D62;
        Wed, 16 Dec 2020 04:49:22 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E3D10013C1;
        Wed, 16 Dec 2020 04:49:20 +0000 (UTC)
Date:   Tue, 15 Dec 2020 22:49:18 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New objtool warning..
Message-ID: <20201216044918.jdmi32dz75uboybv@treble>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:22:23PM -0800, Linus Torvalds wrote:
> I only see this on my laptop, but that's probably because my desktop
> is built using clang. So it's a gcc code generation interaction, I
> suspect..
> 
> Anyway, the new warning is
> 
>     drivers/gpu/drm/drm_edid.o: warning: objtool: do_cvt_mode() falls
> through to next function drm_mode_detailed.isra.0()
> 
> and googling around a bit I see that 0day ended up reporting it on the
> linux-next lists, and blames commit 991fcb77f490 ("drm/edid: Fix
> uninitialized variable in drm_cvt_modes()").
> 
> That presumably then makes gcc generate that odd code.
> 
> That "unreachable()" is because the compiler isn't smart enough to see
> that yes, there really are case statements for every single possible
> case. Oh well. Maybe the code should just make one of the possible
> cases also be the "default:" case, and that might fix it.
> 
> But maybe this is worth looking into for objtool too?
> 
> Anyway, I see it with gcc-10.2.1 as per current F32. Holler if you
> can't reproduce it, I can send the object file around.

I can't recreate with my compiler, but I think I've seen one like this
before.  I suspect s/unreachable()/BUG()/ would fix it?

But yeah, it _might_ be possible to make objtool a little smarter here.
Gimme the .o file and I can take a look tomorrow.

-- 
Josh

