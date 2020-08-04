Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E000123B143
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgHCXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHCXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:51:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:51:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i6so2865537edy.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXDDaDw8Eqt57H3f9xOmMsGMtQY7iJ1imNUg/tVT7gg=;
        b=Cw9FE0dBbSUGSKbJHPzftiC/rFHtKDanwjgHgZmM0zw84L1NME0vqbrJbro1fec6Ds
         GY/TX6SFh1xE57ojf+2CNYbeGcHvYWavFgJ+kWqcEVPA8tMNUqmT41r4AeNkAVs7S0Ec
         M9lnfsErivuKDOlf/lX1wDO80YbsfIq6lqhmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXDDaDw8Eqt57H3f9xOmMsGMtQY7iJ1imNUg/tVT7gg=;
        b=bxCc+/Mjv7GMVcBZ8I5K0tLM75tLN7gbW+dWC+P5UUgjVLAvPfK8nvRR/nIfGj0aY7
         l/N7DnAZcD87WPjYiWrqylqbd6ZGORlsdcQv93r7/HIokm2oWrCHdO5toGLkL9+C4is4
         NO3AcXIOe1pBwbAukW5B51cD+ukigII5qyAdZD99u6/MOpsTZce8APMXdYvErbBpamAR
         KDlgrAp6T4Foxct2Vb7lLGIAZJ2hT05a3OJ6VQ4VgjBaGyzQ8vdM2/Ua7Jmx6XxY9TIp
         V4eY0Mb6nL00S9v7Righs2SI3KTzZWeXi2XcKSc0LBgXVY+lYMXT5eTFQXAVSGcOoUU8
         llkw==
X-Gm-Message-State: AOAM532EZgCioglTPFRXaomEN+MPIIS3g9efRFGoh0Q1plSNUW9uhrmd
        1QMtfuGWUMxg8O818m8L7Ts3iKEBVQU=
X-Google-Smtp-Source: ABdhPJw4j/C5tVWgwQJfqZ1InAQWHppqZZRNl+UTeyRUHiGFIfYr7sRSgkg10DfRS/F7tmxovulchg==
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr17561240edb.106.1596498665887;
        Mon, 03 Aug 2020 16:51:05 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id v13sm1747075edl.9.2020.08.03.16.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:51:05 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r4so32736206wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:51:04 -0700 (PDT)
X-Received: by 2002:a5d:6641:: with SMTP id f1mr16995070wrw.307.1596498664242;
 Mon, 03 Aug 2020 16:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200803234154.320400-1-campello@chromium.org>
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Mon, 3 Aug 2020 17:50:28 -0600
X-Gmail-Original-Message-ID: <CAHcu+VYgA2rYS_R17cnREreRSjqGQvqRDUVFGf_ttQbfQu5OOQ@mail.gmail.com>
Message-ID: <CAHcu+VYgA2rYS_R17cnREreRSjqGQvqRDUVFGf_ttQbfQu5OOQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] sx9310 iio driver updates
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

So sorry, I sent an intermediate version as v4. Please disregard since
it has a couple bugs. I will send v5 with them fixed.

Regards,
Daniel

On Mon, Aug 3, 2020 at 5:41 PM Daniel Campello <campello@chromium.org> wrote:
>
> The first patch resends the DT binding for the driver that was merged in
> v5.8-rc1 with a small change to update for proper regulators. The second
> through the eleventh patch fixes several issues dropped from v8 to v9
> when the initial patch was merged.  The twelveth patch drops
> channel_users because it's unused. The thirteenth patch adds support to
> enable the svdd and vdd supplies so that this driver can work on a board
> where the svdd supply isn't enabled at boot and needs to be turned on
> before this driver starts to communicate with the chip. The final patch
> updates irq trigger flags.
>
> Changes in v4:
>  - Updated macro SX9310_REG_STAT1_COMPSTAT_MASK at call site.
>  - Use FIELD_GET/FIELD_PREP instead of manual shift.
>  - Reverted condition check logic on enable/disable_irq methods.
>  - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().
>
> Changes in v3:
>  - Moved irq presence check down to lower methods
>  - Changed buffer to struct type to align timestamp memory properly.
>  - Added static assert for number of channels.
>  - Added irq trigger flags commit to the series.
>
> Changes in v2:
>  - Added #io-channel-cells as a required property
>  - Reordered error handling on sx9310_resume()
>  - Added #include <linux/mod_devicetable.h>
>  - Added '\n' to dev_err()
>  - Fixed commit message from "iio: sx9310: Align memory"
>  - Changed prox_stat to chan_prox_stat bitmap.
>  - Fixed dev_err() message
>  - Added '\n' to dev_err()
>
> Daniel Campello (12):
>   dt-bindings: iio: Add bindings for sx9310 sensor
>   iio: sx9310: Update macros declarations
>   iio: sx9310: Fix irq handling
>   iio: sx9310: Remove acpi and of table macros
>   iio: sx9310: Change from .probe to .probe_new
>   iio: sx9310: Fixes various memory handling
>   iio: sx9310: Use long instead of int for channel bitmaps
>   iio: sx9310: Use regmap_read_poll_timeout() for compensation
>   iio: sx9310: Update copyright
>   iio: sx9310: Simplify error return handling
>   iio: sx9310: Use variable to hold &client->dev
>   iio: sx9310: Miscellaneous format fixes
>
> Stephen Boyd (3):
>   iio: sx9310: Drop channel_users[]
>   iio: sx9310: Enable vdd and svdd regulators at probe
>   iio: sx9310: Use irq trigger flags from firmware
>
>  .../iio/proximity/semtech,sx9310.yaml         |  65 +++
>  drivers/iio/proximity/sx9310.c                | 421 +++++++++---------
>  2 files changed, 276 insertions(+), 210 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
