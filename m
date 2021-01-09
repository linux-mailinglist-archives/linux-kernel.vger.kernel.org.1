Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18A2F0423
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhAIWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:41:46 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CBC06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:41:06 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id n9so14346859ili.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsxD3JQ+Z5yAC8KY43Ufa4bZIIAj5oqXaUyxG4sP52U=;
        b=f2+8pVYz8/9i5oWWiciKhZkoGDyhTZzn4tYw16s8otgiVBie2hUhZ8Y0PIuhbqHfM4
         IA1Dw4tkhPMNrf6w5mLb74xTVk4OZHL2/jlVXL+aGrzlzem5Rr4itmOGlQ1YmBZEhLj1
         IJD9Z/WWCx1WH8/921n05gvi5xDOPKlHUFr5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsxD3JQ+Z5yAC8KY43Ufa4bZIIAj5oqXaUyxG4sP52U=;
        b=IxdT0sv+9vRiAPoGb61C8A0IXMZ/kusoe7PiRtbjOK9VaitLDSpoybykPH6HGy9Ug5
         TGCR4m2g1oOs2p7GWgLlGbPfvga0XOPXFUsUIIGauFKQER+cCu1Z5rcnocaxPtn6TbXm
         MbcyjJLSzvoJDNM1aFGGX9GjEBp4d3pplNhPnyFTKnPNDp5A/LcL0N0JNrZuVbz6DABX
         sGT6jxrkOy+z1/MWbgt1O9RpI6g58dlowzWH4iRozr+MMHKQhbBy9vCk4sbiFzU7W2gC
         KbydJ7TSHiZPGlYLPxe+a8HS7x/5l9Rsyf4qxYVzopJAQeYSxthUAbkgEDHgTxWwehXX
         HN5Q==
X-Gm-Message-State: AOAM530JnXScHPWbYMt21w/jYgRQwLO3WuI168HQHLm5FoOKRQ9/05bd
        sD4wgqHA5XUJaZaY4xYl8pn64A==
X-Google-Smtp-Source: ABdhPJzViOiXtuc/DySDWQ1oE4j6d7J4K3Ns9sa3TBEgFJI+szAZygdcuPvNsJR2ip3AEdTsleNsyw==
X-Received: by 2002:a92:ca91:: with SMTP id t17mr9586067ilo.67.1610232065992;
        Sat, 09 Jan 2021 14:41:05 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id t21sm11561619ild.86.2021.01.09.14.41.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Jan 2021 14:41:04 -0800 (PST)
Received: from puyallup.local (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id 1680A366BC7;
        Sat,  9 Jan 2021 16:41:04 -0600 (CST)
From:   Steve Magnani <magnani@ieee.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <magnani@ieee.org>
Subject: [PATCH 2/2] udf: fix File Tail reclaim following hole append
Date:   Sat,  9 Jan 2021 16:40:54 -0600
Message-Id: <20210109224054.5694-3-magnani@ieee.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109224054.5694-1-magnani@ieee.org>
References: <20210109224054.5694-1-magnani@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven J. Magnani <magnani@ieee.org>

Adjust bookkeeping during creation of an end-of-file hole to ensure that
any File Tail (preallocated extent) is reclaimed when the file is
released.

This also ensures that the file's Extended File Entry is populated with
the proper count of recorded blocks.

Fixes: fa33cdbf3ece ("udf: Fix incorrect final NOT_ALLOCATED (hole) extent length")
Signed-off-by: Steven J. Magnani <magnani@ieee.org>
---
--- a/fs/udf/inode.c	2020-12-28 20:51:29.000000000 -0600
+++ b/fs/udf/inode.c	2021-01-03 07:04:05.759911829 -0600
@@ -535,6 +535,7 @@ static int udf_do_extend_file(struct ino
 			add = new_block_bytes;
 		new_block_bytes -= add;
 		last_ext->extLength += add;
+		iinfo->i_lenExtents += add;
 	}
 
 	if (fake) {
@@ -571,6 +572,7 @@ static int udf_do_extend_file(struct ino
 				   last_ext->extLength, 1);
 		if (err)
 			return err;
+		iinfo->i_lenExtents += add;
 		count++;
 	}
 	if (new_block_bytes) {
@@ -580,6 +582,7 @@ static int udf_do_extend_file(struct ino
 				   last_ext->extLength, 1);
 		if (err)
 			return err;
+		iinfo->i_lenExtents += new_block_bytes;
 		count++;
 	}
 
@@ -682,7 +685,6 @@ static int udf_extend_file(struct inode
 	if (err < 0)
 		goto out;
 	err = 0;
-	iinfo->i_lenExtents = newsize;
 out:
 	brelse(epos.bh);
 	return err;
