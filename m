Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D520F76C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbgF3Ol7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 10:41:59 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43597 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgF3Ol6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:41:58 -0400
Received: by mail-il1-f194.google.com with SMTP id i18so17927754ilk.10;
        Tue, 30 Jun 2020 07:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWuxKgFISxi6aFfeR/+m+AVV5qQPW/Z25bWRDG1SOUI=;
        b=ZFq36GFT7FM4ZJWVj4frRip+jV2roPnkAgeIQCuQ7BrVRWvdgeavALjQhRw6DiU3mN
         ojd0LenycAgtSt38p7ZzuZXuGbw7nJdfpkXeeev2ZFlH6DyNI8voxFepiwy453bcm+v1
         9DzDXWpBE3QwtzDov0rOZAyaCoRsNp7hO3xtDQ/ODE5Yezfy9FFjyswJetIhE468ryr+
         xUst/RLAI3udghijpNipnFIxXkhZsEJrwGXydEYKICT4G0keiG8hFaFCqPFOuBhH9v89
         scG8v6ToI3BzpsJqGAdHdEo6FPY5Al6Wt+61aRRO8jNWxCTcha3wt7fA8yiJslUYTL4t
         mWVA==
X-Gm-Message-State: AOAM530xbf2l8LMhjYh7BSi9am5f0fvxrP4fYa35IK3DYjZkBWP+2ZZZ
        OUuXqNejEyljSELoJB126p/bz+CN6w==
X-Google-Smtp-Source: ABdhPJxE47qO7YrcebiWxKhvPw21hhdjjh01IjgPQEKOUjWeylfnM28WpmFZCx02yUwlNgDM/HorbQ==
X-Received: by 2002:a05:6e02:f87:: with SMTP id v7mr2859156ilo.251.1593528116254;
        Tue, 30 Jun 2020 07:41:56 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id t21sm1572808ioc.0.2020.06.30.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:41:55 -0700 (PDT)
Received: (nullmailer pid 573635 invoked by uid 1000);
        Tue, 30 Jun 2020 14:41:54 -0000
Date:   Tue, 30 Jun 2020 08:41:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, j-keerthy@ti.com, robh+dt@kernel.org,
        amit.kucheria@verdurent.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: k3: Fix the reg property
Message-ID: <20200630144154.GA573585@bogus>
References: <20200630122527.28640-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630122527.28640-1-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 09:25:27 -0300, Fabio Estevam wrote:
> Adjust the reg property to fix the following warning seen with
> 'make dt_binding_check':
> 
> Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml: example-0: thermal@42050000:reg:0: [0, 1107623936, 0, 604] is too long
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
