Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58080284C73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJFNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJFNVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:21:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A634F208C7;
        Tue,  6 Oct 2020 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601990514;
        bh=2r6oOY4xsG1EB6Z1iMtvKymMAv8zcB6pr2HFpKVhvXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnceM+Pi7yJwn8uNxrah+qJ4fj4k8S+EEGvhqVGYbi5l/bgNOtr4bicFo96ILeSMb
         gKfEkVvHAjf+d4s0dPfXWOMwhtouBvFup4aV4PNGBzEcpCdX/rJVCN2o9PmTRf4l0b
         JN6FOBPbRp6zThS1wSwnA6yLxQW/CVnlrUKVCo8s=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPmuM-0018Kl-6l; Tue, 06 Oct 2020 15:21:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bailu Lin <bailu.lin@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] docs: zh_CN: amu.rst: fix document title markup
Date:   Tue,  6 Oct 2020 15:21:31 +0200
Message-Id: <403816bb44e06049299e5df9f15a3a691fe7f8e6.1601990386.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601990386.git.mchehab+huawei@kernel.org>
References: <cover.1601990386.git.mchehab+huawei@kernel.org>
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

