Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E72C7767
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 04:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK2D3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 22:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK2D3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 22:29:22 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CFC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 19:28:42 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjDNv-00FCcT-VO; Sun, 29 Nov 2020 03:28:24 +0000
Date:   Sun, 29 Nov 2020 03:28:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Walt Drummond <walt@drummond.us>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, brgerst@gmail.com, linux@dominikbrodowski.net,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/signals: Fix save/restore signal stack to correctly
 support sigset_t
Message-ID: <20201129032823.GA3579531@ZenIV.linux.org.uk>
References: <20201119221132.1515696-1-walt@drummond.us>
 <20201128052317.GY3576660@ZenIV.linux.org.uk>
 <CADCN6nyGW0=QS=J+704n-mtAqTxgVrKZC=P8d01NZ_pjssptew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADCN6nyGW0=QS=J+704n-mtAqTxgVrKZC=P8d01NZ_pjssptew@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 06:19:31PM -0800, Walt Drummond wrote:
> Thanks Al.  I want to understand the nuance, so please bear with me as I
> reason this out.   The cast in stone nature of this is due to both the need
> to keep userspace and kernel space in sync (ie, you'd have to coordinate
> libc and kernel changes super tightly to pull this off), and any change in
> the size of struct rt_sigframe would break backwards compatibility with
> older binaries, is that correct?

Pretty much so.  I would expect gdb and friends to be very unhappy about
that, for starters, along with a bunch of fun stuff like JVM, etc.

Ask the userland folks (libc, gdb, etc.) how would they feel about such
changes.  I'm fairly sure that it's _not_ going to be a matter of
changing _NSIG, rebuilding the kernel and living happily ever after.
