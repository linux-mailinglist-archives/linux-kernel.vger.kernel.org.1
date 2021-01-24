Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8F301E92
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhAXTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbhAXTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:54:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A27C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:54:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t6so6311310plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ltb649fO8RUvDMlMxNJBpTVqk8j9NP6KsJDcg7ev6Y4=;
        b=JCV5O1pSwqZq2AVnFfiH+vbw0ZzxLViHrbzqAmhlg+AhbLd5UtFp+2y6R+M4oXRV8h
         JmGcdYDUaOclT4744iIAHXZkeoHsVjRT8wzXE2wVrZqbl0H7r5WwmrDLCCCN3l4m3G+n
         WKENMKmvh6ymZpV/8sxlcDADbKpefc4esxNhK/dMcW7Dl7DL0gV3F4tJY9uhXDGH5Dgv
         22l0hM6O+nCQLHxxKqqb73AvXRqHA1JAEBa1GJqFKOUhSWDQf/QtOW4DL6xLAsf1NSWj
         zbRjdTljsrBqgqEegVtL2ayIiat612CrON95QQ7BvfK6htck5N8/ubyCnbSw7uJSv584
         mc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ltb649fO8RUvDMlMxNJBpTVqk8j9NP6KsJDcg7ev6Y4=;
        b=oXg54z95DUh7rDeeMu/KbOqg8Ewf3cycGs63LFEdFgZtmcPb3HmcfbxRXwp3Y5Un+Q
         nbQkrl1sIVr4vTZ4AbFxFBfb2JiretCfgqkvpxFrvQizuWf+bIeNo420mAxK3RTLcHuO
         5WEUO9c8QyLKrbmGZwWsHck7AW4enrV1cTSRhhI2elYOmbsFS5guG3DF50yWXXa39I26
         pc87l32lV2REKAMIFBGKWsLa6lAEIulBvnm6yltubcOoET980F0/gO1+a2giN7koRaGi
         fgTkZKIrJ8cdRXz73VbQsi6NEwhx9J9a23kE956Eqk4x2gnNs4GG9FTTEfUoqHICwgSx
         ZfXQ==
X-Gm-Message-State: AOAM530hmTeo6SXBwCRLsVtm07KODQJjAkrqYPSiNjIqo72NRhIGzbqp
        ZGgsK9y/T2qgS0KiQmEhBTb2BRmoU9ef9v94vAU=
X-Google-Smtp-Source: ABdhPJyMzqMWlIbM4YtmLGbSwyxu6flhf4uZBdMdVYvQFXtEBXf9gl/dVML1kArVb+Ps05sGDr/raz3bpxU8rzwpE7A=
X-Received: by 2002:a17:902:b190:b029:df:fff2:c345 with SMTP id
 s16-20020a170902b190b02900dffff2c345mr2435989plr.17.1611518044950; Sun, 24
 Jan 2021 11:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20210123121313.79530-1-hdegoede@redhat.com> <20210123121720.79863-1-hdegoede@redhat.com>
 <20210123121720.79863-2-hdegoede@redhat.com>
In-Reply-To: <20210123121720.79863-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Jan 2021 21:53:48 +0200
Message-ID: <CAHp75VdOhXMBb9t8GEA3qrjyuRzNSXFZ--QuaVMUAaNh-=DnGA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] ASoC: arizona-jack: Cleanup logging
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

On Sat, Jan 23, 2021 at 2:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Cleanup the use of dev_foo functions used for logging:
>
> 1. Many of these are unnecessarily split over multiple lines
> 2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFER
>    return value

...

>                 if (IS_ERR(info->micd_pol_gpio)) {
>                         ret = PTR_ERR(info->micd_pol_gpio);
> -                       dev_err(arizona->dev,
> -                               "Failed to get microphone polarity GPIO: %d\n",
> -                               ret);
> +                       dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");
>                         return ret;
>                 }

I still think that using dev_err_probe() naturally, i.e. as a part of
the return statement is better.

-- 
With Best Regards,
Andy Shevchenko
