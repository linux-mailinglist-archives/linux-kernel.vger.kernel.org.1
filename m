Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32F1C99A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgEGSrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:47:39 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC12221F7;
        Thu,  7 May 2020 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877259;
        bh=Q87e/4coWysbUm2Zo1Y28X2901o7xCuO/CduL7ySatE=;
        h=Date:From:To:Cc:Subject:From;
        b=TKflrXuGzDcOT9OuYsvV4mzUc3IDYcsfR6UjVJ0RBjwsTw0euPU8Yos0Cn8m4Pyzt
         qomcqLn7oqZvZldpyglWjVsuXZGoHG14rME6VkhBnT4ZnBZcr36toO9/xby0Pl0g6U
         iRBjJ3tozPrS1zkA2jshtMs6CkZIEN4w02Lcilr8=
Date:   Thu, 7 May 2020 13:52:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: Replace zero-length array with flexible-array
Message-ID: <20200507185205.GA14139@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/dlm/dlm_internal.h |    6 +++---
 fs/dlm/user.c         |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 416d9de35679..d231ae5d2c65 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -421,7 +421,7 @@ struct dlm_message {
 	int			m_bastmode;
 	int			m_asts;
 	int			m_result;	/* 0 or -EXXX */
-	char			m_extra[0];	/* name or lvb */
+	char			m_extra[];	/* name or lvb */
 };
 
 
@@ -450,7 +450,7 @@ struct dlm_rcom {
 	uint64_t		rc_id;		/* match reply with request */
 	uint64_t		rc_seq;		/* sender's ls_recover_seq */
 	uint64_t		rc_seq_reply;	/* remote ls_recover_seq */
-	char			rc_buf[0];
+	char			rc_buf[];
 };
 
 union dlm_packet {
@@ -506,7 +506,7 @@ struct rcom_lock {
 	__le16			rl_wait_type;
 	__le16			rl_namelen;
 	char			rl_name[DLM_RESNAME_MAXLEN];
-	char			rl_lvb[0];
+	char			rl_lvb[];
 };
 
 /*
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 5264bac75115..e5cefa90b1ce 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -46,7 +46,7 @@ struct dlm_lock_params32 {
 	__u32 bastaddr;
 	__u32 lksb;
 	char lvb[DLM_USER_LVB_LEN];
-	char name[0];
+	char name[];
 };
 
 struct dlm_write_request32 {

