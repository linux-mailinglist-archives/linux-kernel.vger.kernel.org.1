Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E382FA1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404604AbhARNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404772AbhARNnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:43:35 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:42:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m10so18258725lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjAbOdlgo9FDkSJLOMR1xs2vpDAbpOPnLP1xRILckhg=;
        b=pvP8y7dPdgXUcANy1K8PfZ+1uoR/B4sfCUvMFHaLyYe/keXJEu2M17I78vHGEfEKBf
         1Q8Z6v2U5meI9+u8PnYjGGKgMkKI6GzHZF8k97FVPn4dNvisu6B1HndqTDEt3qT7dAEi
         sW8ApdPdc5ZfAqy95dmSrr2OxlIjBSeyxK5e3mvcyh2Lv9tQRzy+Hj43h3d5j0xNKlq6
         Hjr1Mv7wtm3FM7FwgyTfkjDVb1Kmfgvo8zdCoZDop/LhhZ5dnU57C3PimcrV58uzvFwf
         ZtqEGJ3TNfO033Y9P9mDi4hXQTZwCN8vJUFrWg7yJCQjpHR3p93gLJfSRghYtbwyBGgw
         MwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjAbOdlgo9FDkSJLOMR1xs2vpDAbpOPnLP1xRILckhg=;
        b=oXuPIr0e+X5xuSag7R1KOZ/7LGEqX0QgD5qylLshTrhpNdI8o7GSCjLuQotOLi2PiE
         v276K2hbEbdBCC9tE3srQG9m/ntIXHDhnTSO6KdVwN9xmCWlwkMT9UQ2HNwY/FTUTEFF
         YpuQAqb8/2is8S3zUgD1UrbZWEji1m3w/VA3hZBDIg24Bs6Gq7GMlI59qQ9inbFuONUg
         nwtZRP+7aSui662pf7Ddz50I4I5ONIk3m1YGv8UEQj2sj3t0xu8ORJKBzvbrTU8EEi3r
         H4/VLjhBLhxEa+kiedzGvU3zFbJ6HwU49DC4+Jqchltmi0zk+uMo4JQo/UVHozErnTfe
         9WOQ==
X-Gm-Message-State: AOAM532EfApiddTaEU+dwt7e/znxJN/nc0Fm0EYrcajeu6cQFUQeIz2M
        Q0GlZSYqxpsXa1ABDa1U/YFd7L5F2KFa5jgvHRxfDg==
X-Google-Smtp-Source: ABdhPJyEgZIiDxXymUPdwUgxEJxJ6JpmtdC2klx+vAcVOvbWq4CDOq+Ue7khu+rZk7m73bkgeZza6B+NITQiBmSebro=
X-Received: by 2002:a2e:586:: with SMTP id 128mr10793860ljf.273.1610977373236;
 Mon, 18 Jan 2021 05:42:53 -0800 (PST)
MIME-Version: 1.0
References: <1610440080-68600-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610440080-68600-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 14:42:41 +0100
Message-ID: <CACRpkdY5xLHQuLjXuZvzN76eMKAHkU70yLm9XBrHLLDvncSWdw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: style: Simplify bool comparison
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, linhua.xu@unisoc.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:28 AM YANG LI <abaci-bugfix@linux.alibaba.com> wrote:

> Fix the following coccicheck warning:
> ./drivers/pinctrl/sprd/pinctrl-sprd.c:690:8-23: WARNING: Comparison to
> bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>

Patch applied, fixing subject as indicated by Baolin.

First fix I get from Alibabas robot :)

Yours,
Linus Walleij
