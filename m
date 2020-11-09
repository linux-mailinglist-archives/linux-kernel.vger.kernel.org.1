Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA72AB449
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgKIKDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgKIKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:03:35 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:03:34 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o23so11369222ejn.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pg3803Uq1jFez/XEat8w7xIQGpLKaTC+YpkdqdVDSG0=;
        b=CYUL4AmCHmDPtuHQwvGbMBOQE0xk93dB7o2AtuHJ5PjMatHWXls20LrkVQLcJ3il9I
         2hAtknbd1LoVmYnIO4zy8oAewFpeuCcY4TYJ/ptDlnzNPOza0/631BlEgnKGrLAu+A2H
         yZT+Vb3YtNZRpCziVnOcQ/hrWdnxI6YOVlZCCQjk943mjIvUNaqc94zJHrkvrxIzX2Mb
         qXsBttCWIRKRTq7NTsLQA6LN1uAS7/QMr1Eo96bYpjE0uepO4vMg5ZoynU2iDtjfmucy
         4TVYCSMA1Er00EaMWd2Qc6z8Wyvm7BK4kO5fgXQ3O+VjpdBOmoGD06ApAoUbNXvYzVxK
         +3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pg3803Uq1jFez/XEat8w7xIQGpLKaTC+YpkdqdVDSG0=;
        b=rGp8K7JQXpydjkoLt9fahEQvyvKpH5iRptkIBWYLGDR9P2VDvl9/WmhmoZl7LTDvSg
         jGIfjUrXWFjzdwvHRDr4BptwBGV5Zc858dr3Nj+zGotnJ/3RulA9h8S3vgBAW7yLIBZ6
         kZlJ3G5+9Xdk9dGt5UNBD5NR3KfWbr/YbQ2oIcQ7ytwwX/omoa2gsTitJ0nNt/5HMt85
         ubqVATa/3Nbo+ZdnLueko0KH/vx8ckOsddwhZzZ+BsvzJEfKh+UYfYqOT6h5alSTKZ0G
         EntCuSeSF+g3XWa4qUTgUiI96UsOWSDZl1kQtPiu/zMqbCe+Hh1pC3J4v43tmEhgu9xB
         K5XQ==
X-Gm-Message-State: AOAM532/Vy40QhvLOUUSpGSl8Tk0zWzG9bCgKxsgmYCVDycce+RRaxTt
        cUQfq5Sx0dFE5N2G5aYomOTpurOo9HKvaf88PjoFCQ==
X-Google-Smtp-Source: ABdhPJxDnrdLn1Z6a94JduAjxjDjF8qMPnVqCBFDJwL0jjqNdmXX9ar0RqJe8/1xqYXorUdbhA5k5IhCGf1D8klvNzo=
X-Received: by 2002:a17:906:14d:: with SMTP id 13mr13950089ejh.516.1604916213272;
 Mon, 09 Nov 2020 02:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20201108230803.1577916-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20201108230803.1577916-1-alexandre.belloni@bootlin.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 9 Nov 2020 11:03:22 +0100
Message-ID: <CAMpxmJXdO0GKDxFDm5sKudAAziesGdVTqgY2sZL0vvKtP=EcdQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: nvmem: remove nvram ABI
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Joshua Kinard <kumba@gentoo.org>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 12:08 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The nvram sysfs attributes have been deprecated at least since v4.13, more
> than 3 years ago and nobody ever complained about the deprecation warning.
>
> Remove the sysfs attributes now.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

One thing that I see missing from the patch is the declaration for
rtc_nvmem_unregister() is still in include/linux/rtc.h. But don't
worry about that - I will take that patch and base my devres
proposition on it and I'll fix this in my series.

Should send something shortly.

Bartosz
