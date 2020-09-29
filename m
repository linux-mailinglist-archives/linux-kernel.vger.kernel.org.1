Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0C27BE64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgI2Hum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgI2Hum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:50:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601365840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZH5RUsiNCBnwQO3HdBH/S2GadrEkNWR9w8D2mfkC+xk=;
        b=hHAP+yEsfXNFbeo5E8kcZzYTiThkE7Qv8ciUdP7sO8ekrcbB+Ppo88bEVffek1C6xufWcN
        ntlBddjnWar0+5sq5PGmH8QSz7qXwJFFs2eQQVEpuRYaL2KXlTqPAUe2mI/1s6NGIym64R
        ioFsWDbKN+5Ws22w7QAWjmLNmMy2wVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-EMQeTyUaP66jzwKTnuvAKg-1; Tue, 29 Sep 2020 03:50:38 -0400
X-MC-Unique: EMQeTyUaP66jzwKTnuvAKg-1
Received: by mail-wm1-f71.google.com with SMTP id p20so1387264wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZH5RUsiNCBnwQO3HdBH/S2GadrEkNWR9w8D2mfkC+xk=;
        b=T/ZdcYxe7lXK6pYfp52W2a4+JOZmkeejo4/S4VhUPHTjPsZYhtXK46zg0PvhD/rfQj
         ri4jZmUfcX1O+GHT50cqRjSDYolmYG7t3QCpHAwhzNp3QSvbetWoNuWYziW2R6ru6LvJ
         vT55g2g77hrTPiGYa4E2RW2jdY/gSKyr9QHvYpoGrkmQahB1t8zZxBWVbWJHcjBv/y1Y
         +0VCQbLhBPYPqNnXIyGt/wmziKc/6uCd66k8nf5vEu6SAZi0qBxK0XcOhUOpwWvLMpdb
         cZE+tg/HE8xA7j0jW/VW+4bsGr9V/7BwM28V7rqgkbXelur25NGG9iegqiRvGCEWCU9A
         q8sQ==
X-Gm-Message-State: AOAM532kCysY80bdwy6rKR6h+6GkU34PZT6NdW6XEYKT6YTHTBpDCkxd
        5dQXL0IJUZTnvdIMfvI099a2j3fmJRgJ7v6BLLqdSVtJb+TrsG/69jj9sh6FTbjjVnUJJ70Pmbd
        C5oRtTRXI+bGxr8ZE9lDN2VHY
X-Received: by 2002:a5d:660f:: with SMTP id n15mr2849631wru.103.1601365837345;
        Tue, 29 Sep 2020 00:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9yDNuK/HRBfrUSRppU/hB6f1n2dAKzHM+mssOZcfIMLGHfW5jc72hMkHH51Lh+uUsHHthwg==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr2849612wru.103.1601365837164;
        Tue, 29 Sep 2020 00:50:37 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id o15sm4204743wmh.29.2020.09.29.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:50:36 -0700 (PDT)
Date:   Tue, 29 Sep 2020 03:50:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, eli@mellanox.com, jasowang@redhat.com,
        lingshan.zhu@intel.com, mst@redhat.com
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20200929035034-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately there are a couple more reported issues in vhost and vdpa,
but those fixes are still being worked upon, no reason to
delay those that are ready.

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a127c5bbb6a8eee851cbdec254424c480b8edd75:

  vhost-vdpa: fix backend feature ioctls (2020-09-24 05:54:36 -0400)

----------------------------------------------------------------
virtio: last minute fixes

A couple of last minute fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vhost: Fix documentation

Jason Wang (1):
      vhost-vdpa: fix backend feature ioctls

 drivers/vhost/iotlb.c |  4 ++--
 drivers/vhost/vdpa.c  | 30 ++++++++++++++++--------------
 2 files changed, 18 insertions(+), 16 deletions(-)

