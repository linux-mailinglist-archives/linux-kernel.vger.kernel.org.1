Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97C22DE29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgGZLNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 07:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZLNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:13:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BDC82065C;
        Sun, 26 Jul 2020 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595761989;
        bh=n9/XJolG+JujfS+CKNyV63g2btTNOmnrhAyGHeQuT4c=;
        h=Date:From:To:Cc:Subject:From;
        b=sciIvOA2b+etPGTq+a0sfQA/N/VXBB2S+FzXS3aKbhPzBYn+MQGXHwdRvpj4Pdx0V
         M8iJqqJHlYmRAN5pAXNZFY0OkKltRKmdkRTjfHOK5dTocSWR7a/eyUN44xMTrBtc5x
         5UbwlNlVA3tYBRSRh8myzxaBblX3yRjKoCf6Zu9g=
Date:   Sun, 26 Jul 2020 13:13:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.8-rc7
Message-ID: <20200726111306.GA1283843@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc7

for you to fetch changes up to 29c4a54bc645c8b6745eeb58519e9ad794ceb419:

  device property: Avoid NULL pointer dereference in device_get_next_child_node() (2020-07-23 17:04:28 +0200)

----------------------------------------------------------------
Driver core fix for 5.8-rc7

Here is a single driver core fix for 5.8-rc7.  It resolves a problem
found in the previous fix for this code made in 5.8-rc6.  Hopefully this
is all now cleared up, as this seems to be the last of the reported
issues in this area, and was tested on the problem hardware.

This patch has been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      device property: Avoid NULL pointer dereference in device_get_next_child_node()

 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
