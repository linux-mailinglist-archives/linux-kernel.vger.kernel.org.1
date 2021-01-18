Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5722FADAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403973AbhARXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 18:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732816AbhARXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:06:53 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4702CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:06:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y19so35980521iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7rnmnLcQCSDR6aA7c0cWaia+gvqY0cFKHfWYnb/JCg=;
        b=PCo9s8EwylulBLvBIgQaJCtt5U+HNFrDGzLD63pHO24pb6bxtAcfwPbtH2tr+6fyoO
         qAnKR1zKIFodXLGACmWQ5bEoLrrneuLP354vNhvtdM83Hr5HY3vwRqBLxpUUwyr9rSRX
         vrNM5/3sIykeDL4GGXRzuA0YdZabUOWStYUNFoDHQk3XS7ndeZv90NYgpcC1UUv1hKxU
         v6WxadUjTQZooA52TI3zBrwpycUr2KrBkdwkkbXKXTfT9jr22xBLmwSRGWxw/Hta04Rm
         /lfJyG1IZYCduTHhumyZ9NG94YiuRYqpEgiXI86gka0eHx7hXKXmrY3il4nopeqKP9H5
         cOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7rnmnLcQCSDR6aA7c0cWaia+gvqY0cFKHfWYnb/JCg=;
        b=KSaI/HqdbmCa58AexThzxQdntRy6ge1KViJdlQIEYTHfm+uoPbgzOSrOXVi5bjsUfC
         CbITTnVEVDy1z22xVeO+PO6DbSwDlZHchoJcC41Vy7/QghTqB0ayn5/nYhavhyqIaNHm
         7tGsTtSEkBUChoTDGwfGkEpugnfePckMxoa8DRDyj+dbUQMnxDjFItyYMKMe9xr9T+7c
         3kM3UJiR9VFX+4w+nAEF0AVVPK/CacRX6qiWIMMC26xp5mwREHLR3CqHy1izfql4dfkj
         3MzMTijku3qQn3nCOzlhDEB8mGyR2z0FdtEJBo6PXa0konWE46/pfqp4hw8676TfNkjs
         lVrA==
X-Gm-Message-State: AOAM530hgg7vjz1jL+xAJMzwGNBHKiGOBR7Sftk+y/TlUJ7XvV9+HC3h
        htiXqsP9WXqE/G6bpxv8e9QyPFrIyeoBamvFrbyT5Vkb3cMTvw==
X-Google-Smtp-Source: ABdhPJwBqz8C3L0c6H0H0Ic0sr8inrHoX114lpVrT49mOtsvHfyfSYt70HmZm8nrxPHR4J4oeWzESPYN6z0UKFLssQw=
X-Received: by 2002:a5d:9418:: with SMTP id v24mr935555ion.61.1611011172623;
 Mon, 18 Jan 2021 15:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20201130184200.5095-1-scott.branden@broadcom.com>
 <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com> <YAU2HnpwqGSNi3zF@kroah.com>
In-Reply-To: <YAU2HnpwqGSNi3zF@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 18 Jan 2021 15:06:01 -0800
Message-ID: <CAOesGMjmFPPmH6deqEwifdchpiN_xaCC362NSaJk3Tv=n-7b+g@mail.gmail.com>
Subject: Re: [PATCH v8 00/13] Add Broadcom VK driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 11:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 17, 2021 at 10:47:59AM -0800, Olof Johansson wrote:
> > Hi,
> >
> > On Mon, Nov 30, 2020 at 10:42 AM Scott Branden
> > <scott.branden@broadcom.com> wrote:
> > >
> > > This patch series drops previous patches in [1]
> > > that were incorporated by Kees Cook into patch series
> > > "Introduce partial kernel_read_file() support" [2].
> > >
> > > Remaining patches are contained in this series to add Broadcom VK driver.
> > > (which depends on request_firmware_into_buf API addition which has
> > > now been accepted into the upstream kernel as of v5.10-rc1).
> > >
> > > [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> > > [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
> >
> >
> > I've been following this series for some time, and I think the code is
> > ready to go in.
> >
> > Greg, mind queuing this up in the misc tree?
>
> I will need a new version, this is long gone from my queue.

I'll let Scott repost then (with acks applied etc)

> And hopefully the tty layer abuse is gone... :)

There's a simple tty driver as the final patch in the series, but it's
pretty straightforward.

If you've still got concerns with it, the rest of the series should
stand on its own and should be mergeable without that piece.


-Olof
