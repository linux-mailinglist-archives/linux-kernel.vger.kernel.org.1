Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A750211B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGBFkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 01:40:21 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50893 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgGBFkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:40:20 -0400
X-IronPort-AV: E=Sophos;i="5.75,303,1589234400"; 
   d="scan'208";a="457763334"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 07:40:18 +0200
Date:   Thu, 2 Jul 2020 07:40:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Matthew Wilcox <willy@infradead.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-doc@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
In-Reply-To: <20200702000843.GV25523@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2007020739270.2478@hadrien>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org> <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de> <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org> <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de> <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de> <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org> <20200702000843.GV25523@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Jul 2020, Matthew Wilcox wrote:

> On Wed, Jul 01, 2020 at 07:52:58AM -0700, Randy Dunlap wrote:
> > On 7/1/20 6:32 AM, Markus Elfring wrote:
> > >>> How do you think about to use the following command variant
> > >>> for the adjustment of the software documentation?
> > >>>
> > >>> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
> > >>
> > >> I don't understand the reason for that change...
> >
> > IOW, your "patch" needs justification and/or explanation. It was missing that info.
>
> What Markus is trying so completely ineptly to say is that
>   make C=1 CHECK=scripts/coccicheck path/to/file.c
> doesn't work.  You need to use the .o suffix to check the .c file.

Thanks Matthew for this very helpful information.

julia
