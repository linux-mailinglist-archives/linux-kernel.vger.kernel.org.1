Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD90264400
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgIJK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 06:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgIJKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:11 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7668220BED;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=ouT/IR50K1v6t5GtAH8QVbTfLficJqrmgVtdLLJX39w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcGShKJx8pxf00qeLhKF2wCw+wLrfJYOFAHbOaZPiRoLpvB3cAVURWYW4v9x/4bSV
         SEyYlbOdgewr6BG1DVIKsO0MDnlYWsnK2phHyUVM1mFsZL/xCut6pRbgtw6i9rfZ0M
         frlB84+FrlPyYVB0IW6WIiC6urWT7wHEtAAQPHNo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINz-Iw; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] Input: sparse-keymap: add a description for @sw
Date:   Thu, 10 Sep 2020 12:24:02 +0200
Message-Id: <252df3dd23da1d11e312a97a50d7582f7b3b3c5c.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description for it, in order to avoids this warning:

	./include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/input/sparse-keymap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/input/sparse-keymap.h b/include/linux/input/sparse-keymap.h
index d25d1452dc6e..d0dddc14ebc8 100644
--- a/include/linux/input/sparse-keymap.h
+++ b/include/linux/input/sparse-keymap.h
@@ -20,6 +20,7 @@
  *	private definitions.
  * @code: Device-specific data identifying the button/switch
  * @keycode: KEY_* code assigned to a key/button
+ * @sw: struct with code/value used by KE_SW and KE_VSW
  * @sw.code: SW_* code assigned to a switch
  * @sw.value: Value that should be sent in an input even when KE_SW
  *	switch is toggled. KE_VSW switches ignore this field and
-- 
2.26.2

