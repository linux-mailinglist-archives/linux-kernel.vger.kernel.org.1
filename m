Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C9263324
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgIIQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333D821D94;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=Ge8bCOe4Iv5pqs/jRkc5OuqiE2EUk7j6IN03gI+k+5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjKr3dzevEXSoEQ6iqBs8oXyIpjrPoBdHvumNpAirqy5QT3yE7gptQZt1mGAScq7A
         qSoDWyPBGcjpymDq6uXVmfyeP5r9t9wHOSPyvZM6U5i0eCPydyHlCdfSDQX1TgOzMk
         rKbqBFBRhWJ80cfIZ3mWOQ93YPXY6m5znNvUcfpA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWY-0d; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/30] .gitignore: docs: ignore sphinx_*/ directories
Date:   Wed,  9 Sep 2020 16:10:32 +0200
Message-Id: <ac4e23d556c7d95cb11d6d5c605f43e425b2c3c7.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default way of building documentation is to use
Sphinx toolchain installed via pip, inside the
Kernel tree main directory. That's what's recommended by:

	scripts/sphinx-pre-install

As it usually provides a better version of this package
than the one installed, specially on LTS distros.

So, add the directories created by running the commands
suggested by the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 162bd2b67bdf..d01cda8e1177 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,3 +152,6 @@ x509.genkey
 
 # Clang's compilation database file
 /compile_commands.json
+
+# Documentation toolchain
+sphinx_*/
-- 
2.26.2

