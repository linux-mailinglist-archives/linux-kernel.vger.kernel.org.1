Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93D29B65C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1797413AbgJ0PXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:23:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37931 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1797045AbgJ0PVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:21:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id b3so1068416vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93FZSzeYLp0GkgDW04dL9ynth1HGAfCT0Yz4DoBYrD0=;
        b=PSlK6ny7ElM3EyImwqlVaQE1kO4Tr41wMTV7T6l166LF0R8Qx8tFXXDF83uOYRFefo
         Kp6Reid8J7durM64HOP9V0aXtPFvoypGthTJTFzXhhoKqw9aXjwGR0SCWsaHmydmPrIH
         0+6/OMoz4dD2r+nfYnBTEMlxP+a5HqfCydXA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93FZSzeYLp0GkgDW04dL9ynth1HGAfCT0Yz4DoBYrD0=;
        b=n/7RspKof3816Gtn2hAi6EXSwVJU0IEjpeEhcHz+OxRjVG0VhAsxk9/P9opYhyqjcG
         iuevKCDg8/9aQzIGFM8OlSVNDRdLOVCs21Xgx+Dxgowau5BkTiru/jjTHiEbeDqEKeSx
         3vXHD2jPbU2eoRBkSKrtUhL1a5ki2gv0wVRzpR0UXzS5+v/LATccODLY18Q/In9uxy3m
         O5gwX/cpeTGUM4WCO8alG5Z64Xdb8/hadyYt3UVbEKfXWRhqXfVy7VjI4YdADPManhKm
         +l6ipTuXZndIfDXgIa/sejqN0Q0JundMWhol38iDxZzAP7SXnA9YJ75WJG8wEtrVl+nE
         4JIQ==
X-Gm-Message-State: AOAM5304EVQckLAAzb+vb3HMhnNkHjmKRbqFnL91YURSJojpj73LhH88
        cS1/bU046qNWTE/FxNBlmK5tvtHeCu+8/Q==
X-Google-Smtp-Source: ABdhPJzmeWBzShCr9jxMYXYrdelYJfk5CA1bTvLspEcBrjdBPiTy87mVbkMCuLjAr4QEznn4RA0L+g==
X-Received: by 2002:a67:8884:: with SMTP id k126mr1864336vsd.44.1603812076081;
        Tue, 27 Oct 2020 08:21:16 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 123sm168857vsr.6.2020.10.27.08.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 08:21:15 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id b129so1074519vsb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:21:15 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr1942252vsl.4.1603812074737;
 Tue, 27 Oct 2020 08:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200921142655.v3.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid>
In-Reply-To: <20200921142655.v3.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Oct 2020 08:21:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVzOpRcpf1y_Lp-etrYhXuAQZYyjiVYkFggqxOvaU2JA@mail.gmail.com>
Message-ID: <CAD=FV=VVzOpRcpf1y_Lp-etrYhXuAQZYyjiVYkFggqxOvaU2JA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sc7180: Provide pinconf for SPI
 to use GPIO for CS
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 21, 2020 at 2:27 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When the chip select line is controlled by the QUP, changing CS is a
> time consuming operation.  We have to send a command over to the geni
> and wait for it to Ack us every time we want to change (both making it
> high and low).  To send this command we have to make a choice in
> software when we want to control the chip select, we have to either:
> A) Wait for the Ack via interrupt which slows down all SPI transfers
>    (and incurrs extra processing associated with interrupts).
> B) Sit in a loop and poll, waiting for the Ack.
>
> Neither A) nor B) is a great option.
>
> We can avoid all of this by realizing that, at least on some boards,
> there is no advantage of considering this line to be a geni line.
> While it's true that geni _can_ control the line, it's also true that
> the line can be a GPIO and there is no downside of viewing it that
> way.  Setting a GPIO is a simple MMIO operation.
>
> This patch provides definitions so a board can easily select the GPIO
> mode.
>
> NOTE: apparently, it's possible to run the geni in "GSI" mode.  In GSI
> the SPI port is allowed to be controlled by more than one user (like
> firmware and Linux) and also the port can operate sequences of
> operations in one go.  In GSI mode it _would_ be invalid to look at
> the chip select as a GPIO because that would prevent other users from
> using it.  In theory GSI mode would also avoid some overhead by
> allowing us to sequence the chip select better.  However, I'll argue
> GSI is not relevant for all boards (and certainly not any boards
> supported by mainline today).  Why?
> - Apparently to run a SPI chip in GSI mode you need to initialize it
>   (in the bootloader) with a different firmware and then it will
>   always run in GSI mode.  Since there is no support for GSI mode in
>   the current Linux driver, it must be that existing boards don't have
>   firmware that's doing that.  Note that the kernel device tree
>   describes hardware but also firmware, so it is legitimate to make
>   the assumption that we don't have GSI firmware in a given dts file.
> - Some boards with sc7180 have SPI connected to the Chrome OS EC or
>   security chip (Cr50).  The protocols for talking to cros_ec and cr50
>   are extremely complex.  Both drivers in Linux fully lock the bus
>   across several distinct SPI transfers.  While I am not an expert on
>   GSI mode it feels highly unlikely to me that we'd ever be able to
>   enable GSI mode for these devices.
>
> From a testing perspective, running "flashrom -p ec -r /tmp/foo.bin"
> in a loop after this patch shows almost no reduction in time, but the
> number of interrupts per command goes from 32357 down to 30611 (about
> a 5% reduction).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v3:
> - Add a blank line between pinmux and pinconf.
>
> Changes in v2:
> - Now just add the pinctrl; let a board use it.
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 104 +++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)

Friendly ping that this patch and the next one in the series are
reviewed and ready to land now that -rc1 is out.  ;-)

-Doug
