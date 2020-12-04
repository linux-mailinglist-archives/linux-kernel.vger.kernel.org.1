Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7FC2CF29C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbgLDRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:05:29 -0500
Received: from latitanza.investici.org ([82.94.249.234]:50015 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbgLDRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:27 -0500
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFp12q0z8sj6;
        Fri,  4 Dec 2020 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101486;
        bh=kBsPfKWRLpgSZzjG1MK0NH4o4e7Olg52IFsReshXxYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS/zBBShYYP3GQ4GpYiXfYv34Bn9Tf8ju6EsU7Zkngw+2p+wjgNXni75sWrcLgT6F
         tmZUa3+CL1N7ih0F6lfaK3fq/1bFjMJ9yrJdqkkBwhRKUckjkuKp1Uw2VD//FzOvQC
         odMXgzm/AeIEQGDNkVqO6cesxl0Kucsv8XluDAmQ=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFn6Mx6z8sj2;
        Fri,  4 Dec 2020 17:04:45 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 12/12] string.h: Remove strstarts().
Date:   Fri,  4 Dec 2020 18:03:18 +0100
Message-Id: <20201204170319.20383-13-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

When str_has_prefix() was introduced in commit 495d714ad140 ("Merge tag
'trace-v4.21' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace"), this commit
stated that the new function should replace the existing one.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/linux/string.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..78bcae9bfa58 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -212,16 +212,6 @@ extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
 
 int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
 
-/**
- * strstarts - does @str start with @prefix?
- * @str: string to examine
- * @prefix: prefix to look for.
- */
-static inline bool strstarts(const char *str, const char *prefix)
-{
-	return strncmp(str, prefix, strlen(prefix)) == 0;
-}
-
 size_t memweight(const void *ptr, size_t bytes);
 
 /**
-- 
2.20.1

