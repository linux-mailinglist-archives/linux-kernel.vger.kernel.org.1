Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55E41A2605
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgDHPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9B822206;
        Wed,  8 Apr 2020 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=a3JpEtgqMbhSCDXAHAnASAtVj+ma3vbopyY6WyqAmxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5JOF+z+I7+cY7nGfSrBvIrUf+7/BBGl7IM61FprqM6C30cGMKO/Db8Om9e/96TSX
         xq7h22xkayEKBe0Q8Ag7MJIGHuBH8HjvcHrFErQ/GCgg/6jNdOmissA/OeWGpdUmSr
         td/5w4OHBGG9MDnp7ozlMTdfgMX7PnKttFmGd6VE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cD4-By; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 35/35] docs: update recommended Sphinx version to 2.4.4
Date:   Wed,  8 Apr 2020 17:46:27 +0200
Message-Id: <2de15bd64b2c0bf7320c96ec2f8c7fba923e0962.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some docs that have nested tables. While this was
always part of the spec, only Sphinx version 2.4.x can
translate it to LaTeX.

In other words, if someone is using a Sphinx version < 2.4,
the LaTeX and PDF output won't work for some of the docs.

So, it seems that it is time to raise the bar again
for the recommented version.

The Sphinx check script is already smart enough to keep
working, with older versions, warning the users that
an upgrade is recommended (and explaining how):

	Sphinx version 1.7.9
	Warning: It is recommended at least Sphinx version 2.4.4.
	Detected OS: Fedora release 31 (Thirty One).

	To upgrade Sphinx, use:

		/usr/bin/virtualenv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 14e29a0ae480..489f6626de67 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
 docutils
-Sphinx==1.7.9
+Sphinx==2.4.4
 sphinx_rtd_theme
-- 
2.25.2

