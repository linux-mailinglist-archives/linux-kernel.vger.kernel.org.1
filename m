Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399472F5BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhANIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbhANIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D941B233FD;
        Thu, 14 Jan 2021 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=5EaFSJVMoXSfpvTjjhVPWpLF3hDhFzeeTdW6YGmNd+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUMZBGRxDYUMHzXaZbEKm7PfRkXLg44YIWDWNQrvK6ESnkssZpO9IYTJQtFk4NopJ
         i8I9heBfhxu1X1+f5zS22sZvRrR/J4uIsLoY+7vfXuuc7QMdtlZmKtN43RbRvXmDci
         Bl2hkD1LEGKxeuEicc60b+QRO2zi/gWGhtQhZ6ceAvMpywdYUqwfIrM84oF+tSid0x
         nhROEnl+Kgp3Q6cEBH2R8egRrV/uAT6w6o7jAlddJ6pawK4YoKpZNeEm4Rn06AjM9O
         nK97h+rbbqEpcca45ah8JcgS3mlL+RSDAOHnOiYjUt7Q8FWlkrKdD9FECgZzxVsld7
         HfRBoPwXcf6kA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6V-RN; Thu, 14 Jan 2021 09:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/16] pstore/zone: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:40 +0100
Message-Id: <a67ca4d12c3ef277dadb9e0d0df8450158e637cc.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented struct is psz_head and not psz_buffer.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 5266ccbec007..7c8f8feac6c3 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -23,7 +23,7 @@
 #include "internal.h"
 
 /**
- * struct psz_head - header of zone to flush to storage
+ * struct psz_buffer - header of zone to flush to storage
  *
  * @sig: signature to indicate header (PSZ_SIG xor PSZONE-type value)
  * @datalen: length of data in @data
-- 
2.29.2

