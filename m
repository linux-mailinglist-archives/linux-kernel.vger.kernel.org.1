Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705392D7787
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbgLKOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392333AbgLKOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:12:54 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:12:14 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id 81so9571193ioc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tkNqrT/rf+QvICrh/2UEiWRatcZIT1m2JY6QNXBeEI=;
        b=btLMlKOWtuEv6gcOxOCIj23IaZHemgxWAMlab8konD5A0udUd1XC+MbTiFm/rvh+ky
         K5CmyhDlrBNOtScXYwg3vxqTCcUvN44njwpKGYx80SP750/FkpbaBbPHkFNbgIE7PV1o
         3xcpfAkLg7bXEtdhKYr+CRH92vCD7ryCoSYBylu0zlhAmGHRFaF4MoxJJLhxIJ0KiuX2
         xnVVXXKtB8a8OLuy/A2wqoYG7mmwHZ4yPXqsuYRPZtkTNYv42bn/Az7z7U9IDj3cvQnX
         jj+ceW+QB00/nCJTW2gnK3MArqwRpVLKu5SfHR87iNlQGa/rmTW5lfS2V5klySGlDiLI
         ngtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tkNqrT/rf+QvICrh/2UEiWRatcZIT1m2JY6QNXBeEI=;
        b=P/B8YkI9Qgk4BBW4UlaKgApObFDDLdJzI114NlCKFCQ6in0//f+Mz5Y9wg8Q7HV1t/
         wVG3BAUDCJmk9j3hhe47KLGJ0TCLV76vefgce6Yb3+sGXq+l3VmmgmBKmQ9IcLJTq3qL
         B06PMfIohXt99PnaZlaGHqnGBTf4+/Q44yK0FFyxul85+K2mANgZmT97zgVyuy74Lgnc
         ayDt9B8qAvZ6+kK/rYovbUm+HwNCfrvAy8CSkdPbeaixkuUFDoOztFHsa/uGjcSWr/fK
         drfH2XsJJIKnzL+zd3eY7IFVECG5x9asacZlsPNW6V2rPcymRYq1a51/rBI0xWH0viMr
         Dh+w==
X-Gm-Message-State: AOAM5327wgjP+AhM6jhhfevs7JrJTSWRMY2z/TN+mYcbEn53GCmUhbyd
        ZtW2SNIseoB1UIBPMfBW6oStzX8J4eBTlFkAUrnvYw==
X-Google-Smtp-Source: ABdhPJxMpXcLyBxDj5CDcasxr95QZFjJDy74aWvz+xKxTJelYKwihuWDGYnpAzKL2Ztc05tQyOAXhudMLbHeEqaw3Nw=
X-Received: by 2002:a02:3e86:: with SMTP id s128mr16197263jas.131.1607695933404;
 Fri, 11 Dec 2020 06:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20201013021241.5656-1-shawn.guo@linaro.org> <X9LyqlcDVsfBY1lm@builder.lan>
In-Reply-To: <X9LyqlcDVsfBY1lm@builder.lan>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Fri, 11 Dec 2020 22:12:02 +0800
Message-ID: <CAAQ0ZWRgEGuUbLd7cnMqPh+BY45Cn0eSsNtku6GrGiC5NiyT1A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: qcom-apcs-ipc: use PLATFORM_DEVID_AUTO to
 register device
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:16 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 12 Oct 21:12 CDT 2020, Shawn Guo wrote:
>
> > On MSM8916, only one qcom-apcs-msm8916-clk device is needed, as there is
> > only one APCS clock.  However, on MSM8939 three APCS clocks need to be
> > registered for cluster0 (little cores), cluster1 (big cores) and CCI
> > (Cache Coherent Interconnect).  That said, we will need to register 3
> > qcom-apcs-msm8916-clk devices.  Let's use PLATFORM_DEVID_AUTO rather
> > than PLATFORM_DEVID_NONE for platform_device_register_data() call.
> > Otherwise, the second APCS clock registration will fail due to duplicate
> > device name.
> >
> > [    0.519657] sysfs: cannot create duplicate filename '/bus/platform/devices/qcom-apcs-msm8916-clk'
> > ...
> > [    0.661158] qcom_apcs_ipc b111000.mailbox: failed to register APCS clk
> >
>
> Spotted this as I was looking for another patch, hence the late reply.
> But it seems this was never reviewed or merged.
>
> What does the bigger picture look like? Do we have 3 APCS global, or
> it's a single memory region that provides the 3 clocks? How does the
> qcom-apcs-msm8916-clk with it's hard coded offset of 0x50 deal with
> this? (Is this a single qcom-apcs-msm8939-clk that registers 3 clocks
> instead? Making this patch unnecessary?)

We have 3 APCS global instances.  I haven't got time to send out other
related patches, but the DT for these 3 APCS global looks like below.

                apcs2: mailbox@b1d1000 {
                        compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
                        reg = <0xb1d1000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&a53pll_cci>, <&gcc GPLL0_VOTE>;
                        clock-names = "pll", "aux";
                        #clock-cells = <0>;
                        clock-output-names = "a53mux_cci";
                };

                apcs1: mailbox@b011000 {
                        compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
                        reg = <0xb011000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&a53pll_c1>, <&gcc GPLL0_VOTE>;
                        clock-names = "pll", "aux";
                        #clock-cells = <0>;
                        clock-output-names = "a53mux_c1";
                };

                apcs0: mailbox@b111000 {
                        compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
                        reg = <0xb111000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&a53pll_c0>, <&gcc GPLL0_VOTE>;
                        clock-names = "pll", "aux";
                        #clock-cells = <0>;
                        clock-output-names = "a53mux_c0";
                };

Shawn
