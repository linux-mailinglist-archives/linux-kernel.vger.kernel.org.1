Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A12E19B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgLWIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgLWIM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:12:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8B03207D0;
        Wed, 23 Dec 2020 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608711102;
        bh=r04tfWe6BzgW/kVLq7dsu9JKh40VfeDiStZESOyfGiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTIAU+9EG80hB23b6L4UsXEUhfnuvBsWojntx70qYFYZMxhJ3izK+ymtEU9UGAo2F
         ehVZTNIdKwNLodmLXtyhtHgcccNrhrYb3DE1mutCVkov1xxQPn950pF0Cw5YyoV6GB
         2/GotKG7sQ/5fDcWWhbwz2L0MY3BmXftTBun+vLg=
Date:   Wed, 23 Dec 2020 09:11:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     balbi@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] usb: dwc3: meson-g12a: disable clk on error handling
 path in probe
Message-ID: <X+L7usyEWYXzxQWD@kroah.com>
References: <20201215025459.91794-1-zhengzengkai@huawei.com>
 <c069b566-224d-f938-089c-6a69d1ec9d55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c069b566-224d-f938-089c-6a69d1ec9d55@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:13:03AM +0800, Zheng Zengkai wrote:
> Hi everyone,
> 
> Friendly ping:
> 
> Just want to know why this patch was ignored,

Right now it is the merge window and we can't do anything with any
patches until 5.11-rc1 is out.  After that happens, I'll work on
catching up on older patches like this.

thanks,

greg k-h
