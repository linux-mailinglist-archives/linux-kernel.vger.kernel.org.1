Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935FC293B71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405851AbgJTMWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:22:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:52509 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394268AbgJTMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:22:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09KCGBUp025510;
        Tue, 20 Oct 2020 07:16:16 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09KCGAIq025509;
        Tue, 20 Oct 2020 07:16:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 20 Oct 2020 07:16:10 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        mathieu.desnoyers@efficios.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc: Fix update form addressing in inline assembly
Message-ID: <20201020121610.GZ2672@gate.crashing.org>
References: <212d3bc4a52ca71523759517bb9c61f7e477c46a.1603179582.git.christophe.leroy@csgroup.eu> <fcff4199459890d107a06dbc39c52668ccd0921b.1603179582.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcff4199459890d107a06dbc39c52668ccd0921b.1603179582.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Oct 20, 2020 at 07:40:09AM +0000, Christophe Leroy wrote:
> In several places, inline assembly uses the "%Un" modifier
> to enable the use of instruction with update form addressing,
> but the associated "<>" constraint is missing.
> 
> As mentioned in previous patch, this fails with gcc 4.9, so
> "<>" can't be used directly.
> 
> Use UPD_CONSTR macro everywhere %Un modifier is used.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Oh well, it will be easy enough to remove this wart later, so

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -525,7 +525,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  		stw%U0%X0 %2,%0\n\
>  		eieio\n\
>  		stw%U1%X1 %L2,%1"
> -	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> +	: "=m"UPD_CONSTR (*ptep), "=m"UPD_CONSTR (*((unsigned char *)ptep+4))
>  	: "r" (pte) : "memory");

Here it would pre-increment ptep+4.  That can never be something useful
afaics?  The order the two operands are (either or not) pre-modified in
the asm is not specified (GCC does not parse the asm template, by
design), so I fail to see how this could ever work.

> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -200,7 +200,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			stw%U0%X0 %2,%0\n\
>  			eieio\n\
>  			stw%U1%X1 %L2,%1"
> -		: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> +		: "=m"UPD_CONSTR (*ptep), "=m"UPD_CONSTR (*((unsigned char *)ptep+4))
>  		: "r" (pte) : "memory");

Same here.

The rest looks fine.


Segher
