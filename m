Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DA1B7F50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgDXTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDXTrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:47:10 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F07C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AZVuLiH3p+8wQZZcoxt6nt2TjZafm2VyUW4d5EZtuyA=; b=ZrErCh9xM1GG9lwK98VsvNvjCn
        +YR28ar6kY/ehntc3I8eCfPmQQgnYdqrjnGV2Cc76lfcMFr8K2R74t7zWrbESWP32Q68ibmkGXnSX
        7SFJo4kDXtwV4QOoQaylH0uekmSLHG/GMv4hEpKcRzNrlPaBba9N1AU9AUdEnK1upC0I=;
Received: from p200300ccff054f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:4f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jS4Hy-0006Fb-Ih; Fri, 24 Apr 2020 21:47:06 +0200
Date:   Fri, 24 Apr 2020 21:47:05 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, festevam@gmail.com
Subject: Re: [PATCH] dts: ARM: e60k02: add interrupt for PMIC
Message-ID: <20200424214705.0a6bf5cc@aktux>
In-Reply-To: <20200329104250.15194-1-andreas@kemnade.info>
References: <20200329104250.15194-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Regards,
Andreas

On Sun, 29 Mar 2020 12:42:50 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Since the PMIC driver now has IRQ handling, add the GPIO to
> listen to things like RTC alarm or ADC conversion completion.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> The corresponding property is added to the bindings documentation in
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-iio-rtc-5.7
>  arch/arm/boot/dts/e60k02.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
> index ce50c4dc6f2a..3af1ab4458ef 100644
> --- a/arch/arm/boot/dts/e60k02.dtsi
> +++ b/arch/arm/boot/dts/e60k02.dtsi
> @@ -117,6 +117,8 @@
>  	ricoh619: pmic@32 {
>  		compatible = "ricoh,rc5t619";
>  		reg = <0x32>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>  		system-power-controller;
>  
>  		regulators {

