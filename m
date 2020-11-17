Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657352B5620
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgKQBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 20:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKQBQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 20:16:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFCEC0613CF;
        Mon, 16 Nov 2020 17:16:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so5228152pgb.4;
        Mon, 16 Nov 2020 17:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QL8bbL+oGG6j6oJ9WDXTBxGYp2AuVWWexQCgXhyNIw=;
        b=UzrhGmoUmM8ZOz+737sUWqYfpZdtl90uocjfMWmiVl9dmtFbEMana3Bc3y8L9pp7II
         wnIpwQwAs70r5FmJBe+p10GqkY84K1z+l1imKI25hqOoG7gPXQccxHBPMS7nsymmz/YU
         6gvgFLulRuKS2VqsccCdluS6S4soaChBTxcLwijS1onUrjad1u/DvPJe6e9ZvdeeOC5T
         CbCpRZ4wvMez0H2dz5reHYPdu6qlyjTKzntDoQsCsbQzB5nGOkGax9Jk9UDSfO7fveLX
         i0TJvZVrRZnMqmZZplsdXRGfvKRfOlIQ6BQiVPIGbY0dtA0um6bhTEYCnAv7dpqPM6NB
         2ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QL8bbL+oGG6j6oJ9WDXTBxGYp2AuVWWexQCgXhyNIw=;
        b=Zsd5JUqyFWJAo5jLd7AklKwIBQjKa3rMPxFgja1/g+3xF533vQDTghfiCZ7JrKSMCn
         yXzAeX9BZPVHpdgEgLMarknuvXessMQvE8fMlKb9TcsUvWDQdVVby2mHCPPg98tEWT1M
         me0hNtdV01YOC5LuLl230QCgASI8aRKgUodCH14+Im3ctp9+9U9G6yFGGu+3n48GNmLd
         3dKW74IRok4Sc949l3xv0j9MScu+Fo52hl0XylUPI/8W7fhkm70eWzc+5oZvvy2aKgVY
         TSIxZ/8snINS1HNP8b50vqTDPBzRsqdH+paE3v8LvbVv/JlouFYcAWffQgrmTsQJa0Sw
         dl5g==
X-Gm-Message-State: AOAM532CYzvXpBBCSITd/scN15mG/QGnlHfbkVwFK+jtOd209RSfxG/L
        gw2Bm2XW2zM6cHEoHO2vvqQ=
X-Google-Smtp-Source: ABdhPJyZmrK95Glb6r1a/zk7QiBx5GV1jnOBBZa8fDAoJbRhXkoD/TKm2WoqieMhtraGYKlO38A0hA==
X-Received: by 2002:a17:90a:4a12:: with SMTP id e18mr1870538pjh.9.1605575770256;
        Mon, 16 Nov 2020 17:16:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id h14sm19306404pfr.32.2020.11.16.17.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 17:16:09 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:16:03 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] ARM: dts: aspeed: minipack: Fixup I2C tree
Message-ID: <20201117011602.GA28529@taoren-ubuntu-R90MNF91>
References: <20201110072446.8218-1-rentao.bupt@gmail.com>
 <CACPK8Xcpj_LsYOJ=S0p1D5Wqof_2m7SLnPRantQen61B2_XjAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xcpj_LsYOJ=S0p1D5Wqof_2m7SLnPRantQen61B2_XjAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:33:45AM +0000, Joel Stanley wrote:
> On Tue, 10 Nov 2020 at 07:24, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Create all the i2c switches in device tree and use aliases to assign
> > child channels with consistent bus numbers.
> >
> > Besides, "i2c-mux-idle-disconnect" is set for all the i2c switches to
> > avoid potential conflicts when multiple devices (beind the switches) use
> > the same device address.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I will apply for 5.11.

Great. Thank you Joel!


Cheers,

Tao
