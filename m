Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3D29C48E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901016AbgJ0OSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:18:06 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37676 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756612AbgJ0OOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:14:34 -0400
Received: by mail-ej1-f68.google.com with SMTP id p9so2465238eji.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnYbfzm2QtBjzDY+z/KOqeSMIK3XTZSXQGAowKeYtjM=;
        b=SeIDQC5AXEEtzGk53oo6CracYXKWUmcXjMfOVAqTuLQT9WJ7aB0jacFHHLewwxl91G
         QE/ZVn4th6VRvXkMz6XTc6zyxh7nwrmWBO7o1edY98e3qLcPbpr5PLvjINhYLIWtpVeh
         XoeebXAOwjCLNzoqYTwYdxpNUWaboppexIJTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnYbfzm2QtBjzDY+z/KOqeSMIK3XTZSXQGAowKeYtjM=;
        b=iPBrX9mChcsQR76Eg4smJrGg9DHirYNtjbDNEOrf22I6nlWq5W5n6CaDukqlhgAzBF
         tcLDW6+BKNwT60IGYGVOzkUeRXY48F3Ff6k57xM+shkPkDIBoOKKHZonRAz31iAIWKUR
         YcOzoZO3akGvPlDVj4wc6bTFD8v28ZLRZQUYLwQFksbS0Wc8J71jy6bIUYgjyJmKmSLg
         QpMHt3BtMXK+ekPwzYN32lJ9lGbpwvECAMuaAVefarf7bTKzv7iJDvEAbcedAnWeULOD
         6jtCwNneEJw+x4L2e8S7If/nPSF0ae2ZJyoaAjJ27MZwUKZHabn3hYycIS02NR3C/3hI
         aDVQ==
X-Gm-Message-State: AOAM531gkGLqjGaO47u/APi9Ns2Wppiw/LHH1IJvxZgd6leyHp7QgnNH
        91hnZ7flcdC9t3Oz4JIOx+JUQU7T+k/RcYOXbFBadw==
X-Google-Smtp-Source: ABdhPJzs+BHa49VIo99NXA3fnV05nItCEbwymyWfIkQq1XTA5IgUEM48crLkS/Tf2DHVdIiR7Qzu7eWI4Xajoao5D2A=
X-Received: by 2002:a17:906:49cf:: with SMTP id w15mr2758898ejv.252.1603808071405;
 Tue, 27 Oct 2020 07:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200828160302.329179-1-jagan@amarulasolutions.com>
In-Reply-To: <20200828160302.329179-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Oct 2020 19:44:18 +0530
Message-ID: <CAMty3ZB+fW5ft1pssic-hnRe8k5Zv5gGpMc8AFH3Ctg16P2K=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6q-icore-ofcap10: Use 10.1" Ampire panel compatible
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Fri, Aug 28, 2020 at 9:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Adding display timings directly on device tree files make it difficult
> to maintain as a same copy of timings may exist on different files or
> panel-simple driver.
>
> We have a panel-simple driver for this particular usage so supporting
> on this driver will help to use the same timings on any device tree
> files if the board mounted on a similar vendor display.
>
> Engicam C.TOUCH OF 10.1" LCD board uses Ampire 10.1" TFT LCD and
> it has supported by panel-simple already, so simply use that binding.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note:
> Panel patch in ML already,
> https://lkml.org/lkml/2020/8/28/685

Panel is part of the Mainline tree now, hope this can apply?

Jagan.
