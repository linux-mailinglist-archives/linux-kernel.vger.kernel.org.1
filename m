Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5728A24868D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgHRN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 09:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHRN5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:57:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060BB206B5;
        Tue, 18 Aug 2020 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759058;
        bh=LmiV+VP1Db1N9hvNckueqBqLd8uBgy6Ev5UsaCvXUy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU7lzg9ftP9Sy6d9btxFSNP1GwXBHsSdeGS8L/2WaNvoTgguYPpUiYM7/oHHTr59l
         iI8dSu03TRGsCG+p380TrKnPUVQMc47aC6VyKEqOyoNT3QmWqcUrqWWQgLacTASzfx
         Euu3hjGRiM/h8ihrGhuf0KjWUA6dpFM9PCBDQE5g=
Date:   Tue, 18 Aug 2020 15:58:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Bansal <adbansal99@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: fixed misspelled word in comment
Message-ID: <20200818135802.GA533736@kroah.com>
References: <20200804145816.GA3823@aditya>
 <20200804124627.GA3348@aditya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804124627.GA3348@aditya>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 06:17:47PM +0530, Aditya Bansal wrote:
> From: Aditya Bansal <adbansal99@gmail.com>
> 
> Subject: [PATCH v2] fixed typo in driver/staging/wfx/hif_tx.c file
> 
> Correct the spelling of word function and careful
> 
> Signed-off-by: Aditya Bansal <adbansal99@gmail.com>
> ---
> 
> diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
> index 5110f9b93762..fc12f9dcefce 100644
> --- a/drivers/staging/wfx/hif_tx.c
> +++ b/drivers/staging/wfx/hif_tx.c
> @@ -125,7 +125,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
>  
>  // This function is special. After HIF_REQ_ID_SHUT_DOWN, chip won't reply to any
>  // request anymore. We need to slightly hack struct wfx_hif_cmd for that job. Be
> -// carefull to only call this funcion during device unregister.
> +// careful to only call this function during device unregister.
>  int hif_shutdown(struct wfx_dev *wdev)
>  {
>         int ret;
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Does not apply to my tree, can you please refresh and resend?

thanks,

greg k-h
