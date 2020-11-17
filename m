Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6042B5EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgKQLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgKQLu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:50:58 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:50:57 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id r5so3557388vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hwJYk7hEudN2n649MMq6v0Gh/9KQI+jorXCHoDxFoY=;
        b=OIt3pRCaaZukLXU43dUKqkM6BZl1GMtdzcB51sMXACHoUJqCN3qKU0jPmJQmwOwq6v
         BpLuUhu+Ds3IEqC5D8IU3ZC+Bzrh7/PRO4g6uvc35mauLZ63LQ6xygT6xNvxo600kkth
         ifURkauy5vR+DVJth4OWnwnOjVBinGY02p4YuEsYA8z7rESaNwvxGWLOh5p3aYR4vv6J
         XCdDTj1wfdghlJHk+xzb7TM4cA9R1F7K52PHB7AFTHB0FFcM+ta0i3NW3gjVXbyankwA
         +WGK4tdQbs6yLOTB9uwVP2b7ZB6D7c9gLzI9ARkxJFhSicWbNfdQ10L1cj+rHpYJjJvN
         gu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hwJYk7hEudN2n649MMq6v0Gh/9KQI+jorXCHoDxFoY=;
        b=rM99XAQGlRxVWN8YgRB0Ivtxm+B2MHqccy/6Ox2LiXlcM0+E0Xmp2e+Mdf+6b4VJUs
         yo9Dr64YjZt3Dgnw810Zyg/1c6WE+8dkuQ6Nv2wwfRS1SavFcB9ulKqBPUEXh7CfkV+B
         oTSevoVT7bdIVW5esPilaPyRq/Oke4Kx527O2VoNlmpM8ESBCTD1mhT8ZnLsD4Td/RAU
         DPPctsNHUO+eO1W39MbL+vFcnMT2mF+ycm3PxIb/NSNi3VFJWiRynxAkkP+9RlJUeaKe
         ZJ77K9kKHhZ3lQftKoHFeDTUZpZaZMvDzm6L3uGa+ug+swQGInjeew9b6fA0Aq/bFXv5
         hDeg==
X-Gm-Message-State: AOAM533NxjU/cjAKEUupAJSraFZoYnUTXE2cihDPaELeFL7199SQM2Ff
        xtildproHE4otx7JGQtNpZ+dQL5v4lsXcI8e8Ts0Vg==
X-Google-Smtp-Source: ABdhPJzc71UajvwTdezFG/2lgrrgQuTT7gr1eKVDUCXlJbjyffyCvdSJQ7YbazSAbhqUJr1ep77TlCCrpWkVOYWE+64=
X-Received: by 2002:a67:3256:: with SMTP id y83mr11595621vsy.48.1605613856563;
 Tue, 17 Nov 2020 03:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:20 +0100
Message-ID: <CAPDyKFpTXA_3cZ8NR3jzECXMcL765gZ+K2gS_0i=ZLxtwQDioQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bug Fixes to Tap Delay code in SDHCI Arasan driver
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 09:33, Manish Narani <manish.narani@xilinx.com> wrote:
>
> This patch set consists a couple of minor bug fixes for SDHCI Arasan
> driver. The fixes are for tap delay programming where in some cases
> tuning is failing for some of the SD cards.
>
> Changes in v2:
>         - Fixed the eemi_ops call issue by replacing to an API call
>           directly
>         - Merged https://lore.kernel.org/patchwork/patch/1336342/
>           with this series of patches
>
> Manish Narani (3):
>   mmc: sdhci-of-arasan: Allow configuring zero tap values
>   mmc: sdhci-of-arasan: Use Mask writes for Tap delays
>   mmc: sdhci-of-arasan: Issue DLL reset explicitly
>
>  drivers/mmc/host/sdhci-of-arasan.c | 51 +++++++++++-------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe
