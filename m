Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949D21D74C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgGMNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 09:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgGMNf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:35:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EAA2072D;
        Mon, 13 Jul 2020 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594647327;
        bh=/wWVErS8bBU0BhjE2vfVnNzcXafBwMZc5v+u2jYiyxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmuGEAAR4usiwresNCHmUSga3+1CuU80WweZcaHM+yq/FjJE2JTKibfYFw8elRZ6D
         NKNdru5+VP0A4XNpAwiAh82dyQLZlYT8mik0p90AaqUd9xZrUMQB9LjTXcG4Q02llN
         Iex0kE//A73LVNRQaFphsMkORjAMfVq+eeg5uabg=
Date:   Mon, 13 Jul 2020 15:35:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Baidyanath Kundu <kundubaidya99@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Staging: vc04_services: Fix code indent error
Message-ID: <20200713133527.GB3122574@kroah.com>
References: <20200713072224.7648-1-kundubaidya99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713072224.7648-1-kundubaidya99@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:52:24PM +0530, Baidyanath Kundu wrote:
> This patch fixes the checkpatch.pl error:
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Baidyanath Kundu <kundubaidya99@gmail.com>
> ---
>  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index a075cd63da7f..86c00b68f099 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -294,13 +294,13 @@ static void buffer_to_host_work_cb(struct work_struct *work)
>  	/* queue the bulk submission */
>  	vchiq_use_service(instance->service_handle);
>  	ret = vchiq_bulk_receive(instance->service_handle,
> -				 msg_context->u.bulk.buffer->buffer,
> -			         /* Actual receive needs to be a multiple
> -			          * of 4 bytes
> -			          */
> -			         (len + 3) & ~3,
> -			         msg_context,
> -			         VCHIQ_BULK_MODE_CALLBACK);
> +				msg_context->u.bulk.buffer->buffer,
> +				/* Actual receive needs to be a multiple
> +				 * of 4 bytes
> +				 */
> +				(len + 3) & ~3,
> +				msg_context,
> +				VCHIQ_BULK_MODE_CALLBACK);

Close, you need one more space for these lines, right?

thanks,

greg k-h
