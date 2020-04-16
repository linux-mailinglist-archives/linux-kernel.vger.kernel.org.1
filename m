Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F91ABEED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632791AbgDPLOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506234AbgDPLLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:11:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF2C061A0F;
        Thu, 16 Apr 2020 04:11:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so4359345wmf.5;
        Thu, 16 Apr 2020 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNPv0L8oZ2ZNvAhFBy+sIdUoPqgqCnfq1Lqa8UBCAVU=;
        b=n/5Ydq3YFrlj/SwcMbqob7nqCSdfpwQ2sooxAqKUqoqglVpnYPTCrA9eIP1pCHqyrY
         h04bJzJvraxcPvNsHzcl0YJamieMAcNUQXjdhtfwl0M3KjPCFf8LgkZmZI3L6Tq3Xyxj
         pVpBmFW8xV0oOoWxLrO2ridYw6m659eWw4rqjNTtUFTHsXYOeZ+KWk6S/XiTgJM/C40v
         9vEOKMnJ5Ka0X80/V4u8th8j54Taa0cPmgtMrLfWXv8fFNR8IZIHBTOPVeM5hQ1lhNbG
         4lXvh6rvmxPZdzq2B5PHXWCcgRXFZBnfl2MMkvAuOBsVzJyrlakiOBAcYbv9aAyh9Wm3
         c0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNPv0L8oZ2ZNvAhFBy+sIdUoPqgqCnfq1Lqa8UBCAVU=;
        b=itIQ7VZLxXSG4hmUttvrbES6LkJGkv9LlKZ6hvwK11b81shOwWHWv43WbNIdqTF18z
         ovDZcUmG52sOsGK9GCQvO09292BbKGHQyzvIn7lMdhT79vlCRQUGdPqQ1Cn1qmzoNekd
         ZE6S/OUwqhidlXiw6uzmjpqhnhHNt232Snnb4j70WJ80MCSlRdpGkyw3il0HfNXEJtXB
         sx5Y+W9wqMdQIJP1YKcWNmj5rPOeED1iSoCKf+24+KmlCe2mV/TFX4NQITpjt4KuQJT5
         TZz5i9BaxJdqmSXNbKIXV8aA5dF4vz1v+2X5KPZc7mXafdqH62Ev2Find5pVTf3ucXbx
         QrBw==
X-Gm-Message-State: AGi0PuYW7urQAWAN1spyTp7blQEzbq3qloTsxL7rVRUUxk3Qn1QgavGP
        449vozsp7b7Rae59OwLsiDN1JG9XFaMiqJF6uRY=
X-Google-Smtp-Source: APiQypLQ3fWux9KGt9LS7rjW4OY0UEaEFLZ7HroqDMMQtyLjSL6kfMZyd/LfqGNRxtBhzjQ4TGpdz7tF8cGRfyR32As=
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr4478119wmr.16.1587035495915;
 Thu, 16 Apr 2020 04:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200409043851.31217-1-paweldembicki@gmail.com> <CACRpkdYKB0CHgOQ0DEhYoy16n3tSZ=DZ0WvL-GhAVCq0Jk8s2w@mail.gmail.com>
In-Reply-To: <CACRpkdYKB0CHgOQ0DEhYoy16n3tSZ=DZ0WvL-GhAVCq0Jk8s2w@mail.gmail.com>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Thu, 16 Apr 2020 13:10:38 +0200
Message-ID: <CAJN1Kky_Wor15GAZvHgdxusVsH+0z_k=K2H3uj28iGMwh8kDOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Check Point
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:57  Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Pawel,
>

Hi Linus,

> On Thu, Apr 9, 2020 at 6:39 AM Pawel Dembicki <paweldembicki@gmail.com> wrote:
>
> >    "^ceva,.*":
> >      description: Ceva, Inc.
> >    "^chipidea,.*":
> > +    description: Check Point Software Technologies Ltd.
> > +  "^checkpoint,.*":
> >      description: Chipidea, Inc
> >    "^chipone,.*":
> >      description: ChipOne
>
> This is wrong, you inserted your new vendor between the regexp
> and description for chipidea and flipped the two lines in your
> match.

I prepared v2 of my patch and it was merged into next:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=84a25ea9cfd9889acf1e1021cbd835277a1df71e

-- 
Best regards,
Pawel Dembicki
