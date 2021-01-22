Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580EA2FFF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbhAVJqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbhAVJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:38:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5205C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:37:45 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g3so2894465plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eabF0vmgV5BknvbMvwMNjuPhnWV49Xa5l1tuh416Y4M=;
        b=iLGiLMWpMt1a+zS7icPwESFH0siR77/NwauBYEYPHgfK7xrfZq3guz9EAIjWync6x8
         bjWJyJa73JStnfOBml+jbNrw5uq5tGIGiLTxAnGZ6vPNLbzHGbjiwotavAeoY6ZP0S55
         W6I/92vmoykmjI1Hz+AzLPbf5IJ4o2Nj4zSOn8jhDXCRyiclqZzWBEecyvsyeOgH+eo1
         vAdLlG4ehx8fXpnIGpJXnXoJfbNW+0q+JqsNNraMkF6MtX0kqXxzDRyMeiHYS2rZWQmG
         ktMCcs7qFu8gjr3qqPob9gkQFQxDOAE7aYdHgztH+EDCVeut6yWANYgnrL4Lee2KXKN3
         P2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eabF0vmgV5BknvbMvwMNjuPhnWV49Xa5l1tuh416Y4M=;
        b=kfbJRiNH9JhxlUB4/VMXEOsz1SQ66u1TK13XQ+s9mARyFli7Fwzd2ycK9vrXpj/5wD
         28+u/b2QhhzfXdRkwHgnI4yeGjEVJbG2/nyb4QUnAPcUxjcexCUKQrPcUYw5WVkbtd8+
         T/meY6AuD4qCBD7aWUf9gMHq5wzKhktPRc2DO2h4Ke0OywYErxrD7QZstWCdq2vJEJJ1
         8Gh74Pqu7Xwn1oIWd9IyGp47yuma+R0bx9eTT0dYTeBhx4e9GDk2IOqK35DCis8ogpOl
         J8YfZJ3O+Uk/3MAxqK8soIxqq1m9lP5k/NFfeITMgqEtT9L99CUEa0KMeK8MR0EsKDT5
         8o/Q==
X-Gm-Message-State: AOAM531NWa3rHTydi/MOX9zpuHVfE7uAmUmIygMEkL0SIW9/2V+yPdq3
        Jm/zT7/2LdJ1qxRVyedl5GfVCHrqDwp0htoxw58=
X-Google-Smtp-Source: ABdhPJx9uoRy3zM1Om9Q8+SrpqE1m53/IA/cxeykDIPBr5yPy7s7W8rsIHd5wjgb2JhjDuc4wY8Bhf3z5uRTH40famg=
X-Received: by 2002:a17:90a:6c90:: with SMTP id y16mr4464746pjj.129.1611308264907;
 Fri, 22 Jan 2021 01:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com> <20210117160555.78376-8-hdegoede@redhat.com>
 <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com> <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
In-Reply-To: <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 11:38:34 +0200
Message-ID: <CAHp75Vdzqx0XyykL8wxwxRNk=kBMHmUKDGXJQQtdhT_1CCa4_w@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] ASoC: arizona-jack: Use arizona->dev for runtime-pm
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 2:03 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 1/18/21 1:02 PM, Andy Shevchenko wrote:
> > On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > Can you elaborate switchings from get() to get_sync() in few places
>
> Sorry, those 2 changes really should have been in a separate commit.
> I've put the 2 get -> get_sync() changed in their own commit now
> with the following commit-msg:
>
> """
> extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>
> Before this commit the extcon-arizona code was mixing pm_runtime_get()
> and pm_runtime_get_sync() in different places. In all cases where
> either function is called we make use of the device immediately

called and we

> afterwards. This means that we should always use pm_runtime_get_sync().
> """
>
> > along with moving disable()?
> The enable / disable calls are not moved, they are removed.
>
> Here is a new commit msg which hopefully explains this better
> which I plan to use for v3:
>
> """
> Drivers for MFD child-devices such as the arizona codec drivers
> and the arizona-extcon driver can choose to either make
> runtime_pm_get/_put calls on their own child-device, which will
> then be propagated to their parent; or they can make them directly
> on their MFD parent-device.
>
> The arizona-extcon code was using runtime_pm_get/_put calls on
> its own child-device where as the codec drivers are using
> runtime_pm_get/_put calls on their parent.
>
> The arizona-extcon MFD cell/child-device has been removed and this
> commit is part of refactoring the arizona-extcon code into a library
> to be used directly from the codec drivers.
>
> Specifically this commit moves the code over to make
> runtime_pm_get/_put calls on the parent device (on arizona->dev)
> bringing the code inline with how the codec drivers do this.
>
> Note this also removes the pm_runtime_enable/_disable calls
> as pm_runtime support has already been enabled on the parent-device
> by the arizona MFD driver.
> """

Makes sense to me, thanks!

-- 
With Best Regards,
Andy Shevchenko
