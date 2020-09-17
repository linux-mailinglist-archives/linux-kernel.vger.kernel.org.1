Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B925726D9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIQKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIQKy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:54:56 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90362208DB;
        Thu, 17 Sep 2020 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600340095;
        bh=7jThiF6cQTn6yfa4wq2zQ0h0SmDPLoGigLyYfTVhNjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F4ZW4Ajz4KpGvDMVym2OHu294EUn6zu+l7g/tIm7fVIKx7Q9wL7dW+VrtqXswXR9W
         bUQieTONW4ObfaC0vxUNmf8CHwpR3YEM6lnbaSdfaPjQomI3Ld3slrT//oHpZBh9bs
         wSNlZETjifCxxOheuSZNhkGAqw0gkUY1vEunKoDU=
Received: by mail-ed1-f47.google.com with SMTP id n22so2054364edt.4;
        Thu, 17 Sep 2020 03:54:55 -0700 (PDT)
X-Gm-Message-State: AOAM532yEe4eODcoUqzB3wNxS8nsL1wCWBvMX9tdHmcZyLjH9Q/VQVyB
        guEtpBgaiMSjFFZ8wqxElfEbqrZhuKud0p4sD6I=
X-Google-Smtp-Source: ABdhPJwPYehgSsEmo4DR/IOVuVqXs5jNB+w+Sm2zTIuyRZw02ICqCNApWOCIFpLQ/BM4MgiHcjhU516sMO7nRbrpLEg=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr31655878edb.143.1600340094199;
 Thu, 17 Sep 2020 03:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200915232803.26163-1-nicoleotsuka@gmail.com> <20200917104315.GI3515672@ulmo>
In-Reply-To: <20200917104315.GI3515672@ulmo>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 17 Sep 2020 12:54:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf5zqJYvaZc102PnTOXKrNYm8fReeJQGGx8eaQDCXavkw@mail.gmail.com>
Message-ID: <CAJKOXPf5zqJYvaZc102PnTOXKrNYm8fReeJQGGx8eaQDCXavkw@mail.gmail.com>
Subject: Re: [PATCH] memory: tegra: Correct num_tlb_lines for tegra210
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jonathanh@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 at 12:43, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 04:28:03PM -0700, Nicolin Chen wrote:
> > According to Tegra210 TRM, the default value of TLB_ACTIVE_LINES
> > field of register MC_SMMU_TLB_CONFIG_0 is 0x30. So num_tlb_lines
> > should be 48 (0x30) rather than 32 (0x20).
> >
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/memory/tegra/tegra210.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Please send this as part of a series including:
>
>     https://patchwork.ozlabs.org/project/linux-tegra/patch/20200916002359.10823-1-nicoleotsuka@gmail.com/
>
> Adding Joerg for visibility. From the Tegra side:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

So basically applying this one alone breaks existing platforms and
makes history non-bisectable...

Nicolin, the bisectability is important requirement so you must always
mention the dependencies between patches.

Best regards,
Krzysztof
