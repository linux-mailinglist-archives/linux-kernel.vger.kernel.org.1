Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97F621AF01
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 07:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgGJFu7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jul 2020 01:50:59 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:47040 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:50:58 -0400
Received: by mail-ej1-f66.google.com with SMTP id p20so4711769ejd.13;
        Thu, 09 Jul 2020 22:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+u1OHrAwg2ADOYj8eKqxxAeJyg8VpcWqOk6VYKf9Pe0=;
        b=p+7gvRcfDTbyG9iBEUtekIm7c6VsUy723mTL0YPEZKWw3xXAIiZdhUioWjaAUQM3JT
         7ob5RX36TvmdihqgRJG67wba6h4E9508COTO2/jz06YQG5qvdM5pRboWw89fC6fnrfdf
         Im2NDfeR092AfUrN5B/oOvlvSdZwrOf+GcDOWtfhtIyyuxyB0Hmd0FyI0cL9N1JaFGQX
         oXTlnsLc1b5snnSxdTXZ0y/tP0bwHBrgYagu025lb0a+T1m/RNN09zNCDbQeanEjdU/C
         yozujWyq3V6hZp9tWimqo3TRHo3sHZGkdRwI9U9vvxymHXV8iVCexa1wC+pQLi5Ba3T9
         vAWw==
X-Gm-Message-State: AOAM533YGebPzVft1MWQN+0tDMPWFy0jbYJdJyfrna5QY/4LH/qCgML7
        XH+1oJXjpi/gIpS0EewMSxOMxTe+W++p6uo4weZIFg==
X-Google-Smtp-Source: ABdhPJxVJGlTZDIkCwHA5tcAx08F4LWdkqqzYqCHatLbiqIjCZCq6A5Nf1ENDfSNGBR8AJl8z4zhu0J8VFCKqk81R4w=
X-Received: by 2002:a17:906:284e:: with SMTP id s14mr58740672ejc.498.1594360256541;
 Thu, 09 Jul 2020 22:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080613.3955-1-krzk@kernel.org>
In-Reply-To: <20200626080613.3955-1-krzk@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Fri, 10 Jul 2020 17:50:45 +1200
Message-ID: <CAGsJ_4xoLj_VbxZ8BXFmwR819Ct0qd=6XQnqgj=mmzF0Ja8u7A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: prima: Align L2 cache-controller nodename with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> 于2020年6月26日周五 下午8:06写道：
>
> Fix dtschema validator warnings like:
>     l2-cache-controller@80040000: $nodename:0:
>         'l2-cache-controller@80040000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  arch/arm/boot/dts/prima2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 9c7b46b90c3c..7d3d93c22ed9 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -50,7 +50,7 @@
>                 #size-cells = <1>;
>                 ranges = <0x40000000 0x40000000 0x80000000>;
>
> -               l2-cache-controller@80040000 {
> +               cache-controller@80040000 {
>                         compatible = "arm,pl310-cache";
>                         reg = <0x80040000 0x1000>;
>                         interrupts = <59>;
> --
> 2.17.1
>
