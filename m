Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6E2DC999
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgLPXdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729970AbgLPXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608161543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tx7WUdnCzwHoHDRuV9Dx8cPV2+Sd++6ZqVhcvibmd2o=;
        b=QOINnRLtiBw4uUrKHMFVQfQb0n2jWoQIUGBR26OXX0FtQDkIqR0qd3Yz8UqTB50L+8ie+6
        8Yqm2G3+BYA0BRv96bBoAnrIH0lqjuQYSoQnTzzCKirGq21z9TVbLO5QBSZjyKyxLpglrq
        8wOuHvVR0kecVQqcXkkEhLRf20rrRvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-NafvrBe_MqeWI-U0-C1sXA-1; Wed, 16 Dec 2020 18:32:22 -0500
X-MC-Unique: NafvrBe_MqeWI-U0-C1sXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B9F4107ACE3;
        Wed, 16 Dec 2020 23:32:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC3141754A;
        Wed, 16 Dec 2020 23:32:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 733C9220BCF; Wed, 16 Dec 2020 18:32:19 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk
Subject: [RFC PATCH 0/3] vfs, overlayfs: Fix syncfs() to return error
Date:   Wed, 16 Dec 2020 18:31:46 -0500
Message-Id: <20201216233149.39025-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is V2 of patches which tries to fix syncfs() for overlayfs to
return error code when sync_filesystem(upper_sb) returns error or
there are writeback errors on upper_sb.

I posted V1 of patch here.

https://lore.kernel.org/linux-fsdevel/20201216143802.GA10550@redhat.com/

This is just compile tested patch series. Trying to get early feedback
to figure out what direction to move in to fix this issue. 

Thanks
Vivek

Vivek Goyal (3):
  vfs: add new f_op->syncfs vector
  overlayfs: Implement f_op->syncfs() call
  overlayfs: Check writeback errors w.r.t upper in ->syncfs()

 fs/overlayfs/file.c      |  1 +
 fs/overlayfs/overlayfs.h |  3 +++
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/readdir.c   |  1 +
 fs/overlayfs/super.c     | 41 +++++++++++++++++++++++++++++++++++++++-
 fs/sync.c                | 29 +++++++++++++++++++---------
 include/linux/fs.h       |  1 +
 7 files changed, 68 insertions(+), 10 deletions(-)

-- 
2.25.4

