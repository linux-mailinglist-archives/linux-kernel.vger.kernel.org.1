Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2092B812F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgKRPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgKRPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605714646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YEB1MOPxQr2d0F2dvLjWRdDGxOL6d15wgfjJ3wkEM+Q=;
        b=KhXyqc1hsZ/dvW+JZFelZLBJNL2lv+YuLbjLoPaHmNwC7Bwh5sAA0R/gKZRcez/vEPCKfd
        84wC/HKJWAdUvaOrsFPYEVr+qrZCzVghcFfCMjG7XI9Nt9TfaD8KSnD1tJYb14Q/zsyUDm
        4k8mTXVCbofsDpuhZgW+8ADaMB8O220=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-ktfKBd0YOcKDVe8a6eURSA-1; Wed, 18 Nov 2020 10:50:44 -0500
X-MC-Unique: ktfKBd0YOcKDVe8a6eURSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0600C8015CD;
        Wed, 18 Nov 2020 15:50:43 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 203AA21E78;
        Wed, 18 Nov 2020 15:50:33 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Another gfs2 fix for 5.10-rc4
Date:   Wed, 18 Nov 2020 16:50:32 +0100
Message-Id: <20201118155032.127787-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following additional gfs2 fix.

Thanks,
Andreas

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc4-fixes

for you to fetch changes up to 20b329129009caf1c646152abe09b697227e1c37:

  gfs2: Fix regression in freeze_go_sync (2020-11-18 16:28:11 +0100)

----------------------------------------------------------------
Fix gfs2 freeze/thaw

----------------------------------------------------------------
Bob Peterson (1):
      gfs2: Fix regression in freeze_go_sync

 fs/gfs2/glops.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

