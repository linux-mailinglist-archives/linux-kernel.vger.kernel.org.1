Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6591D2316
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgEMXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732686AbgEMXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D7C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so1505517ilf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=AOn02sBOw6rI0NNLd1GC3BYjmQUvTLcSjrXTztEWRq4Mny7gHvSQOuXcwhB1DG1zIK
         LmPDcv1PHxtRSmYDIijCw9gFwewYx+4zHXeb/92tPn+NLTkDe2hv3JoOuj5gSt0U/HAW
         nx7JRGerb5+ePP9ev2iBS9ORAjzvvAougqm0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=hdTMKLgXgMw6VAUSCcXwgbcvvgNCAWk5OLO2LrzSMTt67dm7eTUE6W83027yiWAgxk
         FASc2UvM+SsBIIdL4iqpQb7j6vf7Dfl0lbkZbPLrdj1Jw4yqZ9O7cVM9Y03+RqhQ3S4w
         KN+fjjUZWU0PkbmqMroLiGzeK60UWu34hbcZivHqggiXYmsWepFeii4NtW63FA73lXYr
         18LqROWWzb2YL8BPexV+98bAx8Rhc5nD74QgDsBvccqut3AX0JX1zMDLKm7XBca/0GhW
         64ZbBfxQWncrx/40sFcG9OzP8LcFlJBLFSlk4jzXtwd2S7ApkYdgtnqAAEoJawRHG8nv
         h91w==
X-Gm-Message-State: AOAM531BvN+fx84poiKIZF8Y1uLXEEYVdKZl72rdffqha4zC5xTXbUIn
        wqyeRGWrGhMt8LrTXTQHyrHxgA==
X-Google-Smtp-Source: ABdhPJynTVyMUoEORJzVp73FPhPB3uH0FFgzNgJAcDr5KLrfmAGEm4I66Y+wJYXBhHODi+pkS0ENQw==
X-Received: by 2002:a92:d186:: with SMTP id z6mr1906821ilz.119.1589412805697;
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Wed, 13 May 2020 17:33:21 -0600
Message-Id: <62659de2dbf32e8c05cff7fe09f6efd24cfaf445.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589411496.git.skhan@linuxfoundation.org>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introduced in a commit that added kernel_read_file_from_fd() as
a wrapper for the VFS common kernel_read_file().

Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..16a3d3192d6a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,14 +1015,14 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
-	int ret = -EBADF;
+	int ret;
 
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

