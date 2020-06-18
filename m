Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49681FECCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFRHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 03:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:47:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2042166E;
        Thu, 18 Jun 2020 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592466477;
        bh=uN0TGa/T7pPRO9EFXsTyPP8pb9QfsOxNueiaH6cBEEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLXMoTqzkPPPNMphukDIi+S1xDuWNkqoJpP6PiqTa5/VBfFNnbGTRRdlUFkIZyKrc
         yAggmB0Rf6lkOcF3bzxf4MAld23WB8IsJ7FyWb2H7Qjgk1mmrKf4YqNB+U4WhUSl76
         8qEzGi9pYaojDeglSgKCaAVB73qv9Y0sTGGJ7BKM=
Date:   Thu, 18 Jun 2020 09:47:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Richard Yeh <rcy@google.com>,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] staging: gasket: replace symbolic permissions
Message-ID: <20200618074750.GA186463@kroah.com>
References: <20200601005240.6315-1-rodolfovillordo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601005240.6315-1-rodolfovillordo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:52:40AM +0000, Rodolfo C. Villordo wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> warning detected by checkpatch.pl
> 
> Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> index ab5aa351d555..d5e167dfbe76 100644
> --- a/drivers/staging/gasket/gasket_sysfs.h
> +++ b/drivers/staging/gasket/gasket_sysfs.h
> @@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
>  
>  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
>  	{                                                                      \
> -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> +		.attr = __ATTR(_name, 0444, _show_function, NULL),          \

What about using __ATTR_RO() instead?

thanks,

greg k-h
