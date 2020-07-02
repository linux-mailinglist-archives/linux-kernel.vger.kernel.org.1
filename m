Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533F72121E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGBLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:12:11 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39231 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727900AbgGBLML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:12:11 -0400
Received: from localhost.localdomain (ip5f5bf058.dynamic.kabel-deutschland.de [95.91.240.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B2858206462AB;
        Thu,  2 Jul 2020 13:12:08 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] .gitignore: Do not track `defconfig` from `make savedefconfig`
Date:   Thu,  2 Jul 2020 13:12:00 +0200
Message-Id: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running `make savedefconfig` creates by default `defconfig`, which is,
currently, on git’s radar, for example, `git status` lists this file as
untracked.

So, add the file to `.gitignore`, so it’s ignored by git.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 87b9dd8a163b..f07500889fba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,9 @@ x509.genkey
 /allrandom.config
 /allyes.config
 
+# Kconfig presets, default savedefconfg output
+/defconfig
+
 # Kdevelop4
 *.kdev4
 
-- 
2.27.0

