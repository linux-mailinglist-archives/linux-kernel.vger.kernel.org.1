Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E63285E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:32:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 04:32:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so2413917ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UUAtMhUEk/jz98adLLh/kvHWU+87rtZfg/cfL1Bdfv4=;
        b=risRhOIo118pkONLYVu23luhqGeB5jDgqxnxSf8q8nSEGVRzYNHLnpk2xI4o3/akUU
         9iJ6UYN7xRVB6xO1iGDKwIVdnFC9+YmYxobpCvE1XSqJ+cvYrf+pTLuXxhKmXlWLlprA
         TTdRdlIfq520FIItzRxnEZWOQCMPmdw3K35VxMPxnCsDuXYDb9YGLQZhanD4WxwvJdHi
         mA7xkitMJo0Y4VP220+O5aYm7egOe1ATbMWxcjquK+uIBEYsd1S/wc51/Svfj0MgD2Ha
         fsebz/VLQU6nBgdx+OaKjCQScS41zAuJ2om5xUSZAOts9h6bfEIXRCCN+qU9UifNURbj
         aI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UUAtMhUEk/jz98adLLh/kvHWU+87rtZfg/cfL1Bdfv4=;
        b=M3f2tVmX0rPRei37lxY4GlpfTHnlqXDljuNTOTH08R7x5xSYZxXUzW6vE0Zj6CSN+m
         1DcXMsjHi5PabC2GxbYpldhpin1QtC5q8NJaeuYoZHbMpCVz9KtC0WP91aztdJG+SZu3
         6OD4z2bW6NsOaMx5YoKblKgVSA/26B/PYLlSCpAa3gcAVk8IUiI7Z9ad0cVugogbqv4k
         SapnOYpXLbETmVHRHN7oX4g4ETS+4uIbd7R8QxRLTSUJAatS3xSx9JCOeBmxgdZkT8qq
         wvX/5K17PaKmzbGFmMmzf5dyOw+uIynUFnjfDoSobmkpoB2KdLvOcvXe2O3YKQmuTin1
         KzVA==
X-Gm-Message-State: AOAM531Jivx9aJ+lo5HYc6orDGFeAIwpy0nihs40TQG52GoGnx0hWaBi
        MhQP6lcimyExwJl/j9mXRiRFUA==
X-Google-Smtp-Source: ABdhPJwevDhhFb3fbE81queKzB5zgztjuRr7Aq9efuwPUXqmp2hDPvc+PUbX3Xnkw0p65sb/EPunjQ==
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr2859064ejb.91.1602070370261;
        Wed, 07 Oct 2020 04:32:50 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id d59sm1247111edd.74.2020.10.07.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 04:32:49 -0700 (PDT)
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com> <87o8lf74j5.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brad Harper <bjharper@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <87o8lf74j5.fsf@nanos.tec.linutronix.de>
Date:   Wed, 07 Oct 2020 13:32:47 +0200
Message-ID: <1jy2ki1db4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 06 Oct 2020 at 17:33, Thomas Gleixner <tglx@linutronix.de> wrote:

> Brad,
>
> On Wed, Oct 07 2020 at 00:45, Brad Harper wrote:
>> I'm happy to test anything on a range of amlogic hardware with standard 
>> / rt and  multiple mmc devices.  Ill test Jerome's patch in next 24 
>> hours to report the results.
>
> please do not top-post and trim your replies.
>
>> On 6/10/2020 11:43 pm, Thomas Gleixner wrote:
>>>       We rather should make interrupts which need to have their primary
>>>       handler in hard interrupt context to set IRQF_NO_THREAD. That
>>>       should at the same time confirm that the primary handler is RT
>>>       safe.
>>>
>>>       Let me stare at the core code and the actual usage sites some more.
>
> So there are a few nasties in there and I faintly remember that there
> was an assumption that interrupts which are requested with both a
> primary and a secondary handler should quiesce the device interrupt in
> the primary handler if needed. OTOH, this also enforces that the primary
> handler is RT safe, which is after a quick scan of all the usage sites
> not a given and quite some of the users rely on IRQF_ONESHOT.
>
> The below untested patch should cure the problem and keep the interrupt
> line masked if requested with IRQF_ONESHOT.
>

With arm64 defconfig on Khadas vim3, no obvious regression. Looks good.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

I did not test with RT. Brad, Could you let us know is Thomas's patch
works for you ? Thx
