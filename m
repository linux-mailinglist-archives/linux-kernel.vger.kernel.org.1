Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6A2DEB01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgLRVTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:19:43 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40140 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLRVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:19:42 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 6B4F220028;
        Fri, 18 Dec 2020 22:18:54 +0100 (CET)
Date:   Fri, 18 Dec 2020 22:18:53 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jan Engelhardt <jengelh@inai.de>
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
        linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: [PATCH v1 01/13] sparc32: Drop sun4m/sun4d support from head_32.S
Message-ID: <20201218211840.GB2421393@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
 <20201218184347.2180772-2-sam@ravnborg.org>
 <sq2nqr43-21s-21sn-219r-9o83o310r5s9@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sq2nqr43-21s-21sn-219r-9o83o310r5s9@vanv.qr>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=vNdoKIDsHdQOlDJFrDYA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Fri, Dec 18, 2020 at 07:52:08PM +0100, Jan Engelhardt wrote:
> 
> On Friday 2020-12-18 19:43, Sam Ravnborg wrote:
> > notsup:
> >-	.asciz	"Sparc-Linux sun4/sun4c or MMU-less not supported\n\n"
> >-	.align 4
> >-
> >-sun4e_notsup:
> >-        .asciz  "Sparc-Linux sun4e support does not exist\n\n"
> >+	.asciz	"Sparc-Linux sun4* or MMU-less not supported\n\n"
> > 	.align 4
> 
> The asterisk may lead to a moment of bewilderment; sun4u/sun4v are still 
> supported.
Noted, I will come up with something better.

	Sam
