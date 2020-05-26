Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACCD1A667E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgDMMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgDMMu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:50:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A9A2073E;
        Mon, 13 Apr 2020 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782257;
        bh=vJVQxIP9f88bxvWbQgUeSmR5vQOrhBhi/wjsmEHyAPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftx0Q5HVmSoSZgeK9g1GamKCgDj+Lak/WMucjWZl59u6E8USEJUo0N+9cQLWY5loq
         HGgAhS3Q/1c49/yoTie641/B4aMtq1Y6o+u/mEvDhsIfb8PE3nBS2EFyMyKe+lETSy
         gzWavf4kgcW3+aNCE30JO9CGcJx4QwfVqfUT9ldw=
Date:   Mon, 13 Apr 2020 14:50:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH 2/2] staging: rtl8192u: Renames variables in setKey
 function
Message-ID: <20200413125054.GB3077651@kroah.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
 <20200413030129.861-2-c.cantanheide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413030129.861-2-c.cantanheide@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:01:29AM +0000, Camylla Goncalves Cantanheide wrote:
> Renames the local variables of the setKey
> function, making them explicit.

Why do this?

> 
> Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 48 +++++++++++++-------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 87c02aee3854..cc02c3b1eb91 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4877,48 +4877,48 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
>  	write_nic_byte(dev, SECR,  SECR_value);
>  }
>  
> -void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
> -	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
> +void setKey(struct net_device *dev, u8 entry_no, u8 key_idx, u16 key_type,
> +	    u8 *mac_addr, u8 default_key, u32 *key_content)

What was wrong with the original names?  Why add a '_' character for no
good reason?

thanks,

greg k-h
