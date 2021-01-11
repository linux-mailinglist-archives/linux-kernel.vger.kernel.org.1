Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE302F185A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbhAKOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730890AbhAKOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:32:11 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EACC061786;
        Mon, 11 Jan 2021 06:31:31 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 15so12618267pgx.7;
        Mon, 11 Jan 2021 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0DUE/8pHhGvvFe2wGBEpZcQerM7z0IBDMtpx4elHBhY=;
        b=QqgpjRd4tRG8pQJSkIFwsCgwKh23rKwlhb3SzTe/VhcIiMR9knJphpoWssSh7ullpv
         P0zG2Wk5ZIUD44iwoLnJ9h+GHQoNN1XokivbuYcLO6Wd6TXeBf3TvQ4ghCzluLREz0mk
         occHwH9cAS1ccV+yuHPtqOrCzjFLFeGryIST7UyrXSxq4bZOXj1gKD3soPr4C6Slp2zi
         nF2vTkZPgodGRq+qpzoknOfOecHupo0AflRzpMbHE971zKJZqjVTm6ScLtwnrnVJ1sOc
         KvjlKyurUeK46OY/M520fwfk6YTnQOnhJEbMu7O7XAJHNR0KxCz1IzrDu4oXUucNjzTH
         craQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0DUE/8pHhGvvFe2wGBEpZcQerM7z0IBDMtpx4elHBhY=;
        b=p1p1/W+qMOkqC4v52/FCh0G7S9uxsMVJYLRmzJxyuRe3LgbiJXR5Q6WQCyYcqJMjJx
         v3JBM/KWQCUCXVhJzvTvJX10DZ/0wjf8qtWCy/HHgi++HdX8zxyj+wmKOW/eXMxv17Bf
         4g/ovaZoDtiawhuQIldsx8LZvoUw/touhla1HQc6KVfoDw3LMxV2mKEwa3gLJJwPkK7C
         ud+7zRgWbSxN13yWs4ehdvArZQgDqHisIYsWDBEtQrcoP78iVTT0+sotzGy7Fh736a7W
         s8dEHeOSrfbBiRoNBk0aD78sNkTH1A+TUtkN6jqkrV7v2Xzpo4fbEM0y/sUjqWYkYns3
         ciLw==
X-Gm-Message-State: AOAM530KjR5B9fUMkiiVdgv5gG5bUEPxX6admC5fCt1QC+SlkSi/E50b
        nOmFPoFqP8tTFFcZmuivuyK03Gl8txswKoYDazE=
X-Google-Smtp-Source: ABdhPJy/82/6GN7N+sIThX452USVvz/X0zgGG/hMBvtpffzBt/nDrwlfkDZMw8HWcErgWqXw5xt/NQ==
X-Received: by 2002:a65:6484:: with SMTP id e4mr20051803pgv.401.1610375490600;
        Mon, 11 Jan 2021 06:31:30 -0800 (PST)
Received: from minh ([123.20.101.14])
        by smtp.gmail.com with ESMTPSA id y27sm19242295pfr.78.2021.01.11.06.31.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jan 2021 06:31:29 -0800 (PST)
Date:   Mon, 11 Jan 2021 21:31:20 +0700
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     Oliver Neukum <oneukum@suse.de>
Cc:     linux-usb@vger.kernel.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
Message-ID: <20210111143120.GA2769@minh>
References: <20210111104927.2561-1-minhquangbui99@gmail.com>
 <7d6dc09fedc84f9fce942d85c34d5cd41931bbf6.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6dc09fedc84f9fce942d85c34d5cd41931bbf6.camel@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:00:31PM +0100, Oliver Neukum wrote:
> Am Montag, den 11.01.2021, 10:49 +0000 schrieb Bui Quang Minh:
> > In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
> > resubmit the urb, we need to deallocate the transfer buffer that is
> > allocated in mcba_usb_start().
> > 
> > Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> > v1: add memory leak fix when not resubmitting urb
> > v2: add memory leak fix when failing to resubmit urb
> > 
> >  drivers/net/can/usb/mcba_usb.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> > index df54eb7d4b36..30236e640116 100644
> > --- a/drivers/net/can/usb/mcba_usb.c
> > +++ b/drivers/net/can/usb/mcba_usb.c
> > @@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
> >  	case -EPIPE:
> >  	case -EPROTO:
> >  	case -ESHUTDOWN:
> > +		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > +				  urb->transfer_buffer, urb->transfer_dma);
> >  		return;
> >  
> 
> Can you call usb_free_coherent() in what can be hard IRQ context?

You are right, I digged in the code and saw some comments that on some
architectures, usb_free_coherent() cannot be called in hard IRQ context.
I see the usb_free_coherent() is called in write_bulk_callback too. I will
send a patch that uses usb_anchor to keep track of these urbs and cleanup 
the transfer buffer later in disconnect().

Thank you for your review,
Quang Minh.
