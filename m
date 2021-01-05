Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831882EADFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbhAEPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:13:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:12:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h22so73419346lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAo7Bv8+PRfdj2CkpolJ7sGIND+KAsBMkBthX9wMOnQ=;
        b=nXF6LTFHUiPWNbgpQptFaoHNu6rHv9aA3WymgaGg/q+kGwRrWGC330+8keVqxiYXvw
         8OxtMqcGn7pGNNYNc1GnZUnhAhmFUsiSWYwAHO5Ha/WeLIp//8jODUIqr29NmBMc9N6h
         ygl40qgc7bbLz8r7YFTPktCZXywfUGW32RjEVXxc3BL/Gbx3wWv/7lKfyTWQIgXj7sk7
         xajddhsmIjpkSsAXUYilUh7XRAoZFogMtOBpuiP7yqBsPqiao8B4XXYg1CYjuLBaRx4T
         GjBWx4hi3xydwviiGo329KgYLzymsV5Z83rYK3FUdh2q634jWeA36oc2wufTQrQYJm/6
         Snhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAo7Bv8+PRfdj2CkpolJ7sGIND+KAsBMkBthX9wMOnQ=;
        b=gPmlurrPy8TBqoKecV2IskTdyk4lkBTtTIPfvSpwbKh3uhWvehJ0dOpQMAiIAleFMK
         R4rtWRFRPY7WExJRVa9rZjlb/vUup+UIfGu6GjRNMrlhL2hFgj0fz4WGFE/XWPDzSwN4
         HHhxS8AhlrQE8JN9Htd1gS7pGHOuqM2ZMYN7NIp5ofqMPHuMojz4ZP0NBN5zqxNLEuJi
         2gsMIHpVRrj9nZvzCALole/wmcRMta1lRXhXk6cu2DBHY8pAINtW+qcSKyFsfpImUrdh
         NUYd9LuP1HlDHGM4PNo1avLtRqlpWEns2bxN7+dmbFn6oYtvhrNnBE4jphLHShJXBhri
         Q+Yg==
X-Gm-Message-State: AOAM531AXivpOAeehBUEeusgibb1HatvRSZHm0OZFHwNCHJp8L2s0RNP
        Dmv1z1q82LFoXUFDuF85QkKOGwM//cbWxuzfT2KZrg==
X-Google-Smtp-Source: ABdhPJyZuUP0iw3fFjsWvuN4pAS3grsapRCgenHPfDpKKx2GUzTe777FefXfEueNs7vyvRC8ZS65a9Cqc11DWHr89nU=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr33151500lfd.291.1609859565763;
 Tue, 05 Jan 2021 07:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20201229102235.29550-1-brgl@bgdev.pl>
In-Reply-To: <20201229102235.29550-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 16:12:35 +0100
Message-ID: <CACRpkdYUgokeO7EhoRY9EVZhM0vUNAertgGatHz8HTHy-fW1Eg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/4] configfs: implement committable items and
 add sample code
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:22 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

 Committable items in configfs are well defined and documented but unfortunately
> so far never implemented.
>
> The use-case we have over at the GPIO subsystem is using configfs in
> conjunction with sysfs to replace our current gpio-mockup testing module
> with one that will be much more flexible and will allow complete coverage
> of the GPIO uAPI.
>
> The current gpio-mockup module is controlled using module parameters which
> forces the user to reload it everytime they need to change the chip
> configuration or layout and makes it difficult to extend its functionality.
>
> Testing module based on configfs would allow fine-grained control over dummy
> GPIO chips but since GPIO devices must be configured before they are
> instantiated, we need committable items.
>
> This implements them and adds code examples to configfs_sample module. The
> first two patches are just cosmetic.
>
> v1 -> v2:
> - fix a 'set but not used' build warning reported by kernel test robot
>
> v2 -> v3:
> - use (1UL << bit) instead of BIT() in patch 2/4
> - extend configfs_dump_one() to make it print the new flags
> - clear the CONFIGFS_USET_DIR bit on the live group dirent
>
> Rebased on top of v5.11-rc1.

This patch set makes a lot of sense to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
