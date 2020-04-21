Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEF1B1B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 03:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDUBQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgDUBQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:16:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FACC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:16:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y25so5850396pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFRq3RluqVTW3eItiffvhrul27fygOSDx5LOp792/cY=;
        b=jGemw2P2rq8+zKge7bcDV6mMP5GeCYSBjW21Yga4LFd+SRnJNGAo1LIyCZsecJrAj+
         3Y2nk68i50FiVZkjKg3XewJTSb85k963UHIJB4QyqWe/KfxK1rup1VWPKA6RhXdb/LbF
         ZALCrIEKJacoE0XvLyBHMyRJFtUd8Qd5IXRqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFRq3RluqVTW3eItiffvhrul27fygOSDx5LOp792/cY=;
        b=ocboM++aTgXysHRlcMAQ7czW0+/3LX6ooLF70COUNC9pllRvTUuT+cWywU3WNlOO8Z
         0hwmrB+G8e2FUtce4AYx514aK1L4AGFSYLQeDHHbSqk6t/4VGuqbFG04dKIMm8errJnh
         wo2ZPoe3Vl92JDpT2LKwYM5zqz0XCXdC+hbl792mI4AiPfkQkMH46UE4y2jD9qaC6KkE
         sss0BFNvk7qljlG1vsI8ckrIl0tD0i65xzVtHR+BwThPQgeRG48ZBKOiS9C6KAvYPmqP
         fO+IF0EEWKb9do/yDZuLrU9Iq0yRBXA+vU+DtVmTghBUJHHFCMHgABsLn6U+h/5oalp+
         VCdQ==
X-Gm-Message-State: AGi0PuaJTK+x29aaptkQBcQQhFpH1yssxrTxflC9OpSZc/I17iSGcZEa
        kFNT2I5gcKzkOkvZMuxmBr7IJYsvBN0=
X-Google-Smtp-Source: APiQypJdIoVwzT3FE7f4+Gp4pepU2AjB007S0Nf/FLcKNVHcqcaylN3FzSPGrU0U282Kc1xbipyGKw==
X-Received: by 2002:aa7:8743:: with SMTP id g3mr443362pfo.218.1587431762326;
        Mon, 20 Apr 2020 18:16:02 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id y184sm747326pfg.127.2020.04.20.18.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 18:16:02 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id w11so5974745pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:16:02 -0700 (PDT)
X-Received: by 2002:a67:d61c:: with SMTP id n28mr14119322vsj.70.1587431365930;
 Mon, 20 Apr 2020 18:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200403052900.258855-1-evanbenn@chromium.org>
 <CAKz_xw0gV+w_gMkLfB4qUBdULLfFoiv1TBWp9_PHy33wP_XWyA@mail.gmail.com>
 <890948ef-7276-fdae-d270-eb30eff3eab2@amlogic.com> <243e107c-35c1-2d14-5285-c9e13744963c@amlogic.com>
 <CAODwPW9RSB37+4EJ2QXAwz=ShFB23L1GKC2mLYE5L5JuQR2tPw@mail.gmail.com>
 <20200415231215.GA182398@roeck-us.net> <CAKz_xw0+gKBM1jp-Avnd+4j9vSxUix67RZBX-NNbStb0+ri4+Q@mail.gmail.com>
 <CAODwPW9Vt7TcWfKYDmRgLndb2-+5HoNvA6XMJJznXCudQDngqw@mail.gmail.com> <9d029a04-2a37-cbbe-1932-be34d34f6b69@gmail.com>
In-Reply-To: <9d029a04-2a37-cbbe-1932-be34d34f6b69@gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Tue, 21 Apr 2020 11:08:57 +1000
X-Gmail-Original-Message-ID: <CAKz_xw33YBChSCDHcki2JCR=LXrvfEN2pseEN471xVvqhqrUfA@mail.gmail.com>
Message-ID: <CAKz_xw33YBChSCDHcki2JCR=LXrvfEN2pseEN471xVvqhqrUfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yonghui Yu <yonghui.yu@amlogic.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Will Deacon <will@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian,

> The PSCI binding itself has provision for specifying function IDs for
> different functions, and this seems to be followed by other subsystems
> as well like SCMI:
>
> https://www.spinics.net/lists/arm-kernel/msg791270.html

Are you referring to this line in the devicetree linked?

+- arm,smc-id : SMC id required when using smc or hvc transports

I cannot find any prior definition of this in the devicetree yaml
format, so I will add that as well.
Did you have a link for the psci usage that you referenced?

Thanks

Evan
