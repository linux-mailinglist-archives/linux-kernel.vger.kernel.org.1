Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286662C7AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgK2TfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgK2TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:35:19 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B4C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:34:38 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so9295466iln.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrCD3mA5Olpt2H5c3KcvfE24BrJX4U4Y5EspwM0r63Y=;
        b=UFn6ISBx8NsI1cjPakuJ53hAPgzk+3mBf2hqWZfAT7QhuCLmWlTXxrW7WnLDJoFTdU
         0Lkn8QU8kNgR+/8U+n/UUF7jDAmEqUtCAxzhSft57+4oINaAmvhvgH+a+UIpzfcc+kKw
         PVYXCIdYBmYIhsbVENybB8mXiEFJ+993iMEh1Yn/TK3uhZMjnFZIvjKFHXuLcFY3m4Pn
         /vmZZ/1A/VpetC3KKd8PBxo5CNKsAxvN3nzc04KmqnyS8YlHl4Z/D75HzAxwLuHPV7a3
         i29sFX2lPJA9VDbRLKqHTdPPO9c3NXLUP7M9cxKy6gqZseGgEorED9jzZDZJI+KenBAE
         RmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrCD3mA5Olpt2H5c3KcvfE24BrJX4U4Y5EspwM0r63Y=;
        b=pDjFnKcbIjnyjQE4J6lSJWVYEGPXyKykEJn6pl189DzQdHJ4dz2ah/nc8cihcqKG0C
         AlBUavoqnk4qaI9rh3U+Y6c3T6MnLjbd6E76uFh80LL17OMaABDOZPCIgZtT4SZuYg/G
         ongBugaiHBkGF+rTrN4AqG+xoJMJQvieyBjJchmPX3bMg4dnhRIOlEVwENmwxaxBQEjz
         BAsP5fJ8/CYVqeX52z0IhsKQ1HhZ7X29ma+dIJ6CRHFz2D1/iMAPNppmVBIVnuW3pSH5
         rkyv4Dk2Zcat4q//yEzkPzv2T0Fez8+ctR9RDPaiNpNTpg1HmvOM05q29ENhkBcor64c
         gLvQ==
X-Gm-Message-State: AOAM532v3krwkGygXLR8fc00/wd4dxREL28QNK2DxSBJ2SvTTcvOynXt
        p+RlNbKt6KE6lMsZydcmLUW6i9SXhRtOmRalmnl/cA==
X-Google-Smtp-Source: ABdhPJw/lP0mfiZkw0iXv7B+KKy+rmVtb+hS5qjJcjrno7g1bCz0vyIHGDezmsDt8f5wW75Y7m9KTE5cAcv9A7UPPFo=
X-Received: by 2002:a92:c213:: with SMTP id j19mr16249711ilo.255.1606678478036;
 Sun, 29 Nov 2020 11:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20201129102400.157786-1-jean.pihet@newoldbits.com> <20201129165627.GA2234159@lunn.ch>
In-Reply-To: <20201129165627.GA2234159@lunn.ch>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Sun, 29 Nov 2020 20:34:27 +0100
Message-ID: <CAORVsuUez9qteuuqkGpQbU5yXjAFxcpRXGaXnKwqm-hKSKF6NQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: dsa: ksz: pad frame to 64 bytes for transmission
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

On Sun, Nov 29, 2020 at 5:56 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 29, 2020 at 11:23:59AM +0100, Jean Pihet wrote:
> > Some ethernet controllers (e.g. TI CPSW) pad the frames to a minimum
> > of 64 bytes before the FCS is appended. This causes an issue with the
> > KSZ tail tag which could not be the last byte before the FCS.
> > Solve this by padding the frame to 64 bytes minus the tail tag size,
> > before the tail tag is added and the frame is passed for transmission.
>
> Hi Jean
>
> what tree is this based on? Have you seen
The patches are based on the latest mainline v5.10-rc5. Is this the
recommended version to submit new patches?

>
> commit 88fda8eefd9a7a7175bf4dad1d02cc0840581111
> Author: Christian Eggers <ceggers@arri.de>
> Date:   Sun Nov 1 21:16:10 2020 +0200
>
>     net: dsa: tag_ksz: don't allocate additional memory for padding/tagging
>
>     The caller (dsa_slave_xmit) guarantees that the frame length is at least
>     ETH_ZLEN and that enough memory for tail tagging is available.
>

I cannot find this commit. Which tree/branch is it from?

Thanks for reviewing,
Jean
