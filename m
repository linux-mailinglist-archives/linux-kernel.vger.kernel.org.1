Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C3329E8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgJ2K3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgJ2K3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:29:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7466F20782;
        Thu, 29 Oct 2020 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967354;
        bh=Tm90lS175FOlMzUHrCOla4NWfMoRabc/XtwGP38934s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+F9Ceb6vj5MVQVxuwPlZpmgEF0aL6DWXUB724MzjUWBua7+BnSaXtdFvQ7LAFGQi
         cIzicanGk9L1kDvINZFNQSNRl3/ELngkXO+Cxxr1jmgnHtxAwzXQ1lb3QfwA2eNen5
         nq24yTexr+k9QoLIHRfzGRxiT+UCC6NWNIghdCBE=
Date:   Thu, 29 Oct 2020 11:30:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: Fix spelling in comments
Message-ID: <20201029103003.GA3763875@kroah.com>
References: <20201029100759.21668-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100759.21668-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:37:59PM +0530, Bhaskar Chowdhury wrote:
> Fixed two spelling in two different comments.
> 
> s/defalut/default/p
> 
> This is in linux-next.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Please put the driver name in the subject line, like other patches for
this file do.

thanks,

greg k-h
