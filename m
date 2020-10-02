Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26506281ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbgJBS3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbgJBS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:29:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC278C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:29:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y14so1318606pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=sfHqLZf2nv9SkEaSma+fmeDrDPHstMI9otrw857K/6g=;
        b=csQSw6MRVPHQeqxqB/KwBhjwUrG0QqBbH8d8WC5gdVk08R4lh/91tBrbrelyQrc2E6
         VJsnSVuzqiCc6Ow+ETOxkvMp7ltI4ruJ6gV0XcwyyDubiBajsUpfFDnBAAss4H3Lh2xk
         3YIiFFRjS4YqwgpoReBprCdkYRfUsVrH2FoFfHOrxbFNq9g9Av6an55aQVt85GJDBQR+
         VLMn6rS8xKo0++sVDwiCytVsmyjAUH1zY0sKUJBSxeARERKZlHDk+kYJFKvgeT1Y5lKK
         P6kTe+10uzqyItQUY6OTL56PKGBuMasoAQzRkHlrl1kr8Tuej3+5HhIFqUbPZnFpWZXV
         KgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sfHqLZf2nv9SkEaSma+fmeDrDPHstMI9otrw857K/6g=;
        b=iBmROxt61i8kQGjfv8hrC4pHi+dmIYcDeimpilGATqAhTMLQqB0vjrSb7ohX7HSBjc
         fzjIFYhMXsaqdRSJOfoGppO9C2x7+zeuIjovsehYrOsCqjAfHxIJwQK/xzHasiJx6IXX
         l+hhHIuPItqxtiHLFUNVeFXGfskhF2trmqhE1Ec540mQ74nXwf/eDJrOuP1IWH/lpPhl
         UbPHnd+bKsyhEVvtu2v7EqJSuNxRg42JCqj3s/caiPNEQ0Ijs7sHGwTqOHMzyIxZpGvy
         XEssFHUhgkddEngSvTJRdWzTU8cxOMDQmrrj1Mo/SJo/o/5htzzYdZ43+amr05P1De+g
         +wlQ==
X-Gm-Message-State: AOAM531BLWPhPR6qiOdISKlA/TjAMV3uOiXgRE00aKznD0UkZRJ07wey
        jmCjVvFOAaOwEuLeYIOZ/XC2wg==
X-Google-Smtp-Source: ABdhPJxgJ98K+Rw0bnjUuIFWMdd7exfZq0mIY+TYb59j5UER1wmonXlgj69iPqZXPcg0D0fi70RzSg==
X-Received: by 2002:a63:4854:: with SMTP id x20mr3555150pgk.220.1601663374957;
        Fri, 02 Oct 2020 11:29:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m13sm2497574pfk.103.2020.10.02.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:29:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: Re: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
In-Reply-To: <CAFBinCCrbVzK8A0s-=Q++n4yUFO6+Wm_Ayh_vdxkATJh7oSx1A@mail.gmail.com>
References: <20200815181957.408649-1-martin.blumenstingl@googlemail.com> <159830380185.24712.3464811968459073992.b4-ty@baylibre.com> <CAFBinCCrbVzK8A0s-=Q++n4yUFO6+Wm_Ayh_vdxkATJh7oSx1A@mail.gmail.com>
Date:   Fri, 02 Oct 2020 11:29:33 -0700
Message-ID: <7hlfgomqgi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Mon, Aug 24, 2020 at 11:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
> [...]
>> Applied, thanks!
>>
>> [1/1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
>>       commit: b468412409c0e5752ad3396b147cac563ff8dd3b
> this one still seems to be sitting in the v5.9/fixes branch
> I don't see a reason to rush this, so can you please queue it up for
> v5.10/fixes?

Yes, sorry this one slipped through the cracks.

Kevin
