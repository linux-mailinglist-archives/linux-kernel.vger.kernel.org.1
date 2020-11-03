Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C92A454D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgKCMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:35:05 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59414C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 04:35:03 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so2935872qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UU5MbHumRhOWz5JLbHMs+2sxMU2srbV+zxrr4jBZi2I=;
        b=h164jmH6p50wj+mnP3PqI9hxv+1TNNnCzR0DJ8tBt8d9S3tr6kA9HU1Z93XEcyeO4q
         SehC5WwN6ThjIUptkhy/nOHEUGBIhKLW+BADyHTDBu/xHkqrVSgOsZ5FgsUI6J1jnTbT
         tv87qqQwbKFxV9a2RL7dngNztsoS7tjyGE2sZdODGRpcYNMuO/lNfCi7/kwj4i5teukK
         tB701hrZN4cLn2TIp7hDmJ7IVgDCTeNJSSR6KXBZvXiG+EpeB6YKG1dakmxFTxzVWd0Z
         +w0b1YS+Fu0wC2m+lIHFX6bp0/Exzf7buVXLRelDwUSOf6+lgwcjl5GSkY1rnKFxmz/Y
         CD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UU5MbHumRhOWz5JLbHMs+2sxMU2srbV+zxrr4jBZi2I=;
        b=WZ9p6F2b1nz45vpL/SwSqia+f/WIjqhqFonhGAU5KXFliEio43H+LpY7dPnWPQlhIO
         XaPyzU0hlrJBZGb3JqBBRvHaIn1z0G4vBG5G0EZrB239mlw0fr0KUvUw9UnkThhLHs4/
         NRN6sj/HqKD7xAR5Ny6pBeshKfcNbK8d6nSMIPasblTr1YEasTyiTodOCP6MC9KNYNSd
         zgjPIqqPQavmPZUl+APpgCNmhketqVWuvKypYuuzK4S81L94E99e7VFxqIcW9o1ATbe8
         aDHAUiBzoJU4avWEceOs7IEUo1jU4ohzLjPmfXy92abZopDpsI7A4wn3cqmhf9VUC4s1
         iAjQ==
X-Gm-Message-State: AOAM532Nh62IzVPAZd3JSWw4rjxkbD072+wGNo1DecXylluqOiZmdcJn
        kY/ASG4H4w9QQMF2z+EucR//1EFmOrbTNPNRAzw=
X-Google-Smtp-Source: ABdhPJxW4sXn5T8vr31QlV/awsooj8O9pH/jklyMLlWscgm+PC1A+hvLLBLp8OdaGALS+uuBVMevWG4hT2cQq3GKE4o=
X-Received: by 2002:aed:384a:: with SMTP id j68mr18825464qte.170.1604406902596;
 Tue, 03 Nov 2020 04:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201103115645.684-1-kechengsong@huawei.com>
In-Reply-To: <20201103115645.684-1-kechengsong@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 3 Nov 2020 13:34:51 +0100
Message-ID: <CAFLxGvwKTezooPvWQDZViaXsZ6zsbgf6b-O8RtcU9x6w27xYpQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd:ubi: Remove useless code in bytes_str_to_int
To:     Chengsong Ke <kechengsong@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 1:00 PM Chengsong Ke <kechengsong@huawei.com> wrote:
>
> From: k00524021 <kechengsong@huawei.com>
>
> As a local variable, "endp" is neither refered nor returned
> after this line "endp += 2", it looks like a useless code,
> suggest to remove it.
>
> Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
> ---
>  drivers/mtd/ubi/build.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index e85b04e9716b..46a6dd75e533 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1351,8 +1351,6 @@ static int bytes_str_to_int(const char *str)
>                 fallthrough;
>         case 'K':
>                 result *= 1024;
> -               if (endp[1] == 'i' && endp[2] == 'B')
> -                       endp += 2;

Makes sense. But why did you send a v2?

-- 
Thanks,
//richard
