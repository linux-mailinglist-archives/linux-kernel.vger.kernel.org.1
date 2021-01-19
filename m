Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41722FAF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437252AbhASDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437147AbhASDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:10:58 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84211C061573;
        Mon, 18 Jan 2021 19:10:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id l14so8528535qvh.2;
        Mon, 18 Jan 2021 19:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkirs0xt3XLTsL7Ppx9AG5Pdbq7hPLnjo1ZWo6evLOA=;
        b=RAtvlXUhm8RArwZ3wSI+30Dj7+bGzn9tr/P6rGPOvZpqRR3n75HjlfQOXLwWV36Q8J
         N+G+LRv/KhTOPMA+IDMP0LKzHM0HMYASb26+7537iYLLePHdjh6yoHIZ0eUqEh6vitJQ
         OwQuuiTtW8noH/NngZH89NHqHTzQlnNSS4uXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkirs0xt3XLTsL7Ppx9AG5Pdbq7hPLnjo1ZWo6evLOA=;
        b=BQx9D/KJWWF+U0NpeD3oCbxDBGXPtT0G0TAT0PT0XQHe4Ym5UXqrMPCELF56/NuxB+
         OEfsl4QUcZHdwfK6ocIY59cCFheCZmIwr9RZUsJM/z5IUkRD2WNeLr+IWEmU8OOe0DQE
         Xm8y9jpkCIEP9vYp4nocCxsOAtYf0GqbnX25HAsq9BrRriTiciebmB3KjL5ZQzqdNwx2
         o0kPh7ReXdqM/FQScRA2JVAC03NbHNQ/IOJG/yq1IMP+nqCugq9YGDVjNo8C9i5iwBN1
         P72Msug6vmxjRxivkDsXJwk2sTojSsDgdlwXj+Iw/1OyS6YzA0dv4S42A2hWZC9byFf8
         9Hcw==
X-Gm-Message-State: AOAM531CWf1Ju1/LQLmDy6qgQmrfNBscCt5JjVvHQyjrOJhNDPx1wk5g
        QOa57UjFeyfTGkjciGMfJIKBXo2FAayxgjaHwq9n5miXZSA1bQ==
X-Google-Smtp-Source: ABdhPJzjC/DCnkjtreGb9bDOj46D/UPo+qxk1NQO0thQYodj/luLEcDNpJhxNw+2s3Wr9g/BRHCwwHj7B288JX+08e0=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr2395035qva.18.1611025817765;
 Mon, 18 Jan 2021 19:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
 <20210118100813.30821-2-ryan_chen@aspeedtech.com> <02b792c847ea1841603629ba0377cfdfff479882.camel@linux.ibm.com>
 <HK0PR06MB3380AC1A1DF9C0883E83F752F2A30@HK0PR06MB3380.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3380AC1A1DF9C0883E83F752F2A30@HK0PR06MB3380.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 19 Jan 2021 03:10:05 +0000
Message-ID: <CACPK8XfuiN_Nxfwf89ig5tgEo1dmiV_k092TVu527w4fYVFE0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for ast2600-A2
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Joel Stanley <joel@linux.ibm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrewrj@au1.ibm.com" <andrewrj@au1.ibm.com>,
        BMC-SW <BMC-SW@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 03:04, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> > -----Original Message-----
> > From: Joel Stanley <joel@linux.ibm.com>
> > Sent: Tuesday, January 19, 2021 10:20 AM
> > To: Ryan Chen <ryan_chen@aspeedtech.com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> > linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org;
> > andrewrj@au1.ibm.com; BMC-SW <BMC-SW@aspeedtech.com>
> > Cc: joel@jms.id.au; Andrew Jeffery <andrew@aj.id.au>
> > Subject: Re: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for ast2600-A2
> >
> > On Mon, 2021-01-18 at 18:08 +0800, Ryan Chen wrote:
> > > AST2600A1/A2 have different pll calculate formula.
> >
> > To clarify, only the A0 has the old calculation, and all subsequent revisions use
> > the new calculation?
> >
> > If this is the case, do we need to support A0 in mainline linux, or should we
> > drop support for A0 and only support A1, A2 and onwards?
> >
> A0/A1 is use older calculate formula
> After A2 is new calculate formula as the patch.

Thanks for clarifying. I suggest you change the commit log to say
something like this:

Starting from A2, the A-PLL calculation has changed. Use the existing
formula for A0/A1 and the new formula for A2 onwards.

>
> > You should add a line to indicate this is a fix:
> >
> > Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> >
> Got it. so should I send new patch?

Yes, please consider adjusting the commit message as I suggested
above, and add the fixes line.

> > > +       u32 chip_id = readl(scu_g6_base + ASPEED_G6_SILICON_REV);
> > >
> > > -       if (val & BIT(20)) {
> > > -               /* Pass through mode */
> > > -               mult = div = 1;
> > > +       if (((chip_id & CHIP_REVISION_ID) >> 16) >= 2) {

Will this test be true if there are future versions of the chip (A3, etc)?

Cheers,

Joel
