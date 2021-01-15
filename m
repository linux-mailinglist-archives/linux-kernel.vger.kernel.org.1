Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5D2F7FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbhAOPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:34:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbhAOPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610724770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9m9gZHsviycHW7Hn2SloYg5ibkRM2OasePX+zrHXK5Q=;
        b=X9IXcpRBaVk2NZ6y8qeC0xaNIHMLIO3pRlnjugksjebqKanQDvn5d1uk7z0y1QM5jB8zjf
        rG/wQzJxILDGO7ME6hnA/20F7Im7sXF3jNn067OseNkD1zGW7NQn/lMjlvqhVaZqS4u+EO
        XTSTw+DSOgNxfShIydZHLOHruQviI8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-aZw-M--WP7S-ysNF3HyIuA-1; Fri, 15 Jan 2021 10:32:46 -0500
X-MC-Unique: aZw-M--WP7S-ysNF3HyIuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D7D107ACF8;
        Fri, 15 Jan 2021 15:32:45 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5847360BF3;
        Fri, 15 Jan 2021 15:32:44 +0000 (UTC)
Date:   Fri, 15 Jan 2021 09:32:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] objtool: Don't fail on missing symbol table
Message-ID: <20210115153242.7ytieezofbga6qhe@treble>
References: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2101151217000.4375@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2101151217000.4375@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:31:26PM +0100, Miroslav Benes wrote:
> On Thu, 14 Jan 2021, Josh Poimboeuf wrote:
> 
> > Thanks to a recent binutils change which doesn't generate unused
> > symbols, it's now possible for thunk_64.o be completely empty with
> > CONFIG_PREEMPTION: no text, no data, no symbols.
> 
> "without CONFIG_PREEMPTION", or did I misunderstand?

Fixed.

>  
> > We could edit the Makefile to only build that file when
> > CONFIG_PREEMPTION is enabled, but that will likely create confusion
> > if/when the thunks end up getting used by some other code again.
> > 
> > Just ignore it and move on.
> > 
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Thanks!

> 
> with the note below.
> 
> > ---
> >  tools/objtool/elf.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index be89c741ba9a..2b0f4f52f7b5 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -380,8 +380,11 @@ static int read_symbols(struct elf *elf)
> >  
> >  	symtab = find_section_by_name(elf, ".symtab");
> >  	if (!symtab) {
> > -		WARN("missing symbol table");
> > -		return -1;
> > +		/*
> > +		 * A missing symbol table is actually possible if it's an empty
> > +		 * .o file.  This can happen for thunk_64.o.
> > +		 */
> > +		return 0;
> >  	}
> 
> We rely on .symtab presence elsewhere in the code. See 
> elf_create_{rel,rela}_reloc_section(). However, there should never be a 
> problem. If there is a need to create a new reloc section (either for a 
> static call site, or ORC), there should always be a symbol to create it 
> for (or because of it).

Right, let us hope so :-)

-- 
Josh

