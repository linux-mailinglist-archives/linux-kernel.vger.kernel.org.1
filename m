Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1D2C8027
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgK3IjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgK3IjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:39:15 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34B5206E3;
        Mon, 30 Nov 2020 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606725514;
        bh=QspcsVLQ9la3xD2mf4wFFJfEVmxX0dWdQSxbMUyhy48=;
        h=Date:From:To:Cc:Subject:From;
        b=mfemkO3P7D/FlDBgkA4KVBa/54OWkp2UzcVY02va5yDn6PzvauIcsWmFaU9Igy+xK
         KpEL8FVg3cHrWSzUwD3cIm8vfOijm25mp1jIPJd7vugdjRXLIFH7vWlEdQwudRqURA
         5Id3RuUCR0wedbB8+cpkx3pDzGqCZ5Ih2ALAFPyc=
Date:   Mon, 30 Nov 2020 10:38:30 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.10-rc7
Message-ID: <20201130083830.GA9154@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains two memory leak bug fixes for 5.10-rc7.
Details are in the tag.

Thanks,
Oded

The following changes since commit f0992098cadb4c9c6a00703b66cafe604e178fea:

  speakup: Reject setting the speakup line discipline outside of speakup (2020-11-30 09:20:32 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-30

for you to fetch changes up to 5555b7c56bdec7a29c789fec27f84d40f52fbdfa:

  habanalabs: put devices before driver removal (2020-11-30 10:30:16 +0200)

----------------------------------------------------------------
This tag contains two bug fixes for v5.10-rc7:

- Memory leak every time a user closes the file-descriptor of the device.
  The driver didn't always free all the VA range structures it maintains
  per user.

- Memory leak every time the driver was removed. The device structure was
  not "put" at the device's teardown function in the driver.

----------------------------------------------------------------
Ofir Bitton (2):
      habanalabs: free host huge va_range if not used
      habanalabs: put devices before driver removal

 drivers/misc/habanalabs/common/device.c | 16 ++++++++--------
 drivers/misc/habanalabs/common/memory.c |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)
