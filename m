Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6420300840
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbhAVQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:08:49 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34940 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbhAVQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:07:31 -0500
Received: by mail-ot1-f53.google.com with SMTP id 36so5549938otp.2;
        Fri, 22 Jan 2021 08:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XsEWssMCPfLIPwZeIDg292psce+OBhutMUuJWbGwGBg=;
        b=l4TagOEVLPJzBWjNIPDwuUc3gkVWlmZRXAqFGevK0qcAdhrMXgYnIvDhcYcQwmpb79
         sYK7cx0F+9nmboGzjJ7ZekoqRjMhdNrH6PpLGM6MaeiC8VWuqKIe+lXXdx/b/gx5w2i2
         pCHoSCYrBGhOG5+zGWeCYWULwB/4xSOQ7ZesF67I/0Dsdo0IhK5LIVeasEhcW8h9HpBH
         bOb+u8NS/szxLXLtXLuqgAHMvX/5Fe8F8AqddcWFySo/I2l0kuZVx2560bu34XUNylN/
         uQx6GJzvob6zgKt8vjrtywuz9wi+vC4EFOcLhXG+BZiMiajUjs4ElCtUWIB7AnqG/kp4
         t6zg==
X-Gm-Message-State: AOAM530ILGIqF7qGUndahAgwPWtZtFwAXtFUPmTXTuR+Au/X/pkdn9r1
        0TOrj1vUDV20P3yvTOUM8Q==
X-Google-Smtp-Source: ABdhPJyc9igyMeLfK7ygeNj0+UjaZn/4fYN1oUjwoJ0z7bd92UkR5kJYgaRjyUNo2ZDVg+SkLKEIAA==
X-Received: by 2002:a05:6830:1f02:: with SMTP id u2mr3931925otg.124.1611331605445;
        Fri, 22 Jan 2021 08:06:45 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t65sm1746041oie.25.2021.01.22.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 08:06:44 -0800 (PST)
Received: (nullmailer pid 882044 invoked by uid 1000);
        Fri, 22 Jan 2021 16:06:43 -0000
Date:   Fri, 22 Jan 2021 10:06:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings/phy: ingenic: Add compatibles for??
 JZ4760(B) SoCs
Message-ID: <20210122160643.GA865022@robh.at.kernel.org>
References: <20210120115945.29046-1-paul@crapouillou.net>
 <CAL_JsqLS-oFn4kGm7GeU+W2BvVeon9k9+gzVojypcJCJLwbaEQ@mail.gmail.com>
 <SIBCNQ.SZL9QXM6XX3N2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SIBCNQ.SZL9QXM6XX3N2@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:42:28PM +0000, Paul Cercueil wrote:
> Hi Rob,
> 
> Le ven. 22 janv. 2021 à 8:35, Rob Herring <robh+dt@kernel.org> a écrit :
> > On Wed, Jan 20, 2021 at 5:59 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> > > 
> > >  Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible
> > > strings,
> > >  and make the ingenic,jz4770-phy compatible string require
> > >  ingenic,jz4760-phy as a fallback, since both work the same, and the
> > >  JZ4760 SoC is older.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   .../bindings/phy/ingenic,phy-usb.yaml         | 22
> > > ++++++++++++-------
> > >   1 file changed, 14 insertions(+), 8 deletions(-)
> > > 
> > >  diff --git
> > > a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> > > b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> > >  index 0fd93d71fe5a..3c65dfcf352b 100644
> > >  --- a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> > >  +++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> > >  @@ -15,13 +15,19 @@ properties:
> > >       pattern: '^usb-phy@.*'
> > > 
> > >     compatible:
> > >  -    enum:
> > >  -      - ingenic,jz4770-phy
> > >  -      - ingenic,jz4775-phy
> > >  -      - ingenic,jz4780-phy
> > >  -      - ingenic,x1000-phy
> > >  -      - ingenic,x1830-phy
> > >  -      - ingenic,x2000-phy
> > >  +    oneOf:
> > >  +      - enum:
> > >  +        - ingenic,jz4760-phy
> > 
> > This should be 2 more spaces indentation. Indent is always 2 more than
> > the above keyword and ignores '-'.
> 
> Pretty confusing. But alright.

TBC, either way is functional and these are the 2 main styles, so we 
picked one. In some sequences, it's easy to miss a '-' where a space 
would also be valid. For example:

items:
- items:
    enum: ...

vs:

items:
  items:
    enum: ...

Both are valid (as items can be a list or sub-schema).

Rob
