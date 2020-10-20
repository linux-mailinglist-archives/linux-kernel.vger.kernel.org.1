Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618A6293B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406034AbgJTM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:28:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405824AbgJTM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:28:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21so1583430wml.3;
        Tue, 20 Oct 2020 05:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kvJHau+1C9xhcluOnyoXN8jpq+NvyZRN/o42l/UWrDk=;
        b=VwNoqilZNttO9UmxadgY1vKsP4J58FfKcC45jRb/YXxff4O6kGe73C5BDctnWKyJ53
         j92TF5n6ekmY43p8mQ5DPSxuIsoEWzRGrOUh/duhdcttom++wpxeK9rJMy6iTBpgyAmw
         O9DfTU6YEjG38jNtjxewa99BrsQMSpiJttZLvYDs2m3kp8UwsQ8qawr9IfpXfAi0/VQR
         KTdG6VWXCartsQcnzJ0U6edjazH1KqreIMDVNAzJqotosxMiXKlr/T2griTLydsTaeB9
         4vOL9qlvyOXhoUFKNCdN4UtKUNF2P7dl+NFHwF6sNBrwygbsrcba6jyeqtQdh+xKGgHD
         ocDw==
X-Gm-Message-State: AOAM531BkaAo/lMfSHI9PuQgxm/abCCpBYNLlmPaHqXceGktxcXY2MQl
        FP/apa7dg7R3q/P1btd+icw=
X-Google-Smtp-Source: ABdhPJyqzK6f7o49PGw5jayiMHUZf8ORQteJpFpXxf27XX0m2oft/vpRRGPdnf2xRppT9TsQmeiMWA==
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr2548813wmm.115.1603196885133;
        Tue, 20 Oct 2020 05:28:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id y5sm2889797wrw.52.2020.10.20.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:28:03 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:28:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/29] usb: dwc3: Discard synopsys,dwc3 compatibility
 string
Message-ID: <20201020122801.GB126891@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VfS-f39uyb7GcFXPzgZLktWmXTESv798LvKY3-+-GQPrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VfS-f39uyb7GcFXPzgZLktWmXTESv798LvKY3-+-GQPrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:15:06PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 20, 2020 at 3:02 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
> > Discard a DW USB3 compatible string with the deprecated prefix seeing
> > one isn't used by any dts file anymore.
> 
> I'm afraid it's no go.
> It's an ABI from the moment when the driver started supporting this
> compatible string.

Exactly.

Please mark the compatible as deprecated in bindings, correct the DTSes
and optionally after one or two years (or any time later) remove the
support for deprecated bindings.

Best regards,
Krzysztof

