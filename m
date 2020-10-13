Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC1E28CD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgJML55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbgJMLyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:47 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E89F224B2;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=2r6oOY4xsG1EB6Z1iMtvKymMAv8zcB6pr2HFpKVhvXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibopTsWKw9hs5svADXE3qtIKg5fujz6f7Pz/dGNc+Ui5TttEQfPEfB3W0n52wrM13
         cYZfJBS8WvBDYRhsRI6PRXKarwRVC1st0V5Tvs4A++zRw5Id6OwddPCHtD1qKIgBY7
         6Av4A98tkr8Jp2+BxNL3Y6TQTdHOn+kbiblrzcsY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CVb-5u; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bailu Lin <bailu.lin@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 52/80] docs: zh_CN: amu.rst: fix document title markup
Date:   Tue, 13 Oct 2020 13:54:07 +0200
Message-Id: <941f4eeef21060519a88f55e45cbca2432ecb2af.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by Sphinx 2.4.4:
	.../Documentation/translations/zh_CN/arm64/amu.rst:7: WARNING: Title overline too short.

Increase its size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/zh_CN/arm64/amu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/arm64/amu.rst b/Documentation/translations/zh_CN/arm64/amu.rst
index bd875f221330..ab7180f91394 100644
--- a/Documentation/translations/zh_CN/arm64/amu.rst
+++ b/Documentation/translations/zh_CN/arm64/amu.rst
@@ -4,9 +4,9 @@
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
-=================================
+==================================
 AArch64 Linux 中扩展的活动监控单元
-=================================
+==================================
 
 作者: Ionela Voinescu <ionela.voinescu@arm.com>
 
-- 
2.26.2

