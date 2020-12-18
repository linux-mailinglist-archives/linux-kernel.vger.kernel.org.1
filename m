Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E312DEAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgLRU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgLRU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:58:24 -0500
X-Gm-Message-State: AOAM530stEErVHdrUUDZB6BA6w1qMUkIDs1eNECuVwwjvdc/YX9joBWs
        d8NKfLfa6+Vv6u3nsadn+v82UDyQqobvsZiOdpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608325084;
        bh=NDWyD44yv5h4fmgy5/aj2LJSkbrK3dYAcTBLz1rEuhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KeMJCRnTw9phxa7F612ovvnYF4uSaT2vNACdpXKmZJFI6S3Go0Bxke27R2yuGhx1T
         qRVjF37iL4eHwXiW7qhGMW981FW0drS3McSsG7PDzSe2cIgwaQhtYatF1oYb9uULNu
         opb9nw7K2N3T13HAlJDwI7lGUMwS2k6n6qVtiT1lhhKrx0kLXAeAGTzybNyAnd98q7
         PsPAruci3WUj25/qzKRKXOZu2DV34ooicBzYNncYOzB6Xuya0mS6K/Oh1T2RcnnRyV
         FdnDBQJZ88n0hQ76/VdmckeTTWD1SjKs5HuCubgwgwBpOjanoYOz2wTijTZljrEpQN
         EMA2PCgJjFpgw==
X-Google-Smtp-Source: ABdhPJxouB7L6MRsWBksjwJ4rgPpSege1Mw5uUvSWOuHYxF/DoyPNrFkO54j9UDdw1WxdtX3aNU0eJ0hyaR7AFGMuzw=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr4228287otm.305.1608325084134;
 Fri, 18 Dec 2020 12:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201218184347.2180772-3-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-3-sam@ravnborg.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Dec 2020 21:57:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Q1EvvyuPNn7V7tysCDubeyYQe+Z-9dM9iu-CM3XJM8A@mail.gmail.com>
Message-ID: <CAK8P3a1Q1EvvyuPNn7V7tysCDubeyYQe+Z-9dM9iu-CM3XJM8A@mail.gmail.com>
Subject: Re: [PATCH v1 02/13] sparc32: Drop floppy support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David S Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        debian-sparc@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 7:43 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> LEON do not have floppy support so we can drop it
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Denis Efremov <efremov@linux.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: sparclinux@vger.kernel.org
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> ---
>  arch/sparc/Kconfig                 |   2 +-
>  arch/sparc/include/asm/floppy.h    | 786 ++++++++++++++++++++++++++++-
>  arch/sparc/include/asm/floppy_32.h | 393 ---------------
>  arch/sparc/include/asm/floppy_64.h | 779 ----------------------------

Rather than renaming the floppy_64.h to floppy.h, it might be easier to just
remove the #else from floppy.h, similar to what asm/adi.h does.

This might be helpful in the (unlikely) case that someone has patches for
this file and wants to rebase them.

       Arnd
