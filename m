Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE52CA2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgLAMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLAMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:42:32 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB030C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 04:41:45 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id n18so514721ual.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v43BG8WdmWcru6537pQrqF+UFky2hIVmNYym4F7zcys=;
        b=pGSpIf1ZUnp/ObvsAXOZwAFXdIH0M5a7ClfrjwfFm0yfyM1SGO61i8H7bdwHdvByGF
         712YrLSz29NNtaxRRjpMS9ZbBICzmZZLnSrSGtbCFsQX8f2zh6pQoKNhCmAPFUWIPyKF
         rHI7FJ5uJUrhU/OvjudNu2VmwEsVMsTRnGEH7/neChuMm7vJPbGexsxrr2aJx2JKehVc
         8Z55l9Bq5Zbx50SgMmOmHyf7utUSyK5cM5OPdYtT25Ya8B7PEBxm4EQiDWaw0qvkDzbk
         IgZZ1ubcYue4LH5EqPqDhP3Kv+Vm4ITfaLMSZ4uiJvn026//DqU1K0jjyl2OxUtKIpXR
         FLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v43BG8WdmWcru6537pQrqF+UFky2hIVmNYym4F7zcys=;
        b=Pse4cH5azZ0MjrC8d3N3G4hGXtHQv8O6b7FzNEG010rVpg5jMQeooS382qK4ZowVny
         gE6BjMZnwj+pYpcpse4nvMZYHwXLzMWREUsUuj6F/ypjp2RIUnKCl0fOATVrgAorD0sy
         dzTNS5/tsdacHytopcmzIOnttKed+jV9bmHnEkgRVc3hUF/w0DWFxvTuxfwLreCd+anS
         FI532W3MqC657MJELzGtt7lkLFRQKCbSPelAJNMnn0m4ybwc9StQ/luePtqyPT7xOlgS
         cWC47V1bVnHvuf/lHu3jwE9t9xxGq3oEzV9A/q/WupE3RhPSWMGIVqJoDxUofRE1xuMe
         gxJA==
X-Gm-Message-State: AOAM533INjUyXzdMIbZgjl1VVV74GXwXz0X5Yh3fcwcGyY1mX6G/vxmv
        scAUTVgxNeQxDk6gtw3pscmDcRnRPLdxtTPC6rjfdpXotm8=
X-Google-Smtp-Source: ABdhPJx7/9m5qfZKrRGotGWEfjI20997wgUO0Nj77ZMeYLf3xBqE/PcapQUroLqXNt26KQBHIpm7WfXEIrBCKaPXaoE=
X-Received: by 2002:ab0:281a:: with SMTP id w26mr2358094uap.49.1606826504834;
 Tue, 01 Dec 2020 04:41:44 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
In-Reply-To: <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 07:41:33 -0500
Message-ID: <CAGngYiVoj4Gpid5W10pJfiE1FWY=294TJ4fE=CDG4=HwH0WrJw@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 4:04 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Then it should not have been applied to mainline but fully worked out and tested.
>

That would be a reasonable expectation of a product. But Linux
isn't a product, it's a hugely complex, shared system, which may
form the basis of your product. The core maintainers aren't
superhuman, nor do they have access to the 1000s of configurations
and devices where Linux runs or will run. They do their very best,
but if every change had to be 100% tested in every possible
configuration, then few things could ever change, and Linux
would slow down to a snail's pace.

When your product is based on Linux and you pull a newer version
off kernel.org, it's not unreasonable to expect the occasional
breakage. In my case, when I moved from 5.7 to 5.9, some of the
things that broke were my network chip, and most SPI drivers. That
was a bad day, most pulls are trouble-free.

I believe LTSes are more stable than 'stable releases' which are in
turn more stable than RCs. The choice involves a trade-off between
features, security and stability.

When you do run into a breakage, complaining on the mailing list
is good, but posting a fix is better :)

This is my layman's understanding of the situation, I'm just a user
and not a maintainer.

> >
> >>
> >> What should we do?

Hopefully I have some time this week to look into your breakage,
I may get overtaken by someone much more knowledgeable than
me on spi-gpio.
