Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18671A0060
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDFVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:35:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726713AbgDFVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=J4zL+SfB3lMJCxK9MSzko8QIjZ++tFcBg5QlI7j4Y3XqJ+Tfb+5D7Si2Eg2A/nEu+qAo/L
        HIfEl6VHqP1FP8CH3ZFhJWfekeLWKzYc/sw3l1vKI2fRMUsNvOh+vP0bALQivMhrraw5gl
        B0yNSeSfDnSl1YKCfgJO4mgj2Q1/6os=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-m-JTr2suOACqFJFJlHFh7Q-1; Mon, 06 Apr 2020 17:34:59 -0400
X-MC-Unique: m-JTr2suOACqFJFJlHFh7Q-1
Received: by mail-wr1-f71.google.com with SMTP id c8so561085wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=WDuBzixCv2nZEKbN76EnI60cMNZV5vUZs1RZcEuODLknLJ3HQBypIjt4K8t0ngQ9xR
         QVo5hLJe1PvSH7UC9yDNJ94Ikbxm+0m2PAhyWRAqJORnBs1uvN6i6g+MzSdZ6lqek5GP
         HcUbQBMsYaRqHpnXh9v6+yl5+FZegDZlwHClEEQ4kAlq+ZuL/hw8jnGf4YaMBRK7uqGY
         3k9KVlTVnHZ4X3nnP1NKofnc2vFD0aqMN4A0B36XxQsi287t19oTCP4Jd1/JR3qYgxrb
         iO2ru+EM2mD1nNfucVf4YaeC+dNWX6RAnIXauv1v3Otu1tqhG5pRwsRPdhv/tPeloVtq
         Nn0A==
X-Gm-Message-State: AGi0PuaNKVCaXA8ujSMALwnNolMZ+a2Vke6SxCfUDxGl8Noz0z5I4W52
        e3c0b5ncX2zHdVcDrl6tMIHcWz9HZYcib2JiEYU3Xg54ylviow40g5I3NNR3lP5gvcLxLVhAW5f
        JefUPCzQ0ZuFMrSCHxp9hXxvE
X-Received: by 2002:adf:f44f:: with SMTP id f15mr303360wrp.270.1586208898144;
        Mon, 06 Apr 2020 14:34:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypI159ebnTiToQl1tzfpeqQgmH/T1ywBqyQKWOkNaclvA52w3xCI0JwwcGElWapEFXMTsHQeSA==
X-Received: by 2002:adf:f44f:: with SMTP id f15mr303354wrp.270.1586208898000;
        Mon, 06 Apr 2020 14:34:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id j11sm27996776wrt.14.2020.04.06.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:57 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 02/12] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200406213314.248038-3-mst@redhat.com>
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

