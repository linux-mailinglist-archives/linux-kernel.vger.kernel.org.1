Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48A1C9A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgEGTBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:01:23 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE242083B;
        Thu,  7 May 2020 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878082;
        bh=zVXmqoLDVD2WgpBRe4UKXv7/cwYfVjp6DI3tW4V29fY=;
        h=Date:From:To:Cc:Subject:From;
        b=E9FZWmoH2xfmdJj3SKjckcSoz/Qsc3bWTppwIoGvtGgrmUWGrVSIQe9hLD8jqhVmo
         RWo5CbElxmoYiv3rHB8emNc4ryBKizulFOQ4cMpyxZOkBqXfIm31XERDEv/Wfu736G
         f+DaSb2Y1WhHW7KT6yR361U7k42yawGMW3QC1ScA=
Date:   Thu, 7 May 2020 14:05:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: Replace zero-length array with flexible-array
Message-ID: <20200507190549.GA15653@embeddedor>
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
 include/pcmcia/cistpl.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/pcmcia/cistpl.h b/include/pcmcia/cistpl.h
index 59a011101e0e..749320cc9aba 100644
--- a/include/pcmcia/cistpl.h
+++ b/include/pcmcia/cistpl.h
@@ -161,7 +161,7 @@ typedef struct cistpl_funcid_t {
 
 typedef struct cistpl_funce_t {
     u_char	type;
-    u_char	data[0];
+    u_char	data[];
 } cistpl_funce_t;
 
 /*======================================================================
@@ -255,7 +255,7 @@ typedef struct cistpl_data_serv_t {
     u_char	escape;
     u_char	encrypt;
     u_char	misc_features;
-    u_char	ccitt_code[0];
+    u_char	ccitt_code[];
 } cistpl_data_serv_t;
 
 typedef struct cistpl_fax_serv_t {
@@ -265,7 +265,7 @@ typedef struct cistpl_fax_serv_t {
     u_char	encrypt;
     u_char	features_0;
     u_char	features_1;
-    u_char	ccitt_code[0];
+    u_char	ccitt_code[];
 } cistpl_fax_serv_t;
 
 typedef struct cistpl_voice_serv_t {

