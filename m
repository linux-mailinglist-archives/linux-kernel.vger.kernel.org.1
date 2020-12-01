Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3A2C97BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 07:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLAGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 01:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLAGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:55:49 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B72C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 22:55:03 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id x15so715767otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8gNh4uzJ/vrjUJz2fQVgW80e6ioAxOfUVSCAWYilQ0=;
        b=v2vGs5fNznQ/JodWPWIHsyKAZilmUAVVt1CJrkA7/FFu7WWA0AShtU3gkN9IHXVikp
         lZVDgRe8UXQtfj/TxkSfkbnw3jwV+RnRo0FiA6k4OuNFg34Dnpy+PpAWNHpScNIzGO5l
         bfEUltKddnMD0Iaxk+HILWlo9I/sX7e9ytnbdTkKVuPFVC0mwuzD19aoyzfpB/1ZiAng
         ivusSej8UfshPgnEENVEYmlLgDAL7zSK3me/GGopSmCTFFapkcZPnZZS0zB9FvQ8K/0O
         6SdX2dfswRmBIetXLUe11eC7/WbNXP62ziJbirmQl65QdtDXMEqjA75OHwnyRB10TfeY
         Kwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8gNh4uzJ/vrjUJz2fQVgW80e6ioAxOfUVSCAWYilQ0=;
        b=oxp0IKIOj9zjaySH64ZEY1oljkwZMHUCKQwz7a98d4gOmaONBWbwhGlf3cKlQPLoUy
         lGlmZcrEwCafGoX3nw/hVdJHFfsqaDOV5Moa8gXbKNY+TGgcFiqbtCrf55Yf93w5A8Tb
         BcychVtj6itcauuRZaqosl2Rv8CtxbGwhcxx1el76nlSPG0sCTc/K70Xu0eBpno5G8/C
         hZEzw4rqAOy/BF7YMX+/xNZO4QqGT5hovhy+O0KRx134EJSiClq1r3Sj/++e7dWfdouY
         Bc6YTfgXj8mHJQqrRfDIUQFkQa9JYmS5xpZlEODoBP89srmv0SnlJitnCxWr2ty+R5hS
         37TQ==
X-Gm-Message-State: AOAM530lxfiiDVrT/pXjY6UplRn6th450of8n0O+CcopQaO2LtnmJM5U
        Y0m+gku4LF9bOS+JGWXb1dc35pyBw+/9INxeMtolqg==
X-Google-Smtp-Source: ABdhPJziejeDJXv5UJ+mV1sKpOCztprkqjQ4nyzjVsinqpmpzkyBTGlRJai/raYMfbDqjH7yclXxZYbuPhmb6gwHJ3Q=
X-Received: by 2002:a05:6830:1e7a:: with SMTP id m26mr981712otr.104.1606805702433;
 Mon, 30 Nov 2020 22:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20201201060050.1193986-1-furquan@google.com> <20201201062807.GO2034289@dtor-ws>
In-Reply-To: <20201201062807.GO2034289@dtor-ws>
From:   Furquan Shaikh <furquan@google.com>
Date:   Mon, 30 Nov 2020 22:54:46 -0800
Message-ID: <CAEGmHFGYuM91U+Tvq+YDt180cfHQKnOKMY5ToHZ7v44fOs-_8w@mail.gmail.com>
Subject: Re: [PATCH] input: raydium_ts_i2c: Do not split tx transactions
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Mon, Nov 30, 2020 at 10:28 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Furquan,
>
> On Mon, Nov 30, 2020 at 10:00:50PM -0800, Furquan Shaikh wrote:
> > Raydium device does not like splitting of tx transactions into
> > multiple messages - one for the register address and one for the
> > actual data. This results in incorrect behavior on the device side.
> >
> > This change updates raydium_i2c_read and raydium_i2c_write to create
> > i2c_msg arrays separately and passes those arrays into
> > raydium_i2c_xfer which decides based on the address whether the bank
> > switch command should be sent. The bank switch header is still added
> > by raydium_i2c_read and raydium_i2c_write to ensure that all these
> > operations are performed as part of a single I2C transfer. It
> > guarantees that no other transactions are initiated to any other
> > device on the same bus after the bank switch command is sent.
>
> i2c_transfer locks the bus [segment] for the entire time, so this
> explanation on why the change is needed does not make sense.

The actual problem is with raydium_i2c_write chopping off the write
data into 2 messages -- one for register address and other for actual
data. Raydium devices do not like that. Hence, this change to ensure
that the register address and actual data are packaged into a single
message. The latter part of the above comment attempts to explain why
the bank switch message is added to xfer[] array in raydium_i2c_read
and raydium_i2c_write instead of sending a separate message in
raydium_i2c_xfer i.e. to ensure that the read/write xfer and bank
switch are sent to i2c_transfer as a single array of messages so that
they can be handled as an atomic operation from the perspective of
communication with this device on the bus.

>
> Also, does it help if you mark the data message as I2C_M_NOSTART in case
> of writes?

That is a great suggestion. I think this would be helpful in this
scenario. Let me follow-up on this to see if it helps with the current
problem.

>
> I also wonder if we should convert the driver to regmap, which should
> help with handling the bank switch as well as figuring out if it can do
> "gather write" or fall back to allocating an additional send buffer.

I will start with the above suggestion and fallback to this if that
doesn't work.

Thanks for the quick response and the helpful suggestions Dmitry. I
will work on these pointers and get back to you. Thanks again.

- Furquan

>
> Thanks.
>
> --
> Dmitry
