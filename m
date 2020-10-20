Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3317D293B05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394293AbgJTMOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394277AbgJTMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:14:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C299C061755;
        Tue, 20 Oct 2020 05:14:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hk7so877646pjb.2;
        Tue, 20 Oct 2020 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF5K4AQBC58Q99HaXJmQx/bo3MhAOG0onhbqD6ipgo8=;
        b=CSt9eRfLKdp2mWyuUdD4yj7WhC97MurvVuapsPYp8XyjP4SfY/1wP9wIv5aGZYb1qP
         08Qpm1zmwKty1JPEeiULtKgrN245S9GuawGgPkw93x8eqyV0k8noM7FV57P+w8g/Q/55
         04e1RBKH6If+IFWe4KTIYzPp7jEhVtvzkURSgQJSHbundDKYBMMzHKVhNkbNyUqvUQXY
         aUd5bnCN+y3S+1sDY6W5AHSvEPceZ3h8ObboIIuqHtc59X+EKEEhlOPjgVqMT11BL+VS
         0X1k1ORytLidYNgIBDmoF3Wn2J/8VdcnIfNJWooTsnkcQAN8qlODZN+mAFst/W06jOdl
         rVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF5K4AQBC58Q99HaXJmQx/bo3MhAOG0onhbqD6ipgo8=;
        b=L5umFvs9N0WD9BSr8A8Vp0333032JNZCfwVI/lhIYQ4JbHIJADnOvLQJsUd1JormE8
         84mAEqT56n0ofBrr/CR28BJ0jKVsZeUQ042zsIeDYo5o7ySIX4ndRBzlJ6LGzlOQlIPg
         lDwUmiORh5rD1A1J5J1pTo/ly3kWaCYlLmocRpnM0qySMRmIQ9muGKoxC8EwRleKA99G
         9kxbCqCDMcjHLArYjIYg3wg3qCfDwNu3vFWbR+/ra50+IeQKo73y4eXIykuM2c6rr9gH
         ELqXoythLkh3cF680gRtAOHiEXEN2rzYpBOi1nx7Y86ENHqEcT2ISiQ73tUfEeD6WKBm
         vUig==
X-Gm-Message-State: AOAM532DbOctC/X2OsDhcrDCqwT0jJFsr2RpOV8B+lEgfk0kcWq8hhkM
        T0FifXTdDoRXBbd5ilNGjLDQF/GDJjrBHyXNcFPIPrejfKqT4g==
X-Google-Smtp-Source: ABdhPJw6c0Coi0xFClU40U2tBHv6ep6vZNU0tRqBiec7/VP84yZ8EjsvCffmAzLHXj+Ng2mdC8BXdmKDSDxZQp9t2ik=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr2615753pjb.228.1603196057093;
 Tue, 20 Oct 2020 05:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru> <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Oct 2020 15:15:06 +0300
Message-ID: <CAHp75VfS-f39uyb7GcFXPzgZLktWmXTESv798LvKY3-+-GQPrw@mail.gmail.com>
Subject: Re: [PATCH 01/29] usb: dwc3: Discard synopsys,dwc3 compatibility string
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 3:02 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
> Discard a DW USB3 compatible string with the deprecated prefix seeing
> one isn't used by any dts file anymore.

I'm afraid it's no go.
It's an ABI from the moment when the driver started supporting this
compatible string.

-- 
With Best Regards,
Andy Shevchenko
