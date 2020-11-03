Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED77E2A3DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgKCHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 02:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:44:42 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA982222B;
        Tue,  3 Nov 2020 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604389480;
        bh=Jx8wRrB9/fuw7TM0pSE5QGNpspQsth3fmkHA3qSHTmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwJO24CWhTdyHBVOaV52BK6Vr+FwUf87pyxxuE4CZWnOUy/uRUb2I+Qb5EgtWT7Ie
         7AYkgfCSPajmqj7zJdl7bCXpSwjM9XsfUmV30eYeAJiBWlWE8qoQVlAoUBf0nJoRSH
         uAyRdj0C1xgvZi989yl6ywFfXOTUdSTUwuCcTurs=
Date:   Tue, 3 Nov 2020 08:45:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: txx9: add missing
 platform_driver_unregister() on error in serial_txx9_init
Message-ID: <20201103074533.GA2504333@kroah.com>
References: <20201103073341.144512-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103073341.144512-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:33:41PM +0800, Qinglang Miao wrote:
> Add the missing platform_driver_unregister() before return
> from serial_txx9_init in the error handling case when failed
> to register serial_txx9_pci_driver with macro ENABLE_SERIAL_TXX9_PCI
> defined.
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/tty/serial/serial_txx9.c | 3 +++
>  1 file changed, 3 insertions(+)

What changed from v1?  Always put that below the --- line.

Please fix up and send v3.

thanks,

greg k-h
