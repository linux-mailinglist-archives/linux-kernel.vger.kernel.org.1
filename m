Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3C2A2A19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgKBLzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgKBLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA4C061A4A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i16so8834597wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=aNe1UOeICRZDUj51juIkYs9Lwny2RtCmIIYHfF7raPNXvUp+MR9f7l1orsbrnuxaBn
         dFgMO6Uhc31U97A4YcGg71hc16dSHtix2szsIu89S7KBiTHxbVGfwYZU9Ko6YZpfSFCJ
         p7CvZnBrY2uG+sttDlSxDClusnDUONxk97e/DOyn7SZnyks47+/lM5MDpnZKE3GxWQ0V
         Kud4XlPlwvuIrit0mxlFUmdtsg0i6TgJyECZ+C80K4aODQlYd8thsKFe9EnFstB3dY8z
         iKZY6uZHL2i5NmVfxneEW/j5oW9Oh2P31BgXBk0w/ily0GnbYDhw9NWIUgCg+y2EYBA4
         NamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=aWUAz/eRmL0avKCwCHeSmBZjCW3xrXogIlVN/apx5RrdtxrHtBT+KmhWVyFMFBaJaW
         KZZAqqKg6IgleAZujmGemxgbEebFK6wKQyTaY9wgxbKzRGBs+IQm5Rw9ZZEJ5HLIFzOK
         j8JDajm1A4aO/STx/vTanVtiOIUQpjJbV3bVrXQSj9fIqld/zarIL7Grh6xmulI6IbTk
         C7OdKapP5gcpyprgzqjFtpqc0ozhVTBpydYkptMspGJ6avLTzI3z42N5JB82wnq6Vfs5
         HY+jTHN3TwnMoZ97052n0Gu/HmE1vJr1yGHEZCLK5+mGGr590gFj12fsbVldhG9BeTHM
         NnVQ==
X-Gm-Message-State: AOAM5336RTSWF5iS/pNmViMa59Y26/5JTct1ZbASNVdmBNaFHuU2y2qQ
        GSCypt8nXy6JtwFPto2XHdDeZw==
X-Google-Smtp-Source: ABdhPJzz2I+xtA7lYt3DrHliYeba2hil/cvbDSwq7Fj3zS9Q6D0jbmdPE6XMMJ5sSnyzxxfkbrFOLA==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr19909593wrn.253.1604318067409;
        Mon, 02 Nov 2020 03:54:27 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 11/23] mtd: ubi: eba: Fix a couple of misdocumentation issues
Date:   Mon,  2 Nov 2020 11:53:54 +0000
Message-Id: <20201102115406.1074327-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/eba.c:1304: warning: Function parameter or member 'vidb' not described in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1304: warning: Excess function parameter 'vid_hdr' description in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1483: warning: Function parameter or member 'ai' not described in 'print_rsvd_warning'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/eba.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 0edecfdbd01f3..892494c8cb7c7 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1290,7 +1290,7 @@ static int is_error_sane(int err)
  * @ubi: UBI device description object
  * @from: physical eraseblock number from where to copy
  * @to: physical eraseblock number where to copy
- * @vid_hdr: VID header of the @from physical eraseblock
+ * @vidb: data structure from where the VID header is derived
  *
  * This function copies logical eraseblock from physical eraseblock @from to
  * physical eraseblock @to. The @vid_hdr buffer may be changed by this
@@ -1463,6 +1463,7 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 /**
  * print_rsvd_warning - warn about not having enough reserved PEBs.
  * @ubi: UBI device description object
+ * @ai: UBI attach info object
  *
  * This is a helper function for 'ubi_eba_init()' which is called when UBI
  * cannot reserve enough PEBs for bad block handling. This function makes a
-- 
2.25.1

