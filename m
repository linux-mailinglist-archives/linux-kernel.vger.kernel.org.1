Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05D523E44D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 01:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHFXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 19:12:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFXMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:12:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 320BBB5A9;
        Thu,  6 Aug 2020 23:13:10 +0000 (UTC)
Date:   Fri, 7 Aug 2020 01:12:50 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806231250.GA27140@suse.de>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <20200806225651.GC24304@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806225651.GC24304@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:56:51AM +0200, Joerg Roedel wrote:
> I still don't fully understand why, but its late here and my head spins.
> So I take another look tomorrow in the hope to understand it better.

I think I know what the bug is, I am calling p4d_offset(pgd, addr)
without checking for pgd_none() first. That is still a bug in the code
wich needs fixing, even with the revert.


	Joerg
