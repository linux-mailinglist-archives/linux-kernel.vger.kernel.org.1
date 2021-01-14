Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0526A2F6D89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbhANVwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbhANVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:52:10 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:51:30 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y128so3175287ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MaJhCChLvMA5q7Hc7EGz9x2JBN/Mr/+/kQsJO4ydp0=;
        b=giJjqVe3Kr//U30LVgKzadlQb8wdA/+YGhxY7JPrxL8nWL6SpFSejBXGGRnbs3Swbt
         NhA/luSJJs/kbOWr1t0yuKsKMUTOGL1dmLqEULuCHyI6uWj3RSfCCBxJGKE57yqRQtG/
         f9UVuM+T08zZpLGrUgtsQ6SHVS8urxRmV63GmO81u1VohhaCljESsqeKLP4Ilc30rQFJ
         SOb106qBEmPmCswU8nttfm2L+GcfmScDYDmKRM/g4a4jbQ97euKG1/pY57Hi0cF/e9Vc
         wjja0Ee1USX8DCfchkLKG23qhaKtPlP1Is9VoKyH59XzKgNB4UpTx5pXXrwahoI53+96
         Undg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MaJhCChLvMA5q7Hc7EGz9x2JBN/Mr/+/kQsJO4ydp0=;
        b=c/5ZiuBrbsBUgoSWiK8Mq9ygN9aDMUJlMysV+vSSwO2WZcZCa5IDrV/VMHel7v9IW0
         e1i9l7Q/nvDQfqRpXcQnANdFRd3qBLNPPOYEshT8RT/e2F8Mfq75NMuhSqHPUhnPAzOC
         zwCAErd8YAez6n9XqbA3M1RKkct4Up2gqZCDhLDl3Q+KQfIlRy4obwX/4fF1OUDrzOEI
         uic37muJUkpvVfXO2JVtlaTTrfJMq4uKZHNGzdF/WDuTdk8TdgJLaZyJ3/Q9xDE134l9
         RHN0wGP4yUE2VLX75Z+m0tqO/Pm9sE4FOQlaJ/VfM3k9wcUE4bqe+QDms/InW/THxhxB
         QoSw==
X-Gm-Message-State: AOAM531yHRfqFDdDPh072t6fAdMtBBFJV2euc9wIvzs4dsW7WImkdvVI
        lW7cwLLqD/xePkA5MHq4+URY/MUpwlI6mdFrjbVifw==
X-Google-Smtp-Source: ABdhPJxsaHc1Q9X8x1mbLGU3fLEE/2MXeR/09DpXj+8UneKPE7+VKoOfuy3x1/kBXIcpRJdIx02Qu9lRbZDNhE/LXwM=
X-Received: by 2002:a25:d295:: with SMTP id j143mr14364937ybg.20.1610661089343;
 Thu, 14 Jan 2021 13:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <X/dpkgTnUk+inKHK@kroah.com> <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
 <ba2fcbfb-d714-2f73-3bd0-962f49363b62@nvidia.com> <CAGETcx8pdPnH1ndOCoi7Qyz8DDshCfMTzDLQM=oEaCjyds9reA@mail.gmail.com>
 <17703ac8-2238-0b64-3c98-ddadc7ae8a36@nvidia.com> <CAGETcx-=y4Ps41Lb0b_MTCbNTC_ah0cJTmPP+GajywFBc7kEfw@mail.gmail.com>
 <f0240065-a4a0-d985-a696-eba4d42ea580@nvidia.com> <CAGETcx_QmbOcof5T8Wo_zFXKB+qswPN3Cbwz5a6A+m+VrnWg0A@mail.gmail.com>
 <a38c0566-a58e-aaf7-ef57-dc294c4e71b4@nvidia.com>
In-Reply-To: <a38c0566-a58e-aaf7-ef57-dc294c4e71b4@nvidia.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 13:50:53 -0800
Message-ID: <CAGETcx9szf-=JjFNp0p-0LmOfOU1MWE3QqDNe-bAn2wXPH9pEQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:55 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 14/01/2021 16:52, Saravana Kannan wrote:
>
> ...
>
> > Thanks! I think you forgot to enable those logs though. Also, while
> > you are at it, maybe enable the logs in device_link_add() too please?
>
>
> Sorry try this one.
>
> Cheers
> Jon

Phew! That took almost 4 hours to debug on the side! I think I figured
it out. Can you try this patch? If it works or improves things, I'll
explain why it helps.

-Saravana

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 5f9eed79a8aa..1c8c65c4a887 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1258,6 +1258,8 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
 DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
 DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
+DEFINE_SIMPLE_PROP(gpio_compat, "gpio", "#gpio-cells")
+DEFINE_SIMPLE_PROP(gpios_compat, "gpios", "#gpio-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
@@ -1296,6 +1298,8 @@ static const struct supplier_bindings
of_supplier_bindings[] = {
        { .parse_prop = parse_pinctrl6, },
        { .parse_prop = parse_pinctrl7, },
        { .parse_prop = parse_pinctrl8, },
+       { .parse_prop = parse_gpio_compat, },
+       { .parse_prop = parse_gpios_compat, },
        { .parse_prop = parse_regulators, },
        { .parse_prop = parse_gpio, },
        { .parse_prop = parse_gpios, },
