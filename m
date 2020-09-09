Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE70E263326
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgIIQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD04E2224D;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=tzgaAgJpIzDjlP2NVIAPK4NTSvcnNtwteXFciBdLZFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itZgl4mzvi0cdENyyyaQ9B7EgUa62710r/zUedY/MZozBQEQYyC6WXCra3W9yvUiC
         +6uBY6tpR0KVoBBn8hbSWvW0nf4nJictn3XlGnoKNImtsCI/dACTIFeKK2CILr13UF
         bM5oGWEHBploOz1txpKOus4Fqp0//mt+eXB8H62Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXs-Rq; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] kunit: test.h: fix a bad kernel-doc markup
Date:   Wed,  9 Sep 2020 16:11:00 +0200
Message-Id: <78b3aa8f1f56e961ee81616dd06f13f6c296d8a8.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by:

	./include/kunit/test.h:504: WARNING: Block quote ends without a blank line; unexpected unindent.

The right way to describe a function is:

	name - description

Instead, kunit_remove_resource was using:

	name: description

Causing it to be improperly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 41b3a266bf8c..5c5ed262a950 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -498,8 +498,8 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
 }
 
 /**
- * kunit_remove_resource: remove resource from resource list associated with
- *			  test.
+ * kunit_remove_resource() - remove resource from resource list associated with
+ *			     test.
  * @test: The test context object.
  * @res: The resource to be removed.
  *
-- 
2.26.2

