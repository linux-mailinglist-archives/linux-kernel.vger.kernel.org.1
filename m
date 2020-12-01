Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86AA2CA918
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbgLAQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbgLAQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:56:27 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9CC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:55:46 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id u7so1274268vsq.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iM9l8tgZXRGlISc4oqNIJMMb7GstcP8ZH/OdjOUcDS8=;
        b=W9eHUZGNvxYAvC2psNE8PfsPB4W0GsE5CEwo2Pdz1pivePDNSr9LLt9Gc/VXr1O8hA
         lbzwYxty5SyyRg67oWBBDGDemV96+a8EcKEFG7fHYCEWhlklFkb1GZ0q9Q9XeF+j/uiD
         G0V8idBEgPv+U9wgGCrejHNAGqCeuKCNar9yIStVO+E3XaEhA9fQt+KG/wZgixDfdN2k
         n+ERR4icbMBNnR4bNQD8YBXJJYxhmYVsutnAoBk0qlemTIWksxvkBuTISIAzXDEZR+5x
         Hn1FLEfQAvOvoNNw2vllmax5GRIU0ySSCIDwZz5HCxO4HjAyyaPZyQK5rSs8DfKHWRAv
         kdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iM9l8tgZXRGlISc4oqNIJMMb7GstcP8ZH/OdjOUcDS8=;
        b=EWxOLgJtBNFaeVaQJCw/0qRISfkXZPOMyKZGWb6n7vTP5pcpou9/FzRyAy4WL9EUl+
         SqKOu4P2fnniWLIOe3pDMtrfuOi6BVElG6xT+8GcGYQW1dWMyZoUIjyPBCk2iMDBERV/
         jUHhUj/vdmiRGqBn7feB4bWAZRnmQcFM46MMfGJvVc+2GcRbqWsrlmrtQfzC2KAvegsp
         6p3MEAzKsbUgOsg6Afs+JatgyVDG5lTbDAxwRaUbQgzqPJfVYsSKKChWm0St+/Q19JUn
         XwnCAqe/V6WQaQt6te6NY9QrPXAEdi2XHJP4ZZ7I554v5aTltcWLalAH4aXu98V6+Ikd
         qshg==
X-Gm-Message-State: AOAM531dTWehaK2RaJz/aPQqU024qr5gSyrWRIXK+NCraLKeTpeRjl73
        FHamJ4NEDlhL9B1QiXZNwA7+ChhTTfy6vS6tqa8=
X-Google-Smtp-Source: ABdhPJzFQiud71piAWzL/bA79v2nwZQdqSO7giMGUjMJu5UMQC2o03Wut2qo408OwGrAmvyk4aT33JZqCcMA0+BAOS8=
X-Received: by 2002:a67:e43:: with SMTP id 64mr3592393vso.40.1606841745952;
 Tue, 01 Dec 2020 08:55:45 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <20201201174433.2000c8a3@aktux>
In-Reply-To: <20201201174433.2000c8a3@aktux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 11:55:34 -0500
Message-ID: <CAGngYiU2OafLOHGJd-hQd-6dpnCdhv2wjKE8kDR0+R8T9B=Pkw@mail.gmail.com>
Subject: Re: [Letux-kernel] [BUG] SPI broken for SPI based panel drivers
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Dec 1, 2020 at 11:44 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> So if that one is really active-low, why did it ever work?!

Because the spi gpio chipselect was broken (inverted), and
766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
fixes it.
