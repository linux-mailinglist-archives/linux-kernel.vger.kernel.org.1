Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E822A5710
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgKCVdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733285AbgKCVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:33:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 13:33:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f140so16174425ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fk/nsYSwR82is1IswQNV9CoWpeZ/r1DixUE7u1e345M=;
        b=uAp3NG5SStd5TJYHFpvgeRo6jxiQkTV1fy3ZqwB/OC2ncEnkE5F1TfV26AJnr2TGu1
         oVbv9u3HHp5JTchQzRweXIWHM+22I8bv5EDjfj3eQerG5GvxvL7S7PfiSDRrS/rkV/dH
         ol6sbPWdsFEjfnjhx0ktOf4lNchgK/uLVo6OV2IyDAaS95uFKS2xEHoJTQ6uLfSnJowt
         UDwjqqyzvuxfu7nG7r6Rs2m9HvoQu4qr7SRIIljKPh3yEDT7o/ROVmL/dCNNasitwNHE
         Noth4qSTj68Nz4vImzESO78uoC61JJEB5j/vf4XzPy0ma+IeDYj4i3xveELFGlNnQMMo
         oF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fk/nsYSwR82is1IswQNV9CoWpeZ/r1DixUE7u1e345M=;
        b=Xa0A1te11podVXsx8REnbLNcSM2NfYxkv5JOlmHkGWRtQxetekT45mhQ3MZC9HPR2X
         OE4pW2S/ZLqwCATsFqR4ShZ6+yCY/JetG9K0lkxl5looV1FVtF0J1IcswlaMo0Fx32Di
         ajxA3wxsUOtQrr3A+epBfr+eCs1qwRqa3xnC5xR7ybpRYULtD0W8Hj14l/rYp0TmZbVm
         TcULofJefFkwu/usPoaehqoY3FJc0snCVi3VkrvfZpYzGuNziPHfi86xcLD3IUZlBGtE
         oW0+bwDIRiTIt2UYHFG/IvjYIfsrmPyi5pg/PcOtkxrO9TEJ+uFVfbNknbhfKl/zqCJj
         hbyA==
X-Gm-Message-State: AOAM532ALg0DUzlE97Lacw2jlF/2YXi2nAcs047lEtGFodynZD+JBAYo
        HOLIhrEpneOST1grveTbkDR/idlJ+r8SGZ3B8e4=
X-Google-Smtp-Source: ABdhPJxjJ4eULrh9pdjvcTZZtuVavMohH+EUECQWWFsj5FLZnHGq3psx56m+cLX6NQhUCZen1W3Voa9jB98PfD/+w4E=
X-Received: by 2002:a25:d441:: with SMTP id m62mr32045484ybf.422.1604439218468;
 Tue, 03 Nov 2020 13:33:38 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
In-Reply-To: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Nov 2020 22:33:27 +0100
Message-ID: <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Nov 3, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
>
> Now that the clang minimum supported version is > 10.0, enable the
> commented out conditional reformatting key:value lines in the file.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> Hey Miguel.
>
> I don't use this, but on its face it seems a reasonable change
> if the commented out key:value lines are correct.

It is, yeah; however, the concern is that there may be developers
running an old clang-format from their distro (i.e. not using it for
compiling the kernel). We need to compare the functionality advantage
vs. the inconvenience of installing a current LLVM. The best would be
to ask whoever is using it right now, but there is no easy way to do
that -- many will only notice when the change is actually pushed :-)

So far, I have avoided upgrading the requirement until clang-format
could match the kernel style even better (i.e. so that when the
upgrade happens, there is a reason for it). Also, the configuration
can be overridden in subfolders, thus a maintainer can push things
forward in a subsystem meanwhile.

Cheers,
Miguel
