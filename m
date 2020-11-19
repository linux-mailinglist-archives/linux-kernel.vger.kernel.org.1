Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56D72B9767
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgKSQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgKSQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:07:18 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC10C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:07:17 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 94310C009; Thu, 19 Nov 2020 17:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1605802034; bh=wnp7kYlwuZStjD6vk8suZ1iAGibt5LBJYqJazO3nkt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcbtVURf8E4d6fjojEBxPljhoOmxJMjDM+Q0+opIWdb9YqqJEAfHi5LSOfb3zni7U
         2O3ITJMad9fwonq3dlKwO/pAU0ux5oebtPZNTtLIY3XUoF1iLFbJi6oPvTkpU7Y9bK
         MHMXeXh8AdeXmtuuDNoXq+mFjBpt7NsRdOPgwtsRCy2cUGRuVJYRYFKPZYTK490F+G
         rf6BHH416Z8e0lIvsrByeUg0qakuof8CpwSHX7DRic6oj9GXDXLnjmF13Du/x80jM/
         h2sj7LgrbF5XVer76oo8OFiOX/YY17QY+fHeKGKErCELsXHjAErCG4UNNoeDzWu5Ig
         d/bAtSGIp66rQ==
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, lucho@ionkov.net,
        justin.he@arm.com, ericvh@gmail.com, qemu_oss@crudebyte.com,
        groug@kaod.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/2] follow-up to 9p: fix race issue in fid contention.
Date:   Thu, 19 Nov 2020 17:06:50 +0100
Message-Id: <1605802012-31133-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20201103104116.GA19587@nautica>
References: <20201103104116.GA19587@nautica>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case anyone wondered why the patch series isn't in -next yet, I ran into
some troubles with non-none cache that the second patch appears to fix.

Also realized I hadn't sent the fixups I had meant Jianyong Wu to do, so
sending both now (keeping it a separate patch) and will put to my next
tree now, this time for real.

Hopefully not too many other bugs not uncovered... But only one way to
find out, and I think refcounting 9p fid will allow some nice
optimizations in the future if anyone cares to work on it...


Onto fscache now...!


Dominique Martinet (2):
  9p: apply review requests for fid refcounting
  9p: Fix writeback fid incorrectly being attached to dentry

 fs/9p/fid.c             | 10 ++++------
 fs/9p/fid.h             |  2 +-
 fs/9p/vfs_file.c        |  6 +++---
 include/net/9p/client.h |  2 +-
 net/9p/client.c         |  4 ++--
 5 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.28.0

