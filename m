Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE012F1209
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbhAKMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:01:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbhAKMBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:01:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54F1FABC4;
        Mon, 11 Jan 2021 12:00:33 +0000 (UTC)
Message-ID: <7d6dc09fedc84f9fce942d85c34d5cd41931bbf6.camel@suse.de>
Subject: Re: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Date:   Mon, 11 Jan 2021 13:00:31 +0100
In-Reply-To: <20210111104927.2561-1-minhquangbui99@gmail.com>
References: <20210111104927.2561-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 11.01.2021, 10:49 +0000 schrieb Bui Quang Minh:
> In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
> resubmit the urb, we need to deallocate the transfer buffer that is
> allocated in mcba_usb_start().
> 
> Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> v1: add memory leak fix when not resubmitting urb
> v2: add memory leak fix when failing to resubmit urb
> 
>  drivers/net/can/usb/mcba_usb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> index df54eb7d4b36..30236e640116 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
>  	case -EPIPE:
>  	case -EPROTO:
>  	case -ESHUTDOWN:
> +		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> +				  urb->transfer_buffer, urb->transfer_dma);
>  		return;
>  

Can you call usb_free_coherent() in what can be hard IRQ context?

	Regards
		Oliver


