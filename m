Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2D2EE9E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbhAGXnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbhAGXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:43:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ACC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:41:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w17so8457671ilj.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jx60Ul5N89XCwAIuY/EiLUm7+VBi2oCBHzwgOsfm9mg=;
        b=XQMxppMiL/SdL78sTRHqbpD0gnkdQv0vm6hhAbpSSu0l6hYXptEYxC8xRNym4CyuD0
         sQ/qe0d4+82S211Ffl5arJPLAH7heOgyZp/fKRjFXgWUmUI0e2QnvlNI+6HIzNa0hlhj
         RzHO6ApHzKDSVAm8pmQqi1wiC53jkvs7IdHc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jx60Ul5N89XCwAIuY/EiLUm7+VBi2oCBHzwgOsfm9mg=;
        b=JXbLSnj2b9r/mf7sc3bEjn8ShYUKkAnUA5y9SwhVvEva9h9e//nzxv+wJwUwI8kt/N
         L4z9xpUqMoYVkKhsC9ji/ZWV+i8kwtl49Ch67UUuy+ArnMvtwXHTqtCPjPZZ2IvVNFr3
         ZPuWWGA7A3+UMIBydfZhKQv1k11ZNN4QUKti1Fx5WfFICkB3EPuYP+PUNCEqnPTkTFNe
         PveoxVxj99AIsUMzJobnOosUGtmgflugAA56BgjTfn5Xw4+CO1uaVgbmXJuQscggVB3m
         Z2NXLKERyWny4OnEDLxdAPQBO279nEP0BqBrzwEoUlgQcdtNMvhVZAfON3xPacM2O4Dc
         7fxg==
X-Gm-Message-State: AOAM532H2w7R2xfTKVsiGMzEkTj8TRaRILj45i/OZs83qCugTaXA0bpk
        GpGPqOYyHNu1dWTi9zCO9170DIVrQNbC+A==
X-Google-Smtp-Source: ABdhPJwBdLUyGNQO/w0HhC0L+3ONi6JDh1/zOrNENlRNVypIK1zSx/OiPZGDcDjnHk1v38qs0AdD6g==
X-Received: by 2002:a92:c942:: with SMTP id i2mr1250989ilq.227.1610062897482;
        Thu, 07 Jan 2021 15:41:37 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id y3sm5768370ilc.2.2021.01.07.15.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Jan 2021 15:41:36 -0800 (PST)
Received: from puyallup.local (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id C9C0A35E7AD;
        Thu,  7 Jan 2021 17:41:35 -0600 (CST)
From:   Steve Magnani <magnani@ieee.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <magnani@ieee.org>
Subject: [PATCH 1/1] udf: fix silent AED tagLocation corruption
Date:   Thu,  7 Jan 2021 17:41:16 -0600
Message-Id: <20210107234116.6190-2-magnani@ieee.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107234116.6190-1-magnani@ieee.org>
References: <20210107234116.6190-1-magnani@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven J. Magnani <magnani@ieee.org>

When extending a file, make sure that the pointer to the last written
extent does not get adjusted into the header (tag) portion of an
Allocation Extent Descriptor. Otherwise, a subsequent call to
udf_update_exents() can clobber the AED's tagLocation field, replacing
it with the logical block number of a file extent.

Signed-off-by: Steven J. Magnani <magnani@ieee.org>
---
--- a/fs/udf/inode.c	2020-12-28 20:51:29.000000000 -0600
+++ b/fs/udf/inode.c	2021-01-01 19:20:37.163767576 -0600
@@ -547,11 +547,14 @@ static int udf_do_extend_file(struct ino
 
 		udf_write_aext(inode, last_pos, &last_ext->extLocation,
 				last_ext->extLength, 1);
-		/*
-		 * We've rewritten the last extent but there may be empty
-		 * indirect extent after it - enter it.
-		 */
-		udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+
+		if (new_block_bytes || prealloc_len) {
+			/*
+			 * We've rewritten the last extent but there may be empty
+			 * indirect extent after it - enter it.
+			 */
+			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+		}
 	}
 
 	/* Managed to do everything necessary? */
