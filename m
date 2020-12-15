Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC25D2DB59B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgLOVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgLOVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:08:20 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94CC0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:07:40 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s75so24953268oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCqia07Ooz7sYMF7O1542JXQArNsUHqtaZkvNIl8vvA=;
        b=kBziQZsMw0pBIeQGW6Xi4A6IYIfyNt1oM/ivHMIcItUBjEmLJWrEM2Mf7Qf65pEMrd
         qVXmPk0/YFtWilBq5Yg4MrJ127J95EW6BcZ2l6DBf+dZiiePHIp9l+TL6cx8Gn+XF1V+
         tW6YNhUALkmGxftYQ8eaR2baeQYIyughhxaeGk/Spb06+DqjPo2KhvvbArGjTg4FfEJd
         6EAmipIylFMEzHV0nwwQbhdywFIdmnraLOObzPlNm7EJTpoLCrO2RkpSET6aCNojfP7M
         OtqjVDLv3sNc0DXpUM9EztHyHSrZuw5LH9WskPT+yXPc+4uIzKTXE/v4wRr81CVVW2vZ
         SvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCqia07Ooz7sYMF7O1542JXQArNsUHqtaZkvNIl8vvA=;
        b=p5SPz+RKwry6o5MVd583d/uV92fA/QuXJffuQ9n4Dai72F8B8EnKedRQEL+pSSq1tk
         VBo8spIrmA0YT44fr4NfVUrk+RdcUND4XgqzeY110SpkdeXREA9TOAvju5y6Vs+2ETMn
         poaneUKLqcL0PBmG+8zNMiHMG9SroSFN2dFRj5Qrz93KQRc9OO3xpIzn9WAUhBpaLuyg
         HnEGRNww0QqMMQSGrxox2Q0bDfRZq9/d4UvL9b1ViiNQ7pRnM9mq6F8NjsKGThT1unE3
         xwjeJ9DU68+vlzH/XGoTr9b5EqKEnWewj3EG96sF7VKk991h1dlD1m3kqUgTGQk1MSf7
         AnNQ==
X-Gm-Message-State: AOAM530oKoyoH+BOsOiahB/gfC1NN0op/bff/N1KjNNjOeS5xPVMgmTs
        a1/Y7yChe+POND6eQC4/AKcy5w==
X-Google-Smtp-Source: ABdhPJz4LIkqYEzr2F3FudmlHrVdy2N26fYQqwfQ1PlIw9sogsSJc7nLVpgAJ8cbRrQs5n/mChnqqQ==
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr481161oii.27.1608066459834;
        Tue, 15 Dec 2020 13:07:39 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j8sm5390755oif.55.2020.12.15.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:07:39 -0800 (PST)
Date:   Tue, 15 Dec 2020 15:07:37 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: qcom-apcs-ipc: use PLATFORM_DEVID_AUTO to
 register device
Message-ID: <X9klmVX576ePRiAr@builder.lan>
References: <20201013021241.5656-1-shawn.guo@linaro.org>
 <X9LyqlcDVsfBY1lm@builder.lan>
 <CAAQ0ZWRgEGuUbLd7cnMqPh+BY45Cn0eSsNtku6GrGiC5NiyT1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWRgEGuUbLd7cnMqPh+BY45Cn0eSsNtku6GrGiC5NiyT1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Dec 08:12 CST 2020, Shawn Guo wrote:

> On Fri, Dec 11, 2020 at 12:16 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 12 Oct 21:12 CDT 2020, Shawn Guo wrote:
> >
> > > On MSM8916, only one qcom-apcs-msm8916-clk device is needed, as there is
> > > only one APCS clock.  However, on MSM8939 three APCS clocks need to be
> > > registered for cluster0 (little cores), cluster1 (big cores) and CCI
> > > (Cache Coherent Interconnect).  That said, we will need to register 3
> > > qcom-apcs-msm8916-clk devices.  Let's use PLATFORM_DEVID_AUTO rather
> > > than PLATFORM_DEVID_NONE for platform_device_register_data() call.
> > > Otherwise, the second APCS clock registration will fail due to duplicate
> > > device name.
> > >
> > > [    0.519657] sysfs: cannot create duplicate filename '/bus/platform/devices/qcom-apcs-msm8916-clk'
> > > ...
> > > [    0.661158] qcom_apcs_ipc b111000.mailbox: failed to register APCS clk
> > >
> >
> > Spotted this as I was looking for another patch, hence the late reply.
> > But it seems this was never reviewed or merged.
> >
> > What does the bigger picture look like? Do we have 3 APCS global, or
> > it's a single memory region that provides the 3 clocks? How does the
> > qcom-apcs-msm8916-clk with it's hard coded offset of 0x50 deal with
> > this? (Is this a single qcom-apcs-msm8939-clk that registers 3 clocks
> > instead? Making this patch unnecessary?)
> 
> We have 3 APCS global instances.  I haven't got time to send out other
> related patches, but the DT for these 3 APCS global looks like below.
> 
>                 apcs2: mailbox@b1d1000 {
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb1d1000 0x1000>;
>                         #mbox-cells = <1>;

The thing at 0xb1d1000 does not have the IPC bits, so this shouldn't
have the #mbox-cells.

Other than that, this seems to be correct. Please do add the msm8939
compatible as you send this out.

Regards,
Bjorn

>                         clocks = <&a53pll_cci>, <&gcc GPLL0_VOTE>;
>                         clock-names = "pll", "aux";
>                         #clock-cells = <0>;
>                         clock-output-names = "a53mux_cci";
>                 };
> 
>                 apcs1: mailbox@b011000 {
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb011000 0x1000>;
>                         #mbox-cells = <1>;
>                         clocks = <&a53pll_c1>, <&gcc GPLL0_VOTE>;
>                         clock-names = "pll", "aux";
>                         #clock-cells = <0>;
>                         clock-output-names = "a53mux_c1";
>                 };
> 
>                 apcs0: mailbox@b111000 {
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb111000 0x1000>;
>                         #mbox-cells = <1>;
>                         clocks = <&a53pll_c0>, <&gcc GPLL0_VOTE>;
>                         clock-names = "pll", "aux";
>                         #clock-cells = <0>;
>                         clock-output-names = "a53mux_c0";
>                 };
> 
> Shawn
