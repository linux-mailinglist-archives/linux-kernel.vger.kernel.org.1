Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE771A8666
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407478AbgDNQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391940AbgDNQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:56:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A302075E;
        Tue, 14 Apr 2020 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883376;
        bh=6WDdQBN3UPxBWUZoZR6M7r2R0XIrA/7H7diQUsc+NuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L38ChqGg6C8Z15Ww7cdr24cTYo367cpRCjoqLS9o/400vrBC9QkEEzInrrYHzUUhT
         yIIjwx7Cc2cuZPi09gKRnJ6bI1K+EUG6IPEf7wTBmIvFS5DjMtD+WfuB06c4Pj2nMM
         /cWzbNyxVVpVNVJ8zrjxxbCNji+MW4v7ufXkRvwk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOr9-0068yY-0e; Tue, 14 Apr 2020 18:56:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH v2 2/6] scripts: sphinx-pre-install: improve openSuse Tumbleweed check
Date:   Tue, 14 Apr 2020 18:56:09 +0200
Message-Id: <c3774f72ac36c5e5b5f446ae5db5b795d1f274f4.1586883286.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586883286.git.mchehab+huawei@kernel.org>
References: <cover.1586883286.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, with openSUSE Tumbleweed 20200303, it keeps
recommending this forever:

	sudo zypper install --no-recommends rsvg-view

This dependency will never be fulfilled there, as the package
now is named as on other distros: rsvg-convert.

So, improve the detection to avoid such issue.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index ea941c6e0647..6d6d2849fbb1 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -446,9 +446,11 @@ sub give_opensuse_hints()
 		"convert"		=> "ImageMagick",
 		"Pod::Usage"		=> "perl-Pod-Usage",
 		"xelatex"		=> "texlive-xetex-bin",
-		"rsvg-convert"		=> "rsvg-view",
 	);
 
+	# On Tumbleweed, this package is also named rsvg-convert
+	$map{"rsvg-convert"} = "rsvg-view" if (!($system_release =~ /Tumbleweed/));
+
 	my @suse_tex_pkgs = (
 		"texlive-babel-english",
 		"texlive-caption",
-- 
2.25.2

