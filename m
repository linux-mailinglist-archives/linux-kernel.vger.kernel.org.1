Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AF29AB62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750505AbgJ0MDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:03:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45049 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750496AbgJ0MDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:03:40 -0400
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; 
   d="scan'208";a="474507552"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 13:03:35 +0100
Date:   Tue, 27 Oct 2020 13:03:35 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=5BCocci=5D_Coccinelle=3A_Checking_the_relevanc?=
 =?UTF-8?Q?e_of_parentheses_in_=E2=80=9Cgit_grep=E2=80=9D?=
In-Reply-To: <bfb3e786-a64f-ecaf-eb37-8bd6b53cf38a@web.de>
Message-ID: <alpine.DEB.2.22.394.2010271303190.2847@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de> <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de> <45310257-201a-40ea-348f-b8e909c3775c@web.de> <alpine.DEB.2.22.394.2010271155330.2847@hadrien>
 <bfb3e786-a64f-ecaf-eb37-8bd6b53cf38a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-410386229-1603800215=:2847"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-410386229-1603800215=:2847
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 27 Oct 2020, Markus Elfring wrote:

> >> … git grep -l -w \( -e for_each_node_by_type … -e for_each_node_with_property \) -- '*.c'
> >>
> >>
> >> How do you think about to omit these parentheses here?
> >
> > Does it make a difference?
>
> I find that it can be nicer to avoid the passing of unnecessary characters.
>
> * The compilation of the affected OCaml source files can eventually benefit
>   from another bit of clean-up, can't it?

I have no idea what this means.

julia

> * The called software components do also not need to fiddle with such extra data then.
>
> Regards,
> Markus
>
--8323329-410386229-1603800215=:2847--
