Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63C92D7226
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437067AbgLKIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392434AbgLKIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:47:23 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DABC061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:46:43 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so11250456ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDdfQvMZJazL55A92kQ/VzvBdB6WU0HCnW0vsuFnegU=;
        b=XcXLc6NJhH7B/QDM8WKeCcU5W8Hmi1uswSnml+BVR+dijzpEOb0RGCFuN2OvZLJ2o8
         R3r/tcU6AevS0ttHcmsB+IIHTR291ZvTOReyU0u4HOwgLNKjgTAlPaEGWO5sqEXB62bP
         FYOYp9S8WsPYbvBV0koO+4aAThvsrODyEuah+dhZx42IkefQwMJbLWtL/fjGz+97offe
         p7PGZ8nh/msibYgl4fHYD2GGLf+AY5nCvHc86lZZcbddJ9+ysNrBgKns/BcFXkeR4hhv
         X2Cy4NiBUKtlXn+HrEl4yrHWQg/F8L7/vV4sx6/dPSGdj4igAvV6OINgaLdncIxI9ozL
         9fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDdfQvMZJazL55A92kQ/VzvBdB6WU0HCnW0vsuFnegU=;
        b=g6t692g9K+SGa2HAmY1exf7La5XdJaSIc9yWJIT3EbijA5ufsMjr2nMAUIKSxCnliv
         tJFfXiGwacApsi8r74IykjOEC/2EISnJa6i4THv5XO+kSpy57t5yor3xaH+/VjvuImIg
         R/XZmm/b3CW4EhO9li7NXqZJqEnQH++PjhVAhu/uVxKNrzu2Tw259esP8g9kVfs51zDp
         f+Vj065uiJie83RqEp3nTOyMaIPE60TkuqOVYQ47AJ7gDWbSvbXLUbHT0aCSYWwWmK0Y
         84523VF0a4JV4LFeqjLh+nCzRyxyl+mcbnPAK1AZgPdgF39ZJ9DjAOeIjqxzYy/yKfKF
         KRwg==
X-Gm-Message-State: AOAM531PvrD4DxqLOeO51RZNRh+6nJgNOMSzWMNrJrx2DvDWxcCGc1VR
        Js44i2DoP8I6T5ujTzwP8M02qcuOUbk9sZ1YYD5CGA==
X-Google-Smtp-Source: ABdhPJwBcrWFMCBWLOQ2YDvVQUyai6oD/poEHkhd2GUPENNzm23TU68nI/28thF+plLvRXlQI1bvYsCNqQbPsS+b23U=
X-Received: by 2002:a17:906:40c1:: with SMTP id a1mr9852038ejk.520.1607676402010;
 Fri, 11 Dec 2020 00:46:42 -0800 (PST)
MIME-Version: 1.0
References: <1607670251-31733-1-git-send-email-hemantk@codeaurora.org>
 <1607670251-31733-4-git-send-email-hemantk@codeaurora.org> <X9MjXWABgdJIpyIw@kroah.com>
In-Reply-To: <X9MjXWABgdJIpyIw@kroah.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 11 Dec 2020 09:53:14 +0100
Message-ID: <CAMZdPi8-_G+k1RvGOOte2MFFPQQiB=41wx86OkW+KDu13gRGUg@mail.gmail.com>
Subject: Re: [PATCH v17 3/3] bus: mhi: Add userspace client interface driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 at 08:44, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 10, 2020 at 11:04:11PM -0800, Hemant Kumar wrote:
> > This MHI client driver allows userspace clients to transfer
> > raw data between MHI device and host using standard file operations.
> > Driver instantiates UCI device object which is associated to device
> > file node. UCI device object instantiates UCI channel object when device
> > file node is opened. UCI channel object is used to manage MHI channels
> > by calling MHI core APIs for read and write operations. MHI channels
> > are started as part of device open(). MHI channels remain in start
> > state until last release() is called on UCI device file node. Device
> > file node is created with format
> >
> > /dev/<mhi_device_name>
> >
> > Currently it supports QMI channel. libqmi is userspace MHI client which
> > communicates to a QMI service using QMI channel. libqmi is a glib-based
> > library for talking to WWAN modems and devices which speaks QMI protocol.
> > For more information about libqmi please refer
> > https://www.freedesktop.org/wiki/Software/libqmi/
>
> This says _what_ this is doing, but not _why_.
>
> Why do you want to circumvent the normal user/kernel apis for this type
> of device and move the normal network handling logic out to userspace?
> What does that help with?  What does the current in-kernel api lack that
> this userspace interface is going to solve, and why can't the in-kernel
> api solve it instead?
>
> You are pushing a common user/kernel api out of the kernel here, to
> become very device-specific, with no apparent justification as to why
> this is happening.

That would probably deserve re-wording indeed. This interface offers
access to the modem control channel(s), which can be QMI (added in
this patch), MBIM, or the old known AT protocol. Because there is no
WWAN subsystem, these control pipes are directly exposed to userspace
and accessed by tools like libqmi, ModemManager, minicom (for AT)
etc... However, the data path, transporting the network payload (IP)
is well routed to the Linux network via the mhi-net driver.

>
> Also, because you are going around the existing network api, I will need
> the networking maintainers to ack this type of patch.
