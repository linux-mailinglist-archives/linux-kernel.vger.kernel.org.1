Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49512DF454
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLTHox convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Dec 2020 02:44:53 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:32893 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgLTHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:44:52 -0500
Received: by mail-wr1-f41.google.com with SMTP id t30so7499517wrb.0;
        Sat, 19 Dec 2020 23:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A51slqXeBIIj2k18wlJdscEv12PXv3H1QDmjxvkdUGk=;
        b=IahXccl6gclbGI4v/BvlBEX66/ErF/BnNvneMj+oNT7rLfulvU1LHSfbA4JFpy1ie+
         GBiKFv8Y6/pLfaGutgzW5TWt70DvoPRUAWPkUGUrE4yIjyTJi3slB4kDXs0JM084bQT/
         j6sNE7PAo5w/2CrsxT0oyEkGK7PzsUGL0en1kMMNNBz8h/1SN3hRWIRVHFCRcc2VQWde
         9OIvGkCDGJ2wYhpk9ve/Hn+9wVrrSdrL6uwfu9AV6q3rjk3nedVJZthEi6Fm0hA+8vIX
         tLTeLiCtIFnYegkgFEYUT1qZjQSPBl/ZNM5QkI7bOvI2jrc+RASBMAP708d0n9xXJMnJ
         VtBg==
X-Gm-Message-State: AOAM533iShmAgZYrhg2SjNGZQpoCqOnjIcLf+tgY3XSAuJ8exHo39elr
        H4c1Ig0pD1Qq4Kc69Asby26W6DN2O3Gj/+Y7O/I=
X-Google-Smtp-Source: ABdhPJyGmFyfcPcbRaV7/tMrGaaU7DRIuh5KMll/evHnxEoEJijvK81yFd90f71FemAn9WdCExmmj3JJ7JL0QbM8ulM=
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr12146820wrj.79.1608450250229;
 Sat, 19 Dec 2020 23:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
In-Reply-To: <20201219214054.GB3132151@ravnborg.org>
From:   Romain Dolbeau <romain@dolbeau.org>
Date:   Sun, 20 Dec 2020 08:43:59 +0100
Message-ID: <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org,
        debian-sparc <debian-sparc@lists.debian.org>,
        gentoo-sparc@lists.gentoo.org, info@temlib.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 19 déc. 2020 à 22:41, Sam Ravnborg <sam@ravnborg.org> a écrit :
> Another said that it would be a shame to sunset sun4m and sun4d because
> there are so many machines around, and netbsd is also active on the
> sparc32 area.

Yes, those were plentiful back in the day and there's still quite a few around.

> The second mail also re-reminded me of an interesting project
> implementing SPARC V8 and the sun4m platform in VHDL.

There's also new hardware being developed for SBus systems :-)
<https://github.com/rdolbeau/SBusFPGA>
(disclaimer: work-in-progress and shameless self-promotion here!).

If there's still a distribution willing to build for Sparc v8, then I
believe the kernel
should try to keep support of the relevant machine architectures if at all
possible...

Cordially,

-- 
Romain Dolbeau
