Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A72EFF78
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 13:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbhAIMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 07:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAIMfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 07:35:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 776D422525;
        Sat,  9 Jan 2021 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610195707;
        bh=GtNFV/pVKoIupNxyNeIvuiRTCJ8JEKJLNh9pSEUSwDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zm4qSLU5zAb6HTsLm3jSOYGMlC4w67Gw+jjb0dGLBqknWgDJlnYDMguTHxNGPhdQy
         M+BfuwANdF2uFOobW7S2IUI5PnWkJwr+k7fGVP6OuFsNspiJEbhyQygE3S+D/BoK4+
         wZco/Sx7H9BQp2EYBJ+H2pooDYcBkjQvVQXi6QOw=
Date:   Sat, 9 Jan 2021 13:36:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Sasha Levin <sashal@kernel.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4.9 00/10] fix a race in release_task when flushing
 the dentry
Message-ID: <X/mjR1UyAi0QFdcR@kroah.com>
References: <20210107075222.62623-1-wenyang@linux.alibaba.com>
 <X/b781Kwn48xq8aS@kroah.com>
 <e0fa1641-d00b-acfc-91d7-9eb16fb61664@linux.alibaba.com>
 <X/dS37kyW+jf4gg/@kroah.com>
 <82fb683a-bc9d-2083-f657-116f3e96d785@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82fb683a-bc9d-2083-f657-116f3e96d785@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:42:47AM +0800, Wen Yang wrote:
> 
> 
> 在 2021/1/8 上午2:28, Greg Kroah-Hartman 写道:
> > On Fri, Jan 08, 2021 at 12:21:38AM +0800, Wen Yang wrote:
> > > 
> > > 
> > > 在 2021/1/7 下午8:17, Greg Kroah-Hartman 写道:
> > > > On Thu, Jan 07, 2021 at 03:52:12PM +0800, Wen Yang wrote:
> > > > > The dentries such as /proc/<pid>/ns/ have the DCACHE_OP_DELETE flag, they
> > > > > should be deleted when the process exits.
> > > > > 
> > > > > Suppose the following race appears：
> > > > > 
> > > > > release_task                 dput
> > > > > -> proc_flush_task
> > > > >                                -> dentry->d_op->d_delete(dentry)
> > > > > -> __exit_signal
> > > > >                                -> dentry->d_lockref.count--  and return.
> > > > > 
> > > > > In the proc_flush_task(), if another process is using this dentry, it will
> > > > > not be deleted. At the same time, in dput(), d_op->d_delete() can be executed
> > > > > before __exit_signal(pid has not been hashed), d_delete returns false, so
> > > > > this dentry still cannot be deleted.
> > > > > 
> > > > > This dentry will always be cached (although its count is 0 and the
> > > > > DCACHE_OP_DELETE flag is set), its parent denry will also be cached too, and
> > > > > these dentries can only be deleted when drop_caches is manually triggered.
> > > > > 
> > > > > This will result in wasted memory. What's more troublesome is that these
> > > > > dentries reference pid, according to the commit f333c700c610 ("pidns: Add a
> > > > > limit on the number of pid namespaces"), if the pid cannot be released, it
> > > > > may result in the inability to create a new pid_ns.
> > > > > 
> > > > > This issue was introduced by 60347f6716aa ("pid namespaces: prepare
> > > > > proc_flust_task() to flush entries from multiple proc trees"), exposed by
> > > > > f333c700c610 ("pidns: Add a limit on the number of pid namespaces"), and then
> > > > > fixed by 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc").
> > > > 
> > > > Why are you just submitting a series for 4.9 and 4.19, what about 4.14?
> > > > We can't have users move to a newer kernel and then experience old bugs,
> > > > right?
> > > > 
> > > Okay, the patches corresponding to 4.14 will be ready later.
> > 
> > Note for some reason you didn't cc: the stable list for these patches :(
> > 
> > > > But the larger question is why are you backporting a whole new feature
> > > > here?  Why is CLONE_PIDFD needed?  That feels really wrong...
> > > > 
> > > 
> > > The reason for backporting CLONE_PIDFD is because 7bc3e6e55acf ("proc: Use a
> > > list of inodes to flush from proc") relies on wait_pidfd.lock. There are
> > > indeed many associated modifications here. We are also testing it. Please
> > > check the code more.
> > 
> > Is the only "issue" here wasted memory?  Will it eventually be freed
> > anyway even if you do not echo to the proc file to flush caches?
> > 
> > You mention the inability to create a new pid for a specific namespace,
> > is that really a problem?  Shouldn't the code handle such issues
> > normally?  What breaks without these changes?
> > 
> > I think at this point, it might just time for you to move to a newer
> > kernel release, as adding a whole new userspace feature for this feels
> > really really odd.
> > 
> > What is preventing you from doing that today?  What holds you to older
> > kernels that will not allow you to move forward?
> > 
> 
> We have encountered this problem in the cloud server environment. Users will
> frequently create and delete containers, and the corresponding pid_ns will
> accumulate, eventually making it impossible to create a new container.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208613
> 
> The kernels (4.9/4.19) used on a large scale in our current production
> environment (almost tens of thousands of machines) may need to be fixed.

What prevents you from moving them to 5.4 or better yet, 5.10?  You will
have to do it soon anyway, I'm sure you have been testing those kernels
to validate that all works well with them on a subset of your
environment, so for those systems that have this problem, why can't you
update the base kernel?

thanks,

greg k-h
