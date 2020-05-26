Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2A1BC42A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgD1PyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:54:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727865AbgD1PyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtvLrlS7xav629MxmEyHTk8QGI5zi/D//NnhXNFX7PA=;
        b=Qi9JAF2ZFVr+QqWrqru8nR9nlnBN8Q1b8OfNpmkFAb9eHlro8G9psiCZ8+V453VHLycfy1
        k7zBAftOvwD1ARAeCfNrh3sU4uxKqybCpUMZ31hfJSMT4t1eiKy0v1t9EBggpHDlUkNHRu
        Z2BOF29lsUccjZgcMcsqKRuRcOlymcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Zw8MCO1YNSetNfYz8C18kg-1; Tue, 28 Apr 2020 11:54:19 -0400
X-MC-Unique: Zw8MCO1YNSetNfYz8C18kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B87464;
        Tue, 28 Apr 2020 15:54:17 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A64D9648CB;
        Tue, 28 Apr 2020 15:54:15 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:54:13 -0500
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
Message-ID: <20200428155413.b5xzef4s2kyzg5ed@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
 <20200428154909.4cjwetyyb2zhnq5i@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428154909.4cjwetyyb2zhnq5i@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:49:09AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 05:25:52PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 28, 2020 at 09:31:57AM -0500, Josh Poimboeuf wrote:
> > > That's quite the monstrosity, and I still don't see the point.  I
> > > thought we decided to just disallow CFI changes in alternatives anyway?
> > > That can be done much simpler.
> > 
> > Something like so then ?
> > 
> > ---
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 8443ec690051..d14d83e6edb0 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -940,6 +940,7 @@ static int handle_group_alt(struct objtool_file *file,
> >  
> >  		last_new_insn = insn;
> >  
> > +		insn->alt_group = true;
> >  		insn->ignore = orig_insn->ignore_alts;
> >  		insn->func = orig_insn->func;
> >  
> > @@ -2242,6 +2243,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
> >  	list_for_each_entry(op, &insn->stack_ops, list) {
> >  		int res;
> >  
> > +		if (insn->alt_group) {
> > +			WARN_FUNC("alternative has CFI", insn->sec, insn->offset);
> > +			return 1;
> > +		}
> > +
> 
> ACK (separate patch)

BTW, since most people don't know what CFI is, how about something like

	"unsupported stack change in alternatives code"

-- 
Josh

