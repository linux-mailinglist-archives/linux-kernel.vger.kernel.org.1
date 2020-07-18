Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35CD2249D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGRI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgGRI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:29:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100EC0619D4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:29:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so6495201pfn.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dPX5I2zvoaIfMrTJOaEVmZ8AJ80iRBsKVksO1GxJCNo=;
        b=ZzHLgOEL6rfH/FrYghVSfVEQktV2G0Ir7o5GkPsQTPiSTXfAartacdCWERPApI4F4h
         z/xNML4mDKErL7wVRlTVtBRcspOz9kDbKiYzv/yyiLNLwgvPEJoSN37amJBWnAxRy9V2
         9hVGDkdUX8hOdVMJjPWlhR6l8UlkjZKc+fziFbkc/yru2iiCKqBHpaSOUK5RnZW2S/yn
         Pn8cacEL/2XGSr+kepi8HbhO+UN1PagUSVAQCnGrKN9SjBqwzxGDJoQQDa/+JnKN6Shy
         o1suzUkzCeetU7bWUPKA6K7RuhGSovE+CT7GHBU6X1HJ4Oh0B0JzqvprdhMf8kXfmmJ2
         BA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPX5I2zvoaIfMrTJOaEVmZ8AJ80iRBsKVksO1GxJCNo=;
        b=AiJY1wIDOlP/I1Q3/Xgr886AueS8YouF8A+nXVU/536sHPQzkaZWMWc/Xmq3AeLHyo
         kRNzys9it8nVziiqns4Kx68g3LEf/rQ+jNSFYn2ECI0CXdIbvqc79iCBxCA6eXHsuFct
         TFlbIwAdC+8qHKk+fRd81IHlKr++c+uUDhVXiKn30DeOgMfXgUrHiuVrff57E1QPCQX4
         4dCU1DVUsuQR5KjkMvC605zBmkCInXjIo6ONKXoQJY9NezNJaibjLTKsZwmXFS47NVun
         sHNIucB5A/tU3/Sm/9NuPiVtYyNselHKNDsJ+mjcxOrZqcsDcz2FtgR2qeXhsrQs0RX4
         7bdA==
X-Gm-Message-State: AOAM531R5LQF7SdGpml6ZLTo+5aGEGkRtMeET1m5Tffow30nt/N7YhQi
        eVvq22XTCA93hgea1/FAqBAiQw==
X-Google-Smtp-Source: ABdhPJxpkjlVoi1K6zt3TxppMxnpJwdAYknEnoLeYjpkZ5qIgAHhN1uKddV4rWohLA2QlS4I+GW9GA==
X-Received: by 2002:a65:620e:: with SMTP id d14mr11477128pgv.360.1595060966415;
        Sat, 18 Jul 2020 01:29:26 -0700 (PDT)
Received: from localhost ([223.190.30.182])
        by smtp.gmail.com with ESMTPSA id k100sm4874773pjb.57.2020.07.18.01.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 01:29:25 -0700 (PDT)
Date:   Sat, 18 Jul 2020 13:59:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        mirq-linux@rere.qmqm.pl, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 2/3] arm64: tegra: Add t194 ccplex
 compatible and bpmp property
Message-ID: <20200718082914.ecyngrsoir7j5q6y@vireshk-mac-ubuntu>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-3-git-send-email-sumitg@nvidia.com>
 <20200716123715.GA535268@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716123715.GA535268@ulmo>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-20, 14:37, Thierry Reding wrote:
> On Wed, Jul 15, 2020 at 07:01:24PM +0530, Sumit Gupta wrote:
> > On Tegra194, data on valid operating points for the CPUs needs to be
> > queried from BPMP. In T194, there is no node representing CPU complex.
> > So, add compatible string to the 'cpus' node instead of using dummy
> > node to bind cpufreq driver. Also, add reference to the BPMP instance
> > for the CPU complex.
> > 
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Looks like the DT bindings are now done so I've applied this for v5.9.
> 
> Viresh, are you going to pick up the other patches, or do you want me
> to pick them up and send you a pull request?

Applied the other two patches, Thanks.

-- 
viresh
