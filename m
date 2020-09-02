Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24B25A839
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIBJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIBJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:03:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEFC061247
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s62so317469vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFV82M/6u73GqedIKaydXrEwLHTHCWqg1HfMv/IVCCs=;
        b=VZzoNgJoW9pVvA92M/1zKgvhm4xk1DywhQbKr9lziWr2euc7xr7tJqZ7BV3F/7mBJe
         Rmi5STwCgT2WSV4eEldILAKBitUAPowEDgRa/Q2ABJz5ba4q+r3+spzDSFyor3Rhdn6H
         ej0ejV3kcN029m/W+Y0vu38NG7P+7Wp8He8+AbEMlArg2sNq05tNxqKEHeu7J+ZVDFLl
         mjnYOinwdHXOv8naM4Hzpmxan4ss9+v9lUC81Gg4dy1bJ7rF8jf/wmAzXdKlZVnmjqmi
         3yAIZwjpvP4EZ0xlfoa1K8iiJFMZurKo5lfU3hqX1jqHjJdZjS3KO0vEIUqHL188eslq
         uTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFV82M/6u73GqedIKaydXrEwLHTHCWqg1HfMv/IVCCs=;
        b=Kg2HV6HCBHk6PA2uOoTuTRTQ+MXqRe9tYV/NRY5TjP+0a1hkdOndP6noHyp0tJ9YM9
         miwS3djdsGokNTxoH2/a6bik2i+16f3tF1NJUul56rsLrDOIDTJe9hHbCKWrDHmlYx1o
         Pq8yGYiTbNdh9BqxGguHIWD3IW/UnkB56GD/z4/I19bqzhQcEJsI5IcksePH4kgLZlzg
         qpGfLCBH08SSrY4zD0m9gzrm6k/3ToFHnKn+ra0vVloyhKPnVN4hMOpe+7bzHdgE/hYg
         WN416MJHeSbamEQl5j47BiO2h07sIelKBCENnVhSmAYHyalicwvvPwnm86FXfKec6PjL
         Me0w==
X-Gm-Message-State: AOAM530HEKOfl7sZ1HgK7bUUxWOzlkKP4c6hyvTFNc18dgTSoO/rbl58
        /tnt3jttsDINvZrjhKkWog98bu/UM+MA06tSwaDWBQ==
X-Google-Smtp-Source: ABdhPJwsRg1A+IZemgbWMk9SB448rUC9bgen53U3T2+v8AYT3LANtcX7wdMKlegnvUy0kMb/FNEB0pRyZk8gx49TIgM=
X-Received: by 2002:a67:b44a:: with SMTP id c10mr4491532vsm.35.1599037416050;
 Wed, 02 Sep 2020 02:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <1598520783-25250-1-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1598520783-25250-1-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:02:59 +0200
Message-ID: <CAPDyKFp+RKTcssd-zpiOnvfNsv5=7b8mtEw645JQ+MLmH-XGhg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: cqhci: Add pre_enable() and post_disable()
 hook function
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Mao Yong <yong.mao@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 11:33, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
>
> This series provides MediaTek cqhci implementations as below:
>   - Add cqhci_host_ops->pre_enable() and cqhci_host_ops->post_disable()
>   - Implement MediaTek's hook functions
>
> Chun-Hung Wu (2):
>   mmc: cqhci: add new cqhci_host_ops pre_enable() and post_disable()
>   mmc: mediatek: add pre_enable() and post_disable() hook function
>
>  drivers/mmc/host/cqhci.c  |    6 ++++++
>  drivers/mmc/host/cqhci.h  |    2 ++
>  drivers/mmc/host/mtk-sd.c |   22 ++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
>
> --
> 1.7.9.5

Applied for next, thanks!

Kind regards
Uffe
