Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4A1A75F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436751AbgDNIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436744AbgDNIZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:25:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED02C20578;
        Tue, 14 Apr 2020 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586852708;
        bh=xxacNN54FtarsJjPAzYq/IC6+kgP7e5TbdVrVbqAinc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLQ5Jpw5ON3N940xKP7Q/SBKNWa5Cej5DM+MUoEpI7Uk3v3GcdkWTe3aAx4fMaok9
         SNxT6vDEM0Y0+BQlSUHRNi/xcQB4akm8vZ+DJLSKB2vFfxv3X2VVgLOugi4/e1O9GG
         RulZpMuvIxKecT819POw7h1KMmbZspm11B17wIiQ=
Date:   Tue, 14 Apr 2020 10:25:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     carlosteniswarrior@gmail.com
Cc:     linux@jaseg.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: fbtft : fbtft-bus: fixed two checkpatch errors
Message-ID: <20200414082506.GB10645@kroah.com>
References: <20200414073047.2757-1-carlosteniswarrior@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414073047.2757-1-carlosteniswarrior@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:30:47AM +0200, carlosteniswarrior@gmail.com wrote:
> From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
> 
> Fixed two checkpatch space prohibited before that close parenthesis errors.
> 
> Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67b17..cdb451dd3fde 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)

If I remember correct, the original code here is required, due to how
some older versions of gcc works.

Did you test-build this?  Did it work properly?

I would just leave this alone,

greg k-h
