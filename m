Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F79263347
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgIIRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E462221E7;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=F38L5HcK+PWN6kp1gWIMXrEICgbpC/K+TO5DkjZ2XS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXd8/JoALhftUwkdlwfmxkKu3JLctEjQW0ZzzRxsLP81AyPLxBnJ8wLSUxWSAWU4i
         13iGhEnmXGpWUFsO31B4BQYVCwi1K/f3dJvU+WVU917lMupXSzarqB58sZ5ag6QAwJ
         DohP9Sckw/nz2lbWzIiHAt9HoNrBczm4aXLM4L/c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUX5-D7; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] docs: SafeSetID: fix a warning
Date:   Wed,  9 Sep 2020 16:10:44 +0200
Message-Id: <4cbe4cba5158c8b015bf10add87fe5c390e8338e.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx 2.4.4:

	docs/Documentation/admin-guide/LSM/SafeSetID.rst:110: WARNING: Title underline too short.

	Note on GID policies and setgroups()
	==================

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/LSM/SafeSetID.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
index 17996c9070e2..0ec34863c674 100644
--- a/Documentation/admin-guide/LSM/SafeSetID.rst
+++ b/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -107,7 +107,7 @@ for a UID/GID will prevent that UID/GID from obtaining auxiliary setid
 privileges, such as allowing a user to set up user namespace UID/GID mappings.
 
 Note on GID policies and setgroups()
-==================
+====================================
 In v5.9 we are adding support for limiting CAP_SETGID privileges as was done
 previously for CAP_SETUID. However, for compatibility with common sandboxing
 related code conventions in userspace, we currently allow arbitrary
-- 
2.26.2

