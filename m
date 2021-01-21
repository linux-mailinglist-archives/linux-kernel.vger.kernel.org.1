Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE82FDE74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbhAUBG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733068AbhAUBFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:05:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:04:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so168740lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46JmxQ/CXvqo7noi2pYcomoHRmx8I4MAsLM9m4zPwbY=;
        b=PEJ4sY4JTDMp8ROFgcjmj4wCXUhcDWjUZ3D4sxBVhAJTjNl6AclmeoS7EDrOypXB7N
         gt+3Tyu4y2dCx3um4G/gBMeEggOPzTSWE4Vl4v9BRW3wkHsJW/RsbyqOqCHHMBThaY4f
         4U+DZjYcVpTbfNYfF0/NGgMjxadIJ6LGX4o+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46JmxQ/CXvqo7noi2pYcomoHRmx8I4MAsLM9m4zPwbY=;
        b=Na/vLz949K4X+lGXJWXI19vdAsk2Ftd/xnDAIFp5OCHYqbLGbQ9i7TYjeHrSlaFNn+
         dxRdB/1iC/XNYbK+/u6OMTZTeZhBT0YBTlL/FBkGJJthJFGtCHyR+I3n2sR3PdtzYuUC
         xHm+JWEmrrI+vItq3FLGwvMD9Vt+RbN4a6oe8Fhhxcr3Gi6JbYKWaOhz7TmTPMfxMnsw
         Z6+GvmO6Cdlunk2rWrjN3n+gmqmC5JXESzkLNIsmMrIusVu07R6D07yqgq9BkoPPfb3Q
         chPZ8KdH4Q0f/w7T6bbiRp7EcFHiJxNw5F3FPe2yTderA30ao0bheVv3vY9n49wF/Z7V
         SPpQ==
X-Gm-Message-State: AOAM532gKNGdbrTSE0vuDmQUVuzR7bj+zlF03TCL4jDBcY4ih2dG63vt
        5/ZzWUgmVC2d3Z3wN/ywQM4soYICARhegw==
X-Google-Smtp-Source: ABdhPJyn3iJBMEgAdBMX6CK0wnhP9ZT8V3EB3xk/7576hIIk4gHpEmSE0DHnkgPj2st6w/DA955Tmw==
X-Received: by 2002:ac2:43a4:: with SMTP id t4mr5406297lfl.197.1611191076057;
        Wed, 20 Jan 2021 17:04:36 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k11sm345877lfm.181.2021.01.20.17.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 17:04:34 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o19so221863lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:04:34 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr5205705lfc.421.1611191073977;
 Wed, 20 Jan 2021 17:04:33 -0800 (PST)
MIME-Version: 1.0
References: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca> <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca> <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
 <20210121003835.GF740243@zeniv-ca>
In-Reply-To: <20210121003835.GF740243@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 17:04:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
Message-ID: <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK...  I wonder how many debugfs writable files allow pwrite() with
> BS results...

I hope some of them check for "pos == 0" when they start parsing integers.

But honestly, I don't think it's a big deal. We've had these things
that just basically assume that whenever you write, the offset just
doesn't matter at all, and as long as some number comes in one single
write call, we accept it.

Because even if you end up doing something like just

   echo $SOMETHING > /sys/xyz/abc

and that "$SOMETHING" could be done multiple writes, in practice it
all works out just fine and it never really is. You almost have to try
to screw up with something like

  (echo -n 3; echo -n 4) > /sys/xyz/abc

to actually see two writes of "3" and "4" instead of one write with
"34". And honestly, if somebody does something like that, do we really
care? They might get 3, they might get 4, and they might get 34. They
get what they deserve.

> Anyway, possibly more interesting question is why do we care about
> O_APPEND at all - why not treat it the same way we do in write()?

The whole point of O_APPEND is that the position shouldn't matter.

And the whole point of "pwrite()" is that you specify a position.

So the two just do not go together - although we may have legacy
issues, of course.

In contrast, the whole point of just a plain "write()" is that the
position is the "current file position", with O_APPEND is just a
special rule for what the current position for a write is.

Now, splice() is able to do *both* write() and pwrite(), because
unlike pwrite() it doesn't take a "pos" argument, it takes a _pointer_
to pos. So with a NULL pointer, it's like read/write, and with a
non-NULL pointer it is like pread/pwrite.

So I do think that "splice with non-NULL off_out and O_APPEND" should
cause an error in general.

That said, we probabyl have legacy behavior with splice and pipes in
particular, and that legacy behavior would override any "this is
conceptually the sane model".

> So... why do we ban O_APPEND on destination for splice() or for sendfile()?

sendfile() shouldn't be an issue. The offset pointer for sendfile is
for the _source_, not the destination.

For splice(), I do think that O_APPEND and a position pointer don't
make sense as a combination, although if we do allow it for regular
file pwrite() (I didn't check), maybe we could allow it for splice()
too just to be erqually inconsistent.

Honestly, I don't think it's a huge deal. O_APPEND isn't that
interesting, but I do hope that if we allow O_APPEND and a file
position, then O_APPEND always overrides it.

           Linus
