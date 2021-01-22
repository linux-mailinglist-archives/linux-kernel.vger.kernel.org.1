Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBD300DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbhAVUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbhAVUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:38:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96245C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:37:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so3951579plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7RKVj4HjhL/VE3gqWzeMrd+2B2zwHVMlYZv61VFwxU=;
        b=OWmyPIOE0HtWOGRdGpEjvMDUsbv9/r4t5CQ3xekXyaSBMsCrM1Kx7nRMiRXkjEo6Ix
         Lwdar/ZkqxdcaMDY5Gpz5QBPU03jr2f9OnIYMQAxrLSJkG6l5/q/41mYCjoaZVvpaMKb
         YdKeZmXdfWeVu93YO8rjOC0w6aXTtPtMb/FAoZd7w5e+1CIgwYzyypmz8J5ekG0u5Ck/
         ezNwQNiGP0nx13Bi4Acxplw+f1z/18EHZ2i29e4cXMZzkIdaIPgB2K6ouCRhViSqnNUK
         jDcaLU68/+MeER16Nw/4mf9fxt3M0fCSiDYKoPN4GjWT0QaZ2U1O7E43VPijHcfk0aRq
         oqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7RKVj4HjhL/VE3gqWzeMrd+2B2zwHVMlYZv61VFwxU=;
        b=LAcNIp4F6wiFP1pjPmWHywoGLV6XBy4Ba2C9ER9JVQGYvRxgCBkzQpbpjovHely4FE
         d2GV0cGZD7Q9V85DbxTlluwVWmnQxZlGvj88GP3aKXFe6fmAQ2oqZt/E67k2RcCRsFnM
         XVMtVy08Ezl4hXydJCGjHWRr0416Q3kLChuUqdtUHvVEb0u6oKoib73zQoMGUUv0U5Q4
         QsNelYC593UOC32EYwvoyvp+Jnem6rcFOjGH7HT3E3pt9ANp5hKJQwygsHBRIPcxwtmi
         c60HTv/pFOBxl8QExHmBshvQxOpLr+E2rdOqMErDuB4L0/B6S2crTOaCxe0SIfheeuB4
         czRg==
X-Gm-Message-State: AOAM532BX2Foofp6PBzmAR08d+9rBswan+VHloGqCDRTtt33n6/7sUVT
        TQePlmYFE2xeLr/bN14KLAwTwVETjWfc0pBUSPw=
X-Google-Smtp-Source: ABdhPJyaZCzzPtsVRgUFheO/bfg6aAARel8TmeS5o+NRW9JpzWDxq8jbbDgMYPP40nYH46wk6vga5nbK95yI326adus=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr7482084pja.228.1611347860241;
 Fri, 22 Jan 2021 12:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20210122164107.361939-1-hdegoede@redhat.com> <20210122164107.361939-6-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-6-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 22:38:29 +0200
Message-ID: <CAHp75VdPVNMvQnkOr2YOL_VirwS7QxKfG5A9P-P8q2suK=J9dw@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] extcon: arizona: Always use pm_runtime_get_sync()
 when we need the device to be awake
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

On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Before this commit the extcon-arizona code was mixing pm_runtime_get()
> and pm_runtime_get_sync() in different places.
>
> In all places where pm_runtime_get[_sync]() is called, the code
> makes use of the device immediately after the call.
> This means that we should always use pm_runtime_get_sync().

I think it implies the non-atomic (may sleep) context in the below functions.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - This is a new patch in v3 of this patch-set
> ---
>  drivers/extcon/extcon-arizona.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 72d23b15108c..56d2ce05de50 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -290,7 +290,7 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
>         unsigned int mode;
>
>         /* Microphone detection can't use idle mode */
> -       pm_runtime_get(info->dev);
> +       pm_runtime_get_sync(info->dev);
>
>         if (info->detecting) {
>                 ret = regulator_allow_bypass(info->micvdd, false);
> @@ -695,7 +695,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>         dev_dbg(arizona->dev, "Starting HPDET\n");
>
>         /* Make sure we keep the device enabled during the measurement */
> -       pm_runtime_get(info->dev);
> +       pm_runtime_get_sync(info->dev);
>
>         info->hpdet_active = true;
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
