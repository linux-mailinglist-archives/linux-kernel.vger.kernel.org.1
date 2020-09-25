Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9191278536
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIYKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:33:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgIYKdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:33:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4ABC7ACA1;
        Fri, 25 Sep 2020 10:33:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CEDB1E12E1; Fri, 25 Sep 2020 12:33:15 +0200 (CEST)
Date:   Fri, 25 Sep 2020 12:33:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+91f02b28f9bb5f5f1341@syzkaller.appspotmail.com>
Cc:     glider@google.com, jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in udf_evict_inode
Message-ID: <20200925103315.GD11772@quack2.suse.cz>
References: <000000000000f6599a05b01c71ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f6599a05b01c71ed@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-09-20 22:18:21, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c5a13b33 kmsan: clang-format core
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=142cf809900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
> dashboard link: https://syzkaller.appspot.com/bug?extid=91f02b28f9bb5f5f1341
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+91f02b28f9bb5f5f1341@syzkaller.appspotmail.com
> 
> UDF-fs: warning (device loop3): udf_load_vrs: No anchor found
> UDF-fs: Scanning with blocksize 512 failed
> UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
> UDF-fs: error (device loop3): udf_read_inode: (ino 1328) failed !bh
> =====================================================
> BUG: KMSAN: uninit-value in udf_evict_inode+0x382/0x7d0 fs/udf/inode.c:150

Yeah, easy enough. I'll send a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
