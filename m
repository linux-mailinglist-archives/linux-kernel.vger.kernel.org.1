Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7427C259
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgI2KZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2KZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:25:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D7D20708;
        Tue, 29 Sep 2020 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375148;
        bh=2CICJMeSzhqcrQ75ym2YrOJwBAyZ9BZUaOvY7HlgRtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AP52XRTbs8ea37as+UHsd/EfICnUz75+8dDjb9g+XgzDycwcL6hXWTPkOPmNFlIy6
         FslTahUc0klf6E6Ko5DHsP7BSjR3/jP8nQyOaVTFWcalbHax4UjKGiKmVd4uNvBTlA
         BkIGpp2a/sBxVsXhDCOUwBcDNOhIPw/d0QUqkdFc=
Date:   Tue, 29 Sep 2020 12:25:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 01/16] bcm-vk: add bcm_vk UAPI
Message-ID: <20200929102554.GB951772@kroah.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929001209.16393-2-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:11:54PM -0700, Scott Branden wrote:
> Add user space api for bcm-vk driver.
> 
> Provide ioctl api to load images and issue reset command to card.
> FW status registers in PCI BAR space also defined as part
> of API so that user space is able to interpret these memory locations
> as needed via direct PCIe access.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  include/uapi/linux/misc/bcm_vk.h | 84 ++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> 
> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> new file mode 100644
> index 000000000000..5f1fc403bc67
> --- /dev/null
> +++ b/include/uapi/linux/misc/bcm_vk.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */

Why do you need BSD-2 if you already have the syscall-note license?

thanks,

greg k-h
