Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AD2F869C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbhAOUYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbhAOUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:24:48 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85965C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:24:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x78so1724330ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9RX5qj7rGFsbJXJNhBoN2LaZMygrpZRt1un2PekIsg=;
        b=Lws9KxcTbF/05kFWM5ca/fUUTv9qdz9Gq6nJSPR8gOYdAJJYISEV3k8IiV7U/ca4vK
         FKRCwkcQ5VkxJBYfvm1xiCrIdlm1TNTgMeoHtKxxNQPAVZqU1b7tUfTGWnNyHgtlOaNx
         2iAcfnRu710KgMObu7nfIPrNr9YsQeQ6S13YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9RX5qj7rGFsbJXJNhBoN2LaZMygrpZRt1un2PekIsg=;
        b=PHqa3uZ/ulZ6nN7qWSBlARvSsJ4NeB5dL8Z7MJwjgklhQgImv/6ZuSW5+Tiiv8XHbU
         p6wj2SEuJjJRgVMO1plsdvqh19Cztxz0RlqLDdBzExMdl+4+0M2luB4jQ66w0WsmuBFg
         dERTQR9jeI+W7ICpsML0snxZLQpBngDQE83vqBc/2AhF6KfTHGISXWjxYfz4kBTSsnQ4
         1vDkP6cUmJn/LrAA4WxsnE5GjU8TTZvFQ8UgPi2NA+6XG4+VqJjpbIqjjECN6Ls/nbcQ
         a2gBOwNz8xNBdT9AN6VpSKfjgJgmytOgcNnFrpzHAr5SMVREDG79m2sBRn1Lk4Z1Z2p/
         c+9w==
X-Gm-Message-State: AOAM532L0sM0h25LALljMxfhWI6DcIrsUzrYsnz0rkCUT3nmZ03ZaJXK
        +894OfA0F82v/Awajs6XmrDFnElOsTEDvld/H18UWA==
X-Google-Smtp-Source: ABdhPJzbKp6kvJAB2wHiJiHdtH6OLS0uBJV8n51BolL+iPUV2rkxC1Oi3wvGezDc7Xv/goZFG8cSN0t+ZDBCl2aWpro=
X-Received: by 2002:a25:3a04:: with SMTP id h4mr20270835yba.285.1610742247860;
 Fri, 15 Jan 2021 12:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20210114183010.v6.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
 <161067828422.3661239.16933057782247961610@swboyd.mtv.corp.google.com>
In-Reply-To: <161067828422.3661239.16933057782247961610@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Fri, 15 Jan 2021 12:23:57 -0800
Message-ID: <CA+cxXhnimCistZF6e-7Uxz7aZ2Ugm7yoBPhO9RWzCtCm65xgbg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 6:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-14 18:30:30)
> > Add a new property `function-row-physmap` to the
> > device tree for the custom keyboard top row design.
> >
> > The property describes the rows/columns of the top row keys
> > from left to right.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> One nit below.
>
> > diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > index 8e50c14a9d778..a742b0777ee6d 100644
> > --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > @@ -43,6 +54,18 @@ examples:
> >          keypad,num-rows = <8>;
> >          keypad,num-columns = <13>;
> >          google,needs-ghost-filter;
> > +        function-row-physmap = <
> > +                0x00020000      /* T1 */
> > +                0x03020000      /* T2 */
> > +                0x02020000      /* T3 */
> > +                0x01020000      /* T4 */
> > +                0x03040000      /* T5 */
> > +                0x02040000      /* T6 */
> > +                0x01040000      /* T7 */
> > +                0x02090000      /* T8 */
> > +                0x01090000      /* T9 */
> > +                0x00040000      /* T10 */
>
> Can we include the header file for MATRIX_KEY so we can use the macro
> here?
Sure.
