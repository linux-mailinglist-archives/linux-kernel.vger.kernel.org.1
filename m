Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845E12CF38A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgLDSEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgLDSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:04:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8ECC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:03:24 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2so380946pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+Njf8NG6+fsYlsC9GMzSFpNhGjLZL8pv+AFfjpqRlM=;
        b=cKXpELugaWOipTb/KvYJWMqSQbUwnR8wbCWrW8c7uSz2Usy77z7+aCH07etKFMY27n
         sh3KA2AhWZnqwb5F67/SUCNnUHy+ZUwzFYwwv1YlV4yrJgdec0u9/VjeqTtYiE3qYl0o
         t8p0TvFx+vq4mN5G2cXbQ9hFKCy2XgRKm3kodIBOOemE+BCCd5pdWhucQfyV4W5hM01q
         Nt+Ty2vYmlUclZ0N0euG3zaw9ahs4GALX/79GPjkGCbkdRkKLy7urTYxFCVbBv6IpGQW
         SealJ7WTleTqcIHcmbuvksZj/Np9C5tVB23/Hqt6YoWn2X3bodAQwkTHOKjD57eS/+PS
         S1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+Njf8NG6+fsYlsC9GMzSFpNhGjLZL8pv+AFfjpqRlM=;
        b=sUhzyZchAleNUIE3ayWLc1qDIovWS0f0C85r7TcHpgrq2oGlV0CCPwVvYr9plXvkzh
         BNDXqXsLr30elrV5CtxKJbkmtOkuiNk1T2dKlY+3gPv7O9aTFPd+DYDaEjSaCSLP8lx+
         z4WzlGpBol48HZgat+eZMqEQ4Wul2Yd8oWqn0jYYZ8bq1RK7HP6MUCWTkAll16dErL4U
         SfWwABAmqnlFIFzxTFSY56eZDk5oBiNX8QoEB1a6o5Gi/c+6XJ96cN+5wIjcGeoLga7z
         90pI/08U7F7SKhgoSbQxaAm+MVn5+V/+BwNmH6os6EPG16+49d94xWzcFiMBmsey4JMb
         g18Q==
X-Gm-Message-State: AOAM530bxkBWq9ysqpu6Ad6jPUcvt5eQ+KqLhSZNUoqIKd3yjpoo3i0c
        0UWNvA3ydBR5oFRGzoG+MKVAhlhrkXQOeY3Q3Fk=
X-Google-Smtp-Source: ABdhPJz7nytvFUT2W0TzpKWPiz61juYOJk4Dt8QM4Alw2rykoKdUZPIvH1HRfiCHM2FWX0c4pW0jDD9CFa7iY959HrI=
X-Received: by 2002:aa7:9414:0:b029:18c:23f6:bc6d with SMTP id
 x20-20020aa794140000b029018c23f6bc6dmr4922931pfo.21.1607105003635; Fri, 04
 Dec 2020 10:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20201204021350.28182-1-wanghai38@huawei.com> <X8n2CL58pQ/077rQ@localhost>
In-Reply-To: <X8n2CL58pQ/077rQ@localhost>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Fri, 4 Dec 2020 23:32:47 +0530
Message-ID: <CAAs3649kGerXZqgffwethn-JNOiiFSif1COM3no4Az4Ah220VA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: audio: Add missing unlock in gbaudio_dapm_free_controls()
To:     Johan Hovold <johan@kernel.org>
Cc:     Wang Hai <wanghai38@huawei.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, aibhav.sr@gmail.com,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 2:10 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Dec 04, 2020 at 10:13:50AM +0800, Wang Hai wrote:
> > Add the missing unlock before return from function
> > gbaudio_dapm_free_controls() in the error handling case.
> >
> > Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >  drivers/staging/greybus/audio_helper.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> > index 237531ba60f3..293675dbea10 100644
> > --- a/drivers/staging/greybus/audio_helper.c
> > +++ b/drivers/staging/greybus/audio_helper.c
> > @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
> >               if (!w) {
> >                       dev_err(dapm->dev, "%s: widget not found\n",
> >                               widget->name);
> > +                     mutex_unlock(&dapm->card->dapm_mutex);
> >                       return -EINVAL;
> >               }
> >               widget++;
>
> This superficially looks correct, but there seems to be another bug in
> this function. It can be used free an array of widgets, but if one of
> them isn't found we just leak the rest. Perhaps that return should
> rather be "widget++; continue;".
>
> Vaibhav?

Thanks Wang for sharing the patch. As already pointed by Johan, this
function indeed has another bug as well.
Pls feel free to share the patch as suggested above.

--
vaibhav

>
> Johan
