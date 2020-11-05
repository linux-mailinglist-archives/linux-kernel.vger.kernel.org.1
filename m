Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AFA2A7E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgKEMcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:32:46 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:43631 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgKEMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=CeSDKjQThdIABp8s+s/E8JP6zStMA/YM/SdYYX3O/K8=; b=lMGWqo4HYT2Vjxdcyu8lRLeUrb
        HEEwVhDEGTlVF+0T4L9udgmm6dSckgzk7oT6ix/TVRJUvumz3RUjt+sf7mLc3ykbhepjXRBo2Jb9d
        y6/Ggj3leVe40XwlqfqJcYbz3XZ+ePY5EgWWYJ26IOos+xUYeBV44l1VYtIA7t1SbYJtSG4Ha+eI3
        +wZsb4dzufLWJa41huRe95It2N3A9X8sQUyh9EPMasD/wx6rlRTHqP8eFZ0ZRPfjqVry3XSy8vuWl
        CrhX7v1QsQ9+nVcL2MVYs0lYDxDgh46yMd5fDue5uZs2TcEZz3udstQKzvzN/O4OG692QZQ+g9I8Q
        AgY3gaQQ==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, ericvh@gmail.com,
        lucho@ionkov.net, groug@kaod.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        justin.he@arm.com
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Date:   Thu, 05 Nov 2020 13:32:34 +0100
Message-ID: <2540304.0IflC6tfRZ@silver>
In-Reply-To: <20201104115708.GA30104@nautica>
References: <20200923141146.90046-1-jianyong.wu@arm.com> <1755303.6a88tIVZ8j@silver> <20201104115708.GA30104@nautica>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 4. November 2020 12:57:08 CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Wed, Nov 04, 2020:
> > > Greg, Christian - from what I understood (in private, hopefully I'm
> > > allowed to repeat!), he won't be able to contribute to qemu because of
> > > company policies and I'm unlikely to take the time either right now.
> > > I don't think it's a problem to continue as is though, we can land linux
> > > kernel support (it's still useful for non-qemu servers) and if someone
> > > is interested later on they'll just need to finish that bit.
> > 
> > Hmm, no idea what kind of policy that is; there is no GPL3 in qemu at
> > least
> > that some companies are concerned about, but OK not my business.
> > 
> > I actually thought this would still take a while on kernel side,
> 
> To be honest, so did I -- the original patches are so old I had more or
> less given up on it :P
> 
> But I don't see any more problem now and we'll want to get there
> eventually so now's a good time as any... I just want to get fault
> injection to work to test various refcounting cornercases but shouldn't
> be much longer.

Exactly! The situation would presumably not change at any other time in 
future. Maybe there will be issues, we'll see, but I think it's worth it, as a 
large bunch of software depends on use-after-unlink behaviour.

> 
> > so in the
> > meantime we layed the ground in qemu for resolving this issue independent
> > of clients and independent of any guest OS installation by introducing
> > test cases using the 9pfs 'local' filesystem driver:
> > 
> > https://github.com/qemu/qemu/blob/master/tests/qtest/virtio-9p-test.c
> > 
> > So the idea was to resolve that chicken egg problem of this issue that way
> > and also handle it a bit more systematically. If you now run qemu's 9p
> > tests with latest git version (or at least with yesterday's QEMU 5.2 rc1
> > tarball):
> > 
> > cd qemu/build
> > make
> > export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
> > tests/qtest/qos-test
> > 
> > these tests will now create a test directory qtest-9p-local-XXXXXX under
> > the current directory (i.e. the build directory) where they are creating
> > real directories and files like on a production system would do, just
> > without a guest OS.
> > 
> > As you can see, there are already 9p tests for creating and deleting
> > directories, files, symlinks and hard links, etc.
> > 
> > Maybe somebody interested to see this issue resolved in qemu might help by
> > rebasing Greg's old patches and testing it with some test cases this way.
> > Personally I need to work on some other things in the next couple weeks,
> > but if somebody needs help, questions, review, etc., I'll be there.
> 
> Great news, nice work there.
> I see the new tests it doesn't look hard to add new ones reproducing
> open-unlink-fstat for example; I think it's good to have regardless of
> kernel progress.
> 
> We'll get there!

Yes, that was the goal, trying to keep it simple so that people not 
necessarily being deeply familiar with 9P (or QEMU) can still quickly write 
tests for their issues.

This provides several benefits: we can now clearly isolate issues, because in 
the past we often received patches where it was not immediately clear what's 
that this patch is fixing exacly, is it a qemu problem, is it rather the 
client that should handle this, or is this even some spanning side effect of 
several layers involved like e.g. when overlayfs is deployed.

And another major benefit is that it simply makes development much more 
efficient. Because you can now just change something on qemu side, and simply 
run

make && tests/qtest/qos-test

to see within few seconds whether it really does what you wanted it to do. And 
on doubt you just look into that subdirectory qtest-9p-local-XXXXXX to see 
what happened.

You can also automatically test your changes with multiple qemu configurations 
(e.g. different security modes, mappings, etc.) as each test case can supply 
its own set of qemu CL options, and the tests can also be run for all enabled 
architectures.

The command "tests/qtest/qos-test" is just a shortcut for 9P tests of course. 
Because obviously there is a huge amount of test cases in qemu for all its 
subsystems. But I will document this and other things more clearly soon to 
lower the entry barrier for new people getting in touch with the qemu 9p code 
base.

Best regards,
Christian Schoenebeck


