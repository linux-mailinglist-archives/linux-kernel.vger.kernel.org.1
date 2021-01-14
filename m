Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CA42F5C09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbhANIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233A523A00;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=pvwHKHlgSPLiwJsoayG5/IBLUzVlUkqCNpc+zn41Ggw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB/rsikgrvCXODr5ozzjExvUI7jvPJZuNh/ur3PgulKmXFfQcquj1BGtmhSe7qk5M
         YmeutA8y4yFLT2kBTE45Oxmv7KjCD24vnno7AZrCPI2jCi2ZTDCX9RcMhSz7Iu7TnF
         L7NMAX9c763pyZhA20ghPxa2WpMOPtzn37ovDFL9V8bjtwxKsSV9v26xrPAhMTosvd
         zcFCSQZLWk1ouANSDbxvGhMNlnV7GfWTh1HMH7WQ90rCNCh/DoM9lovnoXKYTmJfoB
         oOGt934dVrGjDvnW0ijtmBQOojwD0afc78s0zu+gm3eVJDOmXSKcmkfhZ4QMdozcO+
         pdRgig7VpxKvQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ6k-3r; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/16] w1: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:45 +0100
Message-Id: <2dc136ff6290d7c8919599d21bee244f31647c8c.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/w1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 949d3b10e531..9a2a0ef39018 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -280,7 +280,7 @@ int w1_register_family(struct w1_family *family);
 void w1_unregister_family(struct w1_family *family);
 
 /**
- * module_w1_driver() - Helper macro for registering a 1-Wire families
+ * module_w1_family() - Helper macro for registering a 1-Wire families
  * @__w1_family: w1_family struct
  *
  * Helper macro for 1-Wire families which do not do anything special in module
-- 
2.29.2

