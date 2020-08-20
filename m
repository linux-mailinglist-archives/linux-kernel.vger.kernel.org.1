Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5386B24B121
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHTIdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 04:33:42 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:54162 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgHTIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:33:36 -0400
X-IronPort-AV: E=Sophos;i="5.76,332,1592863200"; 
   d="scan'208";a="464070498"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 10:33:33 +0200
Date:   Thu, 20 Aug 2020 10:33:33 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org> <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com> <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Aug 2020, Joe Perches wrote:

> On Wed, 2020-08-19 at 14:22 -0700, Joe Perches wrote:
> > There are commas used as statement terminations that should typically
> > have used semicolons instead.  Only direct assignments or use of a single
> > function or value on a single line are detected by this test.
> >
> > e.g.:
> > 	foo = bar(),		/* typical use is semicolon not comma */
> > 	bar = baz();
> >
> > Add an imperfect test to detect these comma uses.
> >
> > No false positives were found in testing, but many types of false negatives
> > are possible.
> >
> > e.g.:
> > 	foo = bar() + 1,	/* comma use, but not direct assignment */
> > 	bar = baz();
>
> Hi.
>
> I recently added a test for this condition to linux's checkpatch.
>
> A similar coccinelle script might be:
>
> $ cat comma.cocci
> @@
> expression e1;
> expression e2;
> @@
>
> 	e1
> -	,
> +	;
> 	e2;
> $
>
> This works reasonably well but it has several false positives
> for declarations like:
>
> $ spatch --sp-file comma.cocci mm/huge_memory.c
> diff -u -p a/huge_memory.c b/huge_memory.c
> --- a/huge_memory.c
> +++ b/huge_memory.c
> @@ -2778,7 +2778,7 @@ static unsigned long deferred_split_scan
>  	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>  	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
> -	LIST_HEAD(list), *pos, *next;
> +	LIST_HEAD(list), *pos; *next;
>  	struct page *page;
>  	int split = 0;
> $
>
> Any script improvement suggestions?

I have a bunch of variations of this that are more complicated than I
would have expected.  One shorter variant that I have is:

@@
expression e1,e2;
statement S;
@@

 S
 e1
-,
+;
  (<+... e2 ...+>);

This will miss cases where the first statement is the comma thing.  But I
think it is possible to improve this now.  I will check.

thanks,
julia
