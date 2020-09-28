Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9455527AF68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1NwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgI1NwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:52:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601301135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YE4k2pWThF1WI5QAP4ZHPvanx0t+8Sk8eygkRif+n10=;
        b=ealttz+LeyCszE+ov86vkMM52KabcPGeiGnVFLjYS/mq9S8XddHfP+CLHVHnbKKekXLcE6
        0HBYt1UnFBAV2lmRWH+4EVgNsy2MVYY+GWWOjttuWRYA28CJRGbXchcv7TEwLrZ6BpoEfR
        pyM2Fhb20b1pUA5nVmDsD59TXJP7/VQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-yOlWpJyONYqD_ghYVMhSFQ-1; Mon, 28 Sep 2020 09:52:11 -0400
X-MC-Unique: yOlWpJyONYqD_ghYVMhSFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B17E581F010;
        Mon, 28 Sep 2020 13:52:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8D9D78822;
        Mon, 28 Sep 2020 13:52:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9510644A40;
        Mon, 28 Sep 2020 13:52:10 +0000 (UTC)
Date:   Mon, 28 Sep 2020 09:52:08 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Andrew Price <anprice@redhat.com>
Cc:     agruenba@redhat.com,
        syzbot <syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Message-ID: <1727915046.18798145.1601301128691.JavaMail.zimbra@redhat.com>
In-Reply-To: <5da06d81-7313-288e-14bd-c3aac70dd08c@redhat.com>
References: <0000000000000fe7c205b03aa9e9@google.com> <5da06d81-7313-288e-14bd-c3aac70dd08c@redhat.com>
Subject: Re: [Cluster-devel] general protection fault in gfs2_withdraw
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.68, 10.4.195.22]
Thread-Topic: general protection fault in gfs2_withdraw
Thread-Index: ubuZeyR+w1YWAGpaEZxzJkJAalPukA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> On 26/09/2020 18:21, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    7c7ec322 Merge tag 'for-linus' of
> > git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11f2ff27900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=50a8a9cf8127f2c6f5df
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/
> > c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160fb773900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104f109900000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com
> > 
> > gfs2: fsid=syz:syz.0: fatal: invalid metadata block
> >    bh = 2072 (magic number)
> >    function = gfs2_meta_indirect_buffer, file = fs/gfs2/meta_io.c, line =
> >    417
> > gfs2: fsid=syz:syz.0: about to withdraw this file system
> > general protection fault, probably for non-canonical address
> > 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 0 PID: 6842 Comm: syz-executor264 Not tainted 5.9.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:signal_our_withdraw fs/gfs2/util.c:97 [inline]
> 
> Seems that it's withdrawing in the init_inodes() path early enough
> (while looking up the jindex) that sdp->sd_jdesc is still NULL here:
> 
>    static void signal_our_withdraw(struct gfs2_sbd *sdp)
>    {
>            struct gfs2_glock *gl = sdp->sd_live_gh.gh_gl;
>            struct inode *inode = sdp->sd_jdesc->jd_inode;
> 
> I'm undecided as to whether the bug is that we're withdrawing that early
> at all, or that we're not checking for NULL there?
> 
> Probably introduced by:
> 
> 601ef0d52e96 gfs2: Force withdraw to replay journals and wait for it to
> finish
> 
> Andy

Hi Andy. Thanks for your analysis.

I suspect you're right.
It's probably another exception to the rule. We knew there would be a few of
those with 601ef0d52e96, such as the one we made for "withdrawing during withdraw".
We should probably just add a check for NULL and make it do the right thing.

Regards,

Bob Peterson

