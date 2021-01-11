Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89392F1DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390239AbhAKSQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:16:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389561AbhAKSQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:16:07 -0500
Received: from zn.tnic (p200300ec2f088f00ad31e6206ee73146.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:ad31:e620:6ee7:3146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AC561EC04DD;
        Mon, 11 Jan 2021 19:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610388925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=LqhEmeChdpVI9A3LFYC0dxLv7JlJQp9P7NdtivLsWZk=;
        b=V1F1Dy6v2dW95huyl7fPJ9zNWXGMYblO28MvDxddKBgaO8I6jD6IkxuaOTucauoDo9/b7/
        QYPN/5Clgj2uXWdYRmZg3n6+8i1z8GnflpqCWzlY3eDDoUlNq4oZLs9qASac/4TXaozRv5
        f1rdKnlYt3tl0Xuv1b931MMLH/ka/v0=
Date:   Mon, 11 Jan 2021 19:15:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     tdevries@suse.com, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: gdbserver + fsgsbase kaputt
Message-ID: <20210111181520.GE25645@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so there's a breakage of a use case with gdbserver on fsgsbase machines,
see

https://sourceware.org/bugzilla/show_bug.cgi?id=26804

Tom has an even simpler reproducer:

$ cat test.c
int
main (void)
{
  return 0;
}
$ gcc test.c -m32
$ gdbserver localhost:12345 a.out
... other terminal ...
$ gdb -batch -q -ex "target remote localhost:12345" -ex continue
Program received signal SIGSEGV, Segmentation fault.
0xf7dd8bd2 in init_cacheinfo () at ../sysdeps/x86/cacheinfo.c:761

The correct output is, of course:

...
[Inferior 1 (process 1860) exited normally]

I tried to bisect this but it led me to:

  b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")

which simply enables fsgsbase so I could've made a small mistake in the
bisection.

I say small because booting with "nofsgsbase" cures it so it must be
something fsgsbase + ptrace especially since the symptom is a corrupted
stack canary in %gs...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
