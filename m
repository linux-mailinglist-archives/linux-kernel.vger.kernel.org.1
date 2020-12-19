Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7511E2DF1D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgLSVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:41:51 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:33662 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgLSVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:41:51 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7CD862001F;
        Sat, 19 Dec 2020 22:40:55 +0100 (CET)
Date:   Sat, 19 Dec 2020 22:40:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
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
        gentoo-sparc@lists.gentoo.org, info@temlib.org
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-ID: <20201219214054.GB3132151@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=mgTqUXvhAAAA:8 a=mrJAqwzcyFW6BaUAzm0A:9
        a=CjuIK1q_8ugA:10 a=VOnB0Y9YHlndsCffChEF:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Dec 18, 2020 at 07:43:34PM +0100, Sam Ravnborg wrote:
> The sun4m and sun4d based SPARC machines was very popular in the
> 90'ties and was then replaced by the more powerful sparc64
> class of machines.

I have received a couple of mails in private.
One said it was better to sunset now when it is actually working,
so there is a working state to return to.
Another said that it would be a shame to sunset sun4m and sun4d because
there are so many machines around, and netbsd is also active on the
sparc32 area.


The second mail also re-reminded me of an interesting project
implementing SPARC V8 and the sun4m platform in VHDL.
See https://temlib.org - the author posted a new blog post a
few months ago.

temlib is, to my best knowledge, an impressive one-man project.
And this is not enough to keep sun4m around as this would
require real users that cannot just stay at their current kernel
but who need to follow upstream.

Please keep the inputs coming independent if you are pro or not
for the sunset of sun4m and sun4d.

	Sam
