Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8F304A20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbhAZFPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:15:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbhAYJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:44:07 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l3yP6-0005J1-2i; Mon, 25 Jan 2021 09:43:24 +0000
Date:   Mon, 25 Jan 2021 10:43:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Dealing with complex patch series in linux-next
Message-ID: <20210125094323.gz7g5p6xeifolf5v@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

After having received another round of acks on the idmapped mounts
series and other fses about to move forward with porting I moved forward
with merging [1] into my for-next branch which is tracked by sfr in
linux-next.
Given the nature of the series I expected there to be a good chunk of
merge conflicts including some non-trivial ones. But there proved to be
too many conflicts or at least a few ones that sfr couldn't handle
without more insight into the series. So after talking to sfr this
morning we decided to drop the tree for today.

Obviously we would like to see this in linux-next and we will likely run
into similar problems should you decide to want to pull this.
I could try and choose a common base with at least one tree (e.g. Al's)
but this will only get rid of some merge conflicts.
I'm sure I could also do an extremely fine-grained split of each patch
in the series though I don't think that's very helpful in this case
either.
I could do a daily rebase onto linux-next which is similar to what
Andrew does for such patch series which get included into linux-next as
a rebased post-next patchbomb (as sfr pointed out to me). The series has
a large xfstest series associated with it so it's at least easily
detectable when the rebase breaks things.
I would prefer to not have to burden someone else with this and rather
deal with the merge conflict resolution myself to make sure that no
wider context is missed. It would also allow me to point out where the
painpoints are if this gets sent for inclusion/is accepted.

So completely independent of whether or not you ultimately decide to
accept or reject the series it might be pretty helpful to know what your
preferred way of dealing with similar series is to make it easier for
you later on.

Christian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=idmapped_mounts

I know that we have
https://www.kernel.org/doc/html/latest/maintainer/rebasing-and-merging.html
and it touches on stuff like this to some extent in "Merging from
sibling or upstream" trees but it's not clear that this would be
beneficial here or whether it wouldn't just make the changeset harder to
follow.
