Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577D5266991
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgIKUfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIKUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:35:17 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D6C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so7143116lfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l83CKt/v13NjmKCQ0hFj9pT+gJolIjr8unWrFbwpxZI=;
        b=SYIdzpdmt1uLZg4Uh+l4Wh/coyumMPJ2ONK3rnLVlvissJddQIDWr085g+PPB0YO00
         cuJjP6AIMCiWtW7Y7+Bomwq/MNoFV9fDuIOfBdgGUEBb+ZxN77n9uRJdmgMDaHrq1MxZ
         4c9diY10AEkOuRua8OafABX2Is9xp67JcV4XzAiOYQ3YJrm2YSFkmfZ+EF3zCwgqluOL
         cEKxRz4ZAo+DwdEJT5n+m9l7ShJ1Yo3zfwbVcv6xWVzsYdD6wyJOAxSq63mVz5A8jKkn
         efyMw8FIbkN6KnWvUB4qzOAmR0RUOvPUJ8zpatBxPIDHz5BYHHQGPD6Y03o6g+RHCjRq
         tVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l83CKt/v13NjmKCQ0hFj9pT+gJolIjr8unWrFbwpxZI=;
        b=jGnxDNysIzdXnZVESPzO+gGfgvLwwbpDwteR5oU8TGQqQUoo/0V6aEBtqZ9nNA3dSE
         MhSCp35OYEXU/2ewFv1rKfXBJT2FKEA1TRYhkc6J6bnHHraJcRAsMLGPAZdafYV9njV3
         /SQadINhaTqZ9B+jzyeHxx5iZwgPiL45JZXwwywB8TZvmke6b/VFJ6/dgdlMadyk+Bxf
         XwrWHT60Dc9xGxCp8ZRyzbOcxpktQuJmSbaE4+s4Mk3y/cuKCGUsRBHYHpqQh8A4PV+0
         T+JFX1I19OsjArE4JRYgceoy5rDWndvuOUvfbSZ5/hsbQPyFzXIlnhgtEd6RDUQgCrsm
         VBOA==
X-Gm-Message-State: AOAM5323FqGsjdE7OThrpmnQi1jewkUqz4X0s4pqeCOuBAjn3AEgYCrC
        XzLk1ZIhKY6CwXkj4XY3Dhs=
X-Google-Smtp-Source: ABdhPJwTYdXXi4b9u9NeNWz8vNnIqRgbTEJ7b0P86kFYBbYigb4fzGvdF+1qYJaPceLmp1yN+gd8JA==
X-Received: by 2002:a19:7912:: with SMTP id u18mr861449lfc.298.1599856514971;
        Fri, 11 Sep 2020 13:35:14 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id d1sm214390lfe.180.2020.09.11.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:35:14 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drivers/virtio: Constify static struct virtio_device_id
Date:   Fri, 11 Sep 2020 22:35:06 +0200
Message-Id: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of instances of static struct virtio_device_id which
are never modified. This allows the compiler to put them in read-only
memory.

Rikard Falkeborn (3):
  virtio-balloon: Constify id_table
  virtio_input: Constify id_table
  virtio-mem: Constify mem_id_table

 drivers/virtio/virtio_balloon.c | 2 +-
 drivers/virtio/virtio_input.c   | 2 +-
 drivers/virtio/virtio_mem.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.28.0

