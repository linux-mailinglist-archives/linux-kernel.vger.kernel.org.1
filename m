Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06329833B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418383AbgJYS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:56:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26646 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395217AbgJYS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:56:56 -0400
X-IronPort-AV: E=Sophos;i="5.77,416,1596492000"; 
   d="scan'208";a="474223595"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 19:56:54 +0100
Date:   Sun, 25 Oct 2020 19:56:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=5BCocci=5D_Coccinelle=3A_null=3A_Optimise_disj?=
 =?UTF-8?Q?unctions_in_SmPL_script_=E2=80=9Ceno=2Ecocci=E2=80=9D?=
In-Reply-To: <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
Message-ID: <alpine.DEB.2.22.394.2010251955280.2714@hadrien>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de> <alpine.DEB.2.22.394.2010251924290.2714@hadrien> <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Oct 2020, Markus Elfring wrote:

> >> This analysis result indicates a clear ranking for such function calls.
> >> Thus reorder the SmPL disjunction items according to their usage incidence.
> >
> > Did you actually test this before and after the change and see a
> > difference in performance?
>
> Would you become interested to configure a representative test environment
> for safe comparisons of corresponding run time characteristics
> of the affected software?

In what sense could the comparison possibly be unsafe?

Just use time and run spatch on whatever machine you want.  It's not that
complicated.

> > On my laptop, I see absolutely no difference,
> > for the patch mode and for the context mode.
>
> Does such information trigger a desire to clarify involved aspects in more detail?

Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz

julia
