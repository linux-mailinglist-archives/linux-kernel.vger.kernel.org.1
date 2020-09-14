Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06426858D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:14:13 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53394
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbgINHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:14:11 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358868903"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 09:14:10 +0200
Date:   Mon, 14 Sep 2020 09:14:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC PATCH] scripts: coccicheck: Improve error feedback
 when coccicheck fails
In-Reply-To: <287a8c82-6359-9a7e-c2ca-d26aa5be9650@web.de>
Message-ID: <alpine.DEB.2.22.394.2009140913480.2357@hadrien>
References: <44ab7442-1473-f267-4487-af98631a9338@web.de> <alpine.DEB.2.22.394.2009140821041.2357@hadrien> <287a8c82-6359-9a7e-c2ca-d26aa5be9650@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Sep 2020, Markus Elfring wrote:

> >> How do you think about to use the following check variant?
> >>
> >> +	if [ "${DEBUG_FILE}" != '/dev/null' -a "${DEBUG_FILE}" != '' ]; then
> >
> > What difference does it make?
>
> I propose two implementation details for further development considerations.
>
> 1. Do you care if any variable names should be enclosed by curly brackets
>    in such script code?
>
> 2. A changeable value should be compared to two string literals here.
>    Varying contents should be enclosed by double quotes.
>    Constant values can be enclosed by single quotes, can't they?

I have no idea.  Why can't they be nclosed by double quotes as well?

julia
