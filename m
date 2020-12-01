Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4F2CAE19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgLAVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgLAVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:13:13 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FFDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:12:33 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s18so3368410oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz75KRIu/W04B+gDDU2G3NLHnpqmRKEC0PqjBnYvfAg=;
        b=SkXGruEgApjXBuPBIG+CsTvCnChZ0p6ZTkGXqFgatMkL0SZw0FE8KL0qzUBQa5l4h5
         6etNrreqVrIO5yxLmbc6CXbsSscrR12TJc20LAm0+qHNVdsu7dlyRNu2ReilQMX7VqxA
         qUySfC2XqfuAakxzDFuvA+ZUgBX1Qd3kEjn4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz75KRIu/W04B+gDDU2G3NLHnpqmRKEC0PqjBnYvfAg=;
        b=F/ObRLbpWpHVWX/Wn/j/BvVoZXEqT1NAKExnX8EP0lbCDAjgllSHe8uD9CRt0dg5qh
         GzlfAEcLLV7DscKa6DrZR6Aal3G7o0R2+RBxc3D3a6fpf+k7d2kknz7KLIyDiuJxB/Xf
         Zbl0LDFuW6cbaI8rY75l6FtNbS61V6HHuKy+jW53KYdexOoVSFsOTOFf05WMdkZY4dGy
         gEJKVSNXlRMkavflCdQfknmoz9TFVfx/7SYtZR/NJ2JaOkEzKoE1lMwNBciQapJSP/Dx
         zVGsgxKKG9h8Nym1PHespLHFGWdXkPFjFuhVpqhxjuiVcRk+AnBDC1xl+5YzAVuB/lwj
         jNOA==
X-Gm-Message-State: AOAM531ALoqmCW0ok5L0nz/LtNn5Ob7PgJoj5/mtzTiHPXakOsk/XRG/
        X6wyslnklcPCdjRU2b3sKa2fPR2mFU/srQ==
X-Google-Smtp-Source: ABdhPJwJ8a2XgNyrQDlHD7Lnh3dTWzxSqXvhF2wxKsY69+DwIu4rwSFORNmiBrOKpIKpo2RBEDo7fw==
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr2279030oia.148.1606857152265;
        Tue, 01 Dec 2020 13:12:32 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id r13sm184439oij.10.2020.12.01.13.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:12:31 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 79so3092431otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:12:30 -0800 (PST)
X-Received: by 2002:a9f:3dcc:: with SMTP id e12mr4780191uaj.121.1606857148640;
 Tue, 01 Dec 2020 13:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20201112004130.17290-1-dianders@chromium.org>
In-Reply-To: <20201112004130.17290-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Dec 2020 13:12:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W122aWPbg7Fo=zg+QmK7DHBcYTQ6CjPawLhucd4Rtw9A@mail.gmail.com>
Message-ID: <CAD=FV=W122aWPbg7Fo=zg+QmK7DHBcYTQ6CjPawLhucd4Rtw9A@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
To:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrea Borgia <andrea@borgia.bo.it>,
        Rob Herring <robh+dt@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <jikos@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, Pavel Balan <admin@kryma.net>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 11, 2020 at 4:41 PM Douglas Anderson <dianders@chromium.org> wrote:
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
>  drivers/hid/i2c-hid/i2c-hid-acpi.c            | 159 +++++++++++
>  drivers/hid/i2c-hid/i2c-hid-core.c            | 254 +++---------------
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
>  drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
>  drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
>  include/linux/platform_data/i2c-hid.h         |  41 ---
>  11 files changed, 596 insertions(+), 262 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
>  delete mode 100644 include/linux/platform_data/i2c-hid.h

Are there any additional changes that folks would like with this
series?  It's not crazy urgent to get it in, but it touches enough
lines of code that it'd be nice to get it in before other patches land
and it gets merge conflicts.

Hrm, I just checked and there actually is already one merge conflict
with commit afdd34c5fa40 ("HID: i2c-hid: show the error when failing
to fetch the HID descriptor") but that commit (and thus the
resolution) is trivial.  If there are no other comments I can re-post
atop that patch.  ...or I'm also happy if a maintainer is OK w/
resolving when landing my series.  Just let me know!

...or, if you want me to just shut up for a while and wait until your
tryptophan hangover wears off, that's fine too--just let me know.

-Doug
