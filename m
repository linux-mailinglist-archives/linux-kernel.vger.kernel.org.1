Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836A02CB83D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgLBJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:11:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:46210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387891AbgLBJLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:11:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D65DAED8;
        Wed,  2 Dec 2020 09:10:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC2701E1318; Wed,  2 Dec 2020 10:10:40 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:10:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jan Kara <jack@suse.cz>,
        =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
Message-ID: <20201202091040.GA3534@quack2.suse.cz>
References: <20201130223059.101286-1-brgerst@gmail.com>
 <20201201094810.GB24488@quack2.suse.cz>
 <20201201155126.GE22927@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201155126.GE22927@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-12-20 16:51:26, Borislav Petkov wrote:
> On Tue, Dec 01, 2020 at 10:48:10AM +0100, Jan Kara wrote:
> > On Mon 30-11-20 17:30:59, Brian Gerst wrote:
> > > Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments to
> > > use the compat handlers to allow conversion to passing args via pt_regs.
> > > sys_fanotify_mark() was however missed, as it has a general compat handler.
> > > Add a config option that will use the syscall wrapper that takes the split
> > > args for native 32-bit.
> > > 
> > > Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
> > > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > 
> > Thanks for the patch! It looks good to me. Feel free to add:
> > 
> > Acked-by: Jan Kara <jack@suse.cz>
> > 
> > I assume you plan to push this via x86 tree given the changes are mostly
> > there, don't you?
> 
> Looks sane to me too, I guess I can send it to Linus even now so that it
> lands in 5.10. Is that what you'd prefer Jan?

Yes, that would be fine by me. Although I don't think there's a huge rush.
The thing is broken for some time already so if it goes in later with CC to
stable, that would also work OK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
