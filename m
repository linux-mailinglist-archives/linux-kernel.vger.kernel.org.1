Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2B2B4489
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgKPNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgKPNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605532470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bcklXraRLL6YuQnGUW+mYhCFhDJ3s3DEvlUM79PK4ZQ=;
        b=WOUzmNZ28cAjLHIltbASIsz4OTsABrafVH6b2Xv68AUq0weDd6udm26u37997q51YuYZvC
        tKTbo1p7UB8TXJTS4evAxEOJmJsGWGcbhdy+MsiSIlNX8xL1ja7X5iVFKHKr9BAxxvTtFi
        ISYqSnLXxuVn1ywWp2AEaBvC96RL/rg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-smtxZbjjPqmugvOMkYKx3w-1; Mon, 16 Nov 2020 08:14:28 -0500
X-MC-Unique: smtxZbjjPqmugvOMkYKx3w-1
Received: by mail-wm1-f69.google.com with SMTP id h2so10266439wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bcklXraRLL6YuQnGUW+mYhCFhDJ3s3DEvlUM79PK4ZQ=;
        b=tFo9YHf+JZ/bJgeBkQFvOXPyMr3ZsWcCmPzBUlUxcQ/VrqmUAwg+4LAxSw7Nc3nk2R
         E88Gt0P87ZWAc+/XDvnzjQ2RytNlrc5um1wM2T8Du4+lml4OYc55v0MSv+G9VT5ARWxo
         Wj+OtPhmVa8tu5TE4ldBFJ6l6buWIR3wYoIiH6U+jyDz7XjjUdM1f/ypKlTk2wCfFlQ5
         5DVKgrYW+msXEQhS/7W14Kg5c0jL/Z/xYPvAEeXmeRUo0X2KlYZq5Av5H0HGHtwPozTS
         aiQW5wsosMsdNDcELXmiNekUOamjOphxeGdg+Qj5dFlXNo0EWxjMkBk40iKX8nDVKJul
         wDeQ==
X-Gm-Message-State: AOAM532p4m9SxdmkTlZKSI7bT/LXdQNo838Wg9dOswnKlKrf+ELP0veX
        GkaId2CHZCbGiriHokJR0kFcoXkBhzekN8Qe0reuUMEnZpbdA0PKGVtoBj/lqjagRVfJf0Xpjph
        IDDBLVID+eYfYt2dTBUIbU6aO
X-Received: by 2002:a1c:6002:: with SMTP id u2mr14508764wmb.29.1605532467574;
        Mon, 16 Nov 2020 05:14:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoKOhCtfX4RQPxreiVjgYctq5k6WupqM3uofRLxRDRD1VbWHuNBhZz0uRXMRsQybcwkP1lsQ==
X-Received: by 2002:a1c:6002:: with SMTP id u2mr14508747wmb.29.1605532467415;
        Mon, 16 Nov 2020 05:14:27 -0800 (PST)
Received: from redhat.com ([147.161.8.56])
        by smtp.gmail.com with ESMTPSA id e5sm21249161wrs.84.2020.11.16.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:14:26 -0800 (PST)
Date:   Mon, 16 Nov 2020 08:14:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, lkp@intel.com, lvivier@redhat.com,
        michael.christie@oracle.com, mst@redhat.com, rdunlap@infradead.org,
        sfr@canb.auug.org.au, stefanha@redhat.com
Subject: [GIT PULL] vhost,vdpa: fixes
Message-ID: <20201116081420-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0c86d774883fa17e7c81b0c8838b88d06c2c911e:

  vdpasim: allow to assign a MAC address (2020-10-30 04:04:35 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to efd838fec17bd8756da852a435800a7e6281bfbc:

  vhost scsi: Add support for LUN resets. (2020-11-15 17:30:55 -0500)

----------------------------------------------------------------
vhost,vdpa: fixes

Fixes all over the place, most notably vhost scsi IO error fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Laurent Vivier (1):
      vdpasim: fix "mac_pton" undefined error

Mike Christie (5):
      vhost: add helper to check if a vq has been setup
      vhost scsi: alloc cmds per vq instead of session
      vhost scsi: fix cmd completion race
      vhost scsi: add lun parser helper
      vhost scsi: Add support for LUN resets.

Stephen Rothwell (1):
      swiotlb: using SIZE_MAX needs limits.h included

 drivers/vdpa/Kconfig    |   1 +
 drivers/vhost/scsi.c    | 397 ++++++++++++++++++++++++++++++++++--------------
 drivers/vhost/vhost.c   |   6 +
 drivers/vhost/vhost.h   |   1 +
 include/linux/swiotlb.h |   1 +
 5 files changed, 289 insertions(+), 117 deletions(-)

