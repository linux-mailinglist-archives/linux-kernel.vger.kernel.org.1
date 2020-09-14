Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA526844A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgINFz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgINFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:55:55 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1DC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:55:54 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0A68BC009; Mon, 14 Sep 2020 07:55:50 +0200 (CEST)
Date:   Mon, 14 Sep 2020 07:55:35 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        justin.he@arm.com, Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200914055535.GA30672@nautica>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914033754.29188-5-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914033754.29188-5-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for having a look a this!

Jianyong Wu wrote on Mon, Sep 14, 2020:
> Eric's and Greg's patch offer a mechanism to fix open-unlink-f*syscall
> bug in 9p. But there is race issue in fid comtention.
> As Greg's patch stores all of fids from opened files into according inode,
> so all the lookup fid ops can retrieve fid from inode preferentially. But
> there is no mechanism to handle the fid comtention issue. For example,
> there are two threads get the same fid in the same time and one of them
> clunk the fid before the other thread ready to discard the fid. In this
> scenario, it will lead to some fatal problems, even kernel core dump.

Ah, so that's what the problem was. Good job finding the problem!


> I introduce a mechanism to fix this race issue. A counter field introduced
> into p9_fid struct to store the reference counter to the fid. When a fid
> is allocated from the inode, the counter will increase, and will decrease
> at the end of its occupation. It is guaranteed that the fid won't be clunked
> before the reference counter go down to 0, then we can avoid the clunked
> fid to be used.
> As there is no need to retrieve fid from inode in all conditions, a enum value
> denotes the source of the fid is introduced to 9p_fid either. So we can only
> handle the reference counter as to the fid obtained from inode.

If there is no contention then an always-one refcount and an enum are
the same thing.
I'd rather not make a difference but make it a full-fledged refcount
thing; the enum in the code introduces quite a bit of code churn that
doesn't strike me as useful (and I don't like int arguments like this,
but if we can just do away with it there's no need to argue about that)

Not having exceptions for that will also make the code around
fid_atomic_dec much simpler: just have clunk do an atomic dec and only
do the actual clunk if that hit zero, and we should be able to get rid
of that helper?


Timing wise it's a bit awkward but I just dug out the async clunk
mechanism I wrote two years ago, that will conflict with this patch but
might also help a bit I guess?
I should probably have reposted them...


So to recap:
 - Let's try some more straight-forward refcounting: set to 1 on alloc,
increment when it's found in fid.c, decrement in clunk and only send the
actual clunk if counter hit 0

 - Ideally base yourself of my 9p-test branch to have async clunk:
https://github.com/martinetd/linux/commits/9p-test
I've been promising to push it to next this week™ for a couple of weeks
but if something is based on it I won't be able to delay this much
longer, it'll get pushed to 5.10 cycle anyway.
(I'll resend the patches to be clean)

 - (please, no polling 10ms then leaking something!)


Thanks,
-- 
Dominique
