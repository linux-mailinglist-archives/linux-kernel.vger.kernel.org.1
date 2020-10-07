Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CD28632A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgJGQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgJGQFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:05:34 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45201216C4;
        Wed,  7 Oct 2020 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086733;
        bh=vXNBYzjXxgbdXR2tBuhidFU6GMj6pIUq/B/IITpLXDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcc2vXHJQISo+MwSjajQGEZC9HEuZFgDht6Yeoio+aDQTnlvGn4WsTjAa5wbfw7PC
         XHBPXDOTxGKwiAMAirMa8q5iOO18gG0fT1b34FQu5S7R3tWuwpVnMsyFAaZpR9thGS
         dWimx005lmeEE8n8GzjfAeeTvMs22MTTa64KLvFM=
Date:   Wed, 7 Oct 2020 11:11:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 14/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct ATOM_Vega10_GFXCLK_Dependency_Table
Message-ID: <00a464a7e2141dc3117720784d76048e7e3dbed6.1602020074.git.gustavoars@kernel.org>
References: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use a flexible-array member in struct ATOM_Vega10_GFXCLK_Dependency_Table
instead of a one-element array.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7d61dd.O8jxxI5C6P9FOb%2Fd%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
index c934e9612c1b..a6968009acc4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
@@ -163,7 +163,7 @@ typedef struct _ATOM_Vega10_MCLK_Dependency_Record {
 typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_GFXCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_GFXCLK_Dependency_Record entries[];             /* Dynamically allocate entries. */
 } ATOM_Vega10_GFXCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
-- 
2.27.0

