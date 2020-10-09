Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54340288188
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJIEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIEzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:55:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C93C0613D2;
        Thu,  8 Oct 2020 21:55:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so7061428qtr.6;
        Thu, 08 Oct 2020 21:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JITYELoE/qFaD4z4UN02Zx69cGQiMW1pde3kjV+K9t4=;
        b=Pc8bU3okyDdFxjoMwcb2vkJ3OzZeQyWBhPNwH8Wklu6kofGksdY4leew1nB1ILwV6T
         x3GuSqNpsq5skpjUxuHacbAi8/nnxIiPrgkzSpCP03h8t64maLiv/yGQhyn6ELZHN1VN
         NaXX8oYBTiJ9MbCkHgTFS4VDzEEw3Rbz8eXzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JITYELoE/qFaD4z4UN02Zx69cGQiMW1pde3kjV+K9t4=;
        b=YBpUx5u8mxp1/8tR9Hdex7DL+Gl/d83W/V+r1HWNzjx2QpwQQMjZwhwrT0IU1AaEiT
         0NYdEgnU1XOPRtJ03zenaXXX1dPolaYgvK+W7GeokyOciwOYY6MyF0yC1yGxMujTL4pl
         3UHpfAgWrzsn2CtY9JKOZwgsBKQekr11rawINHZgD4jKNan6ybTJg0lZgaaajDH20mEX
         SFkA51f8seicqdL8aJl26wISrKNABaio7rbiC9UQVd3zsp0VuURUbe7+Sa0l5yipkcXG
         R+q+pmubfHBSJiNAfvnw7IyQ4qxd+9BdBfLRgJRJZLAyD7LLphYUykdMAbouX1tO8CiR
         MHTw==
X-Gm-Message-State: AOAM531syGx6hFpWerUjZ3FcBkZo/QvkNsv1SAud1dBengy7uBTslaNG
        OJ/SONhQjNV0bvInKsA84TZyWZD+AZe3OXmvCMuZZmvvgvo=
X-Google-Smtp-Source: ABdhPJxweXKi0eYYK2fikbnQTeaqtnzyH0KIKjWAIAVeiXcYUH20dQdSYyQgZJo5tRaOmVwtVXVZSok4p22pYSq8f4Q=
X-Received: by 2002:ac8:2612:: with SMTP id u18mr12611002qtu.363.1602219332099;
 Thu, 08 Oct 2020 21:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com> <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
In-Reply-To: <20201009044526.GB111063@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 9 Oct 2020 04:55:19 +0000
Message-ID: <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
To:     Greg KH <greg@kroah.com>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, BMC-SW <bmc-sw@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 04:45, Greg KH <greg@kroah.com> wrote:
>
> On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> > v2:
> >  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> > v1:
> >  -Enable UHCI driver in aspeed_g5_defconfig.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>
> Why do you need this in a defconfig?

I would prefer configurations that are being used to be present in the
defconfig so we can test it. I think this is a sensible change.

Ryan, I gave you my Reviewed-by for the last version of the patch. As
you did not change the contents of this patch it is fine for you to
leave my Reviewed-by on it.

Cheers,

Joel
