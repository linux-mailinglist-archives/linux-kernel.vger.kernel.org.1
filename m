Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B12CFB51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 13:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgLEMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 07:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgLEKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:53:50 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF381C061A4F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 02:53:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cp5yS3QDtz9sWP;
        Sat,  5 Dec 2020 21:53:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1607165585;
        bh=ex3cBBYGGN8ZWn9vGp/TzfU5wQ1yOIKrp67fUHz4AE4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MfCwRUADxMG/+vtCEkz7YojkhXgIWk8lfh8CPgQGdhPqABpzV+bALLpbltLVK9zVn
         PAcfQXIRg2BRFE2XSGuodSDZt/FH5P9ub/IwRC4EYKEr31GPME67ziBri3NKo30/Ig
         0TAdbS1seFMo0HK2sdMRpMniXhCUzMwflYR0m9DwtGZmIULqGo2mnry0eHs7TWMWI4
         or7Z/vIneEsndJtKiBbtEqU9/4pkNSkBZvKzg7suW/GJG8NDSaqlZQVMyVGuc+Q8hU
         1b6DJNd1P+cpKAxdtW+epAzc8nVPdFUfqvYpJw7Z8r25lWjWQACM4i/CBenxI/CDOV
         1mfYiUF0UGpXg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update 68k Mac entry
In-Reply-To: <fbac2cd8632bb719f48cd1368910abd310548a0e.1607139987.git.fthain@telegraphics.com.au>
References: <fbac2cd8632bb719f48cd1368910abd310548a0e.1607139987.git.fthain@telegraphics.com.au>
Date:   Sat, 05 Dec 2020 21:53:03 +1100
Message-ID: <871rg4v81c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> writes:
> Two files under drivers/macintosh are actually m68k-only. I think that
> patches for these files should be reviewed in the appropriate forum and
> merged via the appropriate tree, rather than falling to the powerpc
> maintainers to deal with. Update the "M68K ON APPLE MACINTOSH" section
> accordingly.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 867157311dc8..e8fa0c9645d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10322,6 +10322,8 @@ L:	linux-m68k@lists.linux-m68k.org
>  S:	Maintained
>  W:	http://www.mac.linux-m68k.org/
>  F:	arch/m68k/mac/
> +F:	drivers/macintosh/adb-iop.c
> +F:	drivers/macintosh/via-macii.c
>  
>  M68K ON HP9000/300
>  M:	Philip Blundell <philb@gnu.org>
> -- 
> 2.26.2
