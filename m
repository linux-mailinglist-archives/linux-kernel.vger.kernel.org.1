Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE9295294
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504580AbgJUS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504573AbgJUS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:58:57 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A62C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:58:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w27so857930ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W2pC67xhRkKWu1crwi3WnEWmuFybiuMyc4IE8ybA3Y=;
        b=XTONy7T4k5Gzl6HjRqKQFsj2KbsjHrbmaEhX9T6ZjtoTGm9BYZXs76FMtxy81qcZ7D
         vcOqaD85bifWyUNkHP01hHhKfS8iWZT5m4rueE18sAC49IKJvZp8gm92D+65agyM68yd
         gxdiArHr9YB3wNQiqrJYVK++xAO/6t4/2NoaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W2pC67xhRkKWu1crwi3WnEWmuFybiuMyc4IE8ybA3Y=;
        b=V7rLFNVDTF7KDi6eQPVaeSlQHY+LAfbzA1xdZ/RTGmFYfePdLN0VFI/cH6v4Q1/rvJ
         PXb3Z8iI6nRjuX5Tvea8ifRtqm6ACSne/Ioskjj+RJN4LIWbpy3CDrMqMuLFHeQ2DNbt
         jdH49BSE19vlD2I2p2EvsTb2iHxDAd2YI17MRTCRFWtarin/afs4oMKtyeQ8hWWDUUjo
         Cs/KMS9PzjbTrz3/3B24a/t41QcnGDd2RlZJy1lj/nTnWyk5l3QmP2h24U525ySGKjDS
         XS3Vlii1hfgcAu+4fATsE1GIOZglAQ8EYVco/GjDVOvp4vReSYA2CBKCt4EbTAst3hxN
         eeTA==
X-Gm-Message-State: AOAM531t6le0i+3MUoKAEkZ78XuwQ8Pbk24dqRC5HdR3M/YYQo9kGqJQ
        YyNfRn32xPRL26xddGr9vGmX0hagiOYKlpjSEIFJvNMuloWpVA==
X-Google-Smtp-Source: ABdhPJxh39xHToKhZgOxl+9J4lgKjHHbK/0jjNl2/Cu8xEHEIqkN9JHHNMnqFAvKEn2ZvOp+Z9DIbCgEDAZaQTqnsis=
X-Received: by 2002:a17:906:284f:: with SMTP id s15mr5013892ejc.336.1603306735812;
 Wed, 21 Oct 2020 11:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200731160324.142097-1-jagan@amarulasolutions.com> <CAMty3ZCO5iY6g4uRp7xuCquQNEMiwbeiy=sN9y0dR1TX+0AGzw@mail.gmail.com>
In-Reply-To: <CAMty3ZCO5iY6g4uRp7xuCquQNEMiwbeiy=sN9y0dR1TX+0AGzw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 22 Oct 2020 00:28:44 +0530
Message-ID: <CAMty3ZASgCOUyq0w13iGCnZ-V4e5Wcc9=9kmW3R3h+G81T6A0g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_MP8859
To:     Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Heiko,
>
> On Fri, Jul 31, 2020 at 9:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
> > for 12V supply.
> >
> > roc-rk3399-pc initially used 12V fixed regulator for this supply,
> > but the below commit has switched to use MP8859.
> >
> > commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
> > Enable mp8859 regulator on rk3399-roc-pc"
> >
> > So, enable bydefault on the defconfig.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - none
> >
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 883e8bace3ed..62bcbf987a70 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -556,6 +556,7 @@ CONFIG_REGULATOR_HI6421V530=y
> >  CONFIG_REGULATOR_HI655X=y
> >  CONFIG_REGULATOR_MAX77620=y
> >  CONFIG_REGULATOR_MAX8973=y
> > +CONFIG_REGULATOR_MP8859=y
> >  CONFIG_REGULATOR_PFUZE100=y
> >  CONFIG_REGULATOR_PWM=y
> >  CONFIG_REGULATOR_QCOM_RPMH=y
>
> Can you apply this patch? w/o this regulator the default defconfig is
> unable to boot the Linux.

Gentle reminder.

Jagan.
