Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF422C9E51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgLAJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:48:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:53164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgLAJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:48:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01135AB7F;
        Tue,  1 Dec 2020 09:48:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD3961E1318; Tue,  1 Dec 2020 10:48:10 +0100 (CET)
Date:   Tue, 1 Dec 2020 10:48:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
Message-ID: <20201201094810.GB24488@quack2.suse.cz>
References: <20201130223059.101286-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130223059.101286-1-brgerst@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-11-20 17:30:59, Brian Gerst wrote:
> Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments to
> use the compat handlers to allow conversion to passing args via pt_regs.
> sys_fanotify_mark() was however missed, as it has a general compat handler.
> Add a config option that will use the syscall wrapper that takes the split
> args for native 32-bit.
> 
> Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
> Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Thanks for the patch! It looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

I assume you plan to push this via x86 tree given the changes are mostly
there, don't you?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
