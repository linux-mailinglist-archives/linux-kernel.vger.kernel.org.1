Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA361D1204
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgEML62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgEML60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:58:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8996620740;
        Wed, 13 May 2020 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371106;
        bh=AzQ1GBsA7vb+t+sUqdhpDj5pFQccxwb/vacxaCIKKwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=veu54zijFTH9tV9hdep4oqmKRxlo+9/yg1yax/JmUfYmhty8mC9xQt4bNL0BuSlFC
         orkh9kp754J4DzatlKprBvYa+aUOjx7weYxvCNttblmgA0qv7E6YOp5j+PDrfKDu+p
         jhNi0N0h1hXgNDBNneUKt7u1RMSETOfVkcToZ7HI=
Date:   Wed, 13 May 2020 13:58:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3] staging: vc04_services: vchiq_connected.c: Block
 comment alignment
Message-ID: <20200513115823.GC953616@kroah.com>
References: <20200510101308.10451-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510101308.10451-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 11:13:08AM +0100, John Oldman wrote:
> Coding style issue
> This patch clears the checkpatch.pl "Block comments should align the * on each line" warning.
> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
> v1: Initial attempt.
> v2: Resubmitted with shorter comment line, as suggested by Greg KH.
> v3: Resubmitted with descriptiuon text moved into the comment area.
> 
>  .../interface/vchiq_arm/vchiq_connected.c     | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> index 1640906e3929..993535bbc479 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> @@ -15,10 +15,10 @@ static   int                        g_once_init;
>  static   struct mutex               g_connected_mutex;
>  
>  /****************************************************************************
> -*
> -* Function to initialize our lock.
> -*
> -***************************************************************************/
> + *
> + * Function to initialize our lock.
> + *
> + ***************************************************************************/
>  
>  static void connected_init(void)

Shouldn't that really be written as:

/* Function to initialize our lock */
static void connect_init(void);


No need for the /****** mess, and no need for the blank line.

Simple and clean is best.

thanks,

greg k-h
