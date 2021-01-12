Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193E2F4045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbhALXaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbhALXaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:30:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A230C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:29:22 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id r63so410237ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1seuFAYIbhLRjf8D0C4ZsKHbwGrH6A/TbShGVmd5uo=;
        b=cwO1sEjV1h4NVsOFaISyMfdqqMJfHtXNPyvxr2Gfm6mPYBRO60Zb6pTcwmWCwdT+pb
         OZNRny2bvukSOjPndOUrsEa68XCe/6fEMIfz2/RJmzym5RtuLTIM+weqi9KiEA3B6U63
         aIU0VGwFrZ9XKZdofR8gP8ukAmIvjGvwrUszo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1seuFAYIbhLRjf8D0C4ZsKHbwGrH6A/TbShGVmd5uo=;
        b=noywChv3dPYB2RduaXOrxUxsBgi7uDZwgaqH9TlTvCnT+tY3Bz1xiNAJng6r7+4XjA
         jDnIr8iMeCvYGwaCP2CuZZ1Kr6+qInAaMm690skIx6uv2+tmPYjTsBfv9V+he5bKe6gR
         8UzNxhWO28hTUg61xloIBRY9G3hLu4mtt6BUrOhOLhM4dU6ZTAIHJxrZazIs4btg5hYk
         guH40A1q8HFOMMVrhYcCwPAnZzZWSzAX1siDmSugdSy3asoOjmlG8TUUhQMrc+MeOcY5
         Lc1XBIk3cwJ68C7BdFRDxcXVKMjjH52x8oleHwv72chPNKqJ6spafL7dNU8ap4t87fz2
         s8uw==
X-Gm-Message-State: AOAM531alCSj7LtFXN4bY8b4Ip+v+mXtk7B+tlOekjdLTbF+0e7E1e4n
        ZRxbCGKKJaZmPnbhHRfxOMNrGoUxxupUfHOnSCgd0Q==
X-Google-Smtp-Source: ABdhPJzg3f5FyC7kA1rl+eUDMIlmHup89eW+40+ekVov/RjOLdGoW12i6y4CT4/3T0jTZHB9F3uBtlSmyJMs6PkpKsc=
X-Received: by 2002:a25:3a04:: with SMTP id h4mr2589314yba.285.1610494161587;
 Tue, 12 Jan 2021 15:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20210107154200.v4.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
 <161041741167.3661239.13546059654424804588@swboyd.mtv.corp.google.com>
In-Reply-To: <161041741167.3661239.13546059654424804588@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 12 Jan 2021 15:29:11 -0800
Message-ID: <CA+cxXhkXJGYx0SQ-S7B=6iHAWFoCQpokw7huaGTNKbVmP1JDhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
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

On Mon, Jan 11, 2021 at 6:10 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-07 15:42:08)
> > This patch adds a new property `function-row-physmap` to the
>
> From Documentation/process/submitting-patches.rst
>
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.
I was aware of this guideline, but I thought it only applies to the
summary line.
I'll apply the guideline to the whole description.
Thanks!
>
> > device tree for the custom keyboard top row design.
> >
> > The property describes the rows/columns of the top row keys
> > from left to right.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> > diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > index 8e50c14a9d778..7acdb33781d30 100644
> > --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > @@ -31,6 +31,16 @@ properties:
> >        if the EC does not have its own logic or hardware for this.
> >      type: boolean
> >
> > +  function-row-physmap:
>
> Is there any minimum/maximum number of elements possible?
The maximum is 15.
There is no definition for the minimum - we can probably say the minimum is 1.
>
> > +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> > +    description: |
> > +      An ordered u32 array describing the rows/columns (in the scan matrix)
> > +      of top row keys from physical left (KEY_F1) to right. Each entry
> > +      encodes the row/column as:
> > +      (((row) & 0xFF) << 24) | (((column) & 0xFF) << 16)
> > +      where the lower 16 bits are reserved. This property is specified only
> > +      when the keyboard has a custom design for the top row keys.
> > +
