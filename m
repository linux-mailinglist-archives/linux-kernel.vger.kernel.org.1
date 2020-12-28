Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEB2E34BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgL1HbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgL1HbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:31:21 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3707C061794;
        Sun, 27 Dec 2020 23:30:40 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so8699283ilv.13;
        Sun, 27 Dec 2020 23:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=PLj3xp/tnzBuICb8JY9cCXsEgsM5eWUgcYLIaAX7RK4=;
        b=QVbKRq2RaQGz9CPlf7Hrb0fvk/wxTvA1WzFiQzNIGE+k/VUe0vIosTnbDqVG1qS63e
         dLwXX1akd/EbgWwKIWdklDpyK0Cqgw9G+QEm9TPs4risdP2UnF/LTe6imkGYRL4XenP0
         5jGUFviJD03Hc9IlFr/F3VaBZRxhNQfOgT5f4V6ss6BKkw+n7Nxkb0MJqJni5pMvHmmw
         4ZhFWMQzzxUz1idUKCHk6tUY+GBQvbWWrBCllIRqlvLc188a2M9C0RHpv+uA3X3fyOjT
         jt2PJApiBAOXoM2HjnVJJKeD+MMnbBDJsq7PjDJT/gbeDyMkiGpaUoC/aQDjTAoBVlEQ
         0C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PLj3xp/tnzBuICb8JY9cCXsEgsM5eWUgcYLIaAX7RK4=;
        b=KDj6skOrtDiTfy7/aMpLCfKRAE1+IXFIzvM7ghoSdLL7aLPZC4deVdTMXX2ifvyHCo
         Zx0b0LHB6A38F7i76JxdH3vreEXbC3emPhFjQ6SgNWXz2iQBUhPzmQvlnRc28h6pYjAh
         S4egaDlxHIVHFNrMuXLmFT7MyXIhXFvf1WUsQj2FbybDbE8uXg0/HQTFq0kT3OwlXYTe
         39ycIPjqdayj4bf3JcksDEbDonful2NfyGRvuRiARfU32WU9osB1VZ3aWR3/JO8R9rKE
         FyjzUxJbKzngLklP5pI/Ke1o8P+dONctkaeY43S0IECVM+DO3m6SUG0RU88s7UbkHe2T
         65ZQ==
X-Gm-Message-State: AOAM532n2nBlrUtSZQrbrRY1zo1BfMcg3C+KkvtJSh+Rus4+POEgP9lG
        pBV2yVq83/nN4Yij2/onkmKb2xWU5i70r1zv46k=
X-Google-Smtp-Source: ABdhPJxRZgKrgCXLxaIfm3OWx7j0283r+yW7Sl+eD/d00xWM97Ohyv3Q8b5uSTitI12oARar7RF0mxmOC6m7Tl3V6II=
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr43930600ilv.112.1609140640035;
 Sun, 27 Dec 2020 23:30:40 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 28 Dec 2020 08:30:29 +0100
Message-ID: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     inux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me I am not subscribed to LKML and linux-kbuild ML ]

Hi Linus, Hi Mashiro,

thanks for the Linux v5.11-rc1 release.

With a new release I always do my first builds with my distro's
default compiler and linker (GCC v10.2.1 and GNU/ld BFD v2.35.1).
( It's approx. 40% faster than LLVM toolchain v11.0.1-rc2 here on
Debian/testing AMD64. )

The only warning I see for the first time (with v5.10.3 not observed):

  sh ./scripts/depmod.sh depmod 5.11.0-rc1-1-amd64-gcc10-bfd
Warning: 'make modules_install' requires depmod. Please install it.
This is probably in the kmod package.

The only change I see in this area is:

436e980e2ed5 kbuild: don't hardcode depmod path

depmod from kmod Debian package is placed and I have no /sbin in my
user's path (and not before?):

$ dpkg -L kmod | grep bin | grep depmod
/sbin/depmod

$ which depmod
[ empty ]

$ echo $PATH
/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

OK, this is a warning, but might confuse other users.

Please, let me know if you need further information and keep me CCed.

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/linus/436e980e2ed526832de822cbf13c317a458b78e1
