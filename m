Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9634821E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGNGfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 02:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGNGfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:35:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D142065D;
        Tue, 14 Jul 2020 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594708519;
        bh=9YfHDlDan0VZajidQw+wcfSkD+P7SL9p2kINP03rs5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdqN2/6kvTgo9yVT0pwQrbiTuCFn5/OuhrSSkWxkEsZ+mzGfXBRdZTDd0ZOGPzI5y
         tRhpgofHkvJv2T2ElCV24e/8suwVmhfoaZ09B88x+CDhv57Bo0IGND++JxXzVn7lu/
         b8BE7NmhXLnAy/iPWtrSg1N0i14gXjqzeJmDnW4M=
Date:   Tue, 14 Jul 2020 08:35:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Garrit Franke <garritfranke@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: remove unused kobject action
Message-ID: <20200714063517.GB662760@kroah.com>
References: <20200713191509.342466-1-garritfranke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713191509.342466-1-garritfranke@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:15:10PM +0200, Garrit Franke wrote:
> I noticed that the KOBJ_MAX action is never used. Does it serve any
> purpose, or can it be removed?

Don't ask questions in a changelog comment that you don't also answer :)

> As far as I know, Kobjects shouldn't be
> used for drivers and more higher level abstraction layers, so I figured
> it isn't used by user-provided code either.

Userspace sees these uevents, right?

> 
> Regards
> Garrit Franke

This isn't needed in a changelog text.

Try running and testing this a bit more before sending it for inclusion
please.

> 
> Signed-off-by: Garrit Franke <garritfranke@gmail.com>
> ---
>  include/linux/kobject.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 6cba088bee24..fd99c5d2d8b7 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -58,8 +58,7 @@ enum kobject_action {
>  	KOBJ_ONLINE,
>  	KOBJ_OFFLINE,
>  	KOBJ_BIND,
> -	KOBJ_UNBIND,
> -	KOBJ_MAX
> +	KOBJ_UNBIND

No need to drop that trailing ','

thanks,

greg k-h
