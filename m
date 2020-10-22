Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF0295E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898219AbgJVMfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:35:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35310 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503967AbgJVMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:35:06 -0400
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="473857495"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 14:35:03 +0200
Date:   Thu, 22 Oct 2020 14:35:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: =?UTF-8?Q?Re=3A_Coccinelle=3A_Checking_the_influence_of_=E2?=
 =?UTF-8?Q?=80=9CGrep_query=E2=80=9D?=
In-Reply-To: <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
Message-ID: <alpine.DEB.2.22.394.2010221434210.5113@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de> <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-24693990-1603370104=:5113"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-24693990-1603370104=:5113
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 22 Oct 2020, Markus Elfring wrote:

> > A disjunction is applied by this script for the semantic patch language.
> > This construct uses short-circuit evaluation. It has got the consequence
> > that the last element of the specified condition will only be checked
> > if all previous parts did not match. Such a technical detail leads to
> > a recommended ordering of condition parts if you would like to care for
> > optimal run time characteristics of SmPL code.
>
> I imagine that such information can trigger further software evolution
> at more places.
>
>
> > +++ b/scripts/coccinelle/iterators/for_each_child.cocci
>
> The software “Coccinelle 1.0.8-00177-g28737419” displays the following data.
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch -D patch --parse-cocci
> scripts/coccinelle/iterators/for_each_child.cocci
> …
> Grep query
> for_each_node_with_property || for_each_node_by_type || for_each_node_by_name ||
> for_each_matching_node_and_match || for_each_matching_node ||
> for_each_compatible_node || for_each_child_of_node ||
> for_each_available_child_of_node
>
>
> I suggest to take another closer look at the presented ordering for
> these identifiers.
> It deviates from the proposed listing for the SmPL disjunction.
> Now I am curious if this difference can be meaningful.
>
> If the exact “grep” is performed, it might happen that short-circuit evaluation
> would be applied also by the corresponding software component (or known tool).
> Will any adjustments become relevant then accordingly?

It doesn't matter.  The purpose is just to select files that are relevent
for consideration.  If a file is selected for two reasons instead of one
reason, it doesn't matter; it's still selected.

julia
--8323329-24693990-1603370104=:5113--
