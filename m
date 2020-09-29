Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5727D243
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgI2PN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgI2PNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:13:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:13:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so15563543ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xLPzAomu6d8D04kvDBrtRQzHyWgQisYCMsYSahXBt0=;
        b=RfGxzvPa9jCfuxV2cMVQaoyEKnnWrbtl/1rWexSnmjmNpneYivCbMHg7oz+1AMmKDV
         VqmBMVyQOvYLLFZYm2bN1i0auC7pQIO1/BXbW83aPOBwleQhSyEO/IGJ1pK1v41tnUuG
         aI6FGNuUO0tO/Wx1n05/uhPGyB7dXp5kDaiaBpV7/9Ky3WRPtGqX9YjjxWHSxJNqMbXd
         3GwEjYOwDfEqt1+zwC40Hc4JFEFQ7uygD/faUsTV4DKJ+3FnCj1Fs7HRFOK2FLXWZVhS
         AxbRyYwj0HgcAEse+jmaHLrAs/LWQRyb8JCyq/sgGxc3qbeRJYuoGe9ZRu0kfKx1Ak4S
         +Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xLPzAomu6d8D04kvDBrtRQzHyWgQisYCMsYSahXBt0=;
        b=EAPwgeAark8t9PpbCBMIdWuylrFDwdBE8N5ZYzI/b8n5a9XW1vXii9ApIXruEDnTR0
         VbQYY00W6B5Pgo3Xo4PhcgOcfYpWa6zL0SSkBPG5Au3UOCID5vtJza6+SixvJ7j7C4NN
         VQFq7s5I2UPqbWVUlC0aZEJbOIKjznS8jcDgfiabLueDES23YmP3oHJTeF6xJtYGTk+Y
         J6TJQmns5bGhWXNJT5SIDqCgn1sRyLggZJ5Lvugb6ejrGTXIjf6TR6oj66MZs5cNw33j
         JlPu6Y3GgxmrHWXDp7aHglllHXSAp+XeCXbFOLNAycO+TlqF8KqNksmE1nK6xfuOC3vX
         IaOg==
X-Gm-Message-State: AOAM5317U3DsC+6Fx4EL9ms8wOplSdsiYFtPsRezpYwOyOVCc/kxuZiB
        RFKDn976tnQQLd9SJ4cGx6MNNVz0b06XyNH7Q3eL0id+gA4=
X-Google-Smtp-Source: ABdhPJwjTE/Z9dJqWNhprP87IkK1vkSW7TrtzWliVOx0vgTwGiPAqNxOn+Wf46e6bnCbqgFwyw9GtSr4dbIiBPGRkxQ=
X-Received: by 2002:a17:906:49c6:: with SMTP id w6mr4224530ejv.445.1601392432582;
 Tue, 29 Sep 2020 08:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200928002807.12146-1-warthog618@gmail.com>
In-Reply-To: <20200928002807.12146-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 29 Sep 2020 17:13:42 +0200
Message-ID: <CAMpxmJVV5bCVAbC9WPsZwXqvYvnPLHAqEqky8w-iuPO4pDgeAQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/20] gpio: cdev: add uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 2:28 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> This patchset defines and implements a new version of the
> GPIO CDEV uAPI to address existing 32/64-bit alignment issues, add
> support for debounce, event sequence numbers, and allow for requested
> lines with different configurations.
> It provides some future proofing by adding optional configuration fields
> and padding reserved for future use.
>
> The series can be partitioned into three blocks; the first two patches
> are minor fixes that impact later patches, the next eleven contain the
> v2 uAPI definition and implementation, and the final seven port the GPIO
> tools to the v2 uAPI and extend them to use new uAPI features.
>
> The more complicated patches include their own commentary where
> appropriate.
>
> Cheers,
> Kent.
>

This series looks great now. Unless there are new objections I intend
on picking it up tomorrow.

Bartosz
