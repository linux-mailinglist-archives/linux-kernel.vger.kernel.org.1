Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425D82EB7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAFBgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhAFBga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:36:30 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4AEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 17:35:49 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id r24so989921vsg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 17:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8190Rw9nFurXvpyVpr5H2heqLA3Td/3zauNq8uzsNzM=;
        b=MKfJ7zGxTH1maYa7wKycTAhSCe7iU3Dy08HvTas4FA/zUjsnZ6Hjc05jcStbPpGZ/B
         g7TV1HRXxJ+RX79sAOjh9NV09M2ekhu2NPTSuTTHO9ncVhG+jBvzCjpGxG+wKMSgiOtu
         ZdPYyd4Chi2Xa6auJVV/rnzWGMTaQgVoK9zy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8190Rw9nFurXvpyVpr5H2heqLA3Td/3zauNq8uzsNzM=;
        b=OXDcEI8Q2KedCkJgqCrLaRttWwS/NMCFr/m5zb58LM3afsB6nAVmf5zb9XZf0PPgFp
         typycC6L+EHWUyn+kFXfVAz0l2DGX3uMZxRNLH4ZXiHfsacr9zuPTmIfhP8UIlbl0f1d
         tcT5JglOwSyPJCdNnaGBAJHpczVPq7GoQBB4QG6ceCH6DiKEf/rnKzeSQvNmhafEiugL
         tfqXpsqFl2nqyOq9sLPGiTioksrIsiG8aWVp0ou9o38x97XdBhV2zdPRz96q3NPjiOqM
         FiEVytnSkRsMeiJwZbBTEVBsCxlPFMy8xqbN9rwEnLt8xAG8aRmKtxVNHHxH5jqRbcyp
         UT2A==
X-Gm-Message-State: AOAM531k1ILPkRbvpS/1/k+b2VOim3YgEpkGxp276bRYB80s1XtohyvD
        zA6CJW/DPXXBi8Wrk3sDjFDs79Coy2Mj4A==
X-Google-Smtp-Source: ABdhPJy74hLM/N2LSQvGte3mT/tXgkF1nPCSvyuYgfQ4F8WM0y1pVpeVZU/FReGkXqI7TaLRn4FOxg==
X-Received: by 2002:a67:5d06:: with SMTP id r6mr1457134vsb.49.1609896947869;
        Tue, 05 Jan 2021 17:35:47 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id f23sm168835vsk.8.2021.01.05.17.35.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 17:35:47 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id p2so589369uac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 17:35:46 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr1914472uaa.104.1609896944481;
 Tue, 05 Jan 2021 17:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20201211222448.2115188-1-dianders@chromium.org>
In-Reply-To: <20201211222448.2115188-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Jan 2021 17:35:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ve4wGJ=KxQjraYsiAQZHG_5qEeFW0ZhmBBkRmtdm7Gwg@mail.gmail.com>
Message-ID: <CAD=FV=Ve4wGJ=KxQjraYsiAQZHG_5qEeFW0ZhmBBkRmtdm7Gwg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
To:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Pavel Balan <admin@kryma.net>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin,

On Fri, Dec 11, 2020 at 2:24 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The goal of this series is to support the Goodix GT7375P touchscreen.
> This touchscreen is special because it has power sequencing
> requirements that necessitate driving a reset GPIO.
>
> To do this, we totally rejigger the way i2c-hid is organized so that
> it's easier to jam the Goodix support in there.
>
> This series was:
> - Tested on a device that uses normal i2c-hid.
> - Tested on a device that has a Goodix i2c-hid device.
> - Tested on an ACPI device, but an earlier version of the series.
>
> I believe the plan is for Benjamin to land the whole series.  Will
> said this about the arm64 defconfig change (and provided his Ack):
> > ...there are a few things I really care about
> > in defconfig (e.g. things like page size!), generally speaking we don't
> > need to Ack everything that changes in there.
> >
> > That said, might be worth checking whether arm-soc have any defconfig
> > changes queued in -next so you don't end up with conflicts.
>
> Changes in v8:
> - Mark suspend/resume as static as per patches robot.
>
> Changes in v7:
> - Rebase atop commit afdd34c5fa40 ("HID: i2c-hid: show the error ...")
>
> Changes in v6:
> - ACPI probe function should have been "static"
> - Don't export suspend/resume, just export dev_pm_ops from core.
> - Fixed crash in ACPI module (missing init of "client")
> - No need for regulator include in the core.
> - Removed i2c_device_id table from ACPI module.
> - Suspend/resume are no longer exported from the core.
>
> Changes in v5:
> - Add shutdown_tail op and use it in ACPI.
> - Added mention of i2c-hid in the yaml itself as per Rob.
> - Adjusted subject as per Rob.
> - i2chid_subclass_data => i2chid_ops.
> - power_up_device => power_up (same with power_down).
> - subclass => ops.
>
> Changes in v4:
> - ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.
> - Fully rejigger so ACPI and OF are full subclasses.
> - Totally redid based on the new subclass system.
>
> Changes in v3:
> - Fixed compatible in example.
> - Removed Benjamin as a maintainer.
> - Rework to use subclassing.
> - Updated description.
>
> Changes in v2:
> - ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.
> - Get timings based on the compatible string.
> - Use a separate compatible string for this new touchscreen.
>
> Douglas Anderson (4):
>   HID: i2c-hid: Reorganize so ACPI and OF are separate modules
>   arm64: defconfig: Update config names for i2c-hid rejigger
>   dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix
>     GT7375P
>   HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core

I think this series is ready to land.  The "defconfig" has a trivial
conflict with commit 74b87103b3d0 ("arm64: defconfig: Enable HID
multitouch") against linuxnext, but it's so simple that hopefully
folks will be OK with that when it lands.

Please let me know if there's anything else you need me to do.  :-)

-Doug
