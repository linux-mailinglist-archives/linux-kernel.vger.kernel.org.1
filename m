Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0C304F15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392466AbhA0Bml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394916AbhAZSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:50:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5429C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:49:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so14312997lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zp5zqcUr5zdSzWcHDEL/zZzFElwnhTTkbEQQHu2hn1U=;
        b=aVcmvN+dyB1tgIWsW5Xce8LkTtkBMU7EFzzxcwk2Sx0EdX+o3iAPoF9xQc2bx4nKrn
         OdXusgRW8rCb9+LIaqFdy2IF7ce060RrcbTSz/4D9+RP7ql49cROkSVCtG4VjmVFDMue
         uuoBaUwR0w+4KmIvumCpHEcfpCGyOhKZri45M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zp5zqcUr5zdSzWcHDEL/zZzFElwnhTTkbEQQHu2hn1U=;
        b=m0tQsgQfCKzanFGVjhRn86dCU/181nuJnEIpQBFqx3NWsh2+9SZM+kDrBeCnCNdBaJ
         gnR36yFPViH1Vc5KK9LzXWVTxWKk9oIThv8AX8LQ4ZqNDNV/8Mah6/cSFtNBAoJm8Yq+
         3pFJ19SEBUu3ylVnsSpGVgxeXwbk/Lv3QNNp2YRxUE9PgN3Xj4EQO1r3h7BFvuigMcpD
         gu5dM8186GUGwm78wm2PiKTr/qJINAkR9U7KmRhvSgl9XMcQDsrYeU7N+rs1OecOGkCb
         2QM0T+8f5Ken7dVf7XSU8crSH0MBQoStbx+Dcn8kHW1XTYqDM5YLKTX43UYsD2e+1ikP
         TSgg==
X-Gm-Message-State: AOAM533NccLh2PRfB8GCqSK3uYKFgAlbFoDb7V2kd1TGO9evGaAN5auM
        PPbmzpzLjIclgbshhD/x5yQgQWIjfeOzaA==
X-Google-Smtp-Source: ABdhPJxcLtiCeHqWVW10CXIhSUkXrG3uKxv43QCS4RFJu7/zuhrRtGdi317UnmcQmVL7nS+5STm/Fw==
X-Received: by 2002:a19:c89:: with SMTP id 131mr3344938lfm.584.1611686969141;
        Tue, 26 Jan 2021 10:49:29 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h23sm2708968lfc.246.2021.01.26.10.49.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:49:28 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id a12so16024806lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:49:27 -0800 (PST)
X-Received: by 2002:ac2:5502:: with SMTP id j2mr3141247lfk.421.1611686967549;
 Tue, 26 Jan 2021 10:49:27 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca> <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210126060720.GJ740243@zeniv-ca>
In-Reply-To: <20210126060720.GJ740243@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jan 2021 10:49:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9BELRf-huvVa2vQpFqKiqLHwqu9Wc6RHTvCcVS=5SDA@mail.gmail.com>
Message-ID: <CAHk-=wh9BELRf-huvVa2vQpFqKiqLHwqu9Wc6RHTvCcVS=5SDA@mail.gmail.com>
Subject: Re: Splicing to/from a tty
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

On Mon, Jan 25, 2021 at 10:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Jan 24, 2021 at 11:11:42AM -0800, Linus Torvalds wrote:
> >
> > I agree that it would be better fixed by just having sendfile()
> > basically turn into splice() for the pipe target case, but I haven't
> > seen any patches from you, so I assume it wasn't 100% trivial.
>
> Just to make clear - sendfile() regular-to-pipe is *not* the same
> issue as splice to/from tty.

That's not what I meant.

sendfile() to a pipe is basically the same thing as splice() to a pipe.

Except I think it might have different looping behavior. And as you
noted earlier, the error returns may be randomly different.

             Linus
