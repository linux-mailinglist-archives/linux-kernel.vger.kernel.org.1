Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1A2785E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgIYLcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:32:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65972C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e2so1177209vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK2xKBf38jIncqQXUOXzr0Q8nKbCDFfcVqsOZ+AQjKg=;
        b=idF0RM6FwWTHjL2Ru7MruW/e3XuePPBoSAnUfI4a9V8Wp4GpJvFwSdpyGWpT+ezNFY
         tYkNpv7jSxYZT+Dd4l/z7o5X5aMHWYN/V3lWY/VyDbXgusLr58p/hb8fq65Lyeua085B
         uX2udX5vudKVA98Bj6wqJJxfjsI9NOOCBqh4cKZI3N7FqizofE+JtFUR3Wz1me1TsYIo
         GqWyatlyxM7OmULaHYA+RnTc2gsulG7VjqoWZI0g4AIltaCXCpvLQ8xNnPve6eJkXVIM
         V+P8eq9OAh6gbdiuAN5/NSkpsNScN2j2qwE2IukOWAqNbrWFKYmd5hob3scEMb4Aj4t9
         UGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK2xKBf38jIncqQXUOXzr0Q8nKbCDFfcVqsOZ+AQjKg=;
        b=MX1TkxiMR/UWBT4o+N7tqKZ+6WoFhVOPKwYc+YGdmQ8wBjk+olWk1+Oaaq97xdy7/+
         1gMVAUFKvkrFlTJcHRS9XBbcP8o/FCEJMPbY1P1o9cghHKzI9HCIqNkb8XwwFQKng5Vc
         CvkIqMkT5hej+Diz1gbC0NjrtM5nMTvsXB9xxzFVbQ/7fTlWteazgzlkcuCKa56qKmCp
         e49Wpgq11z8Zxksa0jxlNu2gX+K5gzgwgw1XxEVPubEeX0fDReS3sgZC/MLpR3p8P3ou
         y+C09nCJcUIF5ZnW2pyIRjM58hksy7xwPePhf72VWQP1o63fo0N3eA2cdJVyN01y9uXx
         E2mA==
X-Gm-Message-State: AOAM530odAFW2bZvs4ceZErl3VfFupzIhHi2Cv2PvlTMTzlOspc7zfzZ
        iNqGdLeZbaaDOiMVVihM2XgXT3EdBYSo1rvah5ufRA==
X-Google-Smtp-Source: ABdhPJzORGOUPeovrlLq8j/6gekYRvr8WIFO0ittDHW239GvqKPogB4tMqMM/C6nkXvUbLm/1SwTcy+FqOClu3SIAF8=
X-Received: by 2002:a67:2e54:: with SMTP id u81mr2304621vsu.55.1601033529627;
 Fri, 25 Sep 2020 04:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200920204907.225287-1-ameynarkhede03@gmail.com> <CAPDyKFo7TeKFXLcNJFPoJqWsBsNySjeQrbb2+KRjO=jib+1jJA@mail.gmail.com>
In-Reply-To: <CAPDyKFo7TeKFXLcNJFPoJqWsBsNySjeQrbb2+KRjO=jib+1jJA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Sep 2020 13:31:32 +0200
Message-ID: <CAPDyKFo-FHGs7Po5naNwhe9xEGfxfdJo2gnddpfOJ73YzTFTyA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Drop pointer to mmc_host from mmc_davinci_host
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 14:49, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 20 Sep 2020 at 22:51, Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> >
> > The TI DaVinci MMC host driver uses a pointer to get from
> > the private mmc_davinci_host structure to generic mmc_host
> > structure. However mmc_host always immediately precedes
> > mmc_davinci_host in memory hence get the address of that
> > mmc_host structure using mmc_from_priv() which performs
> > subtraction(which is cheaper than a dereference) and drop
> > the unnecessary pointer.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>
> Applied for next, thanks!

Turned out that this one did cause build errors, so I have dropped it
from my next branch.

Please re-spin a v2 and make sure to run a build test before you submit again.

[...]

Kind regards
Uffe
