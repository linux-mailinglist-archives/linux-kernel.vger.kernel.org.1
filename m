Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BF2CA577
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgLAOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgLAOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:21:05 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561DAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:20:25 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f24so3114057ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Trz6+0KY4Qq/q4s101pZcFlPrXscSV5EXuw66cbAYr0=;
        b=gXW21Gkj2scr1ID0OtMqYCfgwcmnAlVzaTnB582uTuycQVrMpA46fN8FYu2wJ4EqKV
         r9NxMEv4kVIuEjW+LIbHxPvbsWqsw3VT3RYIL6NaDNRNOVngiTJ+3lxJs2clc8c3GmXW
         ypsIFdtQvZ2rAi1BqP3d7dlrloYWNAlD8gpvUM8zTyP75RLvS6dgHluTsdVX0tC/mzx2
         MN3DUuWtNxwXFgsccmIg+iiZWQGW9E5tusVVT6qxO69KLVsQ9tHgCFIH5OStjc3Op2l0
         ADEYxaz7PERgCQvRK9SioTekX08Tl/MsAcAuV/CKaoP8XuGk4UKaflOuAzo9TtS/NhpO
         NhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Trz6+0KY4Qq/q4s101pZcFlPrXscSV5EXuw66cbAYr0=;
        b=g8SVNcvHccmaO1uGmJw3u360ScSJ56MW3aW14d0izvmhnboD+ZD6eFoDWuinjLllcK
         YNpCg3gVN556qbcCj/wGHl12qtVDI4VJoy8ID7qjUjzAkAR030Y22z3Raw0y4PzT0+Jj
         oKlbSLHZj7Lnjofm58+r8KXoykgSbKCUTe4mcxzM7zP+k7FMXmnFlvCgpfZyHWr/y02Q
         dQQRtDl31xOsizMcqlCjBfubjsPkTmXl53368RtPEMcqhVnm/AJXFforvatdip2apHm0
         2yBm5EsKDAtUI/nNQiyccVzsAJov9tVFntspqx7GosicVGoKtNmQ3z1P07X/1ZCNSO7i
         eOeg==
X-Gm-Message-State: AOAM532I/tXFQorJ8X7KbeKl4us15Lq2CGlsiW1AyfnmscAxUmqlidkl
        WhwKI9Py/4pEYbNEBnXWtXY5NCV7SDVGK75gbOSwqQ==
X-Google-Smtp-Source: ABdhPJy5XB4+Hg/fkqqoNCaepkRjzfuahFStHPkFazfc0TKrZmDycdNyZXrrvdaIy8edVs5wk34Sq5LEOBwWGkdq4ww=
X-Received: by 2002:a2e:998e:: with SMTP id w14mr1513703lji.100.1606832423853;
 Tue, 01 Dec 2020 06:20:23 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
In-Reply-To: <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Dec 2020 15:20:12 +0100
Message-ID: <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus, Sven,

the fault that the thing broke in the first place is all mine.
Credit where credit is due!

The reason why I shoot in the dark to convert all SPI
drivers to use GPIO descriptors instead of the global
GPIO numberspace is detailed in drivers/gpio/TODO
so I will not repeat it here.

I don't know if much can be done about it other than
having better programmers than me at the task. Or
less tired when they write the patch. etc.

What other operating systems do to get around the same
type of refactoring problem is to aggressively
deprecate and delete code that does not follow the
latest ideas of the driver subsystem developer. This
is not an option on Linux because we don't like to leave
working hardware and users behind so I am painstakingly
fixing it all over the place, with a little help from my
friends. Sometimes it blows up in my face, sometimes
in other people faces too, sorry about that.

Yours,
Linus Walleij
