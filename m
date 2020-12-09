Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA62D4320
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbgLINWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgLINV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:21:56 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A15C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:21:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so2055657ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IyiTZpFMWvho+JM2+aig10THM9jkmZ2YbNfJyb9npHk=;
        b=e+keF/stQgGiu+hxG7sTEMXYfX4O61ecoiPDsUDGl3dOrWutrsLAhY/lDNFIcB7aoR
         Pb6hl5Z/QbIGpUtieTf0/gvDkDxoU8RbG1JpTH86/55vEwQLnufSeZgc3oszltnWZTtY
         sPmHXotGIeyyf6NVDT8FFLHv0Hkhc9TlY+JNg0BGxRsq9H+Z4thgiRgtC96fSFVGiv0z
         dCg4N1ghLuefyX4zqAilkFhreeOWjqOgBfxNEHwFK4qA85n47gRCd3FH5iPLwH7bsYoq
         lsPIWWgVc0/aoIr2a2UFtPrTlFEClKiBA6IsqxJgB312ZjUvR0CXZEw9gvlJBjKOaFPo
         6sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyiTZpFMWvho+JM2+aig10THM9jkmZ2YbNfJyb9npHk=;
        b=HR3lmQA+2t2cYobZMchxTwx4FyHBAorbLr0Fd7nhp35uYPzmwbNqc242tlhiv+ZOBw
         R4+/DjzsCzIbLbFC9pfEiNA2NDXiT0AJ/9OwlrbSb+Poe81CaIzTFjBZ827couSQgZ2i
         I4JINW0PUet9o+5BqmOBXYngwqIReML+AqRwp5i1T/jQTmS8ehQdlRhe06DyhI3ofI2S
         xe6q45ns3xcLS/KBrZg28/++/8rxTYBTLVV1J2x5dY5kS7gl9Ko0KUQxVR8z1jLGhcWP
         DpWbtIVG8d/tLd/ywMtlO+daMyKvGBKw7AF7zCeHhHiAIkQAPQwV184wfEXI0Usb8Gt+
         A9Nw==
X-Gm-Message-State: AOAM533a+fkvVq5nU5sn0w6aHsZyzD7ScpFCRPfG5fJvbDy06FjLKrol
        6kC4HgOvAUEUbZV4LhBIWD9bVYrGU6I=
X-Google-Smtp-Source: ABdhPJwI+x4mpGBusS3qLS30R3YRoEABqmd7Fq3rlTuowRM0vtGfvezAW23It/hbYBGzknQcuz9lkA==
X-Received: by 2002:a17:906:2445:: with SMTP id a5mr2100219ejb.330.1607520074363;
        Wed, 09 Dec 2020 05:21:14 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id o11sm1525640ejh.55.2020.12.09.05.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:21:13 -0800 (PST)
Date:   Wed, 9 Dec 2020 15:21:11 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Aswin C <realc@protonmail.com>
Cc:     Aswin C <aswinraman2013@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH] net: dsa: sja1105: Remove an unprofessional word from
 the code comments
Message-ID: <20201209132111.ofpwfofsu5yiuetw@skbuf>
References: <20201208103332.5095-1-realc@protonmail.com>
 <20201208123515.wb72g6zwtxlawp34@skbuf>
 <-gMuTlvCAcfhIMqI1V4ylxBXKdWffUwznP_0cODJaam4l3hyfEFTLkZUZMLQV23BCeO8S6vTh1OfN0yOi7M5PhfX0rOX8SkL9JknVM2nKOA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <-gMuTlvCAcfhIMqI1V4ylxBXKdWffUwznP_0cODJaam4l3hyfEFTLkZUZMLQV23BCeO8S6vTh1OfN0yOi7M5PhfX0rOX8SkL9JknVM2nKOA=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswin,

On Wed, Dec 09, 2020 at 11:54:20AM +0000, Aswin C wrote:
> Hello. Thank you very much for the reply.
>
> Firstly, yes, it's my first contribution and apologies for making some
> mistakes and I'd like to thank you for being kind and pointing it out.

No problem. Nobody is born educated, it is through mistakes that we learn.
There is also a convention for replying to email, I might add. It is to
trim down the quoted portion only to what you are replying to, and to
reply below it (and not above, aka top-posting), and to use plain text
and not HTML. This is how your email looks like in plain text. It
doesn't look pleasant to read:
https://lore.kernel.org/lkml/-gMuTlvCAcfhIMqI1V4ylxBXKdWffUwznP_0cODJaam4l3hyfEFTLkZUZMLQV23BCeO8S6vTh1OfN0yOi7M5PhfX0rOX8SkL9JknVM2nKOA=@protonmail.com/
Try to configure your email client to use plain text.

> I came to know about this driver in a casual discussion among my peers
> when one of them pointed out the presence of this particular word on
> the driver.

Who are your peers and why do they care about the Linux driver for an
automotive Ethernet switch?

> I just thought that I'd try to help and get rid of that, if possible.
> Nothing more.

So you do consider that getting rid of it is helpful. Please elaborate.

> As you mentioned, I ran my eyes over drivers/net/dsa/sja1105/sja1105_tas.c
> and the other files. Other than a very minor spelling error, I didn't
> come across wording conventions like the one we are discussing about.

Read more.

> And yes, as you mentioned, "poorly organized" sounds perfect, too.

Well, even though it may sound better to you, I am still not sure I
agree with the change. To reiterate, "professional" was not a goal of
this driver. There are other professional drivers for this hardware.
It is all for fun.

I find that suppressing negative emotions, anger, frustration, is not
helpful, as it tends to only amplify them over time. Instead, learning
to disguise aggressivity, controlling it, making it more subtle and
never directing it towards people can be good ways to let it out.
If I wasn't subtle enough or it really bothered you, I'm open to improve
and do better next time, but you'll have to convince me.

And this is not only about me. In general I believe that you will not
receive a positive reaction from people when you point out to them that
they should watch out for their language in circumstances that really do
not make any difference to you. The linux mailing lists are an amazing
place to learn from people. But engineers do not have good social
skills. You need to make concessions to others' personalities before you
could focus on the good part and learn from them. I think it would be a
shame to start your contributions to the Linux kernel in this way, by
making the language less vulgar. You sure won't be making any friends.
There are plenty of other areas you could concentrate on.

> I believe that not signing off and not sending it to all maintainers
> is all, in the things I did wrong. So, I hope I can fix them and send
> the patch as a reply to this thread.

Do not send follow-up patches in reply to existing threads. They get
lost by maintainers.
Instead, use git send-email --cover-letter="PATCH v2 net-next" and be
sure to send it to the maintainers and the networking mailing list.
