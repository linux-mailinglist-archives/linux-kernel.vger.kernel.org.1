Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268E28746D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgJHMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgJHMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:41:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFA6C061755;
        Thu,  8 Oct 2020 05:41:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h12so3360950qtu.1;
        Thu, 08 Oct 2020 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwIccZ4x3xo7GNWUxzd5wUV2ADrMhw4FCIdifz/8B0I=;
        b=vZxksnFcp26867DGblEpDnjAQUItzZCH6f+iIlz1xZhXcZIRCQO9t13/WcwJQf2P8f
         r6BQrUehWpDixdbQwjW+iM0QVp9mUHaP41uqUf4tnxtNfA0lM9egkrpC3Nr0cFThHk73
         OIXFvRHim7SJEo9SzACJFwWxlQOByJebqbixTNpJyl97kiG5SOmRg10zLR4mi5DEBFeE
         xLPGMS6w24m/bYQX+Y7fELqX0vXjFgpmcgoztMMtVfO6g6zgiM4VVF3uyxNfP+JQw+yt
         ARZer9xVLv7X2OqZlD62BiF7P+Ag22r7JZVYBr6JqXVUR/SoO49kz511j5krUySGGzeG
         MMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwIccZ4x3xo7GNWUxzd5wUV2ADrMhw4FCIdifz/8B0I=;
        b=tQ5Qqip9B7cJwSRvPeebDYrANaR+IkpZuTtU2Z5bwEfLkgObFmGslrNO6M3vTcxjK4
         HsDzsArMQSJNhda7eWzZYYnZsXTP6E5YYZZi9Yfq5u9utZOiblGmB9S6pS9of4jUTZhD
         eqSDv25q7uPJecLvOwmFat6apAM9KCbCjb2KswO9u7L2sPwy8IIDkrph9pRo4GPXWp/I
         JDFv3/VZHtvnJUV/wr7nB6GGA6eVfIQEgDk3Ny2jIANT3H3fAOSUjgw1RCD7kgPzYQfu
         Nyo+L/kyCr3XLODjqOGm8JMNRw5L2kmIqqRB/AISvk1Yzu7Nc/q+dE9dernWYhyJjDcj
         BG0Q==
X-Gm-Message-State: AOAM532yHsAZxiojFchNh1alLqFdim4uUD+IcLluAZ4RBzAsZ5JbLRyS
        4p8jOnLMff+K0cRfqQ+aHmM=
X-Google-Smtp-Source: ABdhPJwY8csqx7avvKjg86EIz3jHs4UXnQT9G4rdloSm3qz66LGKt7lDehYE5cza5UOKTIyETQQIhw==
X-Received: by 2002:ac8:7591:: with SMTP id s17mr4138138qtq.138.1602160877925;
        Thu, 08 Oct 2020 05:41:17 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id j9sm3907966qtk.89.2020.10.08.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 05:41:17 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:41:13 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
Message-ID: <20201008124113.GA5106@ubuntu>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201007210134.GD112961@lunn.ch>
 <20201007214633.GA1972@ubuntu>
 <20201008002621.GF112961@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008002621.GF112961@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:26:21AM +0200, Andrew Lunn wrote:
> On Wed, Oct 07, 2020 at 05:46:33PM -0400, Vivek Unune wrote:
> > On Wed, Oct 07, 2020 at 11:01:34PM +0200, Andrew Lunn wrote:
> > > On Wed, Oct 07, 2020 at 03:01:50PM -0400, Vivek Unune wrote:
> > > > Forgo the use of mmioreg mdio mux infavor of the pinctrl
> > > 
> > > Hi Vivek
> > > 
> > > Could you add some more details please. I don't know this
> > > hardware. I'm assuming there are two MDIO busses, external as talked
> > > about in the comments, and an internal one? And for this hardware you
> > > only need one of them? But i don't see what pinmux has to do with
> > > this?
> > Hi Andrew,
> > 
> > There are indeed two mdio busses. To access the external bus, 9th bit
> > of the mdio register has to be set. And to enable mii function,
> > one has to set the registers 6 & 7 which is part of the pin controller.
> > Earlier the pin controller was not defined and I resorted to use a
> > combination of memory mapped io mux to change desired bits.
> > 
> > Now that we have a pin controller - which is resposnsible for other 
> > functionality such as pwm, i2c, uart2, it makes sense to have a consistent
> > device tree
> 
> What makes it confusing is that you make multiple changes at once. It
> would be easier to follow if you added the pinmux and removed the
> mmioreg mux, and move the switch into the mdio-bus-mux node. Then in a
> second patch rearrange the mdio-bus-mux. Small simple steps, with good
> commit messages are much easier to follow and say, Yes, this is
> correct.
> 
Sure, le me declutter this.

Thanks,

Vivek
