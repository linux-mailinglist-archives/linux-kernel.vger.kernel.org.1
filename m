Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034FD2C804E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgK3Iwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgK3Iwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606726269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IfhR367gJyQi+IqH9Qg+155OiV0npyw4vEgjmNlOLaQ=;
        b=aXutAKNCM0Dig7a8Uq4+9BJ9NJTSKFVs3Xr4w9BWUBlhADqhrj1p8xspk8CAxNQoDL2J2x
        uJ3dM0t/m0ukoYvcymLgxeDvyuD8dsNqE79q8AOY/se+GYFdJLTMBX1QoI/QqnyCgQZX+d
        KC1WaBZ0elxWPm+Im2YsGRkD62kugok=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-IsbZcdMoO1CE-GlXtpi7Og-1; Mon, 30 Nov 2020 03:50:14 -0500
X-MC-Unique: IsbZcdMoO1CE-GlXtpi7Og-1
Received: by mail-wm1-f69.google.com with SMTP id u123so4115174wmu.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IfhR367gJyQi+IqH9Qg+155OiV0npyw4vEgjmNlOLaQ=;
        b=JrwiowaEaCQ1p7xzyjZbuuiRzAZvbFKzNO3IgTs4FgBqfvaHNyGm0dFBP0VYJW/92X
         1YH0HTA/LjVyVKt61uZQF73eWduxs3WOF2KNgotW30MrVX6HTaqJ18IPG5L3sT6Smpkl
         wJafRjgfS9p++7M8uFzBiYgTDmics5MBI/9m1JWVFwtWh1WB/vDyvMc7Ko9EJQLtsKQd
         RvlZZKryTKMwR5OqRbj/AR+t5L+kMuVs22WkOAILiQqXSSRZujCoYmdBYF0eN6m/FBLY
         sSFncVr3zJ+1RJkzafiD9vvoU6gKuJ2IvZO7xgR/dAHNyggqz5mNTENZXFQOuS2NT3o+
         ATzw==
X-Gm-Message-State: AOAM532WQQ6NjR+w+Ju868vvfRjpNFRuOyidWsix8iTH0tdQE1OyvUow
        1FsJ+Wj53nQL4ligUcweWrgzg5l6aDhDIWp/eYaz9pJePMe3GAhQPW/IiRv5BJqqPFMjuwi+S1F
        2dUAt0Mx7xjlwQWJiCL8t6bIc
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr15059093wme.5.1606726213695;
        Mon, 30 Nov 2020 00:50:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0lcq9LYEeQweeQ1PUtnvowfMkCnfs7A6y+pZ1luBu47l3TNrIhMMTxE9tXFN2kqV6KXqSzQ==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr15059071wme.5.1606726213486;
        Mon, 30 Nov 2020 00:50:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id 21sm12930310wme.0.2020.11.30.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:50:12 -0800 (PST)
Date:   Mon, 30 Nov 2020 03:50:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, michael.christie@oracle.com, mst@redhat.com,
        sgarzare@redhat.com, si-wei.liu@oracle.com, stefanha@redhat.com
Subject: [GIT PULL] vhost,vdpa: bugfixes
Message-ID: <20201130035010-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to ad89653f79f1882d55d9df76c9b2b94f008c4e27:

  vhost-vdpa: fix page pinning leakage in error path (rework) (2020-11-25 04:29:07 -0500)

----------------------------------------------------------------
vhost,vdpa: fixes

A couple of minor fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Mike Christie (1):
      vhost scsi: fix lun reset completion handling

Si-Wei Liu (1):
      vhost-vdpa: fix page pinning leakage in error path (rework)

Stefano Garzarella (1):
      vringh: fix vringh_iov_push_*() documentation

 drivers/vhost/scsi.c   |  4 ++-
 drivers/vhost/vdpa.c   | 80 ++++++++++++++++++++++++++++++++++++++------------
 drivers/vhost/vringh.c |  6 ++--
 3 files changed, 68 insertions(+), 22 deletions(-)

