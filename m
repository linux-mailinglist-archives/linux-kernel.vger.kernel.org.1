Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FCE2DC770
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgLPT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgLPT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:57:29 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A09C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 11:56:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b64so20056054qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 11:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR03cJfR0EoBTICVVVesk6XVSp238Ls6oOe5wOmV+20=;
        b=PFYlkvZFtbnh5r9z8g8Lxp8WkAhUfP78FM+ljs/HTs5sdot0FCDzi86wq1x9pIU1Ww
         zYJp0qXkz8tpRVPsxeruiZjzCmGTwVt25kwYmMP1n5KP/DVK6hwLWn3MAnvxMBUlwz7l
         wInu71k8Ml5wkowcEN4usSYkijsdRIJ9GNPdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR03cJfR0EoBTICVVVesk6XVSp238Ls6oOe5wOmV+20=;
        b=L7lvHGRfjRfBWVTzjKQUmhRYlECTe7RQxLZgeuGl/t93niR5NtbJANaZGHvwLQKcmJ
         bI5cKv4Cll+HR+mAlz343g6p4kdJpyTye/UXYdNxJND96/RS/0z3T3zyLg4nGcn+Aq/n
         lqpUiGKA6lk5i7yiM1VgmdiaG+CWqifYdLhdtQecmV4mSPDtKWIXKunZJLxyCZ1u1Bec
         LyDPGKnfLwUPg6Xr8Odb9G8DWyhg3HKjzp/DJVzaxIrzwonsehGUS4IfQO9KBJzAb/vL
         +VxV0KXD30dRUcwKiQAD89SXXcGzxyCpydUPMHvgWqkGockVOw3ohDEDudY+xdPtUmYT
         jpzg==
X-Gm-Message-State: AOAM532r50o9qmTYTXUR9K6zuE5FvnOXjzsCTN5O+4fINzqZX0aX+vsI
        osun/XlYePP8/51HFeUPIiUcCsu2f50sGUAX4bXYpcOa8ckuRQ==
X-Google-Smtp-Source: ABdhPJw9PDp4kWhEe+h6wQ1ZHdeuDrEbhQLAR+6TTniTY2PRAdgvfs5nXQKGuK2YFEZ5xBskM9janFHNubWR2f7ZZoM=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr41614979qke.384.1608148608130;
 Wed, 16 Dec 2020 11:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20200731160324.142097-1-jagan@amarulasolutions.com>
In-Reply-To: <20200731160324.142097-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 17 Dec 2020 01:26:34 +0530
Message-ID: <CAMty3ZDX+T42hOcG1cRa0ucbbz9CaT2csn+dUsibZJR_02qCHg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_MP8859
To:     Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, Jul 31, 2020 at 9:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
> for 12V supply.
>
> roc-rk3399-pc initially used 12V fixed regulator for this supply,
> but the below commit has switched to use MP8859.
>
> commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
> Enable mp8859 regulator on rk3399-roc-pc"
>
> So, enable bydefault on the defconfig.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
> ---
> Changes for v2:
> - none
>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 883e8bace3ed..62bcbf987a70 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -556,6 +556,7 @@ CONFIG_REGULATOR_HI6421V530=y
>  CONFIG_REGULATOR_HI655X=y
>  CONFIG_REGULATOR_MAX77620=y
>  CONFIG_REGULATOR_MAX8973=y
> +CONFIG_REGULATOR_MP8859=y
>  CONFIG_REGULATOR_PFUZE100=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_QCOM_RPMH=y

Look like it is still not merged, can you please push this.

Jagan.
