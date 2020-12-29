Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347822E7329
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL2TEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgL2TEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:04:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B095B207BD;
        Tue, 29 Dec 2020 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609268651;
        bh=ffPMj1yl0t55UFvL8DR/1pnYLFgb/BU5SmeZ55STWzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dKN+Offne8Iv6Yuk6MjQtKBW2MWzzJfObFQyaOxs/IpVii6LZ8T3+0QkVWRHkSJPF
         YSKDF7wp/yFoUQ1QY70TseozUFwGqUUlnnazl8kavzNZ8xcsp37TTllBT+Fysxaek3
         dQZyD7V6K0IxiTN9xS2TTEDEqXNMoAF9KVz0dFcw=
Date:   Tue, 29 Dec 2020 11:04:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH] mm: fix extend calculation for move_page_tables()
Message-Id: <20201229110410.f2ad1655bacb2dd381be7a07@linux-foundation.org>
In-Reply-To: <20201229174517.GA31435@ls3530.fritz.box>
References: <20201229174517.GA31435@ls3530.fritz.box>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 18:45:29 +0100 Helge Deller <deller@gmx.de> wrote:

> On parisc the kernel fails to start the init process because in
> shift_arg_pages() in fs/exec.c, move_page_tables() is called to e.g.
> move pages from start addr 0xffeff000 to the new start addr 0xf9ccb000
> with a length of 0x1000 bytes, but move_page_tables() instead returns
> that it apparently moved 0x57000 bytes. Since the number of bytes is
> different than the number of bytes which should have been moved,
> shift_arg_pages() aborts with -ENOMEM.
> 
> Debugging shows that commit c49dd34018026 ("mm: speedup mremap on
> 1GB or larger regions") is the culprit.
> In this commit, the extent calculation was tried to be optimized, but
> got it wrong for this case.
> The patch below reverts to the previous way to calculate the extent and
> thus fixes the boot problem.
> 

Thanks.  The same as
https://lkml.kernel.org/r/20201219170433.2418867-1-kaleshsingh@google.com.
I'll get that sent to Linus today.

