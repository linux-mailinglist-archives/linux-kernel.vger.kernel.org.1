Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246161C19BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgEAPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC9E2495D;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=LESantMRD/g+tNw9iqgwwJwDazwNEShsTCm1Vmpbw1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGtvnsTPMvymcRmYffBI4H9iKuw9Un9+D9EBzD0u7KVPEA81wNn6ltVs6CixDpPL4
         0SpBT6HZ9DHjd/5k7YjiXcpbkhe3c8BESuyvCM/YVMWE5/5rM9fJ07ltRtOz8puiPT
         ZgJvKhhK6LlleF/LtIF+05ORNuYO69M5O1jD9ZRg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4z-6C; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/14] docs: move digsig docs to the security book
Date:   Fri,  1 May 2020 17:37:53 +0200
Message-Id: <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/{digsig.txt => security/digsig.rst} | 0
 Documentation/security/index.rst                  | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/{digsig.txt => security/digsig.rst} (100%)

diff --git a/Documentation/digsig.txt b/Documentation/security/digsig.rst
similarity index 100%
rename from Documentation/digsig.txt
rename to Documentation/security/digsig.rst
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..8129405eb2cc 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -15,3 +15,4 @@ Security Documentation
    self-protection
    siphash
    tpm/index
+   digsig
-- 
2.25.4

