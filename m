Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0041B29C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgDUObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgDUObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:13 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D663206B8;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=Rd3Iyp9LKd1tzHym9d6ioyRLUmSFC0ezdencW7XNiMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MAu7mQNrg7KnV+/cG6hkn0dY75kmovV7oLXSfDxe1oTDgUUNV98pyQrlaP3dRdwwP
         A+vR6+llcro9R0QpVAiLIcWprekcEYly0XwK/wLUn5f5BB32H1b28nOL5UIDG1uVpO
         5yDZt5XDubNERq1qsVZkuZ+/UBERrtivD3Fywk6Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqF-F4; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/5] More changes for sphinx-pre-install script
Date:   Tue, 21 Apr 2020 16:31:04 +0200
Message-Id: <cover.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

As asked, I changed the sphinx-pre-install script to print a different message
for the PDF minimal recommended version. This change itself was easy,
but, while testing the patch, I noticed some new weird behaviors when python
venv is used.

Basically, when using python venv, the venv environment will contain python
itself. So, an attempt to create a new virtual environment to upgrade a version
fails (at least here with Fedora 31). As I didn't notice this behavior before,
maybe the problem was due to some Fedora upgrade.

In any case, the approach I took should be generic enough to work past eventual
distro packaging differences.

-

At the end,  instead of a single patch, I ended needing to fix some other stuff, 
for this to work better. Oh well...

The good news is that, at the cost of a slicely more complex logic, the script
should now detect if a virtual environment works and to recommend activating
a newer environment if it exists (instead of recommending to reinstall a
venv using the name of an already-existing directory).

Mauro Carvalho Chehab (5):
  scripts: sphinx-pre-install: only ask to activate valid venvs
  scripts: sphinx-pre-install: change the warning for version < 2.4.4
  scripts: sphinx-pre-install: change recommendation text if venv exists
  scripts: sphinx-pre-install: fix a bug when using with venv
  scripts: sphinx-pre-install: change the output order

 scripts/sphinx-pre-install | 118 ++++++++++++++++++++++++++++---------
 1 file changed, 91 insertions(+), 27 deletions(-)

-- 
2.25.2


