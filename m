Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB522AAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgGWIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 04:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWIae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:30:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59F120768;
        Thu, 23 Jul 2020 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595493034;
        bh=mPYqTowX5vor6nLpyE1VROCULLbUPdSd3qfv92B4MpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CA3E/h62M0dkPEcInzOMtb9f2PDv/UzMr12wB/dHq48x/h3qjbmGRXoIFahFOAJtE
         XkKfo2Jpa5pKk0QvFGOjB6POf4IsE88jB6pOiVzXHJSx6E6YS+JE8RqaUxVlbZHRFL
         MY9/Jz7gLNlyQnUlyE/Lm5L4+mP0a5GrYTYVhccs=
Date:   Thu, 23 Jul 2020 10:30:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Add the license identifier
Message-ID: <20200723083038.GA1525929@kroah.com>
References: <20200722153953.GA8148@PKL-UANJUM-LT.pkl.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153953.GA8148@PKL-UANJUM-LT.pkl.mentorg.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:39:53PM +0500, Muhammad Usama Anjum wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: Missing or malformed SPDX-License-Identifier tag
> 
> Add a the SPDX-License-Identifier tag on line 1
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index d06743504f2b..889b7c80666d 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +

How do you know this is the correct license for this file?

Please include how you came to this decision in the changelog text when
you resend it.

thanks,

greg k-h
