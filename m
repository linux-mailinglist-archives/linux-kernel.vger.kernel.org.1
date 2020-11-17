Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC82B58F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKQEtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKQEtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:49:16 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC86C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:49:14 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so9586246pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jf2aIjShD4iVmybDcbPAalYnkGJJs6/Mleod0uBw2fY=;
        b=fNNmCb/RMfl+hVapIhliNSCowc/j3+etgB5FbEZj64xErDnZJ2c12LUB04PQGqwT0v
         +UcGieBgB0gK0q3dNsIGgpi9ckbZfg4mf0PJf4TZ6si2R/TDvzH7NTBPgEYj4KeCJxb+
         ogNwHjpKAdYqnQGMu+ZsV5pR+mSHrx2o+Sxlw9AinlfrHhSU0aHOXSnTGXwFMCEQe0wO
         VFcvrEd5T53igZeUk7GOcaRrLH+0VkZ1uwyoGY5owIzno3s/h9+VZPw+icGqITliND+b
         Ic9iNRsNmgmcnaObzvNtiCtYSmOfjPsWd4WsxcHfW2bEvgfiLc369iH+mNV9HSyRHEt0
         Y9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jf2aIjShD4iVmybDcbPAalYnkGJJs6/Mleod0uBw2fY=;
        b=KsiJ01WvW1zLZ4OoTwIfgfAnzAbx1yTtntTNZqewdOP7yYQBP9rpIRCpOPVJRhsuGU
         qA+L5AxzFyMDRE8102OldvcyxtVSEZijQ0FfLczvqZbnALKu+94tLjbaiitHbXIGNmuX
         TkJV+kGBx0wjS5I1AqtI/X6DjIHuV69DWvrZ9FbzUayhgLX8cWJ8FU1Tbmj4AJQk9KnE
         VnaOp2f9E7cOeRV+7VREzuaC98ZM2HO21kOw7nBmo+qy/QKF2qqWA8bg0ZB3mZQ0FClr
         9/ntFhBDkoEIhQJgZxeZ5jIZe1GPhYpwzw4iYYZiWSf9rFK/pSnUXu9uOLHy2FGVtuzp
         KdsQ==
X-Gm-Message-State: AOAM5329lvcn6clMEnSk5AFoFzkV1P5xgepcr+J2TjF4Jn8qrxGxkgAn
        gkCrQTJozPNh7H46Bh2yMg5hoQ==
X-Google-Smtp-Source: ABdhPJyJDEC5MnNQUCPJkJoEmtBD+pIRYGL2cGyoD+1qZHidQRQsal2JsGoVIIOS6nv4xXksggE3Fg==
X-Received: by 2002:a17:902:be07:b029:d8:afa1:3d76 with SMTP id r7-20020a170902be07b02900d8afa13d76mr16093356pls.14.1605588554383;
        Mon, 16 Nov 2020 20:49:14 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id c15sm1257489pjc.43.2020.11.16.20.49.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 20:49:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:19:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20201117044911.hzmmkasmgpnaxu3m@vireshk-i7>
References: <20201116181356.804590-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116181356.804590-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 18:13, Sudeep Holla wrote:
> The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> implementations where untrusted software had direct access to clock and
> voltage hardware controls. In this attack, the malicious software was able to
> place the platform into unsafe overclocked or undervolted configurations. Such
> configurations then enabled the injection of predictable faults to reveal
> secrets.
> 
> Many Arm-based systems used to or still use voltage regulator and clock
> frameworks in the kernel. These frameworks allow callers to independently
> manipulate frequency and voltage settings. Such implementations can render
> systems susceptible to this form of attack.
> 
> Attacks such as CLKSCREW are now being mitigated by not having direct and
> independent control of clock and voltage in the kernel and moving that
> control to a trusted entity, such as the SCP firmware or secure world
> firmware/software which are to perform sanity checking on the requested
> performance levels, thereby preventing any attempted malicious programming.
> 
> With the advent of such an abstraction, there is a need to replace the
> generic clock and regulator bindings used by such devices with a generic
> performance domains bindings.
> 
> [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../bindings/dvfs/performance-domain.yaml     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
