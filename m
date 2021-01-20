Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA162FD5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbhATQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391718AbhATQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:42:21 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E56C061757;
        Wed, 20 Jan 2021 08:41:41 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q1so48078177ion.8;
        Wed, 20 Jan 2021 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1ptfx9MBkjEmmJ18l5zZfZj5ndiNTQD02M7SBmrC80=;
        b=b54lhfe/lR/z5qUzeKX6jAB8CXmKK7J8XsyATY7LYJLUJ+hbnsi4nskN4GOMGvddz9
         3LFPqe18YuJ4jo8UTLv5uogW3Gog6mWhN7eysHGi/jEvyoB+5XdzM0Gbv5ngZiHsZjpo
         3UlUxXOBP2XiQF50Vnz4ssffWGnLhCHikV8F3ml1zMQNy33SsRXtcJRDyPjdYUm0C4E+
         ep7zxspAMQik7ADES/LMwbCmI1i4ZsKX4f0JKKfIcyarYFxgok7KjZKQA8KFIxgH+MEc
         yXiydONZo2juDScLcvkI6Tc5LDc7MQqhngRXdLVjBQH/msQsMeAl94j20CDksec6MHkG
         BuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1ptfx9MBkjEmmJ18l5zZfZj5ndiNTQD02M7SBmrC80=;
        b=EqElRwIAM6fbM7QONyvSR3l416AzA1n+9zEAJLQReMrYc4SRD9aC5HVveOUxeZkyxw
         SfEyJBcschFDel0EuQKasAPYjHOgRNa2gNl7zWdQuDWkoN9R/tR0IwLRZf4HxYbIaxHH
         4/7hQteKwP30QuAaSPoRHq2PLR+R46at0aNdFCkvtPxAzTMW6g5pGkaP2JuQ5WZfFKka
         bylZ4ncDSMxpYG+lY+0riXOZ89SvDE6zf0gewtr0hvIkoOAALkrBnOOwPvi30J2QxUr7
         POpR/ZmCc8Hz+56ZpyU/EzSsLdCAaAGR8RCTObl4QQjP2vD+y1zfw85/j19VMrCPdyR/
         TwmA==
X-Gm-Message-State: AOAM531BcjG0NukWAfcarielkf8gUJ0nKYYFw9LlwXNuXXHrAkPQDePY
        cebTbrxcJD8dDgVSqnmkynz+evxlx4HOPiTav3uUO0Zl46o=
X-Google-Smtp-Source: ABdhPJwjkfC7vxSYl+elSTXavI2EkbX9fRHxRQYsNVMDnePcYgrd7W8c2kUHMf5xk7qsxsjJKAGToNoQ9/fW0Kdwwqo=
X-Received: by 2002:a02:7fd5:: with SMTP id r204mr8622208jac.74.1611160900259;
 Wed, 20 Jan 2021 08:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20210119212109.1064786-1-aford173@gmail.com> <9dab169a-e551-7ba1-7fe2-d00e80978388@lucaceresoli.net>
In-Reply-To: <9dab169a-e551-7ba1-7fe2-d00e80978388@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 20 Jan 2021 10:41:29 -0600
Message-ID: <CAHCN7xKERYbGvhdX38bzb5Qa75wTUMSkDoLQy4E1BZQYz9wNkA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: clk: versaclock5: Add optional load
 capacitance property
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Adam,
>
> On 19/01/21 22:21, Adam Ford wrote:
> > There are two registers which can set the load capacitance for
> > XTAL1 and XTAL2. These are optional registers when using an
> > external crystal.  Since XTAL1 and XTAL2 will set to the same value,
> > update the binding to support a single property called
> > xtal-load-femtofarads.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  No Change
> >
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > index 2ac1131fd922..c268debe5b8d 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > @@ -59,6 +59,12 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >
> > +  idt,xtal-load-femtofarads:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> "Vendor specific properties having a standard unit suffix don't need a
> type." -- Documentation/devicetree/bindings/example-schema.yaml
>

I tried to remove the "$ref: /schemas/types.yaml#/definitions/uint32"
but when I ran the test to make the yaml files, it threw an error, so
I put it back.

adam
> Overall looks good.
>
> --
> Luca
