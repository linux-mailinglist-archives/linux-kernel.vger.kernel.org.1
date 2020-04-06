Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301721A003F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:34:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgDFVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=dXFeGm316841nJJUPDag3xrDOKWiXOj+hRLZ27lTNgGRW5iSZBoDWIWSurlVUyFFU0E1oP
        5rJyf7nthF9c2ii9x52S1KnFWAVKxiU9BIxmW/DSElQ/NdSvm2ESH/C8v5NCZWuthUzDVF
        z5KAP6OP9fVZP7TDazzbILEhidnZAYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-XQKNXEAWMRy0TDx4L40p5g-1; Mon, 06 Apr 2020 17:34:31 -0400
X-MC-Unique: XQKNXEAWMRy0TDx4L40p5g-1
Received: by mail-wr1-f69.google.com with SMTP id g6so576383wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=oJQNfNwDGdnzW+sx3anqibn+TZ5387mgflQAcixTapeqfbMdHCR0p53v8+cCIexf4n
         k18e3bgA3QwjJaM6dclceBHibhmQopb3NI3jJT6XyrR6Wa/t1Xx/wa2W7e8SRYKk/2Qj
         HvaTNohwMJywMjMBFxx4I+D5wcidEehmhxazsf3S8I/8dOyOvSdCoeBkWYsyNerZsktD
         Cllhj2cHl91nf+bzqvYmG9m0LHVflmHi8FDoNAQR2jX04X9KpXi3YFZhzo02MMguFCts
         /u7758heF/Ms8ZFn+DwrL+6dR54whB65gPI5550l6jEGsnJKlSKfyXh80bS/YcJMuZ6Y
         7X2Q==
X-Gm-Message-State: AGi0Pua5tOK4xuzQsIDD5IQgMLuiwCiG1rNwnpUOI7DCen8CTpkGBRJa
        FheSHV5YwIm6yrHTYKr87dHbx50hWWr8b/tMrfIP97Iw8yUDKQFWvhvYagoBkCl5Et9BllrAyka
        BNGPUO+6EHIxHEfMh8ADkKq3B
X-Received: by 2002:a1c:4805:: with SMTP id v5mr1344526wma.98.1586208870530;
        Mon, 06 Apr 2020 14:34:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIPZi3gtX7Pt/4KiWWhtz117je7cNyTelzpyCcElCBiIj7ZMXAYdNZGgah2e+dZblNCDgVHrQ==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr1344514wma.98.1586208870379;
        Mon, 06 Apr 2020 14:34:30 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id o9sm27494529wrx.48.2020.04.06.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:29 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 02/12] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200406210108.148131-3-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using abort() so let's include stdlib.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index d0351f83aebe..04d563fc9b95 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
 #if defined(__i386__) || defined(__x86_64__)
 #define barrier() asm volatile("" ::: "memory")
 #define virt_mb() __sync_synchronize()
-- 
MST

