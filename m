Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE81C5045
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEEI2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728497AbgEEI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:28:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6386C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 01:28:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so695033ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgM1z0W3jC692xWkgi3/Y+e2n/nzkwaSzFa78vdYF0E=;
        b=DIWu5shlATY4PZunGAKyb/Z+n2zkJihLqazePZ4n/k6j5RCVLrLJOPjtisCmJ8+trj
         /jCI1TplrSRfpZ5kH53qorDrheIpgsvZmn6FcroYQoDm5fn+1FLbBBDr72W4k8wY3OVB
         oP681xMKnTOAASBA2YOqIwqrGCoLIboWhJoH6lGdTMUzvdFTmx0PSELZsW/M50f3dgAy
         Dvxb+NmVgrs1GIGHpvW12W0Rsfa3soOn9dYUbzFobQPhbBJKn3mRg7aivW4Pww+9Jtxh
         0hsIpSJz1JdCxorD1s+WITyExRl8HmHDaaFS3WDusH4MYrxLQ+cH9kSN4LWThyf4wjd2
         GJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgM1z0W3jC692xWkgi3/Y+e2n/nzkwaSzFa78vdYF0E=;
        b=qnvsEaGBPu1NUULXm0f6Oj/keNKyOCIca0IvuP72PrnqblFILjjWQWOs817hDPuwUu
         +vZj4LCCu4F7vDNjIvfQKWRp1Mjaqv/IoHuyWlXGYbFdRJAzeSiW/ypXMrl5f48VrYHu
         TOnCr4KS53JcE9P79pE8+aM5e/nxySoij9ELYobW+wUIhycTYMhjvxK1krx8JAlT9EIz
         uasawwqFo0snFa34qOcl8vCg9jECKaaOk42E2kJNBWYLDqtBkfzE9hpvpeFlimEAg5IC
         4stjHWWTjffxwzQ1q5SA1gJ4OyFivhnkuhcl4wfVUgyEnw2Q1fxM9pk3F32uix8QPaQI
         ePoQ==
X-Gm-Message-State: AGi0PuZ1O6yM2us3J8Pj2FTt6hirfmjKXIhOSh5QO3FtGfPUEfjCWy57
        NI9jK3fN8eganhNw/rnncHKnhh10ddWWAZTTsgD++Q==
X-Google-Smtp-Source: APiQypIIQGGErF0RDv5sRtJ2GxzvtG0I7XM5imQkPX+aeO8aBHMbbijsr0Vbdq7RLakWK+shJtSNW2tUidRKojT/TqI=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr993585ljg.99.1588667284186;
 Tue, 05 May 2020 01:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191458.1260397-1-arnd@arndb.de>
In-Reply-To: <20200408191458.1260397-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 May 2020 10:27:52 +0200
Message-ID: <CACRpkdYQJocN_-i07J0fFC16pDUfb9o0mzRF0YRO8UMrE=Suxw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix link error without CONFIG_DEBUG_FS
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 9:15 PM Arnd Bergmann <arnd@arndb.de> wrote:

> I ran into a randconfig link error with debugfs disabled:
>
> arm-linux-gnueabi-ld:
> drivers/gpu/drm/msm/msm_gpu.o: in function `should_dump': msm_gpu.c:(.text+0x1cc): undefined reference to `rd_full'
>
> Change the helper to only look at this variable if debugfs is present.
>
> Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This fixes a compilation error for me on the APQ8060.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
