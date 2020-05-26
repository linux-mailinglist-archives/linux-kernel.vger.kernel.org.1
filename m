Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8259B1A6689
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgDMMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgDMMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:54:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE4A2073E;
        Mon, 13 Apr 2020 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782479;
        bh=ani0mo4L/AJTIw6JkBA9qVVLgc8vJAgL0LuTd17rhiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dea/gQ2sfw8+g1x3RM6AAgSwyUsTikCO055ndzcAar8+dYhJX05xXcceamuBbf87p
         ukEEWZFlZ5MrJS8tExRITflriPfgAxhZpYgUkZN7D3pcTF4uwfF8ud2ZV4PPscveT4
         euoLLUW6+mESf/VTMkyuofsyrX8geNDixLIv4UqA=
Date:   Mon, 13 Apr 2020 14:54:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     carlosteniswarrior@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: drivers: jr3_pci: fixed two warnings
Message-ID: <20200413125437.GA3116954@kroah.com>
References: <20200412142508.327-1-carlosteniswarrior@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412142508.327-1-carlosteniswarrior@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 04:25:08PM +0200, carlosteniswarrior@gmail.com wrote:
> Fixed two checkpatch warnings.
> 
> Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
> ---
>  drivers/staging/comedi/drivers/jr3_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
> index c3c88e6d298f..6bc87d3c6c3b 100644
> --- a/drivers/staging/comedi/drivers/jr3_pci.c
> +++ b/drivers/staging/comedi/drivers/jr3_pci.c
> @@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
>  };
>  
>  union jr3_pci_single_range {
> -	struct comedi_lrange l;
> -	char _reserved[offsetof(struct comedi_lrange, range[1])];
> +	const comedi_lrange l;
> +	char _reserved[offsetof(const comedi_lrange, range[1])];
>  };

Please work on your knowledge of C first, before modifying Linux kernel
code.  Mistakes like this show you need a bit more work there first.

Good luck!

greg k-h
