Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1682ED6B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbhAGS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbhAGS2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:28:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A6FB23428;
        Thu,  7 Jan 2021 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610044048;
        bh=66kiyYV4QsUShqFsHnKrli1XPFRb81YdO3zpTdzneUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc07YXQh5qOLv6gXRzkf9/EYL2XST1GsgVq09BofgNz/SUWu92n9WD31+iF+Ksg4f
         rCkdjk9MI15VD4Qvv51C7QR0mfpdhV7zZjrPJxGF7RTlbxwUJqTdOeWEnUxYsicQar
         HUl39QgSkqTLAFejeACSRqMKK2iX77iFBDXhK/Fo=
Date:   Thu, 7 Jan 2021 19:28:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Sasha Levin <sashal@kernel.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4.9 00/10] fix a race in release_task when flushing
 the dentry
Message-ID: <X/dS37kyW+jf4gg/@kroah.com>
References: <20210107075222.62623-1-wenyang@linux.alibaba.com>
 <X/b781Kwn48xq8aS@kroah.com>
 <e0fa1641-d00b-acfc-91d7-9eb16fb61664@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0fa1641-d00b-acfc-91d7-9eb16fb61664@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:21:38AM +0800, Wen Yang wrote:
> 
> 
> 在 2021/1/7 下午8:17, Greg Kroah-Hartman 写道:
> > On Thu, Jan 07, 2021 at 03:52:12PM +0800, Wen Yang wrote:
> > > The dentries such as /proc/<pid>/ns/ have the DCACHE_OP_DELETE flag, they
> > > should be deleted when the process exits.
> > > 
> > > Suppose the following race appears：
> > > 
> > > release_task                 dput
> > > -> proc_flush_task
> > >                               -> dentry->d_op->d_delete(dentry)
> > > -> __exit_signal
> > >                               -> dentry->d_lockref.count--  and return.
> > > 
> > > In the proc_flush_task(), if another process is using this dentry, it will
> > > not be deleted. At the same time, in dput(), d_op->d_delete() can be executed
> > > before __exit_signal(pid has not been hashed), d_delete returns false, so
> > > this dentry still cannot be deleted.
> > > 
> > > This dentry will always be cached (although its count is 0 and the
> > > DCACHE_OP_DELETE flag is set), its parent denry will also be cached too, and
> > > these dentries can only be deleted when drop_caches is manually triggered.
> > > 
> > > This will result in wasted memory. What's more troublesome is that these
> > > dentries reference pid, according to the commit f333c700c610 ("pidns: Add a
> > > limit on the number of pid namespaces"), if the pid cannot be released, it
> > > may result in the inability to create a new pid_ns.
> > > 
> > > This issue was introduced by 60347f6716aa ("pid namespaces: prepare
> > > proc_flust_task() to flush entries from multiple proc trees"), exposed by
> > > f333c700c610 ("pidns: Add a limit on the number of pid namespaces"), and then
> > > fixed by 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc").
> > 
> > Why are you just submitting a series for 4.9 and 4.19, what about 4.14?
> > We can't have users move to a newer kernel and then experience old bugs,
> > right?
> > 
> Okay, the patches corresponding to 4.14 will be ready later.

Note for some reason you didn't cc: the stable list for these patches :(

> > But the larger question is why are you backporting a whole new feature
> > here?  Why is CLONE_PIDFD needed?  That feels really wrong...
> > 
> 
> The reason for backporting CLONE_PIDFD is because 7bc3e6e55acf ("proc: Use a
> list of inodes to flush from proc") relies on wait_pidfd.lock. There are
> indeed many associated modifications here. We are also testing it. Please
> check the code more.

Is the only "issue" here wasted memory?  Will it eventually be freed
anyway even if you do not echo to the proc file to flush caches?

You mention the inability to create a new pid for a specific namespace,
is that really a problem?  Shouldn't the code handle such issues
normally?  What breaks without these changes?

I think at this point, it might just time for you to move to a newer
kernel release, as adding a whole new userspace feature for this feels
really really odd.

What is preventing you from doing that today?  What holds you to older
kernels that will not allow you to move forward?

thanks,

greg k-h
