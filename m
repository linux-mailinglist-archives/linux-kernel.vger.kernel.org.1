Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3074828EE89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgJOIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgJOIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:33:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E482075B;
        Thu, 15 Oct 2020 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602750787;
        bh=FdpvF3CuF8OZL1btI9vHfGMHD6Vr4KGDEmjf13C+eoM=;
        h=From:To:Cc:Subject:Date:From;
        b=LhjFtfBN1tr0o9FX6HiDlzY3OMkRxr/kb45pcWzL0am4sASuzoJb4FljvkvDQ3IkK
         AvlPgu4vNaxpDx0khpdvm0nXmYy1SibO8bfUc/4PclgCXNg0Pd1quL/1cKfvTbNPqI
         kziJVYS2dG3Ar6JFgCuubDzrL8AbJW886HgGp55Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: writing-schema: install from PyPI repository
Date:   Thu, 15 Oct 2020 10:32:57 +0200
Message-Id: <20201015083257.15450-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installing dtschema from github.com/devicetree-org is not needed anymore
because dtschema is now part of regular PyPI repository.  In certain
cases it might cause some troubles as it brings latest master version,
not the stable release:

    $ pip3 show dtschema
    Version: 2020.8.2.dev4+g341f3e3
    $ make dt_binding_check
    RROR: dtschema minimum version is v2020.8.1

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 16f21e182ff6..b3cccb7e2059 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -115,7 +115,7 @@ The DT schema project must be installed in order to validate the DT schema
 binding documents and validate DTS files using the DT schema. The DT schema
 project can be installed with pip::
 
-    pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
+    pip3 install dtschema
 
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
-- 
2.25.1

