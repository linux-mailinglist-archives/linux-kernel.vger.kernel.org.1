Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D72968C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 05:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374890AbgJWDbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374872AbgJWDbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 23:31:44 -0400
Received: from mail-vs1-xe63.google.com (mail-vs1-xe63.google.com [IPv6:2607:f8b0:4864:20::e63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874AC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 20:31:44 -0700 (PDT)
Received: by mail-vs1-xe63.google.com with SMTP id r1so110609vsi.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 20:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drivescale-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVOU56vMIKPwRdSa1DX4NgPyTaBBOM7ISpZAf+v+NPc=;
        b=FDqHw2AbeHw6eX4xu+NIjrtMPLcV35cn+OI5XXsmrMmacbgmO0nReXcxT9fALCsb4J
         dmRS1nB0hZaY/g4t9LFwCbv8qZzbt2OMSGH8tGHpn4p2zme0ya5sWPWYfOKXJ4QcPu2a
         HzY6USAQHcs07Ex4HUobYzn6uMa0oyfATmauyOnRYIOPUzQLcE8UcpmDHSBr2C1rXncV
         i2V/gIdf5ZeJ+Dr8nSEkugfpzi7PVptZWpDjt+iQw/hgaS/31cl0Yy4VppT2vDls6KFQ
         K4rVQw0d04AqNw/Nc4CGCniUENd2mYMWrANS3Epp+JTm02OBYnOMJHq7Qp+oJvqv/AAc
         O7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVOU56vMIKPwRdSa1DX4NgPyTaBBOM7ISpZAf+v+NPc=;
        b=olGKGhF6XmSk7Me0sy69h/l84fbeCHARMA4PLB7WShCpvgqEHq2iB144Az1BVkKuwS
         NCKVbDV9DViJwMuzg6YlEkoSJ0jHUBS5v+EWX5uRxq7h+WZb+iJPeBPoXqxQn+t8xoVK
         NR0t6UJx6btAWpR4q/md8kLRT1NzB/M+9WSsQWpX/Q78w2xHzVQqtXvyfxCtHCcqI+sH
         +vieg+1q5INVVT3DJvVGGTqUEu8jxuMfNa7x2yS4sT2vs41qpeEPcAWe8ebhxRCr4TQt
         XgqoDw1oXLgNTdw06UXBIMtaSQ1WBjbzCNKqW0b+NbWdY1BLDmbOWM08E6SWPEWGIUfM
         goJA==
X-Gm-Message-State: AOAM530nhUUlVoLEo8OK8fB1/t10LrttAy5BOdJMGY6oXTESzWgF1U8A
        u5xFt+ZevCG+yUFmagwSyH44ip18iejlB7WwOIa+8WMTE1wwvg==
X-Google-Smtp-Source: ABdhPJyBqtEAMrygy9f0ONPybfZe//14DeioNF4I0kf3/eYvXo/Ag1D3weXXgQLx7e8KDeaIn4+skGf9Rlch
X-Received: by 2002:a67:ea4e:: with SMTP id r14mr205149vso.47.1603423903465;
        Thu, 22 Oct 2020 20:31:43 -0700 (PDT)
Received: from dcs.hq.drivescale.com ([68.74.115.3])
        by smtp-relay.gmail.com with ESMTP id h12sm41939uar.2.2020.10.22.20.31.43;
        Thu, 22 Oct 2020 20:31:43 -0700 (PDT)
X-Relaying-Domain: drivescale.com
Received: from localhost.localdomain (gw1-dc.hq.drivescale.com [192.168.33.175])
        by dcs.hq.drivescale.com (Postfix) with ESMTP id 891494211A;
        Fri, 23 Oct 2020 03:31:42 +0000 (UTC)
From:   Christopher Unkel <cunkel@drivescale.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        cunkel@drivescale.com
Subject: [PATCH 1/3] md: align superblock writes to physical blocks
Date:   Thu, 22 Oct 2020 20:31:28 -0700
Message-Id: <20201023033130.11354-2-cunkel@drivescale.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023033130.11354-1-cunkel@drivescale.com>
References: <20201023033130.11354-1-cunkel@drivescale.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes of the md superblock are aligned to the logical blocks of the
containing device, but no attempt is made to align them to physical
block boundaries.  This means that on a "512e" device (4k physical, 512
logical) every superblock update hits the 512-byte emulation and the
possible associated performance penalty.

Respect the physical block alignment when possible.

Signed-off-by: Christopher Unkel <cunkel@drivescale.com>
---
 drivers/md/md.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 98bac4f304ae..2b42850acfb3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1732,6 +1732,21 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    && rdev->new_data_offset < sb_start + (rdev->sb_size/512))
 		return -EINVAL;
 
+	/* Respect physical block size if feasible. */
+	bmask = queue_physical_block_size(rdev->bdev->bd_disk->queue)-1;
+	if (!((rdev->sb_start * 512) & bmask) && (rdev->sb_size & bmask)) {
+		int candidate_size = (rdev->sb_size | bmask) + 1;
+
+		if (minor_version) {
+			int sectors = candidate_size / 512;
+
+			if (rdev->data_offset >= sb_start + sectors
+			    && rdev->new_data_offset >= sb_start + sectors)
+				rdev->sb_size = candidate_size;
+		} else if (bmask <= 4095)
+			rdev->sb_size = candidate_size;
+	}
+
 	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH))
 		rdev->desc_nr = -1;
 	else
-- 
2.17.1

