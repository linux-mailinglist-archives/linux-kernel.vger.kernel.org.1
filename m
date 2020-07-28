Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E643E230524
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 10:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgG1ISM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 04:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgG1ISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:18:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:18:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s16so4938989ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afN9owJVn9khLrk5jWz5DEIVJ98lhYCwTBibJb7loqo=;
        b=mRFjYSupoXR0XFvmFMkwtXGrXyUBHtmJKcaEdMJH5VxH2rkBVVDAf4HxakGAUipVow
         Q5ZlZrIdM0JftkLGg6uaoGNUSY+cwJ77bVgY80akUkSB947ydVQUshWLPCpHk8pjyqAx
         SJAdO3AhjVzvraV4ziXvgZPQMun83Y7qfIioBZfYbTZ5Ps9lSu8nPBStu2hYAwmm0YMq
         Gwa6h5UKFJ8AG4TrDmAAXJMAmP0XoFVm36oq/iHCnnstmWB2KP1SipH2U3EcyteA+RKm
         9N9/L954a21H/+FXSHyQpQBtNLqr7SE9yrmvahjN2Zvy4Bu+Hc8feBW12pfwktFI5U4a
         aF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afN9owJVn9khLrk5jWz5DEIVJ98lhYCwTBibJb7loqo=;
        b=ktdBo0RG8Z5MzaCGypcxH3AoWvA9GYJI5XAroVX0Jw8tu/gzEbD210pEtI2awa+P9Z
         7ZWlv5qbR2ghA6gjv7D6e0cncYIJ7lGmgqgZ+ZZwiZqBE2MJFfDue6ncePTkWodyztsK
         jDTfLi52SpvQQr5qGJewHAYfY2Xuql7qX1ZjFPwDJo81sREcNZhE9rWrvzKswa+l147w
         vPlMeM8sOGPHYktXajzDNYraTgPlMOqEGBs35oYF3CHlIZCf9IIOhKS+jMDBSjmI5NTH
         3Kg8v2Ov5au4YvZ9BbnxA+hfdmoO62viza9sS3T6+E0+FFY7HokrmFar840Q9C7ENsj7
         wHdQ==
X-Gm-Message-State: AOAM530ICDEHJrQwKFWoWpnsQ7+7CiamdcXsoop6LBICHEe0mh9XxHVG
        GHXcTAAuaGFFed2mtE+/57+bEg0CfgU0hg6C8AsYFw==
X-Google-Smtp-Source: ABdhPJxLzCKouWNzSG+h4CcFUhBlC/Zenvbz8WAoy+mp/kcKtWdhpbDb/CIitCOUbQvcACM1R/1X2U3858EvljGMEtA=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr10817583lji.338.1595924289696;
 Tue, 28 Jul 2020 01:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200723013858.10766-1-Sergey.Semin@baikalelectronics.ru>
 <20200723013858.10766-5-Sergey.Semin@baikalelectronics.ru>
 <20200723100317.GJ3703480@smile.fi.intel.com> <20200724230342.bhdpc32rsjw7rzbl@mobilestation>
 <CAHp75Vdeg6v_yLYjxZPJM7SgDP-fou6SEuaE8+TFCNW4c2r_rA@mail.gmail.com> <20200727215010.qzhvavmskfoaapi5@mobilestation>
In-Reply-To: <20200727215010.qzhvavmskfoaapi5@mobilestation>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jul 2020 10:17:58 +0200
Message-ID: <CACRpkda5Ki+itbvLsxSLj4o1NRKdf9P48kbYXEgArDqcEcWA7w@mail.gmail.com>
Subject: Re: [PATCH 4/7] gpio: dwapb: Convert driver to using the
 GPIO-lib-based IRQ-chip
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:50 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> It turns out my "mostly" was wrong in this matter. It's 4 out of 17 patches,
> which make the initialization in the same order as mine:

I'll think about fixing them up to all look the same at some point
if noone beats me to it. Sorry for the mess, I was just hacking
along to get this work item finalized.

Yours,
Linus Walleij
