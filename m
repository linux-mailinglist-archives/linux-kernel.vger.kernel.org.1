Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03A224E77
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgGSAdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:33:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tNRy03vSUczaK5p83E5OCF01t66x70YRtNpRugt8BMw=; b=O93ahQ1hl7m8KYChlne2IxxXMp
        zoPd2KdFWf7q2eH5N4sKknPfYXWOTFutpt0FFuS0W/0n3aFMoQH/OyIIVLO9lB8CbhRZL46jMqCt3
        NXmXR6HdXnDHR2O/2h5ecc3wdrAqDhVSVJFgBaSBfmujzBtl5s+Dw9SzGXlMNK+DpaXxJg023P1E5
        c5o9PwaU+zAa5UHQw8rO+cEEJrDymau9RMqPFbJkUBp/0k6vAFqYCyehSMA0A5WAZC6uGpvEd5QP0
        jIdzH8kBnFO2QgzGr5AQa8uYG+vrTRd4KO7Ej1YWVxmjTJfPucbYcdoRAqCQisdTdBhSf1SNVv8dz
        Gr83NFOQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxGG-000382-EQ; Sun, 19 Jul 2020 00:33:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Subject: [PATCH] soc: tegra/bpmp-abi.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:32:56 -0700
Message-Id: <20200719003256.21353-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "or" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Timo Alho <talho@nvidia.com>
---
 include/soc/tegra/bpmp-abi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/soc/tegra/bpmp-abi.h
+++ linux-next-20200717/include/soc/tegra/bpmp-abi.h
@@ -931,7 +931,7 @@ enum mrq_reset_commands {
  * @brief Request with MRQ_RESET
  *
  * Used by the sender of an #MRQ_RESET message to request BPMP to
- * assert or or deassert a given reset line.
+ * assert or deassert a given reset line.
  */
 struct mrq_reset_request {
 	/** @brief Reset action to perform (@ref mrq_reset_commands) */
