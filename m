Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF63E2788EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgIYM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:59:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgIYM7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:59:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07118AB9F;
        Fri, 25 Sep 2020 12:59:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA1811E12E1; Fri, 25 Sep 2020 14:59:16 +0200 (CEST)
Date:   Fri, 25 Sep 2020 14:59:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+9991561e714f597095da@syzkaller.appspotmail.com>
Cc:     glider@google.com, jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in udf_get_pblock_spar15
Message-ID: <20200925125916.GE11772@quack2.suse.cz>
References: <0000000000008f4fbc05b00bcbd5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008f4fbc05b00bcbd5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-09-20 02:26:29, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c5a13b33 kmsan: clang-format core
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=12152c81900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
> dashboard link: https://syzkaller.appspot.com/bug?extid=9991561e714f597095da
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9991561e714f597095da@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in udf_get_pblock_spar15+0x4de/0x6b0 fs/udf/partition.c:138
> CPU: 0 PID: 27543 Comm: syz-executor.4 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
>  udf_get_pblock_spar15+0x4de/0x6b0 fs/udf/partition.c:138

I suppose this could result from UDF image where sparing table is larger
than a block. I've added check of the sparing table size to the mount path.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
