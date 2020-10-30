Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6529FEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgJ3HnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FA8222D9;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=OPzgoINKCBaXsTP98YZcAIZ8eKjCtFBWsrDv+IXkK3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuA5RPRmtYfNvgYFOg0Ahfz+Nqj1H0VvLfA0XeSZ6B3y9avI9NsCyPHupCF0wTZKd
         FXyengVac+1XLnGqrwGeAwb3h7Vw5iKBxAg7QrNqi8MwXEmOTDcQEazMfXihTKtld8
         zsXKDqErhVt3JiWIVIewTq8U9wUVpPtcgv0m40EQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004OgJ-89; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/39] docs: ABI: create a 2-depth index for ABI
Date:   Fri, 30 Oct 2020 08:40:42 +0100
Message-Id: <e267b36ae7f32bab2a86f1da6b40bb3e62c877d4.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That helps to identify what ABI files are adding titles.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/abi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/abi.rst
index 3b9645c77469..bcab3ef2597c 100644
--- a/Documentation/admin-guide/abi.rst
+++ b/Documentation/admin-guide/abi.rst
@@ -3,7 +3,7 @@ Linux ABI description
 =====================
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
    abi-stable
    abi-testing
-- 
2.26.2

