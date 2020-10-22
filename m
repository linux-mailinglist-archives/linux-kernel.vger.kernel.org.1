Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05F1295EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505854AbgJVMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505404AbgJVMmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:42:51 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923602245F;
        Thu, 22 Oct 2020 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603370571;
        bh=9zCZ6VIW3zrQtBABsEVJDX3+3/llT4jKQ3QazEIpIKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=u4061ed25z7nkj++DVBgSanbvHKSd9bvERQ6byVlLpUbCJa03UKUJq8RDovoTyaLz
         uIsSbYLdA14muNhDMLlm8RcG7lhWpjAtGUIabJHEIjld3eRUyEM+J9PehbsEAgx1jC
         Ea4y6E9rUlgukk8D2MmW2GP+8adnLS7th1cKA4YE=
Date:   Thu, 22 Oct 2020 14:42:47 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.10
Message-ID: <20201022124246.GA8608@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.10 merge window.
Details can be found in the signed tag.

Thank you,

Jessica

--

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.10

for you to fetch changes up to fdf09ab887829cd1b671e45d9549f8ec1ffda0fa:

  module: statically initialize init section freeing data (2020-10-12 18:27:00 +0200)

----------------------------------------------------------------
Modules updates for v5.10

Summary of modules changes for the 5.10 merge window:

- Code cleanups. More informative error messages and statically
  initialize init_free_wq to avoid a workqueue warning.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Daniel Jordan (1):
      module: statically initialize init section freeing data

Qu Wenruo (1):
      module: Add more error message for failed kernel module loading

 kernel/module.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)
