Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8923AEAF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgHCU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 16:59:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728570AbgHCU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pbr1N8DSevefC/5XR/FPYq4gph7eMtDNIH83d+s2qxE=;
        b=S11nOOoPCQUk4UpUd7qlBd9MgD98aIJziBk8D8FMaCiJYiz1k8499nTLp1NyrGKKz1rgz8
        Xio+L1apAkuyOa+F7oPmnFp3ESqJjq2HqhSGiWlpOWAIP3EkCeivwBjcIVON03DinoV2fz
        TTAVEQuP2IGEWIv72jRtSOs8g0mfSI0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-0Fkmvn9HM8iAMekNUMEIdA-1; Mon, 03 Aug 2020 16:59:14 -0400
X-MC-Unique: 0Fkmvn9HM8iAMekNUMEIdA-1
Received: by mail-qk1-f199.google.com with SMTP id f18so12845348qke.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pbr1N8DSevefC/5XR/FPYq4gph7eMtDNIH83d+s2qxE=;
        b=Vn9yg2T264POGCkkVBnvLSDJteToSKU/ZaszT6UH9GA/p2JGLmYkA0scIpNqqGE/lc
         89PMZlUINpEqAB0JWtjiDQ2RuJo948paQR8Ua6j01RHW2FyfCV6IrlUAVKgf6SJkUxVD
         d4nwnb6BzII3yR56NIgBFEFWpbkyulpoCxG8OUJ4h+rS6L9gBDsJZ33gWGGJOnTLp77U
         LWVInq8ayXzCFFGc+szeSpd7fllKYD+F433auBIraiXMEZE4HEAInrxu/VTwNMyd6ew6
         4Pz9zQv5ej2u1rmFG4Ki3aRdSs1cDpJmzqJ++58TJFHOJlqFiG3FjE5hCFFtk7rtgKHh
         dpBA==
X-Gm-Message-State: AOAM532zgPBOomtC72w3tsIX19iovrb7RZyz26cMKRbsjEiX/M4cXsFy
        FTJsasd1Egn+pIAFygnWmVR80C4lbhFJPH9s9bD3NHeFc1ZsRYkbSWvvEmbJxKCcy24JNu+FXkM
        gK42yHdtwCA457pgAgNDKjHJC
X-Received: by 2002:a37:97c5:: with SMTP id z188mr17625694qkd.185.1596488353342;
        Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpOGU4uU2+OZrgzDbQ/8jdl4TOLFPS5AcU+IWHZ8zsJRTTGwbHFRTkcrWAk9H50yW4pnfpSQ==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr17625681qkd.185.1596488353070;
        Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id k2sm21549694qkf.127.2020.08.03.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:12 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Gonglei <arei.gonglei@huawei.com>, linux-crypto@vger.kernel.org
Subject: [PATCH v2 08/24] virtio_crypto: correct tags for config space fields
Message-ID: <20200803205814.540410-9-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since crypto is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_crypto.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 50cdc8aebfcf..a03932f10565 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -414,33 +414,33 @@ struct virtio_crypto_op_data_req {
 
 struct virtio_crypto_config {
 	/* See VIRTIO_CRYPTO_OP_* above */
-	__u32  status;
+	__le32  status;
 
 	/*
 	 * Maximum number of data queue
 	 */
-	__u32  max_dataqueues;
+	__le32  max_dataqueues;
 
 	/*
 	 * Specifies the services mask which the device support,
 	 * see VIRTIO_CRYPTO_SERVICE_* above
 	 */
-	__u32 crypto_services;
+	__le32 crypto_services;
 
 	/* Detailed algorithms mask */
-	__u32 cipher_algo_l;
-	__u32 cipher_algo_h;
-	__u32 hash_algo;
-	__u32 mac_algo_l;
-	__u32 mac_algo_h;
-	__u32 aead_algo;
+	__le32 cipher_algo_l;
+	__le32 cipher_algo_h;
+	__le32 hash_algo;
+	__le32 mac_algo_l;
+	__le32 mac_algo_h;
+	__le32 aead_algo;
 	/* Maximum length of cipher key */
-	__u32 max_cipher_key_len;
+	__le32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
-	__u32 max_auth_key_len;
-	__u32 reserve;
+	__le32 max_auth_key_len;
+	__le32 reserve;
 	/* Maximum size of each crypto request's content */
-	__u64 max_size;
+	__le64 max_size;
 };
 
 struct virtio_crypto_inhdr {
-- 
MST

