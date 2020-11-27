Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578A2C6062
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392688AbgK0HPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgK0HPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:15:10 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81480C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 23:15:10 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id r11so892054oos.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 23:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaxtEmqvmorbGKJnkkOGAi0ROIbuHga/om0nivkkb44=;
        b=aLY3U6MTUL5dWJ51yx3EqCGeVIF57s3SnrwJbIRRWHH1wUjzpWGvhbxj7+9L8qkAU4
         WFVkHwVupp1lxevjJtNOAMyDzwPNsxVnIhoXQOMIZYWO8T5OJGRf1Nxi5UA5etOWAGKW
         hjA1KC2oJmcYo1OpRvgw2V2Wl4C2Ry0l9nM/UUIeiILMD+n7GiLOh66BXBAZ+7+XtLp0
         +YELbcmEOAQnnvL03qfBtucnfXw21h/kZXqyPQwbcbQMbet1TOfguLjVZtP5PopZT8H5
         jES04bkn9ADkCO7hjLaAuCx8MLL7+e4r72MVV9aYBit52kFHYQx4lmUuy2yMvfk1VWyS
         zZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaxtEmqvmorbGKJnkkOGAi0ROIbuHga/om0nivkkb44=;
        b=mO3VzwQrp2gI+UBAteKNAbcTtx3vARRiMDz/Heg+98B84RYgcEobRvDdBJ5zq29Q8m
         3/jYXZIYUsSRJ0f8IMV8KYTuylxOjhxI4nWEzkCbtaPn/HKh3IFmM2IxpHAR+eX41RAD
         dXBEVWn2qYEygL8vowiQkwV6CtSO47LvpKaJLnL+pYBlSSP35oIDGoQzEx5bnu+ePVLq
         zGTwe8m9gTnVH7hFw3X/oyJEeICqL+jwWaiwSw5xaNy94YRjMcmrnOFo4bnkTGEbnwcC
         lum1X3zFS1Hp1RHdaAvpCk8LXllyFKLQMSqHiozPreaHHcf2cORuvXl1K9GCyEvb4G2q
         EEEA==
X-Gm-Message-State: AOAM5310d68kDIkBn7dRkZZDZBB4H2/9gsdWNZJ71MuVQSViRya79yLu
        TBLtYD0ywrqoMsvn6Wzw+iwEzHdS11xyK3/aLLjtkQ==
X-Google-Smtp-Source: ABdhPJzaQ7O+e2Jbc1bKrR0f+Mraefm0He/WricXD5DvEREyOW1QEFDqCYH+RUzETNr0QT8k5tlI+7JXq4ssDiMD0no=
X-Received: by 2002:a4a:de87:: with SMTP id v7mr4592060oou.6.1606461309608;
 Thu, 26 Nov 2020 23:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20201125120134.GA1642471@jade> <CAK8P3a2CDp0KwCZjffA78fXUqOfAkvUb8Q=R64830fvvn_WG2w@mail.gmail.com>
In-Reply-To: <CAK8P3a2CDp0KwCZjffA78fXUqOfAkvUb8Q=R64830fvvn_WG2w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 27 Nov 2020 08:14:59 +0100
Message-ID: <CAHUa44Fnj4zQ_3O+kdzVopVAggUOdb34KGnA8+r=Rp-4+etWbw@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE driver for v5.11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Nov 26, 2020 at 10:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 1:01 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Hello arm-soc maintainers,
> >
> > Please pull this small patch which allows the OP-TEE driver to work with
> > ARMv7 based single CPU systems.
>
> Can you rebase that branch onto -rc1? I had started the arm/drivers
> branch early on top of that, so I'd prefer to avoid a backmerged.
>
> For the commit itself, shouldn't that be marked as a bugfix and get
> merged into v5.10 instead? If it should, you don't have to rebase
> since the arm/fixes branch is already ahead.

Yes it is a bit of a bugfix, so if you don't mind taking it as that
I'm sure that Rui would be happy to get it in this release.

>
> Also, it would be nice to Cc linux-arm-kernel on the pull request
> in addition to linux-kernel.

I'll keep that in mind the next time. Thanks for the feedback.

Cheers,
Jens
