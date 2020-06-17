Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFA1FD4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFQSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 14:54:24 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3449 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgFQSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:54:24 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="455246752"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 20:54:03 +0200
Date:   Wed, 17 Jun 2020 20:54:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
In-Reply-To: <202006171103.327F86B1C@keescook>
Message-ID: <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <202006171103.327F86B1C@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jun 2020, Kees Cook wrote:

> On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> > +@as@
> > +expression E1, E2;
> > +@@
> > +
> > +array_size(E1, E2)
>
> BTW, is there a way yet in Coccinelle to match a fully qualified (?)
> identifier? For example, if I have two lines in C:
>
> A)
> 	array_size(variable, 5);
> B)
> 	array_size(instance->member.size, 5);
> C)
> 	array_size(instance->member.size + 1, 5);
> D)
> 	array_size(function_call(variable), 5);
>
>
> This matches A, B, C, and D:
>
> @@
> expression ARG1;
> expression ARG2;
> @@
>
> array_size(ARG1, ARG2);
>
>
> This matches only A:
>
> @@
> identifier ARG1;
> expression ARG2;
> @@
>
> array_size(ARG1, ARG2);
>
>
> How do I get something to match A and B but not C and D (i.e. I do not
> want to match any operations, function calls, etc, only a variable,
> which may be identified through dereference, array index, or struct
> member access.)

\(i\|e.fld\|e->fld\)

would probably do what you want.  It will also match cases where e is a
function/macr call, but that is unlikely.

If you want a single metavariable that contains the whole thing, you can
have an expression metavariable E and then write:

\(\(i\|e.fld\|e->fld\) \& E\)

julia



>
>
> --
> Kees Cook
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
