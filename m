Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC72C7191
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgK1Vvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgK1Sw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:52:58 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 21:23:41 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kishZ-00F0hc-Ex; Sat, 28 Nov 2020 05:23:17 +0000
Date:   Sat, 28 Nov 2020 05:23:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Walt Drummond <walt@drummond.us>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, brgerst@gmail.com, linux@dominikbrodowski.net,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/signals: Fix save/restore signal stack to correctly
 support sigset_t
Message-ID: <20201128052317.GY3576660@ZenIV.linux.org.uk>
References: <20201119221132.1515696-1-walt@drummond.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119221132.1515696-1-walt@drummond.us>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:11:33PM -0800, Walt Drummond wrote:
> The macro unsafe_put_sigmask() only handles the first 64 bits of the
> sigmask_t, which works today.  However, if the definition of the
> sigset_t structure ever changed,

... existing userland would get fucked over, since sigset_t is
present in user-visible data structures.  Including the ones
we are using that thing for - struct rt_sigframe, for starters.

Layout of those suckers is very much cast in stone.  We *can't*
change it, no matter what we do kernel-side.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
