Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1C2AA43A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgKGJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgKGJVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:21:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA44B20B1F;
        Sat,  7 Nov 2020 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604740874;
        bh=l0b6DiE53nfhjMPZWX+PUb5yafSJ/uyrW4s9ZgVKcBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRvYO+aWPei7NbTiPQ52wnyii0NwoDXftXSjAYz8LM3MttgzF0364yKVGplE1slNi
         VElYB88WL0TypdKf+9q8/2/cXb9tjgg9Ac5XVEoq5BndMQJklalKYSlV/TJb7R8jrv
         V9moSdpkiV/PrJrCNyEu8u4wWAYRljO31J6F4juo=
Date:   Sat, 7 Nov 2020 10:21:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: export device_is_bound() to fix build
 failure
Message-ID: <20201107092110.GA23599@kroah.com>
References: <20201106153744.22661-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106153744.22661-1-sudipm.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:37:44PM +0000, Sudip Mukherjee wrote:
> When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> is unable to find device_is_bound(). The error being:
> ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> 	undefined!
> 
> Export the symbol so that the module finds it.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---

What patch caused this problem?  Can you resend this with a "Fixes:"
line so we know where to queue it up to?

thanks,

greg k-h
