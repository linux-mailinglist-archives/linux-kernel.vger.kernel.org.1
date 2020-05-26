Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBA1E1E58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgEZJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgEZJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:22:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42852C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:22:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so23661706ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VakK3K1bdraH2CNaKAl1HsIOSqvOwW4BrMU1GIVbMHI=;
        b=MnxWolw9+48E82BoH0W4h0NGW8qNWn6yMAn4GAyxdbSVePnsGeI36UvX1g9L5RRBi8
         GmM11E2y1xIjISz2igNjVGdMCjBKrM7dGLaLrpPJt/vhSsAhQ32ci4eQ/Joq+sj/zxf+
         ZdBlienAY0XqjGtuVjQqycVSNEJFq7gk7pteYStezGwHhU3RBvGrWZg6O7UAPFBTZra5
         jMQ40HcgtLQwdQekePnYsX3Zhvn/0w52mgrC1lbXvcqldPEHypNpf2kG9KIh8jqLkT1i
         yvd1yL6iKiKNNxyS2HcwW4tOv/FS/YwC/HTfDTNd7pS7xmbG5epLeZYMGoTsofuPO8k6
         5KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VakK3K1bdraH2CNaKAl1HsIOSqvOwW4BrMU1GIVbMHI=;
        b=Ujvl3k0YRAU2sfeOX1mNzbCF0rNYCJBNHLP011YGv5fwx++v34+pksyoOtY8p1/10/
         t4JJNFsK3jOPj6f4232X2k2XmoAzUxQDIjErB0sBa2oT6G6vQF7XCzgt61bY64yVaWAY
         dscSN0rzBjmtADLL5xjsymZDE68J8gGZaXt3Ro5hBwx073rS7KDUrhZRKvPJDs75dK9w
         dfZ9Nnr38ngGT8F6AZ3FYNM8X5HFQgJXhgy23o4qBQoYka7Rl9I9eg0yF2Ql7zMtia42
         2frrTgdacUiiBqsxlUmn4pDYqNkB2+84LHvCDawmk+nr+eK+CE7doN17EN7pn7pvfs83
         42pA==
X-Gm-Message-State: AOAM5318HVf2hD7yc7xiM4XUhevL/yGNXaokUdre4sGM5jnoNM33KSQG
        nVCblRO1SoiepL30dUVidm9CKt3qN0S0PpkIcpUgcw==
X-Google-Smtp-Source: ABdhPJw8pZgJaIXNUkLHn6B/J6FuTQ9hom3jWdzfr1ToPBwixrVD38ffTLrjv381+a2u7Q5Qz7hclK+v3FW2m0rQXNA=
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr146695ljp.283.1590484938670;
 Tue, 26 May 2020 02:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com> <20200525151117.32540-4-jonathan.albrieux@gmail.com>
In-Reply-To: <20200525151117.32540-4-jonathan.albrieux@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 11:22:07 +0200
Message-ID: <CACRpkdZo4PsC9Y8seMfS33escA6ZVKWwnbW2BCFOKiX2gY8RDw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 5:13 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> Add reset-gpio support.
>
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
>
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheet says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.
>
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
