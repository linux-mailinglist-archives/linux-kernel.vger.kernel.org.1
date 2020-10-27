Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74229AA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898786AbgJ0K4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:56:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14598
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2898762AbgJ0Kz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:55:57 -0400
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; 
   d="scan'208";a="362868559"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 11:55:53 +0100
Date:   Tue, 27 Oct 2020 11:55:53 +0100 (CET)
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
In-Reply-To: <45310257-201a-40ea-348f-b8e909c3775c@web.de>
Message-ID: <alpine.DEB.2.22.394.2010271155330.2847@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de> <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de> <45310257-201a-40ea-348f-b8e909c3775c@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1797633343-1603796154=:2847"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1797633343-1603796154=:2847
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 27 Oct 2020, Markus Elfring wrote:

> > Will any adjustments become relevant then accordingly?
>
> I have found out that the function “interpret” (OCaml code) constructs a command
> and executes it.
> https://github.com/coccinelle/coccinelle/blob/3c01dc1696dc5ccfb319673f205e491b572ee0be/parsing_cocci/git_grep.ml#L9
>
> I have tried a corresponding test display out. Thus I have got the impression
> that desired patterns are passed with extra parentheses.
>
> … git grep -l -w \( -e for_each_node_by_type … -e for_each_node_with_property \) -- '*.c'
>
>
> How do you think about to omit these parentheses here?

Does it make a difference?

julia
--8323329-1797633343-1603796154=:2847--
