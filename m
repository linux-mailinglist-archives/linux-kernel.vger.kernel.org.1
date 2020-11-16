Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D62B3ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 01:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKPAYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 19:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgKPAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:24:35 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC87C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:24:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so16908918wrx.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tbtYPRVwe91AzaVofnak3fBr/OUB5Tnq78kbe0HEPE=;
        b=oWDXG90b/E+THuTqnGX5t11UZnv3ESw8yGkloNnBAkooHieEFgcEzcOulq9Nwn7Adj
         tMd/8Kf2G+iQSx3Jlle4sCtpdQEzpe9un7BSI+Qd4oGUytykNV8GUkHF0kPqxVqdZFg9
         lXS4cwNY6sqb/HrAdTm9O4dUD29Krs3tvgJBizvgH0LumHoFMq/muzX6w44sPYtgX/4o
         g9WUHwmWSSkqEKPR1IWhfF+HQuWa1T/DqDCmrvg4NRtU3PXXMM6pUOsMXeY+t946a6uS
         Mw/C675Ll+aizQwI2EsSxj3TYxgCPh8gt0su9FQ25SJ3uFrQD1jZjuG9F0DbkNmXF7+K
         qcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tbtYPRVwe91AzaVofnak3fBr/OUB5Tnq78kbe0HEPE=;
        b=h+By1ZxJDxtB3tRZLJIODLX1GfhH+84KobZ6AjDKbAiT4tuI/C3IPL4d3p+GF0kCLg
         VQxm9Au/zG43MTMjW2wHJIENyNKX2CoNm89i+JJ3KRcc6i+0fnz7WOYDwD97yne3xqwf
         00O5gIqb7+BMjmhDd4VtmEmjSDYVpyScyRT/4LfoKj6trGjyd81grKM+lXsPWNZYtF4u
         o29FBjqWqFkmyrSwx6bRS+jbjw5zDUvHSPjRwIYqY6adoRfFIJovR7a/lvExBJ5H0IMi
         WAehVDzL0H4oVP+tcRlZt3KJ41I83euFeVgvl3lIfCAOR9COZkVDsOkxxngIbeAgKRaY
         SqFw==
X-Gm-Message-State: AOAM530YS/l8ySH/Kr8jA9FMOwlQ186LR3bikwhlosaHmQ3UiU7l38ZJ
        uNvT3kNSF9/ardBDhBH/7hDunLGFGf2ubHjI+uI=
X-Google-Smtp-Source: ABdhPJxCYH6jk4uoBN5NncU4HGs8yqTWDEzIsx88wTGAnERsBDJRBw9IqbpdqnDv7Hc7M8BUfOm5aWm1KYHWSNzBNcE=
X-Received: by 2002:adf:eacb:: with SMTP id o11mr16377652wrn.208.1605486272652;
 Sun, 15 Nov 2020 16:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20200919100850.1639111-1-liushixin2@huawei.com> <CAKGbVbuVo3a=Qs3PThrYszh9++D_D+dLVWhpAYOwpVd9_jDnUw@mail.gmail.com>
In-Reply-To: <CAKGbVbuVo3a=Qs3PThrYszh9++D_D+dLVWhpAYOwpVd9_jDnUw@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 16 Nov 2020 08:24:21 +0800
Message-ID: <CAKGbVbv4q7iwNe6g708_NXRGQ5zkQurR6AC82QrNL3eFPihqSQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/lima: simplify the return expression of lima_devfreq_target
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

On Sat, Sep 19, 2020 at 6:43 PM Qiang Yu <yuq825@gmail.com> wrote:
>
> Looks good for me, patch is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Regards,
> Qiang
>
> On Sat, Sep 19, 2020 at 5:47 PM Liu Shixin <liushixin2@huawei.com> wrote:
> >
> > Simplify the return expression.
> >
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > ---
> >  drivers/gpu/drm/lima/lima_devfreq.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> > index bbe02817721b..5914442936ed 100644
> > --- a/drivers/gpu/drm/lima/lima_devfreq.c
> > +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> > @@ -35,18 +35,13 @@ static int lima_devfreq_target(struct device *dev, unsigned long *freq,
> >                                u32 flags)
> >  {
> >         struct dev_pm_opp *opp;
> > -       int err;
> >
> >         opp = devfreq_recommended_opp(dev, freq, flags);
> >         if (IS_ERR(opp))
> >                 return PTR_ERR(opp);
> >         dev_pm_opp_put(opp);
> >
> > -       err = dev_pm_opp_set_rate(dev, *freq);
> > -       if (err)
> > -               return err;
> > -
> > -       return 0;
> > +       return dev_pm_opp_set_rate(dev, *freq);
> >  }
> >
> >  static void lima_devfreq_reset(struct lima_devfreq *devfreq)
> > --
> > 2.25.1
> >
