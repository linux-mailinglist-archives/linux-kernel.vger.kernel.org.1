Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8B2C6A47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgK0Q5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731169AbgK0Q5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606496261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=h1nOL9wj/tWhRU30VsP8qRNUyfiW/X3b6h6qswQWTtc=;
        b=LcV4UafGe15OUiS3aSyylZqA6OFW45iNE/J6Jm4JP8eksrYjpjhmbv7aYBVF/JVs28jUjx
        GNYWNlwYhHdUtN1NY0qGeg+Gnq9vV8L68a40l/CULcz5uKqeGCqbCbJFJzsCMKGU2QSDuX
        8Mo9Lakbb0LH9heycRS96C3K0jBH9fk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-bNJsYhvzN0-pTha-4W39EA-1; Fri, 27 Nov 2020 11:57:40 -0500
X-MC-Unique: bNJsYhvzN0-pTha-4W39EA-1
Received: by mail-qv1-f71.google.com with SMTP id v8so3390681qvq.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h1nOL9wj/tWhRU30VsP8qRNUyfiW/X3b6h6qswQWTtc=;
        b=DHk8+nxw+i9NuTq651OJV760v4dPVVMArY8hkUxvFvdSEMHh2YXZlhwCx16dmSJ6xl
         CxAtSjXuFom3o+rd5sBd+8mlnvYxaPkn0M5sowmt0YNzFqTz8isqwSPOhhMwEEOEtkbN
         I//1zdvb54h3j0TqXRmfE/9r9hhg4k6SKA8B69DmKC4SNpp3T7djrqxGYV8kpfKvtS3g
         TdruYsNE44jbOMjliPpZ0LNcrXhnZnQMHhAYSPuW8y15FqMwM16FChI5VTko8kjWa6j6
         Nhpn2NACZmAPTUQjCb4MZOkkmbe4BtpJjztb8Pd78aU7IZhjzvPFlE+GrNPe/cYcIkem
         hlNA==
X-Gm-Message-State: AOAM530vSU2AahtaRE2Wu+541EcfdRxAxYsshNNeDVzrFOnqkUPTktTW
        ExmK+sYgzbF+9hhT0u8uS+AA7JJMRcZtxI9Tr5BmH97SqxhXWs7qLrywQ/bZ4LBZYr+oc0yNq2n
        u+5ohbGRS2/9nvHPXKB10ICSR
X-Received: by 2002:aed:3383:: with SMTP id v3mr8993404qtd.353.1606496259517;
        Fri, 27 Nov 2020 08:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKC91x7lxDI/bGHUwc6jbF/Sfjr2ZzeiAdBNQmS42sXzMDpxbhFKyXkdMO4M7PzyiNslBnkA==
X-Received: by 2002:aed:3383:: with SMTP id v3mr8993391qtd.353.1606496259350;
        Fri, 27 Nov 2020 08:57:39 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e4sm7323542qtc.54.2020.11.27.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:57:38 -0800 (PST)
From:   trix@redhat.com
To:     khc@pm.waw.pl, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: wan: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:57:34 -0800
Message-Id: <20201127165734.2694693-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wan/pci200syn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index d0062224b216..ba5cc0c53833 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -92,7 +92,7 @@ typedef struct card_s {
 
 
 #define get_port(card, port)	     (&card->ports[port])
-#define sca_flush(card)		     (sca_in(IER0, card));
+#define sca_flush(card)		     (sca_in(IER0, card))
 
 static inline void new_memcpy_toio(char __iomem *dest, char *src, int length)
 {
-- 
2.18.4

