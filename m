Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4536E28EF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbgJOJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgJOJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:12:11 -0400
Received: from mail.kernel.org (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F762222E;
        Thu, 15 Oct 2020 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602753130;
        bh=E9Z9IQGxtHu2T2YUutHpR1pzzUBmgZKAToo+5rgt1H8=;
        h=From:To:Cc:Subject:Date:From;
        b=15HslpWWhc4BgaVuGnwA1SPUqJJYjdAhUM5eb+vdxwwuzGc5T38KWImDoFl/gKjy4
         vIhc+NHJ0CtPhXKM+XUbq03BMxex1UeoC50c5vvhGDrM5rnce6eEJDBRcQ3kjtCa+6
         WAk3rU4if+iUl42uyItdiCBy4wwPqjHXmBd1DUtc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSzIt-000Oki-SS; Thu, 15 Oct 2020 11:12:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        Harald Seiler <hws@denx.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Walle <michael@walle.cc>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: remove a duplicated index entry
Date:   Thu, 15 Oct 2020 11:12:06 +0200
Message-Id: <623fb26a8409a7b002e45bdbb6f517ac08fd508a.1602753121.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipmb file was added twice at index.rst. That
sounds to be because the same patch was applied twice,
via different git trees:

	commit f6ae22d64433fd8e08654adad7966299da931bb9
	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
	Commit: Jonathan Corbet <corbet@lwn.net>

	    docs: ipmb: place it at driver-api and convert to ReST

	commit ac499fba98c3c65078fd84fa0a62cd6f6d5837ed
	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
	Commit: Corey Minyard <cminyard@mvista.com>

	    docs: ipmb: place it at driver-api and convert to ReST

With Sphinx 4.0.0 development tree, a new warning is produced
due to that:

	.../Documentation/driver-api/index.rst:14: WARNING: duplicated entry found in toctree: driver-api/ipmb

The fix is trivial: just drop the duplicated line.

Fixes: f6ae22d64433 ("docs: ipmb: place it at driver-api and convert to ReST")
Fixes: ac499fba98c3 ("docs: ipmb: place it at driver-api and convert to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 987d6e74ea6a..f357f3eb400c 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -77,7 +77,6 @@ available subsections can be seen below.
    console
    dcdbas
    eisa
-   ipmb
    isa
    isapnp
    io-mapping
-- 
2.26.2

