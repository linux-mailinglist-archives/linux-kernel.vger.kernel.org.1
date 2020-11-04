Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E843C2A5ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKDHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgKDHhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:37:06 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781B32080D;
        Wed,  4 Nov 2020 07:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604475425;
        bh=1Gr9DFAzKpHX/cZGrYjD5qYpXcVHWblUC8YWyZNmaIU=;
        h=Date:From:To:Cc:Subject:From;
        b=vXHujw226hjv5AOatQ7wqnpu/ZcGdzqh+sJCkkymbpsvRUBh0lCNHq/sA9t/zQ6yt
         3bgkjP+YIUGwCns4dlzuRFvrdoDQY24uVPc92NVlZxAQiW7O4/TpXjRJ8xjJdgfvUH
         +LnbMZrHVAwALORB3HOPUsNMMCHrjXf0cHrt0wh8=
Date:   Wed, 4 Nov 2020 09:37:01 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.10-rc3
Message-ID: <20201104073701.GA9683@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains three small fixes for 5.10-rc3. Details are in
the tag.

Thanks,
Oded

The following changes since commit bcbc0b2e275f0a797de11a10eff495b4571863fc:

  mei: protect mei_cl_mtu from null dereference (2020-11-03 10:13:48 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-04

for you to fetch changes up to f83f3a31b2972ddc907fbb286c6446dd9db6e198:

  habanalabs/gaudi: mask WDT error in QMAN (2020-11-04 08:56:07 +0200)

----------------------------------------------------------------
This tag contains the following fixes:

- Fix the kernel pointer type we are using across the driver to prevent
  compiler warnings (from u64 to void*)

- Configure GAUDI's MMU coresight component in the correct location. The
  current code had a bug where the configuration was not executed in some
  cases

- Mask watchdog timeout errors in QMANs which can spam the kernel log

----------------------------------------------------------------
Arnd Bergmann (1):
      habanalabs: fix kernel pointer type

Oded Gabbay (1):
      habanalabs/gaudi: mask WDT error in QMAN

Ofir Bitton (1):
      habanalabs/gaudi: move coresight mmu config

 drivers/misc/habanalabs/common/command_buffer.c    |  9 +++--
 drivers/misc/habanalabs/common/habanalabs.h        | 14 ++++----
 drivers/misc/habanalabs/common/hw_queue.c          | 19 +++++------
 drivers/misc/habanalabs/common/irq.c               | 17 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c              | 38 +++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  1 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  5 +++
 drivers/misc/habanalabs/goya/goya.c                | 26 +++++++--------
 drivers/misc/habanalabs/goya/goyaP.h               |  2 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |  1 -
 10 files changed, 62 insertions(+), 70 deletions(-)
