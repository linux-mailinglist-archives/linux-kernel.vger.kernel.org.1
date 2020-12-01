Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACD2C9EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgLAKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgLAKKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:10:32 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F44F206E3;
        Tue,  1 Dec 2020 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606817391;
        bh=fV3KKCadB+LL3j4DL0ZftMHe55epHHnlJ+62WanGo34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSHya1o4FFS4t9ses9Uo0GMqSa0ITLyz5Cv2UseCtCUlNOMVh6W/MkMTV95u2/nkM
         ayLuREbJQLd0mahkPVeE5y6/GtAOjkp24SaEgCsKGZYUcTrvyi+VkByWx6koxYE6uh
         uYBnoUGtUvCBJxYP77cOEdhnU+Yp8np3AE2ofOLs=
Date:   Tue, 1 Dec 2020 11:11:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jiladahe1997 <972931182@qq.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial/imx: Enable TXEN bit in imx_poll_init().
Message-ID: <X8YWt5TGlcI93E8e@kroah.com>
References: <tencent_20B71295BC0C2FCB5807D81BC045ED802C06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_20B71295BC0C2FCB5807D81BC045ED802C06@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 09:52:49AM +0800, jiladahe1997 wrote:
> From: Mingrui Ren <972931182@qq.com>
> 
> As described in Documentation, poll_init() is called by kgdb to initialize
> hardware which support both poll_put_char() and poll_get_char().
> 
> It's necessary to enable TXEN bit, otherwise, it will cause hardware fault
> and kernel panic when calling imx_poll_put_char().
> 
> Generally, if use /dev/ttymxc0 as kgdb console as well as system
> console, ttymxc0 is initialized early by system console which does enable TXEN
> bit.But when use /dev/ttymxc1 as kgbd console, ttymxc1 is only initialized by 
> imx_poll_init() cannot enable the TXEN bit, which will cause kernel panic.
> 
> Signed-off-by: Mingrui Ren <972931182@qq.com>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent this twice?  Which one is "correct"?  I'll drop both from my
patch queue and wait for just one to be resent.

thanks,

greg k-h
