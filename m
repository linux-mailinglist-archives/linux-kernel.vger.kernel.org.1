Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197E2E80C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgLaOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 09:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgLaOw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 09:52:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D3A223E4;
        Thu, 31 Dec 2020 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609426306;
        bh=mttXVcNsr3pH/aRjWc5qpqienEdbGGWuobbapRQZ0FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxyuR7pGdLDm8HrFV0Cuk3wWbUmQZXV6CzL+5Iyp6DjuWM87772sLTM55XBYOXg7K
         Q60gyWRtScHrWlv1IgTtzbTAEq+JWiGokfCFxKigG6mpxi/K8z2hNgXBlp9AJ7h6mV
         xk2Q2Iu+xxdhX3DeCLMcSekOrrbFn1+EeWtX0vgs=
Date:   Thu, 31 Dec 2020 15:53:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: use flexible-array member instead of zero-length
 array
Message-ID: <X+3l1pv89pBW/tKN@kroah.com>
References: <1609416240-35298-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609416240-35298-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 08:04:00PM +0800, Tian Tao wrote:
> Use flexible-array member introduced in C99 instead of zero-length
> array. Most of zero-length array was already taken care in previous
> patch [1]. Now modified few more cases which were not handled earlier.
> 
> [1]. https://patchwork.kernel.org/patch/11394197/
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index d04a162..86b4c5f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -332,7 +332,7 @@ typedef uint32_t char32_t;
>   * scrolling only implies some pointer shuffling.
>   */
>  struct uni_screen {
> -	char32_t *lines[0];
> +	char32_t *lines[];

Are you _sure_ you can do this?  What testing did you do?

thanks,

greg k-h
