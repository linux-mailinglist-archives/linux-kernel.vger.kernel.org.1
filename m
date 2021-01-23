Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C73018D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbhAWXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:01:34 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41521C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:00:54 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u11so10789928ljo.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrXVK1Xlvva74EMLsVDvNnC5B0+F3JZZDWEbxcIzfFk=;
        b=Vmm1S9RZHzIZvDYnDDrAzJH3S3oguv46vM7BrHrlebnTIkbmlQNHWC2pvKYVIHdsgv
         7yaKYVS2GotTPqpZiwnVBUYN5YieVS7QGZqdYh5tXVyf2jy/OCkql7fZ5yMkcL9lT2d8
         HgEmHpD3dFeA5Z+9ANmkoMHmwLTRa2E+7ZAnLRCc2t3rgtzwSRM6UJDB7fmfGc5dz/PO
         Agwqcjv1MHb2lBXqORpM159TskCW+bUPf1AfrwcWFJFuGYGad3RT0baDFn652T/rNC/E
         IYGbyGvwDV0zAXrzpaEesz1+LPFMHEZq086XCdvkLiRpizAZM/F894y+gsE85BZQl+Gz
         Mbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrXVK1Xlvva74EMLsVDvNnC5B0+F3JZZDWEbxcIzfFk=;
        b=UXqhwkNpgdWIkwkYSfpYZ2hv8jA9XrPm/cAX1p9yaIKYZ19lI3garKd1gCdmL0SDEM
         K/3J1F15u8iSqbH3Bk6gT7q2lcQ7b6mGBz3gDIoA1xIKo52ikk2wVPGPcZu6nk5vfKjL
         nE6N+7mKo4xi/0ttCwqH5v8ByfKy5GtaEzEy6pQq/HqhuiMoPkZW+bEZ8RdLtR593iZ7
         U8XWTN7lHpW0tbcmCm+maBSFyuUNIUyY1hi3mbYr7/daIGSFowjHKK6/YepYR2Agl0e1
         i1zM8AzgFGf5jgjirIi7panAND3iC9koThO0ksKDN7FWo3ewJbFlsZer0jJBBOvhTzrj
         8QQw==
X-Gm-Message-State: AOAM533278xFDa3cl6wFz6uibZ+/l0D0ivqR+q6Jt00dsHt8tu1Ti4iZ
        1iiu1V50G4I5us+Dr8xL+B1YZdXo3oOOwKPESxo8BA==
X-Google-Smtp-Source: ABdhPJxxyemhnBxyJIW6WUkq6tdnONnoKmLFjru3rwB+p5RRR8juI+8vkgZwRHs0U5QBMfiq9BIQky35UFJW+y54/vg=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr220937ljk.200.1611442852795;
 Sat, 23 Jan 2021 15:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20210121114907.109267-1-bianpan2016@163.com> <CACRpkdZzVY=AKFhW-hEmCAHmdMgVF8=hQeE8a8W=2W0h44eQVg@mail.gmail.com>
 <YAtdlKe7q4JskefR@builder.lan>
In-Reply-To: <YAtdlKe7q4JskefR@builder.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Jan 2021 00:00:42 +0100
Message-ID: <CACRpkdb18fxjaspBWpRCvPt32ajXPzoEXPU77QiS2m8tjqL=NA@mail.gmail.com>
Subject: Re: [PATCH] bus: qcom: Put child node before return
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pan Bian <bianpan2016@163.com>, Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 12:19 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Fri 22 Jan 16:47 CST 2021, Linus Walleij wrote:
>
> > On Thu, Jan 21, 2021 at 12:49 PM Pan Bian <bianpan2016@163.com> wrote:
> >
> > > Put child node before return to fix potential reference count leak.
> > > Generally, the reference count of child is incremented and decremented
> > > automatically in the macro for_each_available_child_of_node() and should
> > > be decremented manually if the loop is broken in loop body.
> > >
> > > Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
> > > Signed-off-by: Pan Bian <bianpan2016@163.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Please submit this patch for inclusion through the ARM SoC tree.
> >
>
> Any objections to me picking it in the Qualcomm tree? Or that's what you
> indirectly meant?

Kind-of-sort-of :D

Apply it to the Qualcomm tree!

Yours,
Linus Walleij
