Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4A1A85D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440523AbgDNQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440290AbgDNQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589DB2076C;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=usYkvESU4Pm1qI9SJ4cKzhimcRKZU8+i2x+WdqicQE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HC5tW5ZnuC53qzhLAIRkW5n/qjUuLJf5f4s0M4K20l3ZdV4d4Q2/Ub1Zq7LgkE3PV
         pKBeexGt1tac/bdfh5FhkPliC4WIdL862E7tPRk7gIsTnw1kyH0RvBRQ3xMfTSsebR
         /3mfkPMOG3iHqwNdWGxx1ZN2r96g0kem1ywmnV2A=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lH-K8; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/33] docs: LaTeX/PDF: drop list of documents
Date:   Tue, 14 Apr 2020 18:48:31 +0200
Message-Id: <9345dba7164497dbf28578f6ec271e479379610c.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The building system can auto-generate a list of documents since
commit: 9d42afbe6bd4 ("docs: pdf: add all Documentation/*/index.rst to PDF output").

The added logic there allows keeping the existing list, but
there's not real reason to keep it. Now, the media document
has gone (it was split into tree).

So, it sounds about time to get rid of the manual entries,
and let the script to generate it automatically instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 9ae8e9abf846..f6a1bc07c410 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -388,44 +388,6 @@ if major == 1 and minor < 6:
 #  author, documentclass [howto, manual, or own class]).
 # Sorted in alphabetical order
 latex_documents = [
-    ('admin-guide/index', 'linux-user.tex', 'Linux Kernel User Documentation',
-     'The kernel development community', 'manual'),
-    ('core-api/index', 'core-api.tex', 'The kernel core API manual',
-     'The kernel development community', 'manual'),
-    ('crypto/index', 'crypto-api.tex', 'Linux Kernel Crypto API manual',
-     'The kernel development community', 'manual'),
-    ('dev-tools/index', 'dev-tools.tex', 'Development tools for the Kernel',
-     'The kernel development community', 'manual'),
-    ('doc-guide/index', 'kernel-doc-guide.tex', 'Linux Kernel Documentation Guide',
-     'The kernel development community', 'manual'),
-    ('driver-api/index', 'driver-api.tex', 'The kernel driver API manual',
-     'The kernel development community', 'manual'),
-    ('filesystems/index', 'filesystems.tex', 'Linux Filesystems API',
-     'The kernel development community', 'manual'),
-    ('admin-guide/ext4', 'ext4-admin-guide.tex', 'ext4 Administration Guide',
-     'ext4 Community', 'manual'),
-    ('filesystems/ext4/index', 'ext4-data-structures.tex',
-     'ext4 Data Structures and Algorithms', 'ext4 Community', 'manual'),
-    ('gpu/index', 'gpu.tex', 'Linux GPU Driver Developer\'s Guide',
-     'The kernel development community', 'manual'),
-    ('input/index', 'linux-input.tex', 'The Linux input driver subsystem',
-     'The kernel development community', 'manual'),
-    ('kernel-hacking/index', 'kernel-hacking.tex', 'Unreliable Guide To Hacking The Linux Kernel',
-     'The kernel development community', 'manual'),
-    ('media/index', 'media.tex', 'Linux Media Subsystem Documentation',
-     'The kernel development community', 'manual'),
-    ('networking/index', 'networking.tex', 'Linux Networking Documentation',
-     'The kernel development community', 'manual'),
-    ('process/index', 'development-process.tex', 'Linux Kernel Development Documentation',
-     'The kernel development community', 'manual'),
-    ('security/index', 'security.tex', 'The kernel security subsystem manual',
-     'The kernel development community', 'manual'),
-    ('sh/index', 'sh.tex', 'SuperH architecture implementation manual',
-     'The kernel development community', 'manual'),
-    ('sound/index', 'sound.tex', 'Linux Sound Subsystem Documentation',
-     'The kernel development community', 'manual'),
-    ('userspace-api/index', 'userspace-api.tex', 'The Linux kernel user-space API guide',
-     'The kernel development community', 'manual'),
 ]
 
 # Add all other index files from Documentation/ subdirectories
-- 
2.25.2

