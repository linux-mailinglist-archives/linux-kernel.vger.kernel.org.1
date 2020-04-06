Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DB19F9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgDFQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 12:12:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728707AbgDFQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586189523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rIWxYfcYAQw97MdNWUoWLHUlnO3W3ZP0UNabt9fJ3h8=;
        b=FmFGC8NPjC2umzKX+V0+bSp0bDyPrylcdfGTVu+R7yO4u4MM3G8pkR89EwrrnmaCSOjQvZ
        1RZOn1C4rPTZtfsjSyuLA+D1yjE7Ac+mSmOOkVQXKW9ZQBfqvUaGmrk2fe76B8OlyZAGUS
        W2ISHVgDtDWDYxC4/RPmIB6t9xJLRVY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-9oSuK-qfMPGkMr5Jqpwntw-1; Mon, 06 Apr 2020 12:11:59 -0400
X-MC-Unique: 9oSuK-qfMPGkMr5Jqpwntw-1
Received: by mail-wr1-f72.google.com with SMTP id j12so35404wrr.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=rIWxYfcYAQw97MdNWUoWLHUlnO3W3ZP0UNabt9fJ3h8=;
        b=E5XILfzwlKSpleqjIAaDER9RFU2J5A4UE807b1lZ3JuUe5kqC+vEUoWlPwRhOJkOci
         80Dx6gL0tSqz3fdjvvHsFqkW7ggZbVKzcFKiBnLcN4WgVWvTDrtxP9yMGxN5Cjsp8gdq
         Hp87CJLnOfvBbCQWrOmji3O1zw3P2oNplXn6K6xLgDTZesc0zdnmiN2lhgvIIgcQ9Zjd
         j7OiV92CQishsc0CgMGD+3MXpL7JkGgzG4RLFl57oxJFKqa3Rb/I1hiNWilldcoBfuuw
         RcNZ0Jb+70+enUdjoKyrkoVhFTna27CeHm1dE7bgqL7Afs9mDUWi9WGKVVbH6fzqA5uy
         aUsg==
X-Gm-Message-State: AGi0PubKWd60jg5uSViqeP5WaReoONznj4aXvm7ba37m3phbHL5x8V/K
        pu0zHpj5eltcEwl81wErwoqhIX/jKe7Ga3APxc+8KmiEZUrsojup9iSLbxQ9Ho4BVrNi6623ZcM
        UH9wBEPg4oce8zZz3GdMKsqa+
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr94665wmt.89.1586189518551;
        Mon, 06 Apr 2020 09:11:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjE0AKqb8ZcOv/GUCOOSlsc953I0NdI5fP5DlPUOgqc+1/GVFHevXh7Iz5CacTkoPH237xgg==
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr94653wmt.89.1586189518375;
        Mon, 06 Apr 2020 09:11:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h2sm10991033wrp.50.2020.04.06.09.11.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:11:57 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:11:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] virtio: alignment issues
Message-ID: <20200406161146.130741-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative to
	vhost: force spec specified alignment on types
which is a bit safer as it does not change UAPI.
I still think it's best to change the UAPI header as well,
we can do that as a follow-up cleanup.

Changes from v2:
	don't change struct name, instead add ifndef
	so kernel does not see the legacy UAPI version.

Jason, can you pls ack one of the approaches?


Michael S. Tsirkin (2):
  virtio: stop using legacy struct vring in kernel
  vhost: force spec specified alignment on types

 drivers/vhost/vhost.h                   |  6 ++--
 include/linux/virtio_ring.h             | 46 +++++++++++++++++++++++++
 include/uapi/linux/virtio_ring.h        | 26 ++++++++------
 tools/virtio/ringtest/virtio_ring_0_9.c |  6 ++--
 tools/virtio/vringh_test.c              | 20 +++++------
 5 files changed, 78 insertions(+), 26 deletions(-)

-- 
MST

