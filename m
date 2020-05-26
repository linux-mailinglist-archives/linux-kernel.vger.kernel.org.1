Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812391B34A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 03:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDVBrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVBrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:47:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D259C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:47:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so269676pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCEr6pXIIH8a6wvkqNzUF108BpUBYKo9yQQ8CIUa6jU=;
        b=EQfvQRYkh1XrsrAz+l9+x0k+vOSp/UM4fgbCnYQ64D1Dq8B1FWcLG+ca/ZEvrLDjeK
         Lh2aJ9ttT5kKR1+EZokWVRzp6P4jAQiExqYM9Uq7+iSd8vkAer6L1ObRJBmwUbr+Saq+
         DKZprigLH+OXKegSJ60ezTDhpCv/UN11QS9qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCEr6pXIIH8a6wvkqNzUF108BpUBYKo9yQQ8CIUa6jU=;
        b=jrVp0nw0/QwVAQlx9Fbld9g/GoxH3hCI0I880BnqMQvkrBjmtTGvI/bBUEJf435N3U
         GM6ziNisbBsuVq0wrQnxeREfjBA3zYz5prSz33TT8skkwSw0CRBsFkV3lyGukVPiYq9n
         nXnTTr4Z8+uZLCQuXR8Ti+lkVYhO787UbOBSS/mcA8w0iTvS48qTUFtJZjuGoMxUqJxY
         92LmHBKovJf81ShuMzwgTM/aS0thYeSNpVE86W403c/ctrUCM3hgTTsOnnSLJAT7qPxW
         AhnQ8LYL1u4gn0fg8LZZ21eiuIpQQynyqvtGQFK8QL9vwQ+HzeYfRcql1E7MGlhpa8Fo
         yyCQ==
X-Gm-Message-State: AGi0PuYNc/8JBgnPfej3NsqPyHDtjVvW21lQHG26POcmq+stwItXTeEY
        IxtgRjz6N0TCFGSbF6f2sbgCfDYcQtc=
X-Google-Smtp-Source: APiQypKgi8OJ1mX+/HuwapaKLjl2kzCZ/sRFYkride4RhJDFkaVtcRpFwO+cu5rdBhyo9Ui5Zyzrvg==
X-Received: by 2002:a63:4e21:: with SMTP id c33mr25258011pgb.305.1587520066806;
        Tue, 21 Apr 2020 18:47:46 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id p65sm3489114pgp.51.2020.04.21.18.47.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 18:47:46 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id hi11so173489pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:47:46 -0700 (PDT)
X-Received: by 2002:a67:907:: with SMTP id 7mr17409548vsj.42.1587519611840;
 Tue, 21 Apr 2020 18:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200421110520.197930-1-evanbenn@chromium.org>
 <20200421210403.v2.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid> <CAODwPW9MtDLSL_up9W0TO1PcjyA_9cUtNo3No7XXusiwqKBLDw@mail.gmail.com>
In-Reply-To: <CAODwPW9MtDLSL_up9W0TO1PcjyA_9cUtNo3No7XXusiwqKBLDw@mail.gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Wed, 22 Apr 2020 11:39:44 +1000
X-Gmail-Original-Message-ID: <CAKz_xw3-tvYoCDs07xEUBBMf024aezGMoZ35LsTN+_dXT9nC2Q@mail.gmail.com>
Message-ID: <CAKz_xw3-tvYoCDs07xEUBBMf024aezGMoZ35LsTN+_dXT9nC2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 6:31 AM Julius Werner <jwerner@chromium.org> wrote:
>
> > +static int smcwd_call(unsigned long smc_func_id, enum smcwd_call call,
> > +                     unsigned long arg, struct arm_smccc_res *res)
>
> I think you should just take a struct watchdog_device* here and do the
> drvdata unpacking inside the function.

That makes sense, I avoided it because smcwd_call's are made during
'probe', ~while
we are 'constructing' the wdd. But this is C, so I think I have
permission to do this!

> > +static int smcwd_probe(struct platform_device *pdev)
> > +{
> > +       struct watchdog_device *wdd;
> > +       int err;
> > +       struct arm_smccc_res res;
> > +       u32 *smc_func_id;
> > +
> > +       smc_func_id =
> > +               devm_kzalloc(&pdev->dev, sizeof(*smc_func_id), GFP_KERNEL);
> > +       if (!smc_func_id)
> > +               return -ENOMEM;
>
> nit: Could save the allocation by just casting the value itself to a
> pointer? Or is that considered too hacky?

I am not yet used to what hacks are allowed in the kernel.
Where I learned C that would not be allowed.
I assumed the kernel allocator has fast paths for tiny sizes though.

> > +static const struct of_device_id smcwd_dt_ids[] = {
> > +       { .compatible = "mediatek,mt8173-smc-wdt" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, smcwd_dt_ids);
>
> So I'm a bit confused about this... I thought the plan was to either
> use arm,smc-id and then there'll be no reason to put platform-specific
> quirks into the driver, so we can just use a generic "arm,smc-wdt"
> compatible string on all platforms; or we put individual compatible
> strings for each platform and use them to hardcode platform-specific
> differences (like the SMC ID) in the driver. But now you're kinda
> doing both by making the driver code platform-independent but still
> using a platform-specific compatible string, that doesn't seem to fit
> together. (If the driver can be platform independent, I think it's
> nicer to have a generic compatible string so that future platforms
> which support the same interface don't have to land code changes in
> order to just use the driver.)

Yes I think you are correct. I got some reviews about the compatible name,
but I think I misinterpreted those, and arm,smc-wdt would work. I did wonder
if Xingyu from amlogic needed to modify the driver more, EG with different
SMCWD_enum values for the amlogic chip, he could then just add an
amlogic compatible
and keep our devices running with the other compatible. Although of
course it would be nicer if
the amlogic firmware could copy the values here.

Thanks

Evan
