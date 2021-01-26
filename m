Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6298B304F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405386AbhA0BqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389970AbhAZS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:58:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB14C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id q12so24155798lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Mxs8zdPL9ZCk9Zox8X2AwOBA0ccyG0LX0dVQErVm1c=;
        b=J3sN4vLoRR7x1dOvFIHB7r0/iDhFudSOptoKKsXRf9q2UmM0m094AqRVckbabGnP1c
         H7woMscbuu2Vz/7WVc9iyaisVzOQjyUtlD56frv8CWjaygmqZiSDBJr/mHBbhjXz07bN
         wsD/IFz7lFDGRI1rkDw86Nmwg7p8BEwf8ara4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Mxs8zdPL9ZCk9Zox8X2AwOBA0ccyG0LX0dVQErVm1c=;
        b=HA966GpEheM7i6qf0vAbopcZybVkkxWg7lKFHTid8qURvj7V8AeLF4UZyKFu0VVanX
         M2P4NB7Tre6oQHvY+nb4Kh0i406i4AFaInRaSyg2t5punyopjDTZimhTGhgQwge972mC
         RDZKgWIHNlZc4EnqMRJNo9Rl56F7M5MzqO11b+h07viBYzQg3/FzzInljeiGmr5FrLLX
         1/MRWJD6TV3a+j0e/oP9QhjqY/Lm3c5kHmqQ2wlXffU5N5Lu2CZwClwEQ0dLi+tQXW3f
         5g9UDRWwSNmk91CMXRYioNTjXiCKa+Ci5dAMqdoqEIXh3Vt3l+A8/BgGuB1x3W03x//j
         tHNA==
X-Gm-Message-State: AOAM531js3g+RwF/La1HW1VzenHt5q4zH+fgPJLSFRg9NvVBp5gFA3ME
        Mx9ZW9A6dPoym1x4d0jpJugwGEMEgDA72A==
X-Google-Smtp-Source: ABdhPJyiZwApyATdJkNjzLZSzYzOBNtrooFk6y7cp4gcaV8yUmcVGBXcAPVX8xjVKsthNthVkXfsIA==
X-Received: by 2002:a19:c34b:: with SMTP id t72mr3143059lff.45.1611687476264;
        Tue, 26 Jan 2021 10:57:56 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h4sm1586590lfe.268.2021.01.26.10.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:57:55 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 3so20935263ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:55 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr3509780ljo.61.1611687474763;
 Tue, 26 Jan 2021 10:57:54 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca> <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210126060720.GJ740243@zeniv-ca> <20210126060932.GC1461355@zeniv-ca.linux.org.uk>
In-Reply-To: <20210126060932.GC1461355@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jan 2021 10:57:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWRjNwmyBXcLWSiHiLgG5jNxeFskSgTzdj=r9yn3Nbig@mail.gmail.com>
Message-ID: <CAHk-=wiWRjNwmyBXcLWSiHiLgG5jNxeFskSgTzdj=r9yn3Nbig@mail.gmail.com>
Subject: Re: [PATCH 3/3] teach sendfile(2) to handle send-to-pipe directly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> no point going through the intermediate pipe

Ok, this series looks fine to me.

Al - do you want me to apply this as patches for 5.11 (and I'll revert
the then unnecessary one-liner), or should I expect a pull request or
what?

              Linus
