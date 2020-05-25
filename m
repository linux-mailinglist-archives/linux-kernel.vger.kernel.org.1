Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3151E0EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbgEYNCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:02:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3147BC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:02:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so10486459lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TqMW725LlIsB45NBSvFcRZXUVOZteQsXKud6yL3JOI=;
        b=Lgd8S+SR6iLuIdVNeZWgsdH73CM9IhLnsLE5GEiDKzdiYZB4MfZrPsnyGWpse8Lmm1
         PuX6IQqoGQKN/1gRhKmf2959/OakbgAHYoi9EOWIXBonjn+i0kLTTZg+mYuRxt1T0rAS
         Te7ZpmMj0ycI390rRPBlRt9/pqT07reNZmDQm1iPqTXilgML/yRxQbCpeDnGzA9Uho8q
         HBx0XOgqYN2/PnBmWmnzuQbXzL1NzyZH/8CHwGdFln4G6UW6deIekODt6gLLRFn4Az6s
         5yRwFh3rzo21EyGscpCbGLi78gwNyb/2113FZML2MW+xLFRP00seu+9lsa9VOl8hRHq1
         bx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TqMW725LlIsB45NBSvFcRZXUVOZteQsXKud6yL3JOI=;
        b=pkjCG+LmK1sOT3T+wU7/OGS2jCRDm0v0yiwX5QfHJh9QlX6PUOOA5XuvHWdJOSiZYi
         aq92atUdnRQefNtTHw7AbYzvVpREqRMP7P/aWRNwVYxkSNLMh4i7+Hq6DeHaJOHb1fb8
         8lUMEJSiQymKYw3nVvsWjiXo8XIxtOX3UN4bD7SH9PZ91REtHOlO8QKf1iuBt58sPz69
         gsDW3qqJJ7qijLRnAFVF7g8Qr/5QkywEfaN7i6LWKZYAEoXgwewtwRf0475lh4FXEuk+
         lcSqhIACDIuXA4PS4AMi+/7P7jCITFSH6Yh/hXcBRhacAtoucWuKzXfDWguZhNdUVrgN
         2wRg==
X-Gm-Message-State: AOAM531udWH2gJy6NKV2upzq4iQr1+tbmi1F0X1fjObvBUdnT9X6K+8w
        v7SUNDmCkbKyx9oLr3izl9WciOJHNDz/PB+XKhguCw==
X-Google-Smtp-Source: ABdhPJxb4V6ca5WvD7/RCar+rPgb92YBR/ngJbFx3UmobgXZvzsxOjeUo4HrrTayLY4d9pwLTUlozZfcpeeP0A68rYw=
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr13444776lfq.4.1590411746523;
 Mon, 25 May 2020 06:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200428195651.6793-1-mani@kernel.org> <20200428195651.6793-3-mani@kernel.org>
 <CACRpkdZ3b-VLvxN06H_4cDOtUEQTVbe=Zw+NA=YjssMzK2d2sQ@mail.gmail.com>
 <20200429124918.GC6443@Mani-XPS-13-9360> <20200519085703.GB27787@localhost>
 <CACRpkdapMuMs_mEUHheGtaKYg97=nL1bH3zq4Tc3cnX9Jbw-Ew@mail.gmail.com> <20200525111203.GB279021@kroah.com>
In-Reply-To: <20200525111203.GB279021@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 15:02:15 +0200
Message-ID: <CACRpkdaQLmZEDm4nFxtAiyOJVgUMp7tDgAv8-Bwk=G_SV5jf-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: serial: xr_serial: Add gpiochip support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patong.mxl@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 1:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> > I remember I even referred to this myself, but I've been waning a bit
> > on it recently, because it turns out that userspace/users aren't very
> > good at parsing sysfs for topology.
>
> Which is why they could use libudev :)

Yet they insist on using things like Busybox' mdev (e.g. OpenWrt)
or Android ... or is Android using libudev now? I'd be delighted
if they did.

Yours,
Linus Walleij
