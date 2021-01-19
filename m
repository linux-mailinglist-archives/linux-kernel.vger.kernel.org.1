Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3E2FB83B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392486AbhASMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392366AbhASMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:05:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83150C061573;
        Tue, 19 Jan 2021 04:04:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so28719735lfo.1;
        Tue, 19 Jan 2021 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dj35Y10xvadEoj4O3QQAv08yPioskFbVaeePKmUZ9Uk=;
        b=OTt/HPQ18ep/L5BQjn0d2sUCrTGC/Eb4Pc7xsKgfQHwU8n7OQPpqQwwWnuLfwgSCwc
         moSPENoto5XgW6Xn2Icf6eRj2iQEoDviYkXjqAqtot/1l9nVW0HwZK+epzIl721H+Mzd
         1QD+hVWp2vE3ofoDobxXyeJf3cjOqbK++JvdC9FkbzerJIzy+q9F6BPLfsbVBS3ZFY5l
         KfYz64mbFZNMrjIgCl9qJBk15ddrGeGhW03U8dCE8mssEOHWmsuqJ6emCHvym2/ar6nf
         9FDnMXSJ0rU1Odei8mUWjPpWLYgh1DoWKNctx6tb/Nzk3B/GBYgiQNLgs5tSOeEZZJrc
         0MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dj35Y10xvadEoj4O3QQAv08yPioskFbVaeePKmUZ9Uk=;
        b=TEv1uLR4MGYn5z4cP5E88612O+MzuenX3iXuMNbwt/SpXGsw2rNSfEVQ1RRDMEhL48
         8MHhqiNgcCjLl9g5fmMdnaAp2ZmWTWBTzgIAmsExbZ7sr1OTDzTgxkqk2gtIrs98JEr9
         IrH94akP9dUN6+NxqsaaihLjlAIi7Yr3Vevl/0LHlTaT0yqYJMainxEES8DWSzamvslp
         jCTytEKGWNnKAoG03jrJKqmezy2/EQ9LUgwBIJ7avo/EdgqsIk7T0btkuYAizg/ihvPb
         bn0HmHrbRypvUSHYhxRDb6qQQC5+dXUzt3/7NgaD9WA3288Cp8boG9wNf+LHlH9FZqwj
         JOUg==
X-Gm-Message-State: AOAM533+d3nKf7NKTm4c3wM5Xd2ebzJhhtpKSxE/vCw9Q/+XekYqoR2y
        Asfsp1EFXsP4GYS3HzYNo+U=
X-Google-Smtp-Source: ABdhPJyKNYJ/6ghlt3pcnWSiKLntUja0K0OPnDzu3Ijj1aZpbb/PUweZfO0FMXBUIReFejQilX6ZPA==
X-Received: by 2002:a05:6512:33a8:: with SMTP id i8mr1895774lfg.5.1611057872008;
        Tue, 19 Jan 2021 04:04:32 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id h1sm2265819lfc.121.2021.01.19.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:04:31 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 10JC4RAh015519;
        Tue, 19 Jan 2021 15:04:28 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 10JC4QTg015518;
        Tue, 19 Jan 2021 15:04:26 +0300
Date:   Tue, 19 Jan 2021 15:04:26 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ernesto Corona <ernesto.corona@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Steven Filary <steven.a.filary@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Amithash Prasad <amithash@fb.com>,
        Jiri Pirko <jiri@mellanox.com>, Rgrs <rgrs@protonmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Patrick Williams <patrickw3@fb.com>,
        Oleksandr Shamray <oleksandrs@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: [PATCH v29 2/6]  dt-binding: jtag: Aspeed 2400 and 2500 series
Message-ID: <20210119120426.GE2971@home.paul.comp>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-3-ernesto.corona@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413222920.4722-3-ernesto.corona@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:29:16PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag: jtag@1e6e4000 {
> +          compatible = "aspeed,ast2500-jtag";
> +          reg = <0x1e6e4000 0x1c>;
> +          clocks = <&syscon ASPEED_CLK_APB>;
> +          resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
> +          interrupts = <43>;
> +      };

It's nice to have an example but shouldn't it also be included in
aspeed-g5.dtsi as part of the patch series if it's known that the
driver works on those SoCs and the peripheral is always present?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
