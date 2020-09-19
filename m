Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF1270D26
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgISKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 06:43:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A76C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 03:43:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so8031824wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kGmbCRPBREbiuVKFWN0fD+J6+ed58tbBg4isMjD+qM=;
        b=ebqHlK76UnqgjkxZd2BdYuIiQ9Z6kH7xV37jsWwzzILwEma8GIELnfTtc36HP8Wy8j
         sgcaFMqgbGunTKpQWjJHOxHNIx1WzT9vafwatulCs6Pm/+OJntm/siaccKwORgKTn1mr
         PXCLRwTwo9XquHCk3JbBSPoHB2CMLdF+gKYxN2scAVioaS9t81xDCB3bJrM+/aKqm8A3
         dhib8iH/anxadNyn0xHT2jAcVRL4UPpVPmWUaCn88MVfN7O5S72EI70DI9VOdE/qsCut
         btGTZnOLyXftC44W+vqfpCjOqfYI6XfDUNVuQHrz+/UQmqDe05CjqxWq88Cgy//f47WY
         gVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kGmbCRPBREbiuVKFWN0fD+J6+ed58tbBg4isMjD+qM=;
        b=L3iI+ApA4Xou5QtucLVoSixuJqom5uk0zqDhtybW+Hzv6HSSPyM94OcoiJnGYGLv0r
         rErfTYb+yGlhtzp1QrVuDuw1gn8cOhEOZ5GZmKtDFc6gRuNpt2PnFfCVPmFs8nllCkbl
         oVqLqByj+0HM6LB944OYQVspeUjGP6LBEnCONESA2MoFJqU3lIcvdsSCjYHYCVUjk/g3
         D5BswQa2iSgQ/FhNw8NYF+XI+Uxmj5XPYBKfB47u5xgZMZib2keHvE5GSA/aM4IByqyz
         lFVPy8vzuBbK97+Mvdw9D5b6fXTJaFf6pQu/iO/f7KpcC2Armw2Uoeyp6td4UHq2x83I
         scPg==
X-Gm-Message-State: AOAM53153w1a5q23iOIFAeZ5zy4AT7TiKkCpqW3jldgZFkGYc06Ho5K6
        lwZ312P2uz8e5B2QCi2Mzck7nckf7YqxUYDE1srTPN4kqIs=
X-Google-Smtp-Source: ABdhPJz/vZP8XLnKQRDlxWuK+z9Jbl6qgZ368SWPTLjmr2tWnXC05rBMQGN0j4bLmuqNIebOYLz6NJmi7AVwXf1dlSc=
X-Received: by 2002:adf:828f:: with SMTP id 15mr17679406wrc.49.1600512232453;
 Sat, 19 Sep 2020 03:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200919100850.1639111-1-liushixin2@huawei.com>
In-Reply-To: <20200919100850.1639111-1-liushixin2@huawei.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 19 Sep 2020 18:43:40 +0800
Message-ID: <CAKGbVbuVo3a=Qs3PThrYszh9++D_D+dLVWhpAYOwpVd9_jDnUw@mail.gmail.com>
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

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Sat, Sep 19, 2020 at 5:47 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index bbe02817721b..5914442936ed 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -35,18 +35,13 @@ static int lima_devfreq_target(struct device *dev, unsigned long *freq,
>                                u32 flags)
>  {
>         struct dev_pm_opp *opp;
> -       int err;
>
>         opp = devfreq_recommended_opp(dev, freq, flags);
>         if (IS_ERR(opp))
>                 return PTR_ERR(opp);
>         dev_pm_opp_put(opp);
>
> -       err = dev_pm_opp_set_rate(dev, *freq);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return dev_pm_opp_set_rate(dev, *freq);
>  }
>
>  static void lima_devfreq_reset(struct lima_devfreq *devfreq)
> --
> 2.25.1
>
