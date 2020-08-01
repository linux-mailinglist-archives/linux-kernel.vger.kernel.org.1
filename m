Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C68235192
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHAJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 05:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgHAJvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:51:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15ABB20725;
        Sat,  1 Aug 2020 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596275483;
        bh=v2/+wm7/ZgJPVdDZ5fDV3AVWi0VZF9wUEj4ulC1C+2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnyoXCl5yo3Qywrx47QApLP9qsK4JomrJFDjiHlDxLf0G3jbLWDKLA2NHeyaDRBwU
         B9ANzpmijpStrTK3/juzfa4R7PgOaO//4gxJat2Ts5sP/D6G62eyNm72fbC1v8grkB
         YcY4vTtmiV3txsSGstN/BdKzjssF6jPp7m8J/PmE=
Date:   Sat, 1 Aug 2020 11:51:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: replace rtw_netdev_priv define with
 inline function
Message-ID: <20200801095108.GA2840539@kroah.com>
References: <20200801094707.13449-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801094707.13449-1-insafonov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 12:47:07PM +0300, Ivan Safonov wrote:
> The function guarantees type checking of arguments and return value.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  drivers/staging/rtl8188eu/include/osdep_service.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
> index 31d897f1d21f..e0ccafdea9cd 100644
> --- a/drivers/staging/rtl8188eu/include/osdep_service.h
> +++ b/drivers/staging/rtl8188eu/include/osdep_service.h
> @@ -71,8 +71,10 @@ struct rtw_netdev_priv_indicator {
>  };
>  struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
>  
> -#define rtw_netdev_priv(netdev)					\
> -	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
> +static inline struct adapter *rtw_netdev_priv(struct net_device *dev)
> +{
> +	return (((struct rtw_netdev_priv_indicator *)netdev_priv(dev))->priv);
> +}
>  void rtw_free_netdev(struct net_device *netdev);

Is the cast really needed?

And no blank line before the next function prototype?

And is this really needed?  Type checking is already happening as this
is a "simple" macro, right?

thanks,

greg k-h
