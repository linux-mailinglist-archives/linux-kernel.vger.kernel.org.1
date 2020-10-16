Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146DF290750
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408927AbgJPOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407597AbgJPOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602859220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AJH2rQKiaPivnwScef349FvB7E5p9oHS8lm1FpKoy6Q=;
        b=VKQ4vdqooF8E6bwECmWTortZEtGUpmo0TfC8sGRg/Yqo9mOECQbuwNlYqmx59lVyMnhRX1
        lwWugqb6zhZU+PImIjfMkyjun58VfEv3JGxwSWL24k+PKtIRzaCAhyww8ogFn4drpHNTEQ
        rNcM2+xA5AOMmD5YM7q/NfXzucMKw7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Qx8c6uYcNmaCF-64-nUZng-1; Fri, 16 Oct 2020 10:40:16 -0400
X-MC-Unique: Qx8c6uYcNmaCF-64-nUZng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB26D879516;
        Fri, 16 Oct 2020 14:40:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D81181A837;
        Fri, 16 Oct 2020 14:40:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fix cell management, add tracepoint, downgrade assert
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1431073.1602859212.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 16 Oct 2020 15:40:12 +0100
Message-ID: <1431074.1602859212@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a collection of fixes to fix afs_cell struct refcounting, thereby
fixing a slew of related syzbot bugs:

 (1) Fix the cell tree in the netns to use an rwsem rather than RCU.

     There seem to be some problems deriving from the use of RCU and a
     seqlock to walk the rbtree, but it's not entirely clear what since
     there are several different failures being seen.

     Changing things to use an rwsem instead makes it more robust.  The
     extra performance derived from using RCU isn't necessary in this case
     since the only time we're looking up a cell is during mount or when
     cells are being manually added.

 (2) Fix the refcounting by splitting the usage counter into a memory
     refcount and an active users counter.  The usage counter was doing
     double duty, keeping track of whether a cell is still in use and
     keeping track of when it needs to be destroyed - but this makes the
     clean up tricky.  Separating these out simplifies the logic.

 (3) Fix purging a cell that has an alias.  A cell alias pins the cell it'=
s
     an alias of, but the alias is always later in the list.  Trying to
     purge in a single pass causes rmmod to hang in such a case.

 (4) Fix cell removal.  If a cell's manager is requeued whilst it's
     removing itself, the manager will run again and re-remove itself,
     causing problems in various places.  Follow Hillf Danton's suggestion
     to insert a more terminal state that causes the manager to do nothing
     post-removal.

In additional to the above, I've included two more patches:

 (1) Add a tracepoint for the cell refcount and active users count.  This
     helped with debugging the above and may be useful again in future.

 (2) Downgrade an assertion to a print when a still-active server is seen
     during purging.  This was happening as a consequence of incomplete
     cell removal before the servers were cleaned up.

David
---
The following changes since commit bbf5c979011a099af5dc76498918ed7df445635=
b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20201016

for you to fetch changes up to 7530d3eb3dcf1a30750e8e7f1f88b782b96b72b8:

  afs: Don't assert on unpurgeable server records (2020-10-16 14:39:34 +01=
00)

----------------------------------------------------------------
afs fixes

----------------------------------------------------------------
David Howells (6):
      afs: Fix rapid cell addition/removal by not using RCU on cells tree
      afs: Fix cell refcounting by splitting the usage counter
      afs: Fix cell purging with aliases
      afs: Fix cell removal
      afs: Add tracing for cell refcount and active user count
      afs: Don't assert on unpurgeable server records

 fs/afs/cell.c              | 328 +++++++++++++++++++++++++++++-----------=
-----
 fs/afs/dynroot.c           |  23 ++--
 fs/afs/internal.h          |  20 ++-
 fs/afs/main.c              |   2 +-
 fs/afs/mntpt.c             |   4 +-
 fs/afs/proc.c              |  23 ++--
 fs/afs/server.c            |   7 +-
 fs/afs/super.c             |  18 +--
 fs/afs/vl_alias.c          |   8 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |   6 +-
 include/trace/events/afs.h | 109 +++++++++++++++
 12 files changed, 378 insertions(+), 172 deletions(-)

