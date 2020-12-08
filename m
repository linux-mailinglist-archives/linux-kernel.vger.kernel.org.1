Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C652F2D1F32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgLHAnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLHAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:43:10 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA5C061749;
        Mon,  7 Dec 2020 16:42:29 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmR5H-00HIUX-3e; Tue, 08 Dec 2020 00:42:27 +0000
Date:   Tue, 8 Dec 2020 00:42:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [sparc64] current git kernel networking is broken
Message-ID: <20201208004227.GF3579531@ZenIV.linux.org.uk>
References: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:09:47AM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Sorry for the late report, being 5.10-rc7 is out, but current git
> kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
> is broken with the networking. It affects my openvpn tunnel and even
> internet networking.
> 
> ping to a local ethernet network (i.e. gateway ping) works, but i
> cannot download files from the internet.
> openvpn tunnel does not work.

<eyes commit in question>
<swears>
Could you check if the following typo fix is sufficient for your
reproducer?

diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 0c0268e77155..d839956407a7 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -71,7 +71,7 @@
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
-	mov		1, %o3
+	mov		-1, %o3
 	clr		%o4
 	andcc		%g1, 0x3, %g0
 	bne,pn		%icc, 95f
