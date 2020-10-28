Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C329DCED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgJ1WU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgJ1WRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D875247A0;
        Wed, 28 Oct 2020 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895015;
        bh=9CndlUwYK0Pkv0BAJhbUAbfsUVYqfxdjd9QC1RfMLEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGddvqoioYDmq06GNWPFY7BXiyO7rqK+RY+LxH9ijTdCYWwW98o02LfJR3SQcw5mh
         kwlQ8KqMvscSj+CWGoYunTLuy7pPUCD05jWSf3Yi3sdjiLUKAftqSUllrXm/uLTKSk
         GzQtOw5hZf2n1FTly0c0b29SYHkvPMXyGPZcOtS4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMP-003hll-8o; Wed, 28 Oct 2020 15:23:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/33] docs: ABI: create a 2-depth index for ABI
Date:   Wed, 28 Oct 2020 15:23:20 +0100
Message-Id: <d29ff27cb527af03ee6ac35f40e354ebe1c2cafe.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

That helps to identify what ABI files are adding titles.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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

