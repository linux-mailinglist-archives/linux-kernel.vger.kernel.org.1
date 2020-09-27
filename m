Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AD27A421
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 22:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgI0UzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 16:55:22 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4792 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgI0UzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 16:55:19 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="469746005"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 22:55:17 +0200
Date:   Sun, 27 Sep 2020 22:55:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     corbet@lwn.net, michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        linux-doc@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 2/2] Documentation: Coccinelle: Modify parallelisation
 information in docs
In-Reply-To: <3ecfe0e7f95021525b7bbf783a45eb3a176791a9.1600945451.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2009272254140.20726@hadrien>
References: <cover.1600945451.git.sylphrenadin@gmail.com> <3ecfe0e7f95021525b7bbf783a45eb3a176791a9.1600945451.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Sumera Priyadarsini wrote:

> This patchset modifies coccicheck to use at most one thread per core by
> default for optimal performance. Modify documentation in coccinelle.rst
> to reflect the same.

It would be good for the documentation to mention that this only occurs if
the machine has more than two cores (and more than 4 hardware threads).

julia


>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 74c5e6aeeff5..a27a4867018c 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -130,8 +130,8 @@ To enable verbose messages set the V= variable, for example::
>  Coccinelle parallelization
>  --------------------------
>
> -By default, coccicheck tries to run as parallel as possible. To change
> -the parallelism, set the J= variable. For example, to run across 4 CPUs::
> +By default, coccicheck uses at most only one thread per core of the system.
> +To change the parallelism, set the J= variable. For example, to run across 4 CPUs::
>
>     make coccicheck MODE=report J=4
>
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
