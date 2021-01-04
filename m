Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFB2E8FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 05:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbhADEpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADEo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 23:44:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49448C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 20:44:19 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f132so30825633oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 20:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hK9wYRV52OLCT1aIUIfPdQeCZ9d73qXQnCRxpSILOcQ=;
        b=hFoeqrBBx1uol98LLny5xOtq7G2JLLTTnc0RnvYZhADnNMbYMplIGitPZJAfnGXh3r
         RJxDXxfzGHiWLzgiQsD5AbLrFCEKXFlOLAj8dw7j06Z6/RqqLX7cqzERG8YIIV0BfNO6
         zGUha4U4EnKrYsvi+9f1Ggkn/jhpvGR4tmTWP9XrsiNEQoXCMZ/X8Tjt1+c2g3y6BS5p
         N9iYJq0fvC9Fdh3OoG7KJjJ726KvSxu5O6vfWVIvEZZa5hF03N2vqMJpxJwImi+0UCPr
         qnuOiybQZMhDWzHbl3um2fSUXjNB9yNg03Z2h3UmuSQ+G+kS04yVnn2qtRS5CNuQ4Zb0
         ZAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hK9wYRV52OLCT1aIUIfPdQeCZ9d73qXQnCRxpSILOcQ=;
        b=rBCGU3Ban9xV2EXuPOCf1SQTz9TyR2gIY0g3EYen706nbd2+dbH5MojojVE0E4hb1Q
         f9jcDVvRYXqUeMtqWHXsK3gOlnHtFBUMAH7rnvk8FkEY6xJbjHJ+cCKn1GBZTCN63zek
         UFiDeqLtx6B2+mIMDe0S/Yshu+kllDlzP2pN1CNIKjeHi5ZYVhar4O5uOyrs0Ozg0eBY
         wZoeITwslA0ou9tuOrMD1lspe5DQKY1zxvxeDTeOzmf2qXJTKjeUs71P+n8pTJKRW7ig
         xElHaH9NmM70CRZlWKMbwM//+wmXhO2+axajpIVfDJGsZ1Mvu3uJzTjV9Ye2hhToDLpX
         zmTg==
X-Gm-Message-State: AOAM5332i19aNLlqzE8ko2J4k5GQspxGN5S8URWjMKvm1Q6odai208/Y
        dM/KL/H/vSGxMIZx+VCCQcmOFg==
X-Google-Smtp-Source: ABdhPJwEdwKgWXXhOQUhxJ29lpsn17cZ7bxl7/tsvAjuTQmgb8PUjkfkAKGfOQk1oEuh1pszCiDIhQ==
X-Received: by 2002:aca:1102:: with SMTP id 2mr17056991oir.100.1609735458485;
        Sun, 03 Jan 2021 20:44:18 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h2sm12524596ooa.25.2021.01.03.20.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 20:44:17 -0800 (PST)
Date:   Sun, 3 Jan 2021 22:44:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8150: Add PSCI idle states
Message-ID: <X/KdIKDEabanfZhw@builder.lan>
References: <20201221002907.2870059-1-danny@kdrag0n.dev>
 <20201221002907.2870059-3-danny@kdrag0n.dev>
 <X+AbJvE7OGs3cRCw@ripper>
 <e7776f3c-a517-4cf3-9265-92dc0ac09c88@www.fastmail.com>
 <X+odnnZYFW3qpubJ@builder.lan>
 <52495cb9-6230-4f7f-b138-83e74d2834cc@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52495cb9-6230-4f7f-b138-83e74d2834cc@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Dec 17:19 CST 2020, Danny Lin wrote:

> On Mon, Dec 28, 2020 at10:02 AM, Bjorn Andersson wrote:
> > On Tue 22 Dec 20:00 CST 2020, Danny Lin wrote:
> > 
> > > On Sun, Dec 20, 2020 at 7:48 PM, Bjorn Andersson wrote:
> > > > On Sun 20 Dec 16:29 PST 2020, Danny Lin wrote:
> > > > 
> > > > > Like other Qualcomm SoCs, sm8150 exposes CPU and cluster idle states
> > > > > through PSCI. Define the idle states to save power when the CPU is not
> > > > > in active use.
> > > > > 
> > > > > These idle states, latency, and residency values match the downstream
> > > > > 4.14 kernel from Qualcomm as of LA.UM.8.1.r1-15600-sm8150.0.
> > > > > 
> > > > > It's worth noting that the CPU has an additional C3 power collapse idle
> > > > > state between WFI and rail power collapse (with PSCI mode 0x40000003),
> > > > > but it is not officially used in downstream kernels due to "thermal
> > > > > throttling issues."
> > > > > 
> > > > 
> > > > Thanks Danny for this series, very happy to see this kind of additions.
> > > > Just one small question about the cluster param below.
> > > > 
> > > > > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 50 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 50 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > > index 75ed38ee5d88..edc1fe6d7f1b 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > > > @@ -50,6 +50,8 @@ CPU0: cpu@0 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x0>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_0>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 0>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -67,6 +69,8 @@ CPU1: cpu@100 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x100>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_100>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 0>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -82,6 +86,8 @@ CPU2: cpu@200 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x200>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_200>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 0>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -96,6 +102,8 @@ CPU3: cpu@300 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x300>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_300>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 0>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -110,6 +118,8 @@ CPU4: cpu@400 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x400>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_400>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 1>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -124,6 +134,8 @@ CPU5: cpu@500 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x500>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_500>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 1>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -138,6 +150,8 @@ CPU6: cpu@600 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x600>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_600>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 1>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -152,6 +166,8 @@ CPU7: cpu@700 {
> > > > >  			compatible = "qcom,kryo485";
> > > > >  			reg = <0x0 0x700>;
> > > > >  			enable-method = "psci";
> > > > > +			cpu-idle-states = <&BIG_CPU_SLEEP_0
> > > > > +					   &CLUSTER_SLEEP_0>;
> > > > >  			next-level-cache = <&L2_700>;
> > > > >  			qcom,freq-domain = <&cpufreq_hw 2>;
> > > > >  			#cooling-cells = <2>;
> > > > > @@ -196,6 +212,40 @@ core7 {
> > > > >  				};
> > > > >  			};
> > > > >  		};
> > > > > +
> > > > > +		idle-states {
> > > > > +			entry-method = "psci";
> > > > > +
> > > > > +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > > > > +				compatible = "arm,idle-state";
> > > > > +				idle-state-name = "little-rail-power-collapse";
> > > > > +				arm,psci-suspend-param = <0x40000004>;
> > > > > +				entry-latency-us = <355>;
> > > > > +				exit-latency-us = <909>;
> > > > > +				min-residency-us = <3934>;
> > > > > +				local-timer-stop;
> > > > > +			};
> > > > > +
> > > > > +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> > > > > +				compatible = "arm,idle-state";
> > > > > +				idle-state-name = "big-rail-power-collapse";
> > > > > +				arm,psci-suspend-param = <0x40000004>;
> > > > > +				entry-latency-us = <241>;
> > > > > +				exit-latency-us = <1461>;
> > > > > +				min-residency-us = <4488>;
> > > > > +				local-timer-stop;
> > > > > +			};
> > > > > +
> > > > > +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > > > > +				compatible = "arm,idle-state";
> > > > > +				idle-state-name = "cluster-power-collapse";
> > > > > +				arm,psci-suspend-param = <0x400000F4>;
> > > > 
> > > > How come this is 0xf4?
> > > > 
> > > > Isn't downstream saying that this should be either 0x1 << 4 or 0xc24 <<
> > > > 4, depending on how deep we want to go? Could we at least mention why
> > > > this is 0xf4?
> > > 
> > > I'm not sure where 0x400000F4 originally came from. I noticed that
> > > sdm845 uses the same 0xc24 mode in downstream, but Qualcomm used
> > > 0x400000F4 in mainline.
> > > 
> > > I did some testing on a downstream kernel and found that the real value
> > > it uses on sm8150 is 0x4100c244, but the idle state doesn't work at all
> > > if I use the same value on mainline. The logic appears to be the same in
> > > the downstream sdm845 kernel. Maybe it has to do with how downstream has
> > > "notify RPM" before attempting to enter the idle state?
> > > 
> > > In downstream, the final PSCI value is calculated as the sum of:
> > > 
> > > 1. (cluster-mode & cluster-mode-mask) << cluster-mode-shift = (0xc24 & 0xfff) << 4 = 0xc240
> > > 2. (is-reset << 30) = 0x40000000
> > > 3. (affinity level & 0x3) << 24 = 0x1000000
> > > 4. (cpu-mode) = 0x4
> > > 
> > > so 0xc240 + 0x40000000 + 0x1000000 + 0x4 = 0x4100c244.
> > > 
> > > It's also possible that the problem comes from the cluster idle state
> > > needing all CPUs in the cluster to be asleep (as far as I know), since
> > > it doesn't look like mainline handles that.
> > > 
> > 
> > Thanks for the explanation. I believe we have the code in place to do
> > OSI sleep using the "psci domain cpuidle" driver, but I'm not entirely
> > sure about the details about it - perhaps it's just a matter of wiring
> > it all up(?).
> > 
> > Let's go with your current patches and then swing back to this once
> > we've figured out the remaining details.
> 
> Following your hint, I was able to get cluster idle working using power
> domain idle states. The cluster idle state is now successfully using the
> same value as downstream with no apparent issues, and individual CPU
> idle states are still working. Time spent in the cluster idle state
> increases when and only when all CPUs are idle, which matches the
> expected behavior.
> 

Really interesting, thanks for pursuing this!

> Should I send a separate patch for it or revise this series? It might be
> helpful for future reference to keep a record of how to convert the
> current 0xf4 cluster states on modern Qualcomm SoCs in the commit
> history.
> 

I did go ahead and merge this series last week, and I like the idea of
"documenting" how the difference - so please send this as a separate
patch(es).

Thanks,
Bjorn

> >
> > Thanks,
> > Bjorn
> > 
> > > > 
> > > > Regards,
> > > > Bjorn
> > > > 
> > > > > +				entry-latency-us = <3263>;
> > > > > +				exit-latency-us = <6562>;
> > > > > +				min-residency-us = <9987>;
> > > > > +				local-timer-stop;
> > > > > +			};
> > > > > +		};
> > > > >  	};
> > > > >  
> > > > >  	firmware {
> > > > > -- 
> > > > > 2.29.2
> > > > > 
> > > >
> >
