Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788211F4893
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 23:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgFIVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 17:02:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44190 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFIVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 316CA607400D;
        Tue,  9 Jun 2020 23:01:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4bIAtOZviiwE; Tue,  9 Jun 2020 23:01:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D2FB16074010;
        Tue,  9 Jun 2020 23:01:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jQ3-NoYnJRix; Tue,  9 Jun 2020 23:01:58 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BAA0B607400D;
        Tue,  9 Jun 2020 23:01:58 +0200 (CEST)
Date:   Tue, 9 Jun 2020 23:01:58 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <818706511.351.1591736518682.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI changes for v5.8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: elUTXxzBgxSDBQp23tI4ZRWGqBhMNg==
Thread-Topic: UBI changes for v5.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.8-rc1

for you to fetch changes up to 4b68bf9a69d22dd512d61d5f0ba01b065b01ede6:

  ubi: Select fastmap anchor PEBs considering wear level rules (2020-06-02 22:53:05 +0200)

----------------------------------------------------------------
This pull request contains a single change for UBI:

- Select fastmap anchor PEBs considering wear level rules

----------------------------------------------------------------
Arne Edholm (1):
      ubi: Select fastmap anchor PEBs considering wear level rules

 drivers/mtd/ubi/fastmap-wl.c | 39 ++++++++++++++++++++++++---------------
 drivers/mtd/ubi/fastmap.c    | 11 +++++++++++
 drivers/mtd/ubi/ubi.h        |  4 +++-
 drivers/mtd/ubi/wl.c         | 28 +++++++++++++++++++---------
 4 files changed, 57 insertions(+), 25 deletions(-)
