Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0769529EBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgJ2Mdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ2Mdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:33:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF8420756;
        Thu, 29 Oct 2020 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603974817;
        bh=ni7TkjqbA6fJ+ksEIFlg7Zx+Cb5ewBpoNMRVZ0D7amg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSLXl70kXfoQWdeNMjdnzNWGujJeGniYi63Sucw5rNVZDLOWU8F94R4kSq7iwW+UY
         CnkPO8p/pdNs4mmWaJhcaZVaZiF6fLKTA5Guxl9q8CGdvlM9z3yeBjM/PV8OiiU7+q
         o7xytgqqHVIE1iOhQ0TNawmec3Z7RtUIMxj/3a10=
Date:   Thu, 29 Oct 2020 13:34:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drivers: staging: rtl8188eu: Fix spelling in two
 comments i.e defalut to default
Message-ID: <20201029123428.GA2373999@kroah.com>
References: <20201029120725.11666-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029120725.11666-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:37:25PM +0530, Bhaskar Chowdhury wrote:
> Fixed two spelling in two different comments.
> 
> s/defalut/default/p
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What changed from v1?

That always goes below the --- line, please fix up and send a v3.

thanks,

greg k-h
