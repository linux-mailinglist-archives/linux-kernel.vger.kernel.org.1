Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC72D76E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393393AbgLKNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388605AbgLKNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:47:43 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1EC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:47:02 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id t19so2864977uaq.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ6vQHJKZTiZ2neB0QETD39X3O36ySzuaJhj1IGyfyc=;
        b=NJB4v2zz4yNRj0vxmnECFk3OO77v0K7MHZWPaAIeYOxrBDXqv5IfPx/9Y8aIYybanK
         2uOjtOhwUklDbSdSSpy2FOHbgt7NJAlsSrHa2XQF4H8RENznWvDf9yuJNXhY5u7AEbNi
         54jgqJHb9Z/Ld3eYJ5z6pTvvh39IoGWTJu8oJsglxH3uWRG5gTewymRSKuje1/3aQC/W
         T5BmxG/SsNSUELu0V7b/oIx4sCj3kGXfJ2CgdH7E4a69S86SklCWHO7NRIaOowKQUpWw
         4jaNg8CSvE0AcI3DzSjbDr6kG3LhK+3Fkybda/eZHN7P5QNFA1kBSc7PBlRH9470AINW
         4C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ6vQHJKZTiZ2neB0QETD39X3O36ySzuaJhj1IGyfyc=;
        b=fYTAeQz0SGIDK4oXFOCgUhzn+9LouTxgN//kvyPqUlvNYCYWPW1+npLzrJB2mQM6F8
         L343o1GAKq1Txd/eL3YGtxNR6377TdB/UL3x4Kp9+8AapeClisDNT/AGmvdCk2BZugnl
         BYvCj5rkwHFOINMjy6Ma9LCW7JA1OmoMNOTIJxH4nSMhJmA6ayHDjwQA2+WqtbHdBW5H
         gljlq4ygmLVxFvuVrR6FmkyXxJgusjghc/nd18QwBfcPZq2xSksJsmREtl4eMBckovXo
         EtyIsET2sHFguoGjdX7J3Op9qLi3w55yXV+dm9BTTTUPuQmJzo6HT9TTr7+qXl39knSB
         tIwQ==
X-Gm-Message-State: AOAM533AxrU75+/qbzpX98Y8Le/e/Ey4DDp2I1URXD5CwgeLe8nJeKzW
        t79hrX/AcnulX3W92SZzCsG04iGu8UnpID6I7rRaEA==
X-Google-Smtp-Source: ABdhPJyMcAJGiEh2yGNmjbTir7D0bwRrjvDUGQ4zl8dEGa8gcjgCh3wN7tnbZ4EWFh80oTSdtLpxMiGwzhuE8yVJKCU=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr12418198uad.15.1607694421515;
 Fri, 11 Dec 2020 05:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20201204171626.10935-1-mw@semihalf.com>
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Dec 2020 14:46:24 +0100
Message-ID: <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sdhci-xenon ACPI support
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 18:17, Marcin Wojtas <mw@semihalf.com> wrote:
>
> Hi,
>
> The fourth version of the sdhci-xenon ACPI support
> addresses a comment regarding clk handling in xenon_runtime_resume.
>
> The MacchiatoBin firmware for testing can be obtained from:
> https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
>
> Changelog:
> v3->v4
>   * [3/4] Call clk_prepare_enable unconditionally in xenon_runtime_resume.
>   * Add Adrian's Acked-by to all patches.
>
> v2->v3
>   * [3/4] Call clk_disable_unprepare unconditionally.
>   * Add Adrian's Acked-by to all patches.
>
> v1->v2
>   * Split single commit to 4
>   * Use device_match_data and dedicated ACPI ID's per controller
>     variant
>
> Marcin Wojtas (4):
>   mmc: sdhci-xenon: use match data for controllers variants
>   mmc: sdhci-xenon: switch to device_* API
>   mmc: sdhci-xenon: use clk only with DT
>   mmc: sdhci-xenon: introduce ACPI support
>
>  drivers/mmc/host/sdhci-xenon.h     | 12 ++-
>  drivers/mmc/host/sdhci-xenon-phy.c | 40 +++++----
>  drivers/mmc/host/sdhci-xenon.c     | 91 +++++++++++++-------
>  3 files changed, 91 insertions(+), 52 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
