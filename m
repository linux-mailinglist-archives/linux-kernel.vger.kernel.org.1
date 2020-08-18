Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57024872E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHRORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgHRORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:17:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DB4207FF;
        Tue, 18 Aug 2020 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760271;
        bh=Z0Y7yKJ7hTNry0GWGXzM1eNHZTv8P/i3X65kNeToXdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGCqTm2GNRIRopzsETHqC9xIrmKppJ0oVKW+FzrE6CjSCnQaKK/DbFQ+0ZE5B0oZa
         GI9KVx87Klz0GX7oO7gYSythKpA+YSEv51aF8Ml9n3wtLnb3DjNGmAz3q8KfOBVlEw
         CRGWFBXMGlBSRycHJPtFeQDjUoB2j749nuZGC70Y=
Date:   Tue, 18 Aug 2020 16:18:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 42/44] MAINTAINERS: add an entry for HiSilicon
 6421v600 drivers
Message-ID: <20200818141814.GA608915@kroah.com>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
 <60a2766c2e64dc6957480231a4e9ad9e6b00ab40.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a2766c2e64dc6957480231a4e9ad9e6b00ab40.1597647359.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:11:01AM +0200, Mauro Carvalho Chehab wrote:
> Add an entry for the SPMI, MFD and PMIC parts of the
> HiSilicon 6421v600 support.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 956ecd5ba426..e2de0b2119fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7824,6 +7824,12 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
>  F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
>  F:	drivers/crypto/hisilicon/sec2/sec_main.c
>  
> +HISILICON STAGING DRIVERS FOR HIKEY 960/970
> +M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +L:	linux-kernel@vger.kernel.org

staging driver patches are not sent to this list, please use the driver
devel list instead of lkml.

thanks,

greg k-h
