Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8C303A74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbhAZKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbhAZBpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:45:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E14C061222
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:37:20 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f17so17710683ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bf166UoAnPc1eZpDjnQH9epQkjWpJiBGn+Kivjd66Vs=;
        b=oOsrHEhUPIoudIBY2uckM+qwmMEmLGAIdNI65PBfo3TgKAFFsma8vspe8npKdFs83Z
         lEBGO3PDFdZ4oeVOWDwecmXwR5wBP5Yon7/Ht7V1708J+phYi9CfF4YWf34hXZQOTt1l
         ZDozrBwCdXxLFRDJKRqCNS4+DbWg14anD0xGAdSJFi21Y6+VooaeYLj9999zlsC45leu
         hJsqZ0iXXsvO/8V4Tg0E2uW49VZRAZuhIbJvkeq+BSaeDm1IVFEdZ8RNuZY1XOgf4PJj
         cRZlSyaSLp/zrXe3nF6NdrJHgPS0rhs4mTV6JGyPd5918uh4D2rDlYtmmeeFwUk+bhRZ
         xxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bf166UoAnPc1eZpDjnQH9epQkjWpJiBGn+Kivjd66Vs=;
        b=N+M5j6KMKpV74uvYknENY5PwCw/cwQum2dnmgh7LoIjNbIgv6WggFJ+8KF+YCGxr9o
         R8pqxXL5kVSUk5fUHu6VyhvH/1hLEDAVeR3ojfvbpQtRfVqtqiAQeqKjOCRr9b/YQcv/
         FKgpb2t26wxAOGAMAcJ488+ETjLrcKkXxk7oF0SRbG+ie8jzQgoEtlHHU7Baoku6ArzC
         IK4wKIRfUTN4ktxTc3sFNd4gBmqSA55CaZ4UQcFZKXsakWQu3nQ42GC0mR1Qkwf89lgN
         Mo0mdPldoO67nzh1QLPSBGEFAiWh73nrPXAvZ/tud40EMcSeSMB9uvZyhOaWMVTcV22k
         DUWw==
X-Gm-Message-State: AOAM530k6oYiqAibydFdsO1XaHUrtN+69XzQ1BBfALt8PZ0e+5P9yaix
        h3CNe5oK5rWjyT68e20j10mFhK052Ih74lUR
X-Google-Smtp-Source: ABdhPJy1uXJuVTg+wSoApWiNFDLZVjwDWKEjVg4pKWrjxSQWCcoiIxrVufUDpbfLz96lgmuC51oCSQ==
X-Received: by 2002:a2e:a303:: with SMTP id l3mr1550173lje.395.1611625038687;
        Mon, 25 Jan 2021 17:37:18 -0800 (PST)
Received: from localhost ([2a02:a310:53e:fc00:4aa4:72ff:fea0:3782])
        by smtp.gmail.com with ESMTPSA id h9sm783318lfj.24.2021.01.25.17.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:37:18 -0800 (PST)
From:   Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] groups: Use flexible-array member in struct group_info
Date:   Tue, 26 Jan 2021 02:37:15 +0100
Message-Id: <155995eed35c3c1bdcc56e69d8997c8e4c46740a.1611620846.git.hubert.jasudowicz@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace zero-size array with flexible array member, as recommended by
the docs.

Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
---
Hi, get_maintainers doesn't return anything except for the mailing list.
Sending to Andrew Morton as last resort. Sorry for accidental spam.

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..4c6350503697 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -25,7 +25,7 @@ struct inode;
 struct group_info {
 	atomic_t	usage;
 	int		ngroups;
-	kgid_t		gid[0];
+	kgid_t		gid[];
 } __randomize_layout;
 
 /**

base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
-- 
2.30.0

