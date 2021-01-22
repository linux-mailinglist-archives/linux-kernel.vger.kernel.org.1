Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D98300F02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbhAVVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:35:54 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:32912 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbhAVVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:31:35 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 16:31:34 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A6841181CBE0B;
        Fri, 22 Jan 2021 22:22:34 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U7_5uXhhwWfP; Fri, 22 Jan 2021 22:22:34 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CjUuVJcO2lYb; Fri, 22 Jan 2021 22:22:34 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     david@sigma-star.at, richard@nod.at, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Assorted UBIFS fixes
Date:   Fri, 22 Jan 2021 22:22:25 +0100
Message-Id: <20210122212229.17072-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently hunting down a filesystem corruption, while reviewing
various parts of UBIFS I've found some other bugs.
This patches fix these bugs. In another series I'll add a feature to
be able to remove stale fscrypt contexts and wrong directory size counter=
s.

Richard Weinberger (4):
  ubifs: Correctly set inode size in ubifs_link()
  ubifs: Don't add fscrypt context to xattrs
  ubifs: Update directory size when creating whiteouts
  ubifs: Harden ubifs_jnl_write_inode()

 fs/ubifs/dir.c     | 31 ++++++++++++++++++++-----------
 fs/ubifs/journal.c |  6 +++++-
 fs/ubifs/ubifs.h   |  2 +-
 fs/ubifs/xattr.c   |  2 +-
 4 files changed, 27 insertions(+), 14 deletions(-)

--=20
2.26.2

