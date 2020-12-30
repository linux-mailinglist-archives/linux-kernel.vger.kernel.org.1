Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DD2E78AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgL3Ms3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgL3Ms2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:48:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2837B2220B;
        Wed, 30 Dec 2020 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609332467;
        bh=+Vj4AXEbOGEO2HVS8Wk6KVWRPCQg4+wEXVUndvahp30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zA38ZEK6j8WGb/Pn/FdwSM/8Q1gZDhxVkijFp29XO3IPnW8XTyfGjXOI7e81eNzbZ
         95MP0cZJ4qMet5iwrnwcUkj3QJhM6Bj4hSLPwORR6epoKvYNhONYV0Law4FxBTmyUG
         sIMdCBIdodFZKY5ZHyiIvnxxN/je4528+E0LfJl0=
Date:   Wed, 30 Dec 2020 13:49:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: resolve loopback wait problem for aging serial
 port
Message-ID: <X+x3Soqf6D6XzuxY@kroah.com>
References: <1609331946-10165-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609331946-10165-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:39:06PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> Because serial port is low-speed device, serial port writing will be suspended
> when the buffer of driver layer is full due to serial port aging. The concrete
> representation is n_tty_write blocking in the process of wait_woken, the process
> of writing serial port exists without feedback, and becomes a zombie process.
> So for serial port, set the timeout value of wait_woken function to 60s. Wake up
> and flush the buffer after timeout.
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
>  drivers/tty/n_tty.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

What changed from v1?  Always put that below the --- line as the
documentation asks you to do so.

Please fix up and submit a v3.

thanks,

greg k-h
