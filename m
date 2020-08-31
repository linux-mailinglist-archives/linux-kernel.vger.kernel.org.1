Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743EB258155
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHaStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgHaSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:49:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:49:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so7156134qkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gW/GAJk+DvNLvyuRynw+O+IEgqlrjmTs4zN1XyER6Kc=;
        b=HtH0lp3X0B/IS4VslB7oJRNKkUSwHZbrZzhCYTa72DLJK++qOMuVnZh6yqZ+utyxOq
         4OhDcdNjzjXKxN6Vm3TUFSVNgnUSbkWYLGK5QGDwWsEhj30Z3BNZJuUfLXsGRjcmeoyp
         iKd8kDTuPt1TEnq8CQq+Yj2sYCVwLNyGLFdmgwQ6tdeR9nwNa/RxzpSsKVO0laXQGbR4
         BCnRqlbMR4QqY8SZQ3ILTC78tBYf/OoXpUsGw/a1Br8QvNPAhizAGLn6x9MlBoZfm86X
         8JdaQOuhbRka/IMWaQlFWKsmR1bf92NRGHxvLjPt/U+WwNHrCLzcxT+xnhDip8aUw4LH
         wA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gW/GAJk+DvNLvyuRynw+O+IEgqlrjmTs4zN1XyER6Kc=;
        b=p4Y3HBmvcE4DtA4ociayz7pD3phdR8OgsNgYDQjWeynE+2/TpKxL2EOZcbhjNH74AF
         MKI1IpeOGgyoXsoyu8fIwkgafAlZW32HwRXEGo59nYG5xtdtWh39L+iwq+vbq8X27k7t
         8gIa/insGIFqsdEV/DW+z4oxOKb1t8XaCHmG6q8yY2eWWO8dlmQrA9/pq9VitDWfGgt8
         2Sx3fWeSQcxFz2kurU3ZVOQquOeSUKSd0b2vM4yiOdcGsItu9pgbvh8JrKg0/M5MO5u0
         oHLirh3biY0w8PCO3AMeUNThsejfTnmuAaYv21I+Bo369s3VBiy8TI3+PE0RplPu2yG3
         4yJQ==
X-Gm-Message-State: AOAM530s82vPKukDaJrNZoFaCiB4zIj14CHaXH+xo0JBNif30KqUthbB
        hum5AnXHC4mxwaPRSvh7klnny16egg8=
X-Google-Smtp-Source: ABdhPJyEZji/0NQ0lddMUAajB37hmn05TsE/kDQTtJhzrMavyxL5DTi9z+BFEEgG0MmkLnxlUC7Fog==
X-Received: by 2002:a37:b307:: with SMTP id c7mr2852539qkf.33.1598899766644;
        Mon, 31 Aug 2020 11:49:26 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id s17sm11779070qte.50.2020.08.31.11.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:49:26 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dma-direction: Add DMA_DIR_COMPAT() macro to test direction compability
Date:   Mon, 31 Aug 2020 15:48:58 -0300
Message-Id: <20200831184859.110660-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200831184859.110660-1-leobras.c@gmail.com>
References: <20200831184859.110660-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given a existing mapping with 'current' direction, and a 'wanted'
direction for using that mapping, check if 'wanted' is satisfied by
'current'.

current			accepts
DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL, DMA_TO_DEVICE,
			DMA_FROM_DEVICE, DMA_NONE
DMA_TO_DEVICE		DMA_TO_DEVICE, DMA_NONE
DMA_FROM_DEVICE		DMA_FROM_DEVICE, DMA_NONE
DMA_NONE		DMA_NONE

This macro is useful for checking if a DMA mapping can be reused.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 include/linux/dma-direction.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 9c96e30e6a0b..caf3943a21f4 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -9,4 +9,7 @@ enum dma_data_direction {
 	DMA_NONE = 3,
 };
 
+/* Checks if wanted direction is satisfied by current mapping direction*/
+#define DMA_DIR_COMPAT(current, wanted)	(((current) & ~(wanted)) == 0)
+
 #endif
-- 
2.25.4

