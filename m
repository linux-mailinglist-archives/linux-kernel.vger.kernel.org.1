Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7027DF11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgI3Dlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3Dlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:41:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 20:41:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so159444qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=904wo1HstmKPfAlqw09yQOCjg2/bb4jTacjAS/C5REA=;
        b=FxqvT8XjUW9EsnLWiMGev/S/pqV96UKY8Lln3yn7e0jP/0IFICsD+WyV1xSyK30+3W
         nYu6ZM2ciAeakWkSEr0S1VX6wK37oNkEIjQGQywTiBmcdrI8OHsCOXPkxjmG2IVFIK9s
         WBz9Xo+zUsYN0QPTFKKFRMLpDaSHl5kcDVmgzp7KywSRAcdCfV+publL4eMHs932s71B
         oA7mEvY2uelrMoAL4LLmbuk2GqFu/RKNP5J579TjOMxHzKe7VQUpsr9IysNQBESmpLGL
         OSAsRUk/sQdyYV4uHkVzy9ngzK86w9K1M9Rvs8MPJyKSQUS/2L/8dAhbdyzwAJoA+AA5
         2j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=904wo1HstmKPfAlqw09yQOCjg2/bb4jTacjAS/C5REA=;
        b=aqATS6+tVX822M7MAuoLNTGXjXee98UBEvcfayKJJnQHlO+DiFd2svOSA3mv6ZDNwv
         wPCJtsjvStW7GUJYmxmEPSS4TnTjDeuk+O6W18/CpA5zAh272VdRNc5ouHx+wRa3G+0l
         MKHtOMv1MSd3Xz94I4D7+6rbOSPp5XTJYF3/ohXCbBhg2KAgUSxSEW+l8SmBeIgY+CKm
         rdTM+SKLKOkLW/+HlIMOU8U3EXDdMv7Uf++F1qFqJ7qc62QbjQeGb4EnSMumL/QXIRqY
         Ab2tKn4u0h0O0nMF4pFnBVZo9TeySKoWoHn5yjSPnE6g06q+c6NoHuF1fSbbEfDssNeH
         XslQ==
X-Gm-Message-State: AOAM532rRKQmoEfozHx+TKc5aIRgzicCwNG0yOwyOQfOSmN7C1n1XohL
        O0z2qeWdaVyypkqp2+KG3EweelwTuk6Qtmztl5k=
X-Google-Smtp-Source: ABdhPJyBorD11hOERa2IM2DMaTmg2iWVV10SSsGQhH3lgvbKAy+MfEo0+NmxczMsYsKswQZuskKdzUOTY+UJ7wk74D0=
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr708391qkg.277.1601437312482;
 Tue, 29 Sep 2020 20:41:52 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
Date:   Tue, 29 Sep 2020 23:39:53 -0400
Message-ID: <CAF4OWHKYrcZzZp_YVf+mnGgjHUi7AKPA22s5q7vVfu371_8HTg@mail.gmail.com>
Subject: [PATCH v2] Staging: nvec: Remove duplicate word in comment.
To:     marvin24@gmx.de, Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate word in a comment within nvec.c.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
Changes in v2:
 - Fix spelling mistake in commit.
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
