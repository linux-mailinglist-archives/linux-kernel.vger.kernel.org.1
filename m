Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12AC1A6686
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgDMMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbgDMMvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:51:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A7E2073E;
        Mon, 13 Apr 2020 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782302;
        bh=ejpdoK6nCyovUTodcgI+x/yIdqO1GdrH6k62EYHDX/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wv9jiJj171n/VbX1/Oz+CDoFDAXgADnSrXt4yq4K9JyfAma1u+FgtbwvYQuGSH31M
         7RE2ZNinmeytr5BiBQB/J44cUZdQ9f8xVCdgKFVd8nceGeg7l3kyp8rNBZQH+aKE+j
         4w5D+kkaXwA+B3rkz1U52/jflGs0SrTzJMLcDCq4=
Date:   Mon, 13 Apr 2020 14:51:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     carlosteniswarrior@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: Comedi: Drivers: das08: Fixed some coding style
 issues
Message-ID: <20200413125140.GC3077651@kroah.com>
References: <20200413080555.29267-1-carlosteniswarrior@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413080555.29267-1-carlosteniswarrior@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:05:55AM +0200, carlosteniswarrior@gmail.com wrote:
> Fixed a coding style issue caused by some declarations that weren't separated.
> 
> Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>

Your From: line in your email client does not match with this :(

> ---
>  drivers/staging/comedi/drivers/das08.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/comedi/drivers/das08.c b/drivers/staging/comedi/drivers/das08.c
> index 65e5f2e6c122..f884f5841788 100644
> --- a/drivers/staging/comedi/drivers/das08.c
> +++ b/drivers/staging/comedi/drivers/das08.c
> @@ -141,7 +141,9 @@ static const struct comedi_lrange *const das08_ai_lranges[] = {
>  static const int das08_pgh_ai_gainlist[] = {
>  	8, 0, 10, 2, 12, 4, 14, 6, 1, 3, 5, 7
>  };
> +
>  static const int das08_pgl_ai_gainlist[] = { 8, 0, 2, 4, 6, 1, 3, 5, 7 };
> +
>  static const int das08_pgm_ai_gainlist[] = { 8, 0, 10, 12, 14, 9, 11, 13, 15 };

What is wrong with the original code?  It makes more sense, don't you
think?

greg k-h
