Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8029745F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbgJWQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608A5241A4;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=uokSk4pb8ToMUj5rUXCAVXVqGG2ogix2a2/PzZOFXVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2qOfeVwTtP16JZow33scpZCClWc89cCAUezcHPYIgRJ09HbNzTdz0eOBrQ5IJ0tC
         4W4f47wZwspglPx2u9PPGBbTQJ+pD34Hg8ftaq8X9Smr5FVwtb2152kvA0zJPPXeQo
         mFlDKAicPxr3IHE9onsNg3qwamQ2F1YXwgHkwDDY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Ax2-9l; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 37/56] pstore/zone: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:24 +0200
Message-Id: <576a3e3c27b84d0e36ced89840872ec3f251b2b2.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented struct is psz_head and not psz_buffer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 3ce89216670c..46a1610c06fa 100644
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
2.26.2

