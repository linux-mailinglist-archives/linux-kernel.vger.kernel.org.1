Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA752FBD88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbhASR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390864AbhASR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:26:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E093C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:25:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o10so30128893lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSuxKl9i3MviKkXc1tPk1ynw+W/qV9a+NFF8vAhWt1Y=;
        b=BvEi4TQRn5+15HoGp/+RRlpw3/o46gBl2BWPMovGuq5ET0EnljlKkuuVyP/gR6btg4
         i3BBIXx0Fe+Cf6yHXdAahAnr3C3GNvZHK24KUjcs87/8hSYNIN9B6KBJOxAAHSmZEMYT
         8sktds61hNSKjE/JVBkCFdCdbN8U1q+kIjuv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSuxKl9i3MviKkXc1tPk1ynw+W/qV9a+NFF8vAhWt1Y=;
        b=LWhxSBIYiSkF9uUnCdOuCRD8jSdYRDxtKCKfLQfC9ElBxvkfMN6EV3iggDRyevOnbp
         BE2NGUUsnAAk2loaS96RepTH8+fzDnZ8Nos47vPVad0wRJ3orsas64SPpM6g4MOh32xN
         ZEyzs6K+LXqCQiQ/z6gqnppBFQoZfdsiQcyfcm4LeYh5qTkqVhRFuHNfd6D8qfkfCpny
         Ot5+/WsmAty6kyeg3uU6osdu0NyzEfgc6SoSbPzJAUf8Q1er6wWaVAPgfBGHtIOA+7oD
         Xd070wb1K19EfVNJ6L4e4jIx8qXHY9WzWPkn5WBGMXu6ICtZbPO25sc5c87+jxulU+z2
         Uqbw==
X-Gm-Message-State: AOAM531lbqF0s8Doo362lxZpjoPzodk50M2lCLy0ooeMdcmWCkC4agcJ
        F+7zwFJixIMgT8dIrUW9l0eNwch9U/0VuQ==
X-Google-Smtp-Source: ABdhPJy05hmQ9F+59mUexdDjp0wq3+6r2eRkwrdgQlDRWXedirkGAoGl4eRK3TAmnVrvww0QVCikmg==
X-Received: by 2002:a05:6512:3a8e:: with SMTP id q14mr2104367lfu.209.1611077138316;
        Tue, 19 Jan 2021 09:25:38 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q25sm2335609lfd.282.2021.01.19.09.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:25:37 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id o13so30199971lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:25:37 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr2222580lfh.377.1611077137003;
 Tue, 19 Jan 2021 09:25:37 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
 <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
 <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
 <CAHk-=wjgufiORSuAb270XpGn45jexRjP9SCmcc7AAAZsVrAaPw@mail.gmail.com>
 <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com> <YAbIVgGt1Qz8ItMh@kroah.com>
In-Reply-To: <YAbIVgGt1Qz8ItMh@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jan 2021 09:25:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_CDqKUZ50QkEhKrAwuEm=qLs=rEFf8e2uUWEqL13oGw@mail.gmail.com>
Message-ID: <CAHk-=wi_CDqKUZ50QkEhKrAwuEm=qLs=rEFf8e2uUWEqL13oGw@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 3:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This looks sane, but I'm still missing what the goal of this is here.
> It's nice from a "don't make the ldisc do the userspace copy", point of
> view, but what is the next step in order to tie that into splice?

I'll cook something up. With this, it should be fairly easy to add
both the splice and iov_iter versions, because now it only needs the
wrappers in tty_io.c, not for each line discipline.

I hope. Let's see..

           Linus
