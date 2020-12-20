Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279292DF431
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgLTGgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 01:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgLTGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 01:36:41 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB1C0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 22:35:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j18so3078907qvu.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 22:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KQzSwVhVPrMTFiKK5zcVnTGXaTdTl16gjC5nDFjrik=;
        b=Ukp1RMF/5A86WTY3wlgY8TbBHP+KrFbjj7VPpakT259+bzIGqLx+zb8RNhwwNCJJbd
         2N05RB14y3DufQkCs+S3+a7Q1/gtsg9UNurHFe0OLUpvbTtB8BQa2LA61jsJOKRoiF/W
         si6VDNnGAIKUizeoNM/KNIFYU5h5SdOBPlc4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KQzSwVhVPrMTFiKK5zcVnTGXaTdTl16gjC5nDFjrik=;
        b=nMvhs8B7og0bNdkLkHhUflBk7z5uNICyjBvd4YYj+ojEEHrYUfqav1P9zL8Oxcmfjm
         4pwDsjPmUXYUMJxX+f+NtnZ0k4LLthdtuHsLaiSnaVn4ZxdHem0P+YmfB0flVIB/zvZZ
         PTt4gFy79048Ld+fUATvwN7/VZ6Se5WDt5bo09QYQwg82fJtn2Rkm5k0XJyCH1Mf95Ho
         NzusZrCPnBUuwC1XTHQ6MuFKyOsoMMqF9ywbnfKUgOFqgvHvZp3J6Fxx1XaAlr/1ugDr
         qO+dslhbVuurlmsk8vMG6C3a74YYzW7DnJqZDnhjwVQfmCo71Z2DS2xqFGLeXH12NhqN
         PAtg==
X-Gm-Message-State: AOAM5339WAkZ4qySng9WuOz/IjfCttswNAsvps2sZQn47uvAU1NifMNF
        Y+2oNDcH0FoOyfOdnM4mF02xrI8/5btEgfl+1VPDXa3134E=
X-Google-Smtp-Source: ABdhPJxdPhtXXaO5QG2qMf+7byySCoi8Od7JhDQ6s4ZtD71A+pcvqZBFderGkPMbt0Flapkt1yKBMoyrHutfFgIm+Yw=
X-Received: by 2002:ad4:5a50:: with SMTP id ej16mr12406191qvb.25.1608446152018;
 Sat, 19 Dec 2020 22:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com>
 <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com>
In-Reply-To: <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 20 Dec 2020 15:35:41 +0900
Message-ID: <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, 20 Dec 2020 at 12:39, Stephen Boyd <sboyd@kernel.org> wrote:
> > +  clock-output-names:
> > +    minItems: 8
> > +    maxItems: 8
> > +    description: |
> > +      This should provide a name for the internal PLL clock and then
> > +      a name for each of the divided outputs.
>
> Is this necessary?

I found without the names specified in the dt probing of muxes that
depend on the outputs but appear earlier didn't work.
Also this same PLL layout seems to be used in some other places so
eventually I was thinking this driver would get used for those PLLs
with different output names.

Thanks,

Daniel
