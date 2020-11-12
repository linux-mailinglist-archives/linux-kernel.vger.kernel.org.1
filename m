Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9B2B1162
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKLWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgKLWX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605219835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rp2pBrrUWJ4/DT4IbJIqjOV2fOOYBjdstlgbwGEZFhg=;
        b=U2PIk32ypwxpYD1BeUIolAzMEExSu36utWb5yeRIi2H3HyVJQEetKqpNk0N2c4bfoEXwxo
        E+B44zccKSpsr+EHu2wCs6IQLtDeCm5kt+iFJP6mejixuS5x4VtgmjVpG5QEefZepwGxGh
        fX5F8fVhnpyx279kru0TF465hu0Xtp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-dmpb-5bxNJuFiRk4KONcew-1; Thu, 12 Nov 2020 17:23:53 -0500
X-MC-Unique: dmpb-5bxNJuFiRk4KONcew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A446107464A;
        Thu, 12 Nov 2020 22:23:52 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C9645C1BB;
        Thu, 12 Nov 2020 22:23:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 fixes for 5.10-rc3
Date:   Thu, 12 Nov 2020 23:23:46 +0100
Message-Id: <20201112222346.2227664-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following additional gfs2 fixes on top of 5.10-rc3.

Thank you very much,
Andreas

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc3-fixes

for you to fetch changes up to 4e79e3f08e576acd51dffb4520037188703238b3:

  gfs2: Fix case in which ail writes are done to jdata holes (2020-11-12 18:55:20 +0100)

----------------------------------------------------------------
Fix jdata data corruption and glock reference leak

----------------------------------------------------------------
Bob Peterson (2):
      Revert "gfs2: Ignore journal log writes for jdata holes"
      gfs2: Fix case in which ail writes are done to jdata holes

Zhang Qilong (1):
      gfs2: fix possible reference leak in gfs2_check_blk_type

 fs/gfs2/aops.c |  2 +-
 fs/gfs2/bmap.c |  8 ++------
 fs/gfs2/log.c  |  2 ++
 fs/gfs2/rgrp.c | 10 +++++-----
 4 files changed, 10 insertions(+), 12 deletions(-)

