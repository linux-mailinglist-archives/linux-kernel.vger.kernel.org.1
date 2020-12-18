Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC53F2DEADD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLRVRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:17:36 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:39904 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgLRVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:17:36 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8EAAA20026;
        Fri, 18 Dec 2020 22:16:40 +0100 (CET)
Date:   Fri, 18 Dec 2020 22:16:38 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH v1 02/13] sparc32: Drop floppy support
Message-ID: <20201218211638.GA2421393@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
 <20201218184347.2180772-3-sam@ravnborg.org>
 <CAK8P3a1Q1EvvyuPNn7V7tysCDubeyYQe+Z-9dM9iu-CM3XJM8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Q1EvvyuPNn7V7tysCDubeyYQe+Z-9dM9iu-CM3XJM8A@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8
        a=Z4Rwk6OoAAAA:8 a=NufY4J3AAAAA:8 a=MYakio4dAAAA:8 a=fxJcL_dCAAAA:8
        a=ebG-ZW-8AAAA:8 a=9jQWrajF32laIYKc0cIA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
        a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
        a=TPcZfFuj8SYsoCJAFAiX:22 a=cei-m1nUyINrUup_78-m:22
        a=Bj2TwAA_C77lQ_X2_dkp:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:57:47PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 18, 2020 at 7:43 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > LEON do not have floppy support so we can drop it
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Denis Efremov <efremov@linux.com>
> > Cc: Willy Tarreau <w@1wt.eu>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: sparclinux@vger.kernel.org
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > ---
> >  arch/sparc/Kconfig                 |   2 +-
> >  arch/sparc/include/asm/floppy.h    | 786 ++++++++++++++++++++++++++++-
> >  arch/sparc/include/asm/floppy_32.h | 393 ---------------
> >  arch/sparc/include/asm/floppy_64.h | 779 ----------------------------
> 
> Rather than renaming the floppy_64.h to floppy.h, it might be easier to just
> remove the #else from floppy.h, similar to what asm/adi.h does.
That is what I had first but then thought it pointless with a wrapper
file. I will revert back to use floppy_64.h for now - we can always
consolidate header files later.

	Sam
