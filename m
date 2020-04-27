Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC91BA9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgD0QEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0QEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:04:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83433205C9;
        Mon, 27 Apr 2020 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003473;
        bh=yQw0lJ/dRaWvFr7ULAC65L+RGkqRLDb06f2ufgGujFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/Py3y0d1wzPrPpmUOb7U9JcpztHzqc7ZxE3DgQbJfdjXwWJe4Lr86U6KRZtDizxB
         /wfZziWMVR3tY+Mffgt5GPvLaNNWaeei2AwoaxOT/dsYGLmNge+CirLheUAFLMQ4LG
         XWJk2jQ1xU/vOlG1bKbormCJlAsvk8vQu+MfrSUA=
Date:   Mon, 27 Apr 2020 18:04:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else-if statements
Message-ID: <20200427160430.GA3549342@kroah.com>
References: <20200427152442.26597-1-john.oldman@polehill.co.uk>
 <20200427152442.26597-2-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427152442.26597-2-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 04:24:42PM +0100, John Oldman wrote:
> Make a better job of fixing coding style issues, this time fixing
> all blocks as per Joe Perches' comment.
> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/staging/rts5208/rtsx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index ca836ca2ee81..e16a7b9c3203 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -402,19 +402,15 @@ static int rtsx_control_thread(void *__dev)
>  		if (chip->srb->sc_data_direction == DMA_BIDIRECTIONAL) {
>  			dev_err(&dev->pci->dev, "UNKNOWN data direction\n");
>  			chip->srb->result = DID_ERROR << 16;
> -		}
> -
> -		/* reject if target != 0 or if LUN is higher than
> -		 * the maximum known LUN
> -		 */
> -		else if (chip->srb->device->id) {
> +		} else if (chip->srb->device->id) {
> +			/* reject if target != 0 or if LUN is higher than
> +			 * the maximum known LUN
> +			 */
>  			dev_err(&dev->pci->dev, "Bad target number (%d:%d)\n",
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
>  			chip->srb->result = DID_BAD_TARGET << 16;
> -		}
> -
> -		else if (chip->srb->device->lun > chip->max_lun) {
> +		} else if (chip->srb->device->lun > chip->max_lun) {
>  			dev_err(&dev->pci->dev, "Bad LUN (%d:%d)\n",
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
> -- 
> 2.17.1

Why is this not just one patch?
