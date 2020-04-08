Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 620391A2678
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgDHPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73B52075E;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=qp3qEYEeHjKKxIsRa+ChwJ5Ycbkeaz0aFxGnu0R/3g0=;
        h=From:To:Cc:Subject:Date:From;
        b=r9d7FEi/HI76EEOUJNA+TD9ORGT9eWPIkLUEanPgtfogQhipauzvcUXWUr88FdY9X
         bsWa6FAeXE+nsKzrXShusODWGE4DQ0lvElthVIOsfF9cZlbxQwbG0FqCiq6FJl3JNr
         eIas/O4S1y2H1oUqCxjJZiqT8q05FaG0EzV9KSHk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD30-000cGh-TQ; Wed, 08 Apr 2020 17:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 0/6] sphinx-pre-install improvements for Kernel 5.8
Date:   Wed,  8 Apr 2020 17:55:19 +0200
Message-Id: <cover.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on the discussions we had with regards to use

	python -m venv

to create python3 virtual machines.

After this series, the script will be smarter when detecting python3 and
python2.

As I had to re-test it with different distributions, it also do several
improvements and fixes at the detection logic and at the support for
some distributions that I don't use (except when testing this script)
and/or for some corner cases.

Mauro Carvalho Chehab (6):
  scripts: sphinx-pre-install: improve distro detection check
  scripts: sphinx-pre-install: improve openSuse Tumbleweed check
  scripts: sphinx-pre-install: fix a dependency hint with Ubuntu 16.04
  scripts: sphinx-pre-install: address some issues with Gentoo
  scripts: sphinx-pre-install: add support for OpenMandriva
  scripts: sphinx-pre-install: add support for python -m venv

 scripts/sphinx-pre-install | 168 +++++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 46 deletions(-)

-- 
2.25.2


