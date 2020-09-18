Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110C26FF62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIRN7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgIRN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:59:10 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:59:09 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id a16so1283921vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZx4kJcNFEjGr4SDJUskmqm2bu+XUaenHe1fGMPrn78=;
        b=lYx6gFCUgc1VTSHP5PLNZP54DR80Q6CK2e/EdfEDUk7E69mE+ebuqQm1OJW4ypV1cE
         TMIbDp9vCVl0fSbB/Aoaq0Hgm2akeSa+Zbv+NBsd9lcl+T5zSJSbdajbhcUAfqBYNdhm
         WvLwJ2X4e+ScmVFy4f2N+n6AmyCTkLe7jvwk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZx4kJcNFEjGr4SDJUskmqm2bu+XUaenHe1fGMPrn78=;
        b=DgSatSnhUMTCF6YOUeGhECnDnbQnqfaCTkE5IWp5QWc8xfSr+0edVbvQSinfu7BckJ
         7QXGCdUfMTlkTJpYG1up0EMKTKLoiPdEf5aSSPF2ZkAxfP83rWYvqA9CYwUu4efTL+GC
         +8bEuCBp59iQfUA3DuC3LO068ev4HABPovRu4je3hQZjleTLgbdU9ZX4IHd+vSpZTkFD
         3M0VXMIQhLeQA75IlgEoEs7UgJESq7/dC8wfPy/ZTRk/D3cNka+9K75alpHTJAHrKadU
         tXKiJuv85ZlEG2yEugP6Iqe7oVpyaGdd65YS2bOinr8JCoxuh9bHbPSFZrUDsXM8E1/t
         o52A==
X-Gm-Message-State: AOAM530+2+FQ1XmBdYXPvtditK2JqPa1VMmSM4NRgv/+xYsEcSOL3eSW
        niqCBGN0v/Qm0eu250bhxmPc15tOeZcEgw==
X-Google-Smtp-Source: ABdhPJzYTh8BtolA//h6t0fR1RXbNt/rwYDq/DJbMpVdwlt6IFli9194ySKJuk+GfrlC5EQzn1jfFw==
X-Received: by 2002:a1f:2492:: with SMTP id k140mr11111154vkk.15.1600437548773;
        Fri, 18 Sep 2020 06:59:08 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 6sm481037vkt.16.2020.09.18.06.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 06:59:07 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id q13so3604597vsj.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:59:07 -0700 (PDT)
X-Received: by 2002:a67:8bc2:: with SMTP id n185mr12030703vsd.49.1600437546889;
 Fri, 18 Sep 2020 06:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <1600435026-1876-1-git-send-email-srivasam@codeaurora.org>
In-Reply-To: <1600435026-1876-1-git-send-email-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Sep 2020 06:58:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtSEB6-M8x564t=RuSEKHwH3YvcmuZ9VGpxY+5kcL7rA@mail.gmail.com>
Message-ID: <CAD=FV=WtSEB6-M8x564t=RuSEKHwH3YvcmuZ9VGpxY+5kcL7rA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7180: Add lpass cpu node for I2S driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 18, 2020 at 6:18 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1742,6 +1742,45 @@
>                                 };
>                         };
>
> +                       sec_mi2s_active: sec-mi2s-active {
> +                               pinmux {
> +                                       pins = "gpio49", "gpio50", "gpio51";
> +                                       function = "mi2s_1";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio49", "gpio50", "gpio51";;

There are still two ";" on the above line.
