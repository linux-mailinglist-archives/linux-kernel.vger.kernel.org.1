Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876892814DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgJBOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:20:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6307F206A5;
        Fri,  2 Oct 2020 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601648413;
        bh=FoOoYOhtAyhs3Uw/Tey8mM+CYMUqi+LEhTEaTEjrqjM=;
        h=Date:From:To:Cc:Subject:From;
        b=Er6RbwoggqXABHBPqKXnmCcuk/eEW2Lmbl6x9zBiCpybFW9+Ynbecy7l2lhdQsYAc
         K4jOvrAf966VPyoV0Tuhc7YBAJs6oeNfBotpqLVrARf5moo6f26Hz4gd/SdErB1/Em
         VugA+YEa3G41hAdgSa8cebSGVLwZ2ueRQ2/03pfk=
Date:   Fri, 2 Oct 2020 16:20:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] IIO driver fixes for 5.9-rc8
Message-ID: <20201002142011.GA3499938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc8

for you to fetch changes up to 52a035235ed5a1392fc264bd614eb96d1ac97a3d:

  Merge tag 'iio-fixes-for-5.9b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-09-22 18:36:40 +0200)

----------------------------------------------------------------
IIO fixes for 5.9-rc8

Here are two small IIO driver fixes for 5.9-rc8 that resolve some
reported issues:
	- driver name fixed in one driver
	- device name typo fixed

Both have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Baryshkov (1):
      iio: adc: qcom-spmi-adc5: fix driver name

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.9b-take2' of https://git.kernel.org/.../jic23/iio into staging-linus

Mircea Caprioru (1):
      iio: adc: ad7124: Fix typo in device name

 drivers/iio/adc/ad7124.c         | 4 ++--
 drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
