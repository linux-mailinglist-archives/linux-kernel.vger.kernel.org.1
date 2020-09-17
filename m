Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB726E2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgIQRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgIQRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:43:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59552C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:36:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so1773393pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xZMHi4HwDhGZXftClnq46LW61QUYpAjALMHSAmeHFo=;
        b=HrJY2l/+l6LLt+Iw+bTAHyVBsfRpf7NXHisw3NF+BRrcx97XLJ1enSWvPFYFay6mlq
         nIPRsnaEYtIDGPEQOSnNcHEug3cCEXVWXaRveLYt/Wj5rweFLiorsoUedzM/kkVQg7DE
         pt87URxYnqvl+qYdQDAmzB9SmZKlpSN3tCDu56s/pq5y6sFOY7GsDnat4M0Um5xN2acp
         nkOscukJPH2POn4AO+doyLqmX3oi3cc1Iv3NGHvSq9y3yaeaAeqxyiCh0jrUDluzlSy5
         TcAgjwkcWg/DUbcbv3GSssYHuZhxPrsQ3+lRtQaikvqx2J19Gsnj9n6rMCNCCu4UfCCn
         ejxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xZMHi4HwDhGZXftClnq46LW61QUYpAjALMHSAmeHFo=;
        b=lXpfPWw5oB1Ump02ZyJc0hnfpBlIPfiJJ/n3NtlGX3jqsoOCrrnsvdWM+wVsvLietQ
         E44YIZf4mfDUjnR7C7JPP1juVS79Br/Q+exi2gpN/oFLTa3ekDD17XGzkpye6xyetSa5
         gk+MEOwImyWmeRYHLKg+lGbMVT59hsGa1L5weHmA9vEk6+xO0j18DUJ7+yZ5OKwZvciI
         FiA7v+VDIxuP8Ja08cgmyW8nGVrPfosYJv9q6E1Y5TScGlFnGXuA3fA0SsHAOtbpYquV
         dOoF5hGGOQGfFjPOsrMPhJhwSYD/USarNNBhDqxqsGkKy2qRixbUoiNc3xVurtb7q2jE
         FLoA==
X-Gm-Message-State: AOAM533pN+7xHAQiS7FShlb/jlpjVcs8CxfayC+YD9vF8wthK6XjgSqw
        cEWpv2uuKcBiVoDQAv5jkSS62rknO+aamURajdDPpQ==
X-Google-Smtp-Source: ABdhPJxE3ZgMjHDO8XI3+2LaZOLj4qA0/dlWB3n1yY4pXgIC9QaqYcsZlYmpVt+Ecsma4zqmTYQ9dIr0Ws0KfewjqLg=
X-Received: by 2002:a63:5d57:: with SMTP id o23mr7458172pgm.263.1600364214666;
 Thu, 17 Sep 2020 10:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
In-Reply-To: <20200917131515.147029-1-jingxiangfeng@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Sep 2020 10:36:43 -0700
Message-ID: <CAKwvOdnm-PkEt6T3HqB-NYNYADth0MJkXCvFsc-_gyqRE-nmcg@mail.gmail.com>
Subject: Re: [PATCH] fbcon: Remove the superfluous break
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>, daniel.vetter@ffwll.ch,
        jirislaby@kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        george.kennedy@oracle.com, peda@axentia.se,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 6:15 AM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> Remove the superfuous break, as there is a 'return' before it.

superfluous (missed "l")

>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch; I audited the rest of the switch statements in
this translation unit; LGTM.

> ---
>  drivers/video/fbdev/core/fbcon.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 0b49b0f44edf..623359aadd1e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>                                     vc->vc_video_erase_char,
>                                     vc->vc_size_row * count);
>                         return true;
> -                       break;
>
>                 case SCROLL_WRAP_MOVE:
>                         if (b - t - count > 3 * vc->vc_rows >> 2) {
> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>                                     vc->vc_video_erase_char,
>                                     vc->vc_size_row * count);
>                         return true;
> -                       break;
>
>                 case SCROLL_WRAP_MOVE:
>                         if (b - t - count > 3 * vc->vc_rows >> 2) {
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
