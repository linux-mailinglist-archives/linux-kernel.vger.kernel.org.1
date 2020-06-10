Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371891F515D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFJJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgFJJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:44:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B7C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:44:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so1654681ljv.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svyjfmEJc3+r5Bull8lSuu/qgDN2rTAndZ5rJi9Ba2o=;
        b=AMgNG3LbXSbZD6eBl2/IEceHF5cilPgFw2K3RxPXAl8WAyTiHclajD38G1Tc2Q7IIL
         JSAl5vPSokAFzuD6dghWzOBP8VQeaIBnEhmG7l6DbIj5XLzYlaKFxl68kpyO7qxTJuch
         Oknbf4oKQ2BxCbsKbeM4DVYh+BL5fS+J3SitSurgrSviegmUdN1RTWASwgL5E7dK3Eea
         ftChCFiQWkpFaq8mqhE2kLdcsDJoZmen1UBhmI1jCJ/cSLyTijZ0xSpCTHcX9e5qpBOV
         KK4npBNbzohL21ccWphgOTo20/ZK6StWglohLHKmhPuVh27p5gBk18RwPFlLeJWaHDQQ
         dH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svyjfmEJc3+r5Bull8lSuu/qgDN2rTAndZ5rJi9Ba2o=;
        b=cGkAxP5GY/Wns/fq9IRKJor+1wQAMV0bf/1gzBiiU0NrrPrU5JBN+eI2PHMkETHQbh
         hua7bbGQVsym1wpWJuhSYn0ambGHeld7Mx11ceG+Owxfezu04VUfdWPmoBsIEh9ZMTX4
         DunGSL8egv/QSfAz7/MS9f5fmyQ8mjWqLol8Fp9oT0zWdqBY/2OVBvZWgSJ527s6lyfC
         Ph/M2yVrR3JWqlhqHRUDmRw33po4jWvKcf0Z+hwO9FgIv80XJAgaVQ5u9lJt0kVDTJeJ
         JQvMEu9N1R6awunWeoyuxUa4ohgqNbbNLgMwT8SdOpxc/9JsQSwMh7KvGAxwgkpckoZ5
         S31A==
X-Gm-Message-State: AOAM533QnaSqi2X+5O23VqJMVv+G6yXXBSW6d0qklDlv1bV43gJqKsHv
        T21SVCm49Nrq2xwLz0DmU95E0KgF0IU+GM0Yh4PqlQ==
X-Google-Smtp-Source: ABdhPJxUjW4GtVDMwGhimJkXUwNvX7Tr9JwCOPxfrbQrulwUS0MDRdszf4lJ44i0EOIMa/Nnos4vHOhpiJdziWPCCqs=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1266313ljz.104.1591782257094;
 Wed, 10 Jun 2020 02:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-3-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-3-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:44:05 +0200
Message-ID: <CACRpkdY4RzgpGg-dCSJet-es39bmC7KNxxCjma_mgjpUzVTvKg@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] power: supply: gpio-charger: Make gpios optional
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> While strongly recommended, not all devices have a gpio to
> detect if the charger is connected. This moves the 'gpios'
> from required to optional section.
>
> This also modifies error handling for the GPIO a bit: We
> no longer fallback to pdata, if a GPIO is specified using
> GPIO descriptor tables. This is a bit cleaner and does
> not have any real impact: There are only two mainline pdata
> users (arm/mach-sa1100/collie.c, arm/mach-pxa/tosa.c) and
> none of them specify the GPIO via gpiod descriptor tables.
> Once both have been converted the driver's support for
> specifying GPIOs numbers in pdata will be dropped.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
