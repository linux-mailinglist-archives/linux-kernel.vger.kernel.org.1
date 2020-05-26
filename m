Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BA1C640A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 00:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgEEWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 18:37:56 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:33133 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgEEWhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:37:55 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4b5e7785;
        Tue, 5 May 2020 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Xmrp5mSypaMdXoDD21AWMvUQLus=; b=fc+sEK
        //aogbYTSnnJAa80R+/LMD8vukObNf9opqJQXd2VaPOoMoRsTeakuZvT0o9+D5Tu
        UD4jB5fJVHwIAHoxMTenKkJxjPiW/0k+P4oKIooUldnok21aj7L+qGunOg687ddE
        TVbdzT/8e48NqQ+hTIA/wJ9kWI3QDW4GdPVOKs+giK+rfJNeeGX8JEDZv9ff2Zky
        0KLKIoyUT1kXlfXzuCMjCLLJovE2jqvNhgGZnLMIFftqvzdKuyY/18tRkThV1bcm
        j2uyWJdlgNW8yDMmAxXX18HaNWxLbvpDJfQqohwkbZISVO1/2W0c2uMc5nmMt4vh
        ikvqLkY4fLHi/fag==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f08cdc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 5 May 2020 22:25:14 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id f3so225622ioj.1;
        Tue, 05 May 2020 15:37:49 -0700 (PDT)
X-Gm-Message-State: AGi0PubvjxrCIApRoy6usn/dZmjZ0nX5wN6heE9AMYBqRHFIgNkL2uPV
        Ne6kEirxVEhd/g6gh1KXaEBdr4cXHJUnI9CF6r4=
X-Google-Smtp-Source: APiQypIMXHaVA0r53/yu3ohly0KqV9mHBNiR3J+yG56KaFKXdRY80P72wnCldnOEX/2Yawf4pZEuzWOZ1K7cea8YJO8=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr5651739jam.36.1588718269082;
 Tue, 05 May 2020 15:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
 <20200505215503.691205-1-Jason@zx2c4.com> <CAKwvOdk32cDowvrqRPKDRpf2ZiXh=jVnBTmhM-NWD=Ownq9v3w@mail.gmail.com>
 <20200505222540.GA230458@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200505222540.GA230458@ubuntu-s3-xlarge-x86>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 5 May 2020 16:37:38 -0600
X-Gmail-Original-Message-ID: <CAHmME9qs0iavoBqd_z_7Xibyz7oxY+FRt+sHyy+sBa1wQc66ww@mail.gmail.com>
Message-ID: <CAHmME9qs0iavoBqd_z_7Xibyz7oxY+FRt+sHyy+sBa1wQc66ww@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: disable FORTIFY_SOURCE on clang-10
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> I believe these issues are one in the same. I did a reverse bisect with
> Arnd's test case and converged on George's first patch:
>
> https://github.com/llvm/llvm-project/commit/2dd17ff08165e6118e70f00e22b2c36d2d4e0a9a
>
> I think that in lieu of this patch, we should have that patch and its
> follow-up fix merged into 10.0.1.

If this is fixed in 10.0.1, do we even need to patch the kernel at
all? Or can we just leave it be, considering most organizations using
clang know what they're getting into? I'd personally prefer the
latter, so that we don't clutter things.
