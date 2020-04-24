Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E771B7121
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgDXJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 05:43:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgDXJnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:43:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9AE34AC4D;
        Fri, 24 Apr 2020 09:43:13 +0000 (UTC)
Date:   Fri, 24 Apr 2020 11:43:13 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
In-Reply-To: <20200423161656.GX20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004241141240.6175@pobox.suse.cz>
References: <20200423125013.452964352@infradead.org> <20200423125042.713052240@infradead.org> <7df9ec97-dc14-c4b6-fb26-f163e9afb1cd@oracle.com> <20200423161656.GX20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Peter Zijlstra wrote:

> On Thu, Apr 23, 2020 at 05:40:38PM +0200, Alexandre Chartre wrote:
> > 
> > On 4/23/20 2:47 PM, Peter Zijlstra wrote:
> > > Wrap each stack_op in a macro that allocates and adds it to the list.
> > > This simplifies trying to figure out what to do with the pre-allocated
> > > stack_op at the end.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >   tools/objtool/arch/x86/decode.c |  257 +++++++++++++++++++++++-----------------
> > >   1 file changed, 153 insertions(+), 104 deletions(-)
> > > 
> > > --- a/tools/objtool/arch/x86/decode.c
> > > +++ b/tools/objtool/arch/x86/decode.c
> > > @@ -77,6 +77,17 @@ unsigned long arch_jump_destination(stru
> > >   	return insn->offset + insn->len + insn->immediate;
> > >   }
> > > +#define PUSH_OP(op) \
> > > +({ \
> > > +	list_add_tail(&op->list, ops_list); \
> > > +	NULL; \
> > > +})
> > > +
> > > +#define ADD_OP(op) \
> > > +	if (!(op = calloc(1, sizeof(*op)))) \
> > > +		return -1; \
> > > +	else for (; op; op = PUSH_OP(op))
> > > +
> > 
> > I would better have a function to alloc+add op instead of weird macros,
> > for example:
> 
> I know it'll not make you feel (much) better, but we can write it
> shorter:
> 
> +#define ADD_OP(op) \
> +       if (!(op = calloc(1, sizeof(*op)))) \
> +               return -1; \
> +       else for (list_add_tail(&op->list, ops_list); op; op = NULL)

FWIW, I like this version the best.

Miroslav
