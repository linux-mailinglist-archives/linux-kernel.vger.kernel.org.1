Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153902CC0AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgLBPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgLBPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606922395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFR2t3IjQI80xXgeJr/lLM6Ot3yuaPlWOezeBx0tbPI=;
        b=EHgBezg4BI+AW+nlYWzogXpTdqbxkir4TNi5eUZKSNYi+NGZ71P0cUz44hlun4AxOhdh6N
        Qdogz+9ERYqvXU33Ae3bUrslK/mXNgjCilqcgG1nEyoEYmFkbXfVTSwCDXytOd63qm9e9n
        8ZTYaKi0+dBGnbKjnqpiHbZ9+lnC9f4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-L11-MSxyPzeQcezPu2Upqg-1; Wed, 02 Dec 2020 10:19:54 -0500
X-MC-Unique: L11-MSxyPzeQcezPu2Upqg-1
Received: by mail-pj1-f71.google.com with SMTP id c1so1207376pjo.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFR2t3IjQI80xXgeJr/lLM6Ot3yuaPlWOezeBx0tbPI=;
        b=XtII5N7xUMBtzT3crDh2/3/Zj2YXfyjQmWUmsHjuyUTca1cS8mMgaV0+5SZlOeRdyK
         HDXIcZOs7TsQl6rraxpskmfUb+6e8ARXyC2hidvIzl1+VL5U0tPWfnWCsf0WgkWkKbvj
         HVfjf9JqtZA0WE6QF4uTXQjXg2lXBQOhgfu+O3qICD4FnFiCVKEFy0SYEvJq5wcQesJj
         ePUkvwP8L5BmjIpwWxxkdOnl3nSglh18DY9+tjlf7t3di6nnSY02YzKQR55bEdTbcMYr
         OjNfix6TLzimDgU7urPEgEXMVvqCHbj7ScXgnU/2KvNvo5m3CY7uApFK3QZU2P31u6HC
         o+3Q==
X-Gm-Message-State: AOAM533UfMKZDy7LhxbF+EJZH22qHEK2uWq8F8GTfKDnJwaBMX+JXJZy
        2lnXlWD4wafqReb9vHJAHcH0j3SOHcshLgxvQYxPZPInr/lph0yTbV3hPXxCSlc3zKO838csrgv
        QtozLRKIkgZEZHQb3kBCCiYVjEP396bPtc8hQ3jqH
X-Received: by 2002:a63:1414:: with SMTP id u20mr312483pgl.147.1606922392850;
        Wed, 02 Dec 2020 07:19:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx1g9/LllhhTY2kqAX7DReYattvLk+1Zn+n8SVM7MqR/ECZ0g58ckaZi/4ZDUMErdOi5rr0+tT9celGmI9Nto=
X-Received: by 2002:a63:1414:: with SMTP id u20mr312476pgl.147.1606922392587;
 Wed, 02 Dec 2020 07:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20201112004130.17290-1-dianders@chromium.org> <CAD=FV=W122aWPbg7Fo=zg+QmK7DHBcYTQ6CjPawLhucd4Rtw9A@mail.gmail.com>
In-Reply-To: <CAD=FV=W122aWPbg7Fo=zg+QmK7DHBcYTQ6CjPawLhucd4Rtw9A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 2 Dec 2020 16:19:41 +0100
Message-ID: <CAO-hwJ+amboty_wKzP3n11mHLfssGz8Npzdfu9QrcipEvu3VHA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrea Borgia <andrea@borgia.bo.it>,
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

Hi Doug,

On Tue, Dec 1, 2020 at 10:12 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 11, 2020 at 4:41 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The goal of this series is to support the Goodix GT7375P touchscreen.
> > This touchscreen is special because it has power sequencing
> > requirements that necessitate driving a reset GPIO.
> >
> > To do this, we totally rejigger the way i2c-hid is organized so that
> > it's easier to jam the Goodix support in there.
> >
> > This series was:
> > - Tested on a device that uses normal i2c-hid.
> > - Tested on a device that has a Goodix i2c-hid device.
> > - Tested on an ACPI device, but an earlier version of the series.
> >
> > Changes in v6:
> > - ACPI probe function should have been "static"
> > - Don't export suspend/resume, just export dev_pm_ops from core.
> > - Fixed crash in ACPI module (missing init of "client")
> > - No need for regulator include in the core.
> > - Removed i2c_device_id table from ACPI module.
> > - Suspend/resume are no longer exported from the core.
> >
> > Changes in v5:
> > - Add shutdown_tail op and use it in ACPI.
> > - Added mention of i2c-hid in the yaml itself as per Rob.
> > - Adjusted subject as per Rob.
> > - i2chid_subclass_data => i2chid_ops.
> > - power_up_device => power_up (same with power_down).
> > - subclass => ops.
> >
> > Changes in v4:
> > - ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.
> > - Fully rejigger so ACPI and OF are full subclasses.
> > - Totally redid based on the new subclass system.
> >
> > Changes in v3:
> > - Fixed compatible in example.
> > - Removed Benjamin as a maintainer.
> > - Rework to use subclassing.
> > - Updated description.
> >
> > Changes in v2:
> > - ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.
> > - Get timings based on the compatible string.
> > - Use a separate compatible string for this new touchscreen.
> >
> > Douglas Anderson (4):
> >   HID: i2c-hid: Reorganize so ACPI and OF are separate modules
> >   arm64: defconfig: Update config names for i2c-hid rejigger
> >   dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix
> >     GT7375P
> >   HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core
> >
> >  .../bindings/input/goodix,gt7375p.yaml        |  65 +++++
> >  arch/arm64/configs/defconfig                  |   3 +-
> >  drivers/hid/Makefile                          |   2 +-
> >  drivers/hid/i2c-hid/Kconfig                   |  47 +++-
> >  drivers/hid/i2c-hid/Makefile                  |   6 +-
> >  drivers/hid/i2c-hid/i2c-hid-acpi.c            | 159 +++++++++++
> >  drivers/hid/i2c-hid/i2c-hid-core.c            | 254 +++---------------
> >  drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
> >  drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
> >  drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
> >  include/linux/platform_data/i2c-hid.h         |  41 ---
> >  11 files changed, 596 insertions(+), 262 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> >  create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
> >  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> >  create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
> >  delete mode 100644 include/linux/platform_data/i2c-hid.h
>
> Are there any additional changes that folks would like with this
> series?  It's not crazy urgent to get it in, but it touches enough
> lines of code that it'd be nice to get it in before other patches land
> and it gets merge conflicts.

Sorry for the delay. I was having an internal deadline last week. I
just re-read the code, and I am quite happy with it. I also just
tested it on the i2c-hid w/ acpi machine I have here, and it seems OK.

So other than that, do we need to have approvals for patch 2/4
(arch/arm64/configs/defconfig)? I can easily take that in the HID
tree, but I prefer having the approval from the maintainers first.
Catalin, Will?

>
> Hrm, I just checked and there actually is already one merge conflict
> with commit afdd34c5fa40 ("HID: i2c-hid: show the error when failing
> to fetch the HID descriptor") but that commit (and thus the
> resolution) is trivial.  If there are no other comments I can re-post
> atop that patch.  ...or I'm also happy if a maintainer is OK w/
> resolving when landing my series.  Just let me know!

If I can quickly get the approval from the arm64/config maintainers, I
can try to apply it. Though, I wouldn't be against you sending a clean
and conflict-free series :)

>
> ...or, if you want me to just shut up for a while and wait until your
> tryptophan hangover wears off, that's fine too--just let me know.
>

Heh. Sorry, I have a tendency to have my inbox flooded, and some time
gets distracted to do other important work I am paid for (too). I
don't mind a gentle nudge from time to time, that helps figuring out
the priorities :)

Cheers,
Benjamin

