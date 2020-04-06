Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E826C1A004F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDFVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:35:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47199 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726708AbgDFVfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=aELiRR02UCobAWlaRF/NxB45erRYqXisJ9NTXotPaG/H/18WSTvpY9XkgvTvfJJ1CgiDCM
        nJ8ZX+GDX/XDfVeQdRetRJVgwewp9mBsge7ixv0YI+Xc9jM+J1AmmZqFO8AhqulLyijysg
        uFL0AJSf2a5GPXhY7Nip4oYzhOjxKhs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-F5qjrpBsPGCpUCTfPJbhDw-1; Mon, 06 Apr 2020 17:35:01 -0400
X-MC-Unique: F5qjrpBsPGCpUCTfPJbhDw-1
Received: by mail-wr1-f69.google.com with SMTP id w12so554928wrl.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=WQH/6jmF8vx5bWFE1Vq8D/14892aY/SvPmAxKyDpyPiV7l2aBfzE9845xiESFY/iZO
         DBDKZvyRB2Qz2y8XHyr9mBvYR26ytiTS+YFHjX/2l4yxnbdetCS6RPibvg0X4I74aXpQ
         lNP1z0iJu5gkpg2MAajFeAD87KOUqLioWug6cxNuWP3KoMNk+ZrsSb4jy+29HVvdr1lL
         lyq3sbq/9b9W50KtIWpEnCC6zQa4NVf2F8y/cCDHXWMpT/kKgD0P91RaqVj/OuqrYnbZ
         YFsxR4vX6kPMNKWRrBhzwLP5xDVf1SBUAs84G9AEzrq2w8pq9zVkkASSJ1Z0Rhs4PpPm
         yckg==
X-Gm-Message-State: AGi0PuZh9lXLdz8KxIvkKXKDIJqoclbjcX4rmr8wtd1asN1PMSj8Y5zj
        4zhVNkMS7Rp2BIGh8Db6ksjJwpDcksIq+WlRA4sJtYP1mjFeWwV9/54Apddly2BPyGgMfY0816R
        fAjuF2u4zcYxQcWbRt6B6QXEo
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr1480029wmj.106.1586208900157;
        Mon, 06 Apr 2020 14:35:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxwNpdhgwvijcmYFwK7AjslG9GMzpweTVcwoOVdgae0Vm3Q9It7NJ0w/b7TaK+8UFDmgykOw==
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr1480011wmj.106.1586208899943;
        Mon, 06 Apr 2020 14:34:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id j11sm1043727wmi.33.2020.04.06.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:59 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 03/12] tools/virtio: define __KERNEL__
Message-ID: <20200406213314.248038-4-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we are building in userspace, we are emulating kernel bits.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index b587b9a7a124..ea6674307507 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -D__KERNEL__
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
-- 
MST

