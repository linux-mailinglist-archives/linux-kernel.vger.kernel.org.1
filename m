Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EAA2F4E77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbhAMPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:24:31 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43321 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbhAMPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:24:30 -0500
Received: by mail-oi1-f172.google.com with SMTP id q25so2447343oij.10;
        Wed, 13 Jan 2021 07:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=inHtYKeqXgYpC8rM4LtuUVX9gUWdNh37ogYQAnlVxao=;
        b=liQf3wqOM6r8EGVwnMRJOqcGzeRhwKeRL+iHrgRJj8AqUgXYvVuoKHb/n7SdBX63td
         FbNY6HqZVAu1FOQnevW+t61vVGWKCgs5We3pxg6vSovRqTeyi4OCsDNocRvL4+wvIfWw
         wOy3a+duQ83iFt4ovqqwC8ftV8QV/wR6AkjRBA3/CexaGFtTaOMING4lCrqUmaUG08jI
         zlny0juRWx/3aJNHBiw/xnjXGCrXYfiLIZjYp6b6enMzo+GQiQp8y3yRLBhjF4t6KPer
         wu6PIOweeS3iF/Pivbd2kB1GRhbD5+tIKwYAjLDdzF7aMCBLEbXNmJ/XIorLZaIXD3sv
         SRbg==
X-Gm-Message-State: AOAM531gYhjy4xKIXIbXmkz5iYtD4uf5+xUh30UE0CBm/rpmEXU+i+TM
        1N8I2Up5Dnp53WHk7stEFA==
X-Google-Smtp-Source: ABdhPJzd1ySPWvl889sZ1jrIgHKLQZQAXILq8FLOZq8TIZlcQwL6CFNeow/7i5b5fi3xDsxIiujvtg==
X-Received: by 2002:a05:6808:148:: with SMTP id h8mr1558981oie.10.1610551429786;
        Wed, 13 Jan 2021 07:23:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w5sm462062oow.7.2021.01.13.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:23:48 -0800 (PST)
Received: (nullmailer pid 2472492 invoked by uid 1000);
        Wed, 13 Jan 2021 15:23:47 -0000
Date:   Wed, 13 Jan 2021 09:23:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>, openbmc@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] dt-bindings: timer: nuvoton: Clarify that interrupt
 of timer 0 should be specified
Message-ID: <20210113152347.GA2472428@robh.at.kernel.org>
References: <20210108163004.492649-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210108163004.492649-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 17:30:04 +0100, Jonathan Neuschäfer wrote:
> The NPCM750 Timer/Watchdog Controller has multiple interrupt lines,
> connected to multiple timers. The driver uses timer 0 for timer
> interrupts, so the interrupt line corresponding to timer 0 should be
> specified in DT.
> 
> I removed the mention of "flags for falling edge", because the timer
> controller uses high-level interrupts rather than falling-edge
> interrupts, and whether flags should be specified is up the interrupt
> controller's DT binding.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Fix a typo in the word "watchdog"
> ---
>  .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt        | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
