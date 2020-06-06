Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D11F08D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgFFUu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 16:50:26 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47836 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbgFFUu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 16:50:26 -0400
X-IronPort-AV: E=Sophos;i="5.73,481,1583190000"; 
   d="scan'208";a="453335185"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 22:50:08 +0200
Date:   Sat, 6 Jun 2020 22:50:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH 1/2] Coccinelle: extend memdup_user transformation
 with GFP_USER
In-Reply-To: <6f83e89b-f261-5251-19f8-4ba52ef0e6f4@linux.com>
Message-ID: <alpine.DEB.2.21.2006062249170.2578@hadrien>
References: <20200530205348.5812-1-efremov@linux.com> <20200530205348.5812-2-efremov@linux.com> <alpine.DEB.2.21.2006061024100.2578@hadrien> <6f83e89b-f261-5251-19f8-4ba52ef0e6f4@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jun 2020, Denis Efremov wrote:

>
>
> On 6/6/20 11:24 AM, Julia Lawall wrote:
> >
> >
> > On Sat, 30 May 2020, Denis Efremov wrote:
> >
> >> Match GFP_USER allocations with memdup_user.cocci rule.
> >> Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
> >> memdup_user() from GFP_KERNEL to GFP_USER. In most cases it is still
> >> a good idea to use memdup_user() for GFP_KERNEL allocations. The
> >> motivation behind altering memdup_user() to GFP_USER is here:
> >> https://lkml.org/lkml/2018/1/6/333
> >
> > Should the rule somehow document the cases in which memdup_user should now
> > not be used?
> >
> > julia
> >
> >
> >>
> >> Signed-off-by: Denis Efremov <efremov@linux.com>
> >> ---
> >>  scripts/coccinelle/api/memdup_user.cocci | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> >> index c809ab10bbce..49f487e6a5c8 100644
> >> --- a/scripts/coccinelle/api/memdup_user.cocci
> >> +++ b/scripts/coccinelle/api/memdup_user.cocci
> >> @@ -20,7 +20,7 @@ expression from,to,size;
> >>  identifier l1,l2;
> >>  @@
> >>
> >> --  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
> >> +-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
>
> Actually, we can add optional __GFP_NOWARN here to match such cases as:
> GFP_KERNEL | __GFP_NOWARN
>
> However, I don't know how to express it in elegant way. Something like?
> (
> -  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> |
> -  to = \(kmalloc\|kzalloc\)(size, GFP_KERNEL|__GFP_NOWARN);
> |
> -  to = \(kmalloc\|kzalloc\)(size, GFP_USER|__GFP_NOWARN);
> )

I guess you could do:

\(GFP_KERNEL\|GFP_USER\|\(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\)

julia
