Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165EF2EFB08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAHWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbhAHWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:21:20 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595BC061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 14:20:39 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id 73so3930981uac.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+28rernzc3C0mjkmB3xMJvm5PiyDyFYwes4MhAeT590=;
        b=miY99HtjMOqHsXPkemocimuS3wuxQX+VapsXPQMV4KxnP8YjfU5ngb/avj8ZdrErJd
         5ECUo9eLuD54ehNvBzHxwTqRQ9/GABakXuA81do99rbJqsKVLS8w6hBIGgz75eeVap9B
         tdylz0rZ0+h7lHAFNkDFeH6OutxCiexkTkXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+28rernzc3C0mjkmB3xMJvm5PiyDyFYwes4MhAeT590=;
        b=mvPwVHE1HAOEWbpAhBdjY2PRu8XKz+cRvdP6qxw0Zru6qcU/4lhZYcpn8GA/KWXeVo
         9cjvTmy6lN8r3+ViUDaEr4vKVgxle1npTkFnoH0k0BKvlaOHBKvor4A9EXudBmxpxSi+
         aB2Kj8IrXCKD3wHRzG7XdiFFwYK1/D4v30nl1KP0BLEEqEF7xsdaTFeEyBkR7vXMZgxC
         GvRBeSFRTcyiAzcFvNNp4a7s5SmNjmcjqXhF/KNF1NUULC8/pyETByzBZ6YpyJCdK9Bc
         Snk7tqMSHzJ028dGGSsXRcDPX+pri9g4ajVL7d93IbZtAL6ivq/0hsmVu8946G7XyUps
         KUZw==
X-Gm-Message-State: AOAM5315l7gQwcXDmEYAR0SMKm6ymv3C8wvLh2iyIFnbYwJMLr63A+/y
        ikgU7kBeKxND5mixjK1Le0dGJCuID9tPbA==
X-Google-Smtp-Source: ABdhPJxEY+MFWLDmDWPigcOdZQbASJ/DpVQk8ukzbQg92GS0NIXfGC17K4/HWl82FIPcv+PXwFkjgg==
X-Received: by 2002:ab0:184c:: with SMTP id j12mr4996992uag.29.1610144438503;
        Fri, 08 Jan 2021 14:20:38 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id u69sm1317301uau.1.2021.01.08.14.20.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:20:37 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id q10so6394887vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:20:37 -0800 (PST)
X-Received: by 2002:a67:32c5:: with SMTP id y188mr4644914vsy.4.1610144436974;
 Fri, 08 Jan 2021 14:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20210108141648.1.Ia8019b8b303ca31a06752ed6ceb5c3ac50bd1d48@changeid>
In-Reply-To: <20210108141648.1.Ia8019b8b303ca31a06752ed6ceb5c3ac50bd1d48@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Jan 2021 14:20:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wn3rqgu5fLYuJRQFU1s221VNvsk6voSY=_ye24HbMH4w@mail.gmail.com>
Message-ID: <CAD=FV=Wn3rqgu5fLYuJRQFU1s221VNvsk6voSY=_ye24HbMH4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add labels for cpuN-thermal nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 8, 2021 at 2:17 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add labels to the cpuN-thermal nodes to allow board files to use
> a phandle instead replicating the node hierarchy when adjusting
> certain properties.
>
> Due to the 'sustainable-power' property CPU thermal zones are
> more likely to need property updates than other SC7180 zones,
> hence only labels for CPU zones are added for now.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
