Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C2292F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgJSUQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:16:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:44972 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSUQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:16:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09JKAlXU020418;
        Mon, 19 Oct 2020 15:10:47 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09JKAkCX020411;
        Mon, 19 Oct 2020 15:10:46 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Oct 2020 15:10:45 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9
Message-ID: <20201019201045.GS2672@gate.crashing.org>
References: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:12:46PM +0000, Christophe Leroy wrote:
> GCC 4.9 sometimes fails to build with "m<>" constraint in
> inline assembly.

> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -223,7 +223,7 @@ do {								\
>  		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
>  		EX_TABLE(1b, %l2)				\
>  		:						\
> -		: "r" (x), "m<>" (*addr)				\
> +		: "r" (x), "m"UPD_CONSTR (*addr)		\
>  		:						\
>  		: label)
>  
> @@ -294,7 +294,7 @@ extern long __get_user_bad(void);
>  		".previous\n"				\
>  		EX_TABLE(1b, 3b)			\
>  		: "=r" (err), "=r" (x)			\
> -		: "m<>" (*addr), "i" (-EFAULT), "0" (err))
> +		: "m"UPD_CONSTR (*addr), "i" (-EFAULT), "0" (err))

Wow, ugly!  But these are the only two places that use this, so

Acked-by: Segher Boessenkool  <segher@kernel.crashing.org>

I just hope that we get rid of 4.9 before we would use this a lot more ;-)


Segher
