Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C22B1C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgKMNs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgKMNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zahLTNS43nRj+vHGeTYURaqz9Ba56dxaMqAEL8MHFEM=;
        b=DzeiBxjaxlza6nV0gTvLiYvLxCPzkGGfbzNLopb1F56mkT7zOpBS0GFv7ojeEXFkUbkZXQ
        rMSnMZIMpePRl/+6yKmJSBIRxiSWIkqEIRMB5c9mcpzNFqlVCp8flfw8egDwsLUc8WyA3l
        P7apbGhSN3EAHg4+8zi5kGcpbrZzaJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-XNL1iMqPN5OBFqQ7ctti7g-1; Fri, 13 Nov 2020 08:48:48 -0500
X-MC-Unique: XNL1iMqPN5OBFqQ7ctti7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072748030A7;
        Fri, 13 Nov 2020 13:48:47 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 306005D9F3;
        Fri, 13 Nov 2020 13:48:45 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 11/12] vringh: allow vringh_iov_xfer() to skip bytes when ptr is NULL
Date:   Fri, 13 Nov 2020 14:47:11 +0100
Message-Id: <20201113134712.69744-12-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, it may be useful to provide a way to skip a number
of bytes in a vringh_iov.

In order to keep vringh_iov consistent, let's reuse vringh_iov_xfer()
logic and skip bytes when the ptr is NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

I'm not sure if this is the best option, maybe we can add a new
function vringh_iov_skip().

Suggestions?
---
 drivers/vhost/vringh.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 8bd8b403f087..ed3290946ad7 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -75,7 +75,9 @@ static inline int __vringh_get_head(const struct vringh *vrh,
 	return head;
 }
 
-/* Copy some bytes to/from the iovec.  Returns num copied. */
+/* Copy some bytes to/from the iovec.  Returns num copied.
+ * If ptr is NULL, skips at most len bytes.
+ */
 static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 				      struct vringh_kiov *iov,
 				      void *ptr, size_t len,
@@ -89,12 +91,16 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 		size_t partlen;
 
 		partlen = min(iov->iov[iov->i].iov_len, len);
-		err = xfer(vrh, iov->iov[iov->i].iov_base, ptr, partlen);
-		if (err)
-			return err;
+
+		if (ptr) {
+			err = xfer(vrh, iov->iov[iov->i].iov_base, ptr, partlen);
+			if (err)
+				return err;
+			ptr += partlen;
+		}
+
 		done += partlen;
 		len -= partlen;
-		ptr += partlen;
 		iov->consumed += partlen;
 		iov->iov[iov->i].iov_len -= partlen;
 		iov->iov[iov->i].iov_base += partlen;
-- 
2.26.2

