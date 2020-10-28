Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98EF29D855
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgJ1WbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgJ1WbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC88C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:31:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so1127086edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICbI/UdThJ7VwcdM+R69PEmT9tj+Qod3lfTEpbHHLpc=;
        b=BPr+F0iKjUNJfX5QWDbuTRpNvZ/l8APFnn++eUrY59iDhY83bbHiN/kLrk6Q1EySIw
         QZ2H0NYGI56cTCLKEcLepA2i9F5ZIipMfUe+C09TcoRyAIHRjDrO41xhPrvhTTWc5HwW
         yGUuA2DIMesMjJiqfhRXPuuZNkt7QJT9mNpVWXpygA8m7ab3ddc0mPEo1tir9G3mTbxk
         4jR84FVDHUo4XEbPKe7rHTgcXPv96m7gJzSOuKK6st43nppb8DUU1Otjs/BXNrUs9SX8
         ArZ8mQ0sMbteg+sae68lfonz92FF2cwD8rLph9wAYwjwEBMdrEvRuRVEnj0A3vjWVuLy
         ZC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICbI/UdThJ7VwcdM+R69PEmT9tj+Qod3lfTEpbHHLpc=;
        b=nPfnHyKGuGTdOMzhfkgSinBwiIPH+ld5VvyDrLk30t1bqKFCOq/whW0XS5Xb82w0+y
         gy9N5KDTAuyxifLI95hvZYw7UeEBh2Z6/nvyKbcP0jbPC+AaVGtnS4l/EoYeo5+Yjptr
         otMMP7dsPDw5/3yDbcX4K9Hjoi7bCv688BbB/sGleoDR+Kw6X7kO+3AFWEhMIm8rRxsN
         koYpIrHFlovx93H6nC6EMkjFYDxRS6CKowEgmpk/Bq4wjb9kuAwExgXPpkCFdDbF27hO
         z463gUiolGo0mx8xFeu4vK+uN1wydYht7iZ3DC08NJ15j3bHB46SxCXMphB+47sZiyWF
         OKBw==
X-Gm-Message-State: AOAM530pVW0g1e9a6HaNqhU3ccOh7a2rsDXMYCC490qqjTDu6tU5MhEU
        Qc/PLXmnWCvCtbW240N12wQWR9fHdGc/2P8bEECIoC9grv2iOQ==
X-Google-Smtp-Source: ABdhPJzJUaMMQZamqfp7s7x24JD6LJQ05fn/YM5TVoAVdEUyxvLdl64KkPnycpYl6rfaAIaNhjqRpi0XpXSRZ+/jICQ=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr2822630lfe.441.1603900920062;
 Wed, 28 Oct 2020 09:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201014231158.34117-1-warthog618@gmail.com>
In-Reply-To: <20201014231158.34117-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 17:01:49 +0100
Message-ID: <CACRpkdbTsN6p4n3f9SJrgAjdkzDu2S67rU3tLWwX0X50ekjctQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 1:12 AM Kent Gibson <warthog618@gmail.com> wrote:

> This patch set adds the option to select CLOCK_REALTIME as the source
> clock for line events.
>
> The first patch is the core of the change, while the remaining two update
> the GPIO tools to make use of the new option.
>
> Changes for v2:
>  - change line_event_timestamp() return to u64 to avoid clipping to 32bits
>    on 32bit platforms.
>  - fix the line spacing after line_event_timestamp()

Where are we standing with this patch set? Good to go so
I should just try to merge it?

Yours,
Linus Walleij
