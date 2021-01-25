Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676573020E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbhAYDtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhAYDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:49:03 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:48:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id g69so12606904oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4a5tIooMtDv6SEF5S8JWRuXD5tSGj5nomhEoxl5xxAI=;
        b=OqiLSnfu+tQexnWWZ8goPT//Wha9q1odHy9SG8B2EbmvN4OOAyT4nYYrsmdu5XUP6i
         YhsOIUt9azUt1ngiybqOELwzk8nyDQTG1tDT1Ho97HdfjWzhy7DftXaRgltJFARrI3iH
         FucRaYCXljbOHafpJstBfiv6t1YH/Lox73Gxh29P2xA6Zh7s/F4THxi2nLZ7xarpV6FJ
         6Y+WznhANn8wY8CqopcbfwJkE2GpP1fcuucuECFqBTyQyvjfoa3CMEUfhAFy047Z4mmp
         ARWz+LHL/U8Ic2RF24oz+5KMo49x3r2Z1bACpCg072BIjSoQ1t1U4HGlKoHHK5JCwNfb
         7dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4a5tIooMtDv6SEF5S8JWRuXD5tSGj5nomhEoxl5xxAI=;
        b=d/45fB2Jr1Lo1Ob8pk9IAabTZCH9TmsfdkvkWx2xGANgRU2gO7GkyqPzp4GhcxHrcQ
         8Gb1UFJYaLmQgKUMumeJqItLvkZYSKbOuU4Y1rIWCCcr6Ts3gqwiLHcq/sHbgM6CGWQw
         TcezVQZQdFmH+SHy6tHeyMtW/jQ0RF/YhrVvHbszBbA9zkXn1jzrem+zvAtSaODAhG5e
         Yw8BfN76Q6/NdRPlLVsKmj3XEe5pT+0GhPje0Wi6lGXZ/IjzNc8oaR8isyzNCIi+/Mzh
         wPcb52uOD1GeqLqhuRynflpUFf2dDBpbG5k7u31dP2cgoLQtvtaOM52beDCYslSHFmWa
         /Ccw==
X-Gm-Message-State: AOAM533IoMQ3NHx/rp3FaAm0xFVZ/Gu7HSHUjUpYAGNl/ogsUcQJPzN5
        i2DNBUuwhUEl2VOiNFZaqZkAHg1BbUM=
X-Google-Smtp-Source: ABdhPJzcQMDfQHGPqJ/RgMNNO3VA8m+v15OrrPuwhd1dkqShv58/L+TZr9RCbKjMI1b6+dnIps8YUA==
X-Received: by 2002:aca:620a:: with SMTP id w10mr25005oib.66.1611546501896;
        Sun, 24 Jan 2021 19:48:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w11sm3283359otl.13.2021.01.24.19.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jan 2021 19:48:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Jan 2021 19:48:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210125034819.GA163132@roeck-us.net>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 05:06:40PM -0800, Linus Torvalds wrote:
> So this rc looked fairly calm and small, all the way up until today.
> 
> In fact, over 40% of the non-merge commits came in today, as people
> unloaded their work for the week on me. The end result is a slightly
> larger than usual rc5 (but both 5.10 and 5.8 were bigger, so not some
> kind of odd outlier).
> 
> Nothing particularly stands out. We had a couple of splice()
> regressions that came in during the previous release as part of the
> "get rid of set_fs()" development, but they were for odd cases that
> most people would never notice. I think it's just that 5.10 is now
> getting more widely deployed so people see the fallout from that
> rather fundamental change in the last release.  And the only reason I
> even reacted to those is just because I ended up being involved with
> some of the tty patches during the early calm period of the past week.
> There's a few more still pending.
> 
> But the bulk of it all is all the usual miscellaneous fixes all over
> the place, and a lot of it is truly trivial one- or few-liners. Just
> under half the patch is for drivers, with the rest being the usual mix
> of tooling, arch updates, filesystem and core (mm, scheduling,
> networking).
> 
> Nothing here makes me go "Uhhuh" in other words.
> 

Looking pretty good now.

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Guenter
