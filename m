Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB74D1EE93D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFDRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgFDRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:16:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E189E207DF;
        Thu,  4 Jun 2020 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591290993;
        bh=xlvCcankQA9MFCIiXiqb4rudhOnmx6uF/9ckqom/KqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NGYApT4Yvh6GHePH+aTn9EtTJhBPHGbYQe3pHgPVQ0TQ27Dkj3aTPwpzHXBdsvndy
         ys9mND1jQECUMjj8/bX971PEruZf32VoX1rLl38h0Iyg8FQ6r2fZxaaDCZAEtbOcmk
         igAFo5xfRi8ydpLZ9Wxr4O2s1EafEEn3Zk53mPlk=
Date:   Thu, 4 Jun 2020 12:21:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] docs: deprecated.rst: Add note to the use of struct_size()
 helper
Message-ID: <20200604172138.GA21820@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note to educate people about the proper use of struct_size() when
the trailing array in the enclosing structure is a one-element array.

Zero-length and one-element arrays will soon be removed from the kernel,
but in the meantime, it's worth letting people know how to correctly
use struct_size() together with such constructs.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

Kees,
 
This is not substitute for the patch I'll write about flexible-arrays
and the deprecation of zero-lenght and one-element arrays.

Thanks
--
Gustavo

 Documentation/process/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66c..0b7b37718bf96 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -85,6 +85,17 @@ Instead, use the helper::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+NOTE: You might want to use the following form in case the trailing array
+is a one-element array, as unlike zero-length arrays and flexible-array
+members, `one-element arrays occupy at least as much space as a single
+object of the type <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+hence they contribute to the size of the enclosing structure::
+
+	header = kzalloc(struct_size(header, item, count - 1), GFP_KERNEL);
+
+It's also worth noting that one-element arrays --together with zero-length
+arrays-- will soon be completely removed from the codebase and deprecated.
+
 See array_size(), array3_size(), and struct_size(),
 for more details as well as the related check_add_overflow() and
 check_mul_overflow() family of functions.
-- 
2.27.0

