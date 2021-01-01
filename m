Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52C62E8351
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbhAAITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 03:19:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbhAAITi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 03:19:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EC8C221E9;
        Fri,  1 Jan 2021 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609489132;
        bh=Eywt6vGrmq9DTg4SpIk2R2wqQ1iRxAO/RH7CPApb4iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9yWVT3Bp7Dylx4XnBQcj2EQ/+i+YTXXK8IdG9Nf+BUwgPrwV4tqSFETOMydVm+vq
         WWzGR8z37HcNMhUilxW/9qnLyz2l0FRkacbyhGycEJd4sr37A0+qIw89a0y8N4HA2F
         l/M7Q7Ag2zboIyDdXP3n161wxUFfKgrRW1HP0X1g=
Date:   Fri, 1 Jan 2021 09:18:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gao Yan <gao.yanB@h3c.com>
Cc:     jirislaby@kernel.org, paulus@samba.org, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2]net:ppp: remove disc_data_lock in ppp line discipline
Message-ID: <X+7a6OudZwupatGw@kroah.com>
References: <20210101033718.45198-1-gao.yanB@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101033718.45198-1-gao.yanB@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 01, 2021 at 11:37:18AM +0800, Gao Yan wrote:
> In tty layer, it provides tty->ldisc_sem to protect all tty_ldisc_ops
> including ppp_sync_ldisc. So I think tty->ldisc_sem can also
> protect tty->disc_data, and the disc_data_lock is not necessary.
> 
> Signed-off-by: Gao Yan <gao.yanB@h3c.com>
> ---
>  drivers/net/ppp/ppp_async.c   | 11 ++---------
>  drivers/net/ppp/ppp_synctty.c | 12 ++----------
>  2 files changed, 4 insertions(+), 19 deletions(-)

What changed from v1?

And how did you test this?  Why remove this lock, is it causing problems
somewhere for it to be here?

thanks,

greg k-h
