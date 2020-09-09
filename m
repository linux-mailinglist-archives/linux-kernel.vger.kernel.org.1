Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E7263336
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgIIQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730640AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A1522211;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=H8u21lHYR0QTzmGXeeCy6jkZ+7enZwKCuGPulIWQAOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdCZoQ/PmDz30lrsWHlrr/ifUApUJOutPWMpwMmgnMdUaxTNCWA/ycqQJ57twnRLN
         eiRz0md1CU4JTlxmYF8ckrHM5tvTHOKA+dWaY1PAKE4I7LBgjglRASCFpCnINvZmBU
         Bn+EmCQKWjMkT/DVXBb6NL8EkGmMLKb5UEpJT/N8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXN-Ib; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/30] docs: soundwire: fix some identation at stream.rst
Date:   Wed,  9 Sep 2020 16:10:50 +0200
Message-Id: <eddde9f8d121e27d7968b3d747064e16de8bec4f.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sphinx emits one warning on this file:

	Documentation/driver-api/soundwire/stream.rst:522: WARNING: Block quote ends without a blank line; unexpected unindent.

That's due to some extra spaces before the title of a chapter.

Yet, the list afterwards is missing identation.

So, address both issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/soundwire/stream.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 8858cea7bfe0..b432a2de45d3 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -518,10 +518,10 @@ typically called during a dailink .shutdown() callback, which clears
 the stream pointer for all DAIS connected to a stream and releases the
 memory allocated for the stream.
 
-  Not Supported
+Not Supported
 =============
 
 1. A single port with multiple channels supported cannot be used between two
-streams or across stream. For example a port with 4 channels cannot be used
-to handle 2 independent stereo streams even though it's possible in theory
-in SoundWire.
+   streams or across stream. For example a port with 4 channels cannot be used
+   to handle 2 independent stereo streams even though it's possible in theory
+   in SoundWire.
-- 
2.26.2

