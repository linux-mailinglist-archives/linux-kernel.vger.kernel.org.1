Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA97A2F222A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbhAKVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbhAKVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:49:32 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D44C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:48:52 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id p128so129144vkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycqBvUr+Vo1t/GTBf1XQxI/E70FpV4LReNsXCXbr5zA=;
        b=nDvz71VFC7tuExZBjZ0HwnGETlX8M+pA/S4N1kUA7Xo5KvS/0On9BO73dX46znIGQf
         /fDiqU4VVcK4XWrBMXMxE9g5GK95XEptJ/ZLmdUb71YX4pjVvWSpBhiFqyz7WdJAmHNj
         s1chUaCF8la6b8wswV0IVk70pgz0dwX+zfAUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycqBvUr+Vo1t/GTBf1XQxI/E70FpV4LReNsXCXbr5zA=;
        b=a24lx71W4z3PKa6RSlwn7pP3rgXJD5ZOhNpsS2GRTf0pDpA0FrzwOSpjQ6erdQF0j/
         qrAnRKR1xxabhm3giX84/fRPjuYmPQeET18gRzlybFZhwPCgkb0YiIOofDDKpGOj5Jru
         an4omxhS7sZgC1BqFpUK7EXeR8Cq/TjuxEAyZ+664TixW1JNetDNKOJDeqU+mwVcxmZ1
         b4LCQaAnWsXXeqczD19y5vVf9uMVoAf3IqaZwsKh4SD1YSXdMIc0LOLK41ooj3+or1dS
         gnwyeCPnPgonwVqHylyDM+9JHtSwkIV5iBZ1ybRYpxTnm60+d7KSe8jTdzoK3R1YTB5W
         /DRQ==
X-Gm-Message-State: AOAM531Yu7tkNHYLZ/xgvdc36dJ59mi/wxg/QEVHBLn95j1x3E9zdi8I
        7gYkyFJr4vq2g2jj9+G9Gf/R0CDyNF6blw==
X-Google-Smtp-Source: ABdhPJw5JtzankMuMt9HjbF/0XyF9Hd07BK/nC2j5csg9E6/gLyHDFbeJ2en3NTXdlg3690uRLN9mg==
X-Received: by 2002:a1f:acc9:: with SMTP id v192mr1923929vke.2.1610401730633;
        Mon, 11 Jan 2021 13:48:50 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id x186sm164097vke.32.2021.01.11.13.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 13:48:49 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id h18so341585vsg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:48:48 -0800 (PST)
X-Received: by 2002:a67:bd01:: with SMTP id y1mr1578141vsq.49.1610401728440;
 Mon, 11 Jan 2021 13:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20201207143255.1.Ib92ec35163682dec4b2fbb4bde0785cb6e6dde27@changeid>
In-Reply-To: <20201207143255.1.Ib92ec35163682dec4b2fbb4bde0785cb6e6dde27@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jan 2021 13:48:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VWEEP7xsD5-wBjtToB+Ke69vFXzvPoAoocWPyREdjjhw@mail.gmail.com>
Message-ID: <CAD=FV=VWEEP7xsD5-wBjtToB+Ke69vFXzvPoAoocWPyREdjjhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Clean up sc7180-trogdor voltage rails
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Dec 7, 2020 at 2:33 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> For a bunch of rails we really don't do anything with them in Linux.
> These are things like modem voltage rails that the modem manages these
> itself and core rails (like IO rails) that are setup to just
> automagically do the right thing by the firmware.
>
> Let's stop even listing those rails in our device tree.
>
> The net result of this is that some of these rails might be able to go
> down to a lower voltage or perhaps transition to LPM (low power mode)
> sometimes.
>
> Here's a list of what we're doing and why:
>
> * L1A - only goes to SoC and doesn't seem associated with any
>   particular peripheral. Kernel isn't doing anything with
>   this. Removing from dts. NET IMPACT: rail might drop from 1.2V to
>   1.178V and switch to LPM in some cases depending on firmware.
> * L2A - only goes to SoC and doesn't seem associated with any
>   particular peripheral. Kernel isn't doing anything with
>   this. Removing from dts. NET IMPACT: rail might switch to LPM in
>   some cases depending on firmware.
> * L3A - only goes to SoC and doesn't seem associated with any
>   particular peripheral. Kernel isn't doing anything with
>   this. Removing from dts. NET IMPACT: rail might switch to LPM in
>   some cases depending on firmware.
> * L5A - seems to be totally unused as far as I can tell and doesn't
>   even come off QSIP. Removing from dts.
> * L6A - only goes to SoC and doesn't seem associated with any
>   particular peripheral (I think?). Kernel isn't doing anything with
>   this. Removing from dts. NET IMPACT: rail might switch to LPM in
>   some cases depending on firmware.
> * L16A - Looks like this is only used for internal RF stuff. Removing
>   from dts. NET IMPACT: rail might switch to LPM in some cases
>   depending on firmware.
> * L1C - Just goes to WiFi / Bluetooth. Trust how IDP has this set and
>   put this back at 1.616V min.
> * L4C - This goes out to the eSIM among other places. This looks like
>   it's intended to be for SIM card and modem manages. NET IMPACT:
>   rail might switch to LPM in some cases depending on firmware.
> * L5C - This goes to the physical SIM.  This looks like it's intended
>   to be for SIM card and modem manages. NET IMPACT: rail might drop
>   from 1.8V to 1.648V and switch to LPM in some cases depending on
>   firmware.
>
> NOTE: in general for anything which is supposed to be managed by Linux
> I still left it all forced to HPM since I'm not 100% sure that all the
> needed calls to regulator_set_load() are in place and HPM is safer.
> Switching more things to LPM can happen in a future patch.
>
> ALSO NOTE: Power measurements showed no measurable difference after
> applying this patch, so perhaps it should be viewed more as a cleanup
> than any power savings.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 82 ++------------------
>  1 file changed, 7 insertions(+), 75 deletions(-)

We've been running with this in the downstream tree since December 8th
and nobody has yelled.  You can see <https://crrev.com/c/2573506>.  Is
it a good time for it to land upstream?

Thanks!

-Doug
