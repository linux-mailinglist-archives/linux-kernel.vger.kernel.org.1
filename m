Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D979F2C711D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbgK1VxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733182AbgK1TGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:06:31 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47686206D8;
        Sat, 28 Nov 2020 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606566088;
        bh=XDJGm6jyXN7vWcHuXHNiBeLAICRudsN8dmuONp9fM7M=;
        h=Date:From:To:Cc:Subject:From;
        b=NQw58DwE3qrzs73npw8q4vq95nSJJ2DMOtQDeTWUlgmpRjfE9w1YmrwCxyqDLppOJ
         EyFtCn0aItNeKG6fiIJseLdYuurfhFmbO7/Q0iY3pj3RhwhVz+hi86BQvLBmJvotxv
         mJvIAnrNUMsNUTcorIOk4E+RnNazrR1jkIUAe7bc=
Date:   Sat, 28 Nov 2020 13:22:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.10-rc6
Message-ID: <X8JBDK8P6ZiKrvav@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc6

for you to fetch changes up to c7acb6b9c07b4b75dffadc3b6466b1b43b3fda21:

  MAINTAINERS: Adding help for coresight subsystem (2020-11-26 09:09:18 +0100)

----------------------------------------------------------------
Char/misc driver fixes for 5.10-rc6

Here are some small misc driver fixes for 5.10-rc6.  They include:
  - interconnect fixes for reported problems
  - habanalabs bugfix for found issue when doing the switch fallthrough
    patches.
  - MAINTINERS file update for coresight reviewers/maintainers

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Georgi Djakov (4):
      interconnect: qcom: msm8974: Prevent integer overflow in rate
      interconnect: qcom: msm8974: Don't boost the NoC rate during boot
      interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nodes
      interconnect: qcom: qcs404: Remove GPU and display RPM IDs

Greg Kroah-Hartman (2):
      Merge tag 'icc-5.10-rc6' of git://git.kernel.org/.../djakov/icc into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2020-11-23' of ssh://gitolite.kernel.org/.../ogabbay/linux into char-misc-linus

Marek Szyprowski (1):
      interconnect: fix memory trashing in of_count_icc_providers()

Mathieu Poirier (1):
      MAINTAINERS: Adding help for coresight subsystem

Oded Gabbay (1):
      habanalabs/gaudi: fix missing code in ECC handling

 MAINTAINERS                           |  4 +++-
 drivers/interconnect/core.c           |  1 -
 drivers/interconnect/qcom/msm8916.c   | 12 ++++++------
 drivers/interconnect/qcom/msm8974.c   | 12 ++++++++++++
 drivers/interconnect/qcom/qcs404.c    |  4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c |  2 ++
 6 files changed, 25 insertions(+), 10 deletions(-)
