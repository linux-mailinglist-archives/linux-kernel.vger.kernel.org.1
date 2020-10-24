Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBA297EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764552AbgJXVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763077AbgJXVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 17:09:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E4FC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 14:09:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o14so4716620otj.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YmDiLIstb4K9D6S9jTZohBVgF8FGdooIv9+LYA/HqZ8=;
        b=g6EQ9oF5oYzdppaDHsTe5WnO+lDrZN/zWvEhTjNNdfjQzXwECsPBR84sHnIm/244ut
         dF7BxNWOYAGD64UZXpyWwi5tZf4PV7OB53GkFlBfRUWAJyFmzJZyfdoCaxjGrPELrina
         H/vY2S3CtFCb9JBbwNw6IiFBr6E9pFM7R3IoBq0aqsyyJLeMLK2HBo7w3o5TnARn8O34
         6BSpZOQiKpPajrstnRyJ/vRjMYyR3oAlZJEZhNfWqc9LN4mNp+Eb/dWkkuQkYa8pKNxZ
         dWQUPxPp2+jHXo1RNjQFImYOTim5gbxf8NVD/Hjw70LfpnqLMV7t2IhF0AR9KEQqvMjB
         PqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmDiLIstb4K9D6S9jTZohBVgF8FGdooIv9+LYA/HqZ8=;
        b=aN6x28a0VgzLbYC22/vp0CX8bTd16AT9cqlxTeUzqRfFWBfR1lCuNUHy869Ma9eXSP
         MHzSRMHbXKFlg0vel8XZOWLpQR/hc0Nr+v9Vn2a1a4lTuI+00/R98RrzMXQgH29dDGKf
         S+c9FALEIkQwckZBhYXsCGrZAbT+6h8mqJRYApXbS4L6IkkIPo4WaRBnF3/r0LMz2Ie4
         7LGmQtPbWx8izH4AbW1UzaRkyeAJeRbYj6Bqe6xzb37vtjIDGvAwC5KQ7Mkzt62y1+r1
         gAPbA0eFY3HgdF1iO8VsDUQlJQN7TzN+tyEEjSs2wgBUr5oeIprve/FfJgo7TZxSf3LJ
         iRTw==
X-Gm-Message-State: AOAM532KDIt3YsqXB7Sh/rmD5A8FYWCOl17dobwSJOg59l2PPor5z8y1
        YhEdMSQxrpqThMEvYbd4ucxRng==
X-Google-Smtp-Source: ABdhPJxQRzlCmBugYgNRY1i0fnNciLHOU5Jv0qRUCTs0LGm43BVaaCoYtHPqErO8Ane2O+9a+MPT2A==
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr6071668ots.90.1603573753565;
        Sat, 24 Oct 2020 14:09:13 -0700 (PDT)
Received: from arch-xps.localdomain ([209.221.58.71])
        by smtp.gmail.com with ESMTPSA id l62sm1670268oif.18.2020.10.24.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 14:09:12 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:09:10 -0600
From:   Brigham Campbell <me@brighamcampbell.com>
To:     robh+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alchark@gmail.com
Subject: Re: [PATCH] ARM: dts: Add empty "chosen" node to WM8xxx device trees
Message-ID: <20201024210910.GA27207@arch-xps.localdomain>
References: <20201009165742.GA35334@arch-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009165742.GA35334@arch-xps.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:57:42AM -0600, Brigham Campbell wrote:
> The following patch is a bug fix for an issue introduced by commit
> abe60a3a7afb4058278864aa18c5faf62094c11a which removed the deprecated
> device tree skeletons.
> 
> For the devices corresponding to these device trees, an updated version
> of U-Boot is not available. Therefore, we must append DTBs to the kernel
> instead of counting on the bootloader to load one into memory and pass
> the pointer to the kernel during init.
> 
> For some reason, when this method of appending DTBs to the kernel is
> used with any revision after abe60a3a7, the DTB seems to load correctly,
> but the kernel parameters aren't loaded correctly. Regardless of whether
> the kernel parameters are built into the kernel or passed in via U-Boot,
> they simply aren't registered by the running kernel.
> 
> Adding an empty "chosen" node to the device tree fixes this issue. I've
> tested this with a WM8650-based laptop. Regrettably, I'd be lying if I
> said that I know exactly why this fixes the problem. However, I know
> that this solution works. I'm happy to hear suggestions/ridicule
> regarding these changes.
> 
> Finally, I have my suspicions that the WM8xxx series devices aren't the
> only ones affected by this issue. I think this solution, if acceptable,
> could be applied to other devices which may or may not be having issues
> related to appended DTBs and kernel parameters. Perhaps other devices
> which commit abe60a3a7 changed?
> 
> This is my first patch submission to the Linux kernel, so please tear it
> apart. Let me know what I've done incorrectly. And thanks, Alexey, for
> helping me along. I have much to learn and I wouldn't have made it half
> as far without his patience.
> 
> Thanks,
> Brigham Campbell
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> 
> ---
>  arch/arm/boot/dts/wm8505.dtsi | 2 ++
>  arch/arm/boot/dts/wm8650.dtsi | 2 ++
>  arch/arm/boot/dts/wm8850.dtsi | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
> index 168cd12b07bc..2b814b48b458 100644
> --- a/arch/arm/boot/dts/wm8505.dtsi
> +++ b/arch/arm/boot/dts/wm8505.dtsi
> @@ -10,6 +10,8 @@ / {
>  	#size-cells = <1>;
>  	compatible = "wm,wm8505";
>  
> +	chosen {};
> +
>  	cpus {
>  		#address-cells = <0>;
>  		#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
> index bc057b6f7d16..a68c82c8035e 100644
> --- a/arch/arm/boot/dts/wm8650.dtsi
> +++ b/arch/arm/boot/dts/wm8650.dtsi
> @@ -10,6 +10,8 @@ / {
>  	#size-cells = <1>;
>  	compatible = "wm,wm8650";
>  
> +	chosen {};
> +
>  	cpus {
>  		#address-cells = <0>;
>  		#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
> index 65c9271050e6..c864883ae777 100644
> --- a/arch/arm/boot/dts/wm8850.dtsi
> +++ b/arch/arm/boot/dts/wm8850.dtsi
> @@ -10,6 +10,8 @@ / {
>  	#size-cells = <1>;
>  	compatible = "wm,wm8850";
>  
> +	chosen {};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.28.0
> 

Sorry to generate another notification, but I don't believe I've
recieved a response on this patch in the ~two weeks it's been up. Did I
format something incorrectly or have I sent it to the wrong addresses?
Maybe the relevant maintainer has just been busy?

Thanks,
Brigham Campbell
