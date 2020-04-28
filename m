Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53E21BC5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgD1RBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 13:01:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39351 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgD1RBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588093312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbRtAJkKgCtftuUWl+fk3b/C2eaLvF8SbXdEgi8sec8=;
        b=TXPEEaoIz9X7e41L5B+lLryfzBjNaCqHDntzKjyDXRlcAvw5ok8GV/fWHjnOpHZJEZJv3U
        J8tInTnyS5yP95hrw5VhGdQx64fPJVqROfz4dHKl87haVic5ifE+CVu9TK8FDFvVNg4ac+
        QsaYjKsEJyow5r048wIUYDjdGWRtGCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-nmwDUeyINzet9K4qW7Z98A-1; Tue, 28 Apr 2020 13:01:48 -0400
X-MC-Unique: nmwDUeyINzet9K4qW7Z98A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5D2800C78;
        Tue, 28 Apr 2020 17:01:46 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CEEB196AE;
        Tue, 28 Apr 2020 17:01:45 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:01:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428170143.zc2jvytxc5jqkxgb@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
 <20200428154909.4cjwetyyb2zhnq5i@treble>
 <20200428164444.GD16910@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428164444.GD16910@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 06:44:44PM +0200, Peter Zijlstra wrote:
> > > @@ -2494,8 +2494,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> > >  				}
> > >  			}
> > >  
> > > -			if (skip_orig)
> > > +			if (skip_orig) {
> > > +				struct instruction *prev_insn = insn;
> > > +				sec_for_each_insn_continue(file, insn) {
> > > +					if (!insn->alt_group)
> > > +						break;
> > > +					if (!insn->visited)
> > > +						insn->cfi = prev_insn->cfi;
> > > +				}
> > >  				return 0;
> > > +			}
> > 
> > NACK :-)
> > 
> > What happens if you have two alternatives adjacent to each other (which
> > can definitely happen in this scenario)?
> 
> Alexandre's alt_group would help:
> 
>   20200414103618.12657-3-alexandre.chartre@oracle.com
> 
> Then we can do something like:
> 
> static void fill_alternative(struct instruction *insn)
> {
> 	struct instruction *first_insn = insn;
> 	int alt_group = insn->alt_group;
> 
> 	sec_for_each_insn_continue(file, insn) {
> 		if (insn->alt_group != alt_group)
> 			break;
> 		if (!insn->visited)
> 			insn->cfi = first_insn->cfi;
> 	}
> }

Ugh...

> > I still like my patch, at least the hack is done before the validate
> > code, so validate_branch() itself is simpler.
> 
> But it doesn't handle the case where the alternatives themselves have
> unreachable holes in them, if that happens we'll generate spurious ORC
> entries for them.

Ah, I see what you mean.

I need to think about it...

-- 
Josh

