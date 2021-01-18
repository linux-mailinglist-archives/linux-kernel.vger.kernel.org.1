Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04832FA65F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393338AbhARQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406591AbhARQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610987463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqqkV4pT3FZ8X8fvg8OJBm77Py4wiQX0myH+LsoZDCw=;
        b=a6h9eXCo75jl5isULT7F3kmejAQX6of968yumgoMe955AWpcxvhrucIz9zPSkB5y0aqNbg
        IplVcN0dy7+1gjnBsb2nTRf4Lr8mo2cCUNKH7/S0h9w7ZKQjdLiQGfTTno/koPFRBBogJL
        flLywJEcIKLU6uOuiF3BoQoddA3BocI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467--8e0S27_Nn602RnP94rx6w-1; Mon, 18 Jan 2021 11:31:01 -0500
X-MC-Unique: -8e0S27_Nn602RnP94rx6w-1
Received: by mail-pl1-f199.google.com with SMTP id c5so11830396plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqqkV4pT3FZ8X8fvg8OJBm77Py4wiQX0myH+LsoZDCw=;
        b=WXEFRFDxb4kD8i1OAunB97xH0rsaDagRF1yabQeoNOug30HFv8WvLMToRb1rpbvpLq
         uzBfRQZjDmS2B/E+A9xgwomzBp8peLcgZG44bul1TSqn8Mxyj8c8DPWLL3hbT57pdrfw
         QmtSjAU9qTHAwrdBI4OwTtWZoJ0N+gDhCNq4lAMF7ZBg5CiOHJpshX7G3LoYS4YpFqZ4
         xUkre/A8fQ73eoXVP7KaCroEhO0jnkavhgs4HkZ1qCAm97LL0AkxEwf57+J+D100MFSA
         AsX2QMkLqISaw/9g+RSEj1RGwLto0IKwV+nDLmWBfY5ltYJj8P2h/GQxtbid0zrXaer1
         X/IQ==
X-Gm-Message-State: AOAM532Sy41bB11SLM1NIAyk4EygLnNqSTc8lTfOFgx2Wxbekg0nSlNd
        wDP/2EHFoAhMZ2EfFgQ4RqsSXIWUKo2FQCj5pxbBxj+GZ3k3igbXuZyIAjO7ECl4++Fj6ZyBiLE
        SobGDiDkIdzmzZVAJGCo2w0Uexuyh1iOnZEnTGklN
X-Received: by 2002:a62:5547:0:b029:1a4:cb2a:2833 with SMTP id j68-20020a6255470000b02901a4cb2a2833mr342778pfb.35.1610987459103;
        Mon, 18 Jan 2021 08:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQZOW38waFNxH9jbai1nJ21Z+g0/K1dIN8TLDr66GfVuysO8ZrPHNLGZxQPy2H160dRR5gxUpHW2cA6nG/36I=
X-Received: by 2002:a62:5547:0:b029:1a4:cb2a:2833 with SMTP id
 j68-20020a6255470000b02901a4cb2a2833mr342749pfb.35.1610987458819; Mon, 18 Jan
 2021 08:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20210115170641.903392-1-dianders@chromium.org>
In-Reply-To: <20210115170641.903392-1-dianders@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 18 Jan 2021 17:30:47 +0100
Message-ID: <CAO-hwJJyQqvhZaRAbnxvi0k+pUr8i3iwCnkEs69sAw+byRst3g@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:07 PM Douglas Anderson <dianders@chromium.org> wrote:
>
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
> Changes in v9:
> - 120 ms delay => 180 ms delay
> - Local variable in ACPI code "ihid_of" => "ihid_acpi".
> - Squash Benjamin's change for ACPI power on.
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
>
>  .../bindings/input/goodix,gt7375p.yaml        |  65 +++++
>  arch/arm64/configs/defconfig                  |   3 +-
>  drivers/hid/Makefile                          |   2 +-
>  drivers/hid/i2c-hid/Kconfig                   |  47 +++-
>  drivers/hid/i2c-hid/Makefile                  |   6 +-
>  drivers/hid/i2c-hid/i2c-hid-acpi.c            | 143 ++++++++++
>  drivers/hid/i2c-hid/i2c-hid-core.c            | 252 +++---------------
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
>  drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
>  drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
>  include/linux/platform_data/i2c-hid.h         |  41 ---
>  11 files changed, 578 insertions(+), 262 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
>  delete mode 100644 include/linux/platform_data/i2c-hid.h
>

Many thanks for the wait. I have now scheduled this series in for-5.12/i2c-hid.

Cheers,
Benjamin

