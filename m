Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8B2A63B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgKDL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:57:27 -0500
Received: from nautica.notk.org ([91.121.71.147]:59189 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgKDL50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:57:26 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 653E9C01B; Wed,  4 Nov 2020 12:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1604491043; bh=2t1AiDgkKOtehlJf9ksFzwCpxYWIkcr1ROs3yTQip1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syYxOsh8Q/ebgtC4yxsyxN5Qdt0aRu85IZXEBj0oK2AWULlHpCnmAQ4fSVCdLNk6y
         TWf3jcRX3EoFhpfoQayn3WWQHUDhN7Bz1vQzr9JO8dhht+24YeDSnAKtkJJgeYdUcm
         yh7uIrZGyCGmmmwzBydG4JQ+KZZfPkteAnWx+t3BObik+OLDUfCSWo8nsJ/uEXJGhm
         8YfFmi78gmkJiKHaUO+ya5cIEZiLR2599zwWMKiS7Qq9P1wRxPzb2jPAJehWLKlxJb
         YpJj2c6G45qumFh305/qHSbcRQSiLiQQwCtBDv1iXhtygeYoAoCl4zowiku5xCQmvU
         YwiqTOtM62Mcg==
Date:   Wed, 4 Nov 2020 12:57:08 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, ericvh@gmail.com,
        lucho@ionkov.net, groug@kaod.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        justin.he@arm.com
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Message-ID: <20201104115708.GA30104@nautica>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com>
 <20201103104116.GA19587@nautica>
 <1755303.6a88tIVZ8j@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755303.6a88tIVZ8j@silver>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Wed, Nov 04, 2020:
> > Greg, Christian - from what I understood (in private, hopefully I'm
> > allowed to repeat!), he won't be able to contribute to qemu because of
> > company policies and I'm unlikely to take the time either right now.
> > I don't think it's a problem to continue as is though, we can land linux
> > kernel support (it's still useful for non-qemu servers) and if someone
> > is interested later on they'll just need to finish that bit.
> 
> Hmm, no idea what kind of policy that is; there is no GPL3 in qemu at least 
> that some companies are concerned about, but OK not my business.
> 
> I actually thought this would still take a while on kernel side,

To be honest, so did I -- the original patches are so old I had more or
less given up on it :P

But I don't see any more problem now and we'll want to get there
eventually so now's a good time as any... I just want to get fault
injection to work to test various refcounting cornercases but shouldn't
be much longer.

> so in the 
> meantime we layed the ground in qemu for resolving this issue independent of 
> clients and independent of any guest OS installation by introducing test cases 
> using the 9pfs 'local' filesystem driver:
> 
> https://github.com/qemu/qemu/blob/master/tests/qtest/virtio-9p-test.c
> 
> So the idea was to resolve that chicken egg problem of this issue that way and 
> also handle it a bit more systematically. If you now run qemu's 9p tests with 
> latest git version (or at least with yesterday's QEMU 5.2 rc1 tarball):
> 
> cd qemu/build
> make
> export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
> tests/qtest/qos-test
> 
> these tests will now create a test directory qtest-9p-local-XXXXXX under the 
> current directory (i.e. the build directory) where they are creating real 
> directories and files like on a production system would do, just without a 
> guest OS.
> 
> As you can see, there are already 9p tests for creating and deleting 
> directories, files, symlinks and hard links, etc.
> 
> Maybe somebody interested to see this issue resolved in qemu might help by 
> rebasing Greg's old patches and testing it with some test cases this way. 
> Personally I need to work on some other things in the next couple weeks, but 
> if somebody needs help, questions, review, etc., I'll be there.

Great news, nice work there.
I see the new tests it doesn't look hard to add new ones reproducing
open-unlink-fstat for example; I think it's good to have regardless of
kernel progress.

We'll get there!
-- 
Dominique
