Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1628A284
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgJJW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgJJTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:49:32 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F5C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 02:11:14 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o70so5366456ybc.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CGf/YBV8az+8bFiKJZW7WiV6wKvy1BTDhazpaywPDs=;
        b=IOEJUYCHKYD7bySIoRwRvxLSFTSd59I+ROKAKETIAGxJPrL7nksEakThHDYhs6+0n2
         FvIIWHw3cw8mXs5i0PpGx13X4gtfaVnLYBQr5xPECtvF59JhOnYHGf6OXljS3219+ntn
         5CFAFO3dpig1Cb+25UzViGNRFOQRrhBegTLgXq9FhJqI0vV53vZp7OsF8836HgMnKotp
         Cwnt/lBBYisR631A766kgQ1wd9jt3Ln8kyf6oHJYj86zcKVr9b/X5Cz7jKNh61oTVYrX
         X2cAIhpaRSpGvq+HYcKzqKTHRTfAHzV72M9q6aFa3694jLV6FwOh7pw83oPPlGJ3Mlsv
         PC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CGf/YBV8az+8bFiKJZW7WiV6wKvy1BTDhazpaywPDs=;
        b=E0sFb4Oxkxs3PtQslvTIOq1xNHuRl3QOl1loXv1/9PTSly0cfBuNMXaLK3VNDuDng0
         Z49vk14BtvPXuhej+MEL4toLQWdJcxeyKlTAckh+9mWcnlLCgE3Rg5dTIGKtt6J/Pbsc
         tb6NSGQxRnA/DczAZLlhyAz7siHqC/OXqQvgh8/9lq1Y+VQDRR5d3FFvZpJzohxOKcry
         mpG6njbzejfeb9nhpTURW9Magqa/vuXkkuNPV+a/1qUOOTmpozww1Ods2a22WMMIDd9F
         rhuyiKmVTW3B4DQlXAE01Lf3qezAFEMNek+dosYdcimoynRHufj5d46Q5vAmDHkD+/b9
         +x/w==
X-Gm-Message-State: AOAM532xipRIo4XOOiqA0Z+UlRn1elolpszHek5NUpkylHZFibqYQq29
        vIctY/z/njkUunSKYGYIM945VjIhCm72VZRhMRc=
X-Google-Smtp-Source: ABdhPJy3LvR5vMjiWYkK17OnfirKSzwFprNXlAlNWkdo4psUDosS+qZEokywyzfGxRtCsMoPOIb97yM7l4D4brEGYak=
X-Received: by 2002:a25:7405:: with SMTP id p5mr23241699ybc.19.1602321073821;
 Sat, 10 Oct 2020 02:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com> <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
In-Reply-To: <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 10 Oct 2020 10:10:37 +0100
Message-ID: <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     Greg KH <gregkh@linuxfoundation.org>,
        Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 1:08 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 5:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 08, 2020 at 11:57:13PM +0530, Harshal Chaudhari wrote:
> > > Checking the argument passed to the ioctl is valid
> > > or not. if not then return -EINVAL.
> >
> > Along the the comments that Arnd made, this is not the correct value to
> > be returning from an ioctl when you don't pass in the correct command.
> >
> > And it doesn't match what your patch says, please be consistent.
> >
> > And do you have this device to be able to test your changes?
>
> I will test this tomorrow. But from an initial look, its going to
> break ppdev. There are few ioctls which don't need any arguments.

No, sorry. I missed the check for _IOC_NONE.
Tested on a desktop which has a parallel port with a very basic test
code of open->claim->write->release->close and it still works.


-- 
Regards
Sudip
