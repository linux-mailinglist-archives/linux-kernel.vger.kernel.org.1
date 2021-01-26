Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19573304DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbhAZXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbhAZEzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:55:03 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D004C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:23 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id t6so9172507plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxNEOYhgKwvRvVfu2/k3ZgwDNvcTYU3oc8R54p0XWwA=;
        b=to0uKAF7Nj1QlCsWyg4IjE5lSdoDnjb+l9Ld6oFvxCEr+TdnupQouEo+9kBXa/CDTa
         CcWbs9nZMugSmys1AYrg0YzRl7gGvYIGqFcWo3m+tnDDoNP1eEytLw8r3y7GSwMyrmCe
         D1MkaErva8TKJARzEmQ3TRygPOnZWkae0oQNXH8nuBTl1tLbbILHBtIsNbb52vxMEmBG
         HQHRvco4f3ttmI5jpwD72uQoDxUVtsLsRLoXAOuHMtgh+IGcrxP5DwZ+4nZ3hWnf9Yc7
         BPYalDoaBtLHOmX56hB5YjYixLyMljyMwoz86Q8ScLyG6lL2uoJfpDdBof0J7WJ4hrPV
         oSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxNEOYhgKwvRvVfu2/k3ZgwDNvcTYU3oc8R54p0XWwA=;
        b=pek+HXjjxT1Urh5RDcS871SQaQpfZjmBQYMZCf20Jlfsp2XxODId99BjVqUI/p5tgf
         702NVjiPjBIXR4LsG/IQ0aaEeIvU7SSoEcSFfV6B4W5+6CwH3ap5Rq9f5g1qzjpBrptZ
         uuTC+uTjZ4BztTEXPvhuKNEe1RWU+9+sAxpZfUl+4M6UneCGRRwq7M2HAcaj3Fs2F+9n
         6doVGsBNFQjFpsf8mlWM+wSaNRLG4mIrt6GBZq4plw9R9xGfAhCmsPa3KUV7XEWeQNRd
         NWmrDqEMFQ+8idS2wpSIJvTKNU0bPkED1TU5BiG6YkZE0WwIjgLHBPcHLwOO0iqFIN1V
         8/ng==
X-Gm-Message-State: AOAM530NrMFY5zgUGsvDO0SvEdayxmKT8Jd8vQ+zDbTbKXxAMZktELTC
        lXim3bdk9L+4/bOJQlfp3R4Yr9qX2fo=
X-Google-Smtp-Source: ABdhPJwtUyXXER9bmRZ+e2DThvE7nOQ7xV1I38TK3IzCWyGCRxyYZp+rA6/30YI7Bw+AQQF+pC05Lw==
X-Received: by 2002:a17:902:e844:b029:de:5abb:7df1 with SMTP id t4-20020a170902e844b02900de5abb7df1mr4028710plg.55.1611636862738;
        Mon, 25 Jan 2021 20:54:22 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:22 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/xive: remove unnecessary unmap_kernel_range
Date:   Tue, 26 Jan 2021 14:54:02 +1000
Message-Id: <20210126045404.2492588-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126045404.2492588-1-npiggin@gmail.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iounmap will remove ptes.

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/sysdev/xive/common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 595310e056f4..d6c2069cc828 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -959,16 +959,12 @@ EXPORT_SYMBOL_GPL(is_xive_irq);
 void xive_cleanup_irq_data(struct xive_irq_data *xd)
 {
 	if (xd->eoi_mmio) {
-		unmap_kernel_range((unsigned long)xd->eoi_mmio,
-				   1u << xd->esb_shift);
 		iounmap(xd->eoi_mmio);
 		if (xd->eoi_mmio == xd->trig_mmio)
 			xd->trig_mmio = NULL;
 		xd->eoi_mmio = NULL;
 	}
 	if (xd->trig_mmio) {
-		unmap_kernel_range((unsigned long)xd->trig_mmio,
-				   1u << xd->esb_shift);
 		iounmap(xd->trig_mmio);
 		xd->trig_mmio = NULL;
 	}
-- 
2.23.0

