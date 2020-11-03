Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0542A4703
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgKCNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgKCNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:52:44 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E8C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:52:44 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id p10so16166980ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lC4dBTxJYkjs9fjwVar5pymw+dim3RaQbKTa3/16fLg=;
        b=IvPZttqCFmK/eLYW9z+4gesA6xzjstSuUR1QDv2/qFyLbK4VNCXDrNWvpUeDyTaLjP
         R+k4/3gKHp/KM2mByxA+Q9z6+dIE0/PeCeVYJflGP0dqjBrD30Y7vE7I/3dcNnOb0QS9
         HZ1m+Otj17/aIbvtPKTmlURk8jBNJDVNk+D4S/bIOUCxekLYwMcXU4M4OgLyiK96iRTu
         aEePef2naxoBS7ixojrrQeG/K/Y27sYFCKYsGdix2dL/Wm++HRq4YUnEmPQNlx97MXGl
         jCtp0wad45QC5oQdIqG/d5+4Z2EFbLMFxuBPyUyXdzLxPagbjap70dSmxI+iT8RnjMgG
         ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lC4dBTxJYkjs9fjwVar5pymw+dim3RaQbKTa3/16fLg=;
        b=auJRrWiGDRNdCDyINJKOC7jNkz690fhIzDIiqyIu24/5oRSqDN8nt11gSk+KeSdIfS
         LzJIjpERdzrjOtybpbRikq6Lsm1Vxh4Hx7ze47Czdpa1pyUsztS+hF8N7ey/4u+AJVZ7
         8RM+mx7ihDs3Ky2hUB6FpPylypDecCstZZEB34M28PY5ulJSTW31Sp64xHvTw0Pwutfu
         9MhOjk8TII+1xt8FTTpP91etw8Icy+bOCRmaRlsg+kylBZNZoEnIZBiEfDy+I29ZcFU0
         0j/xd/lztS+9v1qD80cU0yDZoQgOZPG+LVOo9Kogr65GlITEuTEo4Q5gSFRMBmWl0/Zp
         XR7w==
X-Gm-Message-State: AOAM5306Wd5WkaDNEonlaEhLoJ4Jc4uWPK3G5m550uCjS6S/zRfDAB/z
        c1MzI/k/wpxx+fHO+8olKDo5W0CbSipAF6Mk/96dfqsnEvtqvg==
X-Google-Smtp-Source: ABdhPJz6wiYEwu5GrcrOQOKifpcp6fzHHSXy8/Q4so5uqeJowxX47Rp72HoEMjsbS7RdD7tBJVlcDmaKst365rDp7G4=
X-Received: by 2002:a05:6e02:801:: with SMTP id u1mr7915363ilm.199.1604411563529;
 Tue, 03 Nov 2020 05:52:43 -0800 (PST)
MIME-Version: 1.0
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
 <20201102231420.1833852-1-ztong0001@gmail.com> <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
In-Reply-To: <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 3 Nov 2020 08:52:32 -0500
Message-ID: <CAA5qM4C+UGB_SXW5OeWKPtNkXyVCfwwB_ct9wps0Lj6VhvTawg@mail.gmail.com>
Subject: Re: [PATCH v3] qnx4: qnx4_block_map error handling
To:     David Laight <David.Laight@aculab.com>
Cc:     Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 5:54 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Tong Zhang
> > Sent: 02 November 2020 23:14
> >
> > qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
> > not interpret -EIO as a correct block number
>
> That commit message is now wrong.
ouch -- what would you suggest here?

> Also 'blknum' is only 'unsigned long' so ~0ull is wrong.
> It can be worth injecting an error and checking the error
> propagation works.
>
> What is the actual maximum file size?
The maximum file size is 2GB-1, but from my understanding
qnx4_block_map() returns
a physical block number. The max disk size supported is 2**64 bytes, however
it is limited to unsigned long (2**32)
-- so I am actually very hesitant to encode an error code in the return value
without changing the function return type, which will introduce more
changes I don't like.
The original -EIO in qnx4_block_map() is also dodgy btw.
> Is there actually an 'out of range' blknum value
> that can be used to signify an error without
> changing the return value to 'long long'.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
