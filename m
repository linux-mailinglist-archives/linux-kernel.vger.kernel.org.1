Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49AB2DE960
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLRS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLRS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:58:38 -0500
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Dec 2020 10:57:57 PST
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FDC0617A7;
        Fri, 18 Dec 2020 10:57:57 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 84ADD5872FB54; Fri, 18 Dec 2020 19:52:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 789BF60C43A95;
        Fri, 18 Dec 2020 19:52:08 +0100 (CET)
Date:   Fri, 18 Dec 2020 19:52:08 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Sam Ravnborg <sam@ravnborg.org>
cc:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
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
        linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org,
        gentoo-sparc@l.g.o
Subject: Re: [PATCH v1 01/13] sparc32: Drop sun4m/sun4d support from
 head_32.S
In-Reply-To: <20201218184347.2180772-2-sam@ravnborg.org>
Message-ID: <sq2nqr43-21s-21sn-219r-9o83o310r5s9@vanv.qr>
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201218184347.2180772-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 2020-12-18 19:43, Sam Ravnborg wrote:
> notsup:
>-	.asciz	"Sparc-Linux sun4/sun4c or MMU-less not supported\n\n"
>-	.align 4
>-
>-sun4e_notsup:
>-        .asciz  "Sparc-Linux sun4e support does not exist\n\n"
>+	.asciz	"Sparc-Linux sun4* or MMU-less not supported\n\n"
> 	.align 4

The asterisk may lead to a moment of bewilderment; sun4u/sun4v are still 
supported.
