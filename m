Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4321C94B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgGLMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 08:40:33 -0400
Received: from mail.stusta.mhn.de ([141.84.69.5]:39686 "EHLO
        mail.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgGLMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 08:40:33 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jul 2020 08:40:32 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4B4R3s1S8Hz1n;
        Sun, 12 Jul 2020 14:31:52 +0200 (CEST)
Date:   Sun, 12 Jul 2020 15:31:51 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200712123151.GB25970@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
>...
> but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"
>...

I won't attend, but I do have a topic that should be covered:

Firefox always depends on recent Rust, which forces distributions to 
update Rust in stable releases.

As an example:
Ubuntu LTS releases upgrade to a new Rust version every 1-2 months.
Ubuntu 16.04 started with Rust 1.7.0 and is now at Rust 1.41.0.

It would not sound good to me if security updates of distribution
kernels might additionally end up using a different version of the
Rust compiler - the toolchain for the kernel should be stable.

Would Rust usage in the kernel require distributions to ship
a "Rust for Firefox" and a "Rust for the kernel"?

> Thanks,
> ~Nick Desaulniers

cu
Adrian
