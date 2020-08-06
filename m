Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADD23E0C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgHFSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgHFSfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E5F623102;
        Thu,  6 Aug 2020 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738321;
        bh=VAU1eGfzCZfS7G3FX+Wn/xXTQQH5HorEtjLf+F1OX28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXqHoFUBTp6Wfsbm9vRJqQUKwEuV8d/XmfWKVnu+R/hlUZPEP0voCFwpiql36+fxN
         aVXfleK8EVRRbX0y8jxECPsZOaSciaIITxd4jglIIpSQ8R+zRbAXAlo6GjrQ1waz/y
         fqaLnN6L+cykz+Rh4mjkkNs96GoIwR4C2gn4J77I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 41/41] MAINTAINERS: Add more name matches for Samsung SoC entries
Date:   Thu,  6 Aug 2020 20:20:58 +0200
Message-Id: <20200806182059.2431-41-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC maintainer entry covers drivers and headers matching
"exynos" name but except that there are also files for S3C24xx, S3C64xx
and S5Pv210 SoCs.  These sometimes do not have a separate entry for a
driver maintainer thus might miss review.  Add them to the Samsung SoC
maintainer entry to cover all SoCs with name matches.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c74aa41e35b..7dcd9305a622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2422,6 +2422,9 @@ F:	drivers/soc/samsung/
 F:	drivers/tty/serial/samsung*
 F:	include/linux/soc/samsung/
 N:	exynos
+N:	s3c2410
+N:	s3c64xx
+N:	s5pv210
 
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-- 
2.17.1

