Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F242B558C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgKQAJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQAJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:09:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE732465B;
        Tue, 17 Nov 2020 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605571779;
        bh=kxglu5UvP5BYkoq5KmpDkh39wczJaE8VszE0bLZCrWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u0dTIwkh4WBu5GRaGCFP4C7qBv/iSMk4MP+foCBRnVkYjGDtkMfxhLQ3sQAbpc2IX
         YxO2z3g8OwGmNlda4hjKLNTE1jq8bsrxJqJZmh4545Lh4MeuVSAcSgaln/s0sBeSgC
         yPQVNe3jx2XGAqc7imhFfUVrwQGc6ghpSlsAbc2o=
Date:   Tue, 17 Nov 2020 09:09:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 1/2] tools/bootconfig: Align the bootconfig applied
 initrd image size to 4
Message-Id: <20201117090936.cfa520bc662954d2fb6fc895@kernel.org>
In-Reply-To: <CAHk-=wj-eXNoAXmtsr3hiLWsJffVpi9sOzy6W-gQwqAqbDBv5A@mail.gmail.com>
References: <160554375807.96595.16142008590130221699.stgit@devnote2>
        <160554376709.96595.14400301252651907015.stgit@devnote2>
        <CAHk-=wj-eXNoAXmtsr3hiLWsJffVpi9sOzy6W-gQwqAqbDBv5A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 10:29:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Nov 16, 2020 at 8:22 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >         /* TODO: Ensure the @path is initramfs/initrd image */
> > -       ret = write(fd, data, size + 8);
> > +       ret = write(fd, data, size);
> >         if (ret < 0) {
> >                 pr_err("Failed to apply a boot config: %d\n", ret);
> 
> Side note: that's not the right error check for a write() call.
> 
> The problem predates your patch, so it's independent, I just noticed
> as I looked at it.
> 
> The right error check is
> 
>         if (ret != size) {
> 
> because partial writes can happen even with regular files (yeah, it's
> not POSIX, but NFS is a thing).
> 
> And the filesystem filling up is a possibility too, of course.

Yes, and I also found the error message used return code, but it must use
errno...  

> 
> > +               /* Write padding null characters */
> > +               ret = write(fd, padbuf, pad);
> > +               if (ret < 0) {
> ...
> > +       ret = write(fd, &size, sizeof(u32));
> > +       ret = write(fd, &csum, sizeof(u32));
> 
> Those two guys don't check at all...

Oops, OK, fix it.

> 
> >         /* Write a magic word of the bootconfig */
> >         ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> >         if (ret < 0) {
> 
> .. and same comment.
> 
> Anyway, I'm not sure this is worth worrying about - even on NFS the
> partial IO thing is basically non-existent.
> 
> But the filesystem full (or file size limit, or whatever) case is real
> even on POSIX filesystems, and testing for write errors by checking
> for a negative return is simply incorrect.
> 
> Partial writes are an issue (although the _next_ write will then
> return an error, so you have to be unlucky to hit that partial write
> on the very last write() that you do and that you test the return
> value incorrectly).
> 
> The fact that it works in all normal circumstances just means that
> these kinds of bugs tend to stay around, until somebody is really
> unlocky and then you have inexplicably corrupt files..

Agreed. If I hit the partial write, I need to roll it back. Or bootconfig
command can not find the magic word and initrd image may just increase
the size with the garbage data.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
