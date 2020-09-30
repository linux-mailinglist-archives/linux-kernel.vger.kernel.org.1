Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2D27DDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgI3B1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3B1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:27:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:27:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so117242qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5gnISX+IzAorXHcCo+89A+UyYx9cHW9TLkVvhrX+eKY=;
        b=tEEBIv+qbex8aRCj3XUftJLJmIgNEDArOgjk0UThudv2pDpM4/OxQSJHKtduuUu37F
         B4iJ40o2L5so+Ebb8Br5uyCDKTRfhwOA/5B7q/FRvrTda5dyHIa4B+luYBZLCMpv3R1S
         70TgWA6L2ZWP/CF/Jmhe9BfYKiSHJl333c2lEKqTb9Ap2Ij3+Hc1E+T08iVA7wpPW6Ud
         I2uijLazYW1Gd1EvHAZazR0xBdA0vuVKq9xaHrRDSbbCts9s+fuEZAp/X+2+tDnZ++FI
         WIsuNrGCNeVI7s1DAueICI1zxTznzkOzWklCg543FJ+o7AuZcNl5ZD1OctfH9wl3ZMYN
         2y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5gnISX+IzAorXHcCo+89A+UyYx9cHW9TLkVvhrX+eKY=;
        b=cFGEL4fBa61YLSROEZO50S9emAFXULpnWcf0s4IN+iHKjqLMkV2F0E8VLVOJsQkFjT
         PbUebytir4nQxeuDUYNIyWLV2J1NoXMtX9EZy+WBnqS0cLa/8fylSdwgN52dLceI9LJh
         N03drxB+JNwao4+2BQ+MIMBP+Y1zEx771EH5w/9F5QDvjFK+L6bgkJn703M7Z7A1KtTD
         tpFxAYnFUnrtvGUlwGPwKxQ6hleRZdE/JDebzES04i26juJDODTHO7HdlIG0zy7eqcsA
         dZrD1X8/32AsE6jdv6aFAHctqrVUu4i7A+r2foOqIAXNqTEzMjZDYqdIUeNliCT2G1ca
         6kiQ==
X-Gm-Message-State: AOAM531PRqIzhWfBjJyLE99ENEckvPh4CexM+kSxjM7k68XtqpqCUNfT
        V45eGbmb+OieaZHyTrhn8qU=
X-Google-Smtp-Source: ABdhPJx5iSB+x25WErWz1VdSvy6nwLd46V+4VlwnHAj+ThkVa5O0hdCpWJUEjfI/bsP9qZ6TEhAlhA==
X-Received: by 2002:a0c:d443:: with SMTP id r3mr207532qvh.17.1601429267746;
        Tue, 29 Sep 2020 18:27:47 -0700 (PDT)
Received: from core.localdomain (pool-71-175-101-131.phlapa.fios.verizon.net. [71.175.101.131])
        by smtp.gmail.com with ESMTPSA id c40sm380220qtb.72.2020.09.29.18.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 18:27:47 -0700 (PDT)
Date:   Tue, 29 Sep 2020 21:32:21 -0400
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     marvin24@gmx.de, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: nvec: Remove duplicate word in comment.
Message-ID: <20200930013210.br2env7wjvul6tcd@core.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gemoved a duplicate word in a comment within nvec.c.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
 drivers/staging/nvec/nvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 360ec0407740..a80996b2f5ce 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(nvec_write_async);
  * interrupt handlers.
  *
  * Returns: 0 on success, a negative error code on failure.
- * The response message is returned in @msg. Shall be freed with
+ * The response message is returned in @msg. Shall be freed
  * with nvec_msg_free() once no longer used.
  *
  */
-- 
2.26.2

