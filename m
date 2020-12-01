Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED12CAB38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgLAS6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbgLAS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:58:53 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:58:13 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t13so2743936ilp.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMk7/+B37MjE2tzrVpjBEF0k4vtUEGsXD71pfxhgFE4=;
        b=x6/tobbGhy0Xqa4b1ZSQcuDLcGemKwX40boAQa1eiY/vGSl7jxnpqPeqR5/yS3FpPs
         H4Hc+PMXCJ0IGltHfd+vgWCaegFAaKywxkIEYKZe4r/+MBneGrTZOBvrsxca2KDXyvH8
         JdDP0pdWBxSiGIrJ7L+xYiMM4jndSstfo4Llehjys820znyb+y7sqY++pZ2ddnJElllK
         g2ouCAJYkJOZTzWF1xrCPopV7Ai2smiSPHUZI+obDBekhv26x3I8U9yl5cA+/kCdRs92
         Ga6uiFjckfl+uGpEzjc5xRBDxwf7XHvXSZW/bTWHimdBp2R8+iiK504op4SsxF4tJNr1
         CHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMk7/+B37MjE2tzrVpjBEF0k4vtUEGsXD71pfxhgFE4=;
        b=N9jh/0EL50wmMoMvMXmkfjP8jML5XsZiu+4+sLMdLo9xnvfm/fjS9NMisL4PSPn1Fx
         gFVHLvFvorLfUYg/5iAkzcJm8oNh5ib+aiD6ASC3/4gbYdsRuI5CrrtlQFsCctvFv+NC
         ubGYy71r2A/dKycyQLGwIxOfdSTFZg7mkr2yysFXETx/quuxFV2LheU7CvLGIGFLcbbj
         lrgyyzgW6llqbRvuR8WH9OZmpSmh5VNayVwHqWBVnLinL31NUUyocIr4jtSJm0BaNwOx
         MebbnZbB9estBpqL6mhRyMlmiTAWhV5YZXsaQAQdJbGjMYpnsKPj5CkouY9CykBqleev
         8GaA==
X-Gm-Message-State: AOAM531vXiMjzT20l2uKP5SkT85q1a7GiX88m0FCId/c2GHDisMr/du8
        bAIVxXjVMqOwv+jhmFdAQ26LMvacrhf8gQTR5tlIvQ+FZdA=
X-Google-Smtp-Source: ABdhPJyiwXnGw9orV9Hn7BmgZsCLMGAfOhVZJoqb6/qa57XsmjvhkRRffdEVO2fN4fC+AMRV9V6VaqoiuTGX8gA/hBE=
X-Received: by 2002:a92:c213:: with SMTP id j19mr4050312ilo.255.1606849092404;
 Tue, 01 Dec 2020 10:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20201201083408.51006-1-jean.pihet@newoldbits.com> <20201201184100.GN2073444@lunn.ch>
In-Reply-To: <20201201184100.GN2073444@lunn.ch>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 1 Dec 2020 19:58:01 +0100
Message-ID: <CAORVsuXv5Gw18EeHwP36EkzF4nN5PeGerBQQa-6ruWAQRX+GoQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: ksz8795: adjust CPU link to host interface
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Hugo Cornelis <hugo.cornelis@essensium.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Dec 1, 2020 at 7:41 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Dec 01, 2020 at 09:34:08AM +0100, Jean Pihet wrote:
> > Add support for RGMII in 100 and 1000 Mbps.
> >
> > Adjust the CPU port settings from the host interface settings: interface
> > MII type, speed, duplex.
>
> Hi Jean
>
> You have still not explained why this is needed. Why? is always the
> important question to answer in the commit message. The What? is
> obvious from reading the patch. Why does you board need this, when no
> over board does?

I reworked the commit description about the What and thought it was
enough. Do you need a cover letter to describe it more?

The Why is:
"
Configure the host port of the switch to match the host interface
settings. This is useful when the switch is directly connected to the
host MAC interface.
"
Thank you for reviewing the patch.

BR,
Jean
>
> Thanks
>         Andrew
