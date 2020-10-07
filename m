Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA0286A88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgJGVxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgJGVxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:53:07 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3732083B;
        Wed,  7 Oct 2020 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602107586;
        bh=MPd+m+gOLhyTzVCwh1CGngmTmB7inK08d900/ooQw9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnxFOdeNEKmQJdA5hETP2QGSDLr/fCGuUC9/1xgIQl+np7cqXuRCiQQaM2GvsmRRh
         ez1hPfv5bD5jjNNanaYgG3D+i+t+oAemCw+0Cv63eCgSd+VJ15urbTIh32t06eCEMO
         ZCvbQLL/TeJAdIT0860MmhjRRkXTShnCH6kllMb8=
Date:   Wed, 7 Oct 2020 14:53:05 -0700
From:   jaegeuk@kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com
Subject: Re: [f2fs bug] infinite loop in f2fs_get_meta_page_nofail()
Message-ID: <20201007215305.GA714500@google.com>
References: <000000000000432c5405b1113296@google.com>
 <20201007213253.GD1530638@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007213253.GD1530638@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07, Eric Biggers wrote:
> [moved linux-fsdevel to Bcc]
> 
> On Wed, Oct 07, 2020 at 02:18:19AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    a804ab08 Add linux-next specific files for 20201006
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17fe30bf900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ee250ac8137be41d7b13
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336413b900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f7392b900000
> > 
> > The issue was bisected to:
> > 
> > commit eede846af512572b1f30b34f9889d7df64c017d4
> > Author: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date:   Fri Oct 2 21:17:35 2020 +0000
> > 
> >     f2fs: f2fs_get_meta_page_nofail should not be failed
> > 
> 
> Jaegeuk, it looks like the loop you added in the above commit doesn't terminate
> if the requested page is beyond the end of the device.

Yes, that will go infinite loop. Otherwise, it will trigger a panic during
the device reboot. Let me think how to avoid that before trying to get the
wrong lba access.

> 
> - Eric
