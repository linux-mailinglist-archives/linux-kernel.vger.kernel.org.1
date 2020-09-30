Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECD327E9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgI3N07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730252AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674F423A59;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=J74G5kQSa0vkKhBu17975/ADBNsJSxOJrcSKfNRKnzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxGgsHwXeXTaXkiV7JB5mez6CDXAp0V2tE93kNoEahHC3IxDdQqOsnofJ0YBrdBfY
         sP1OwxUliY/qkay9AG7Ub8C1RYURI9oa7Q9+g2FNADjmzDL8rs8jf9IpgRfkFcv4FN
         CfW4e4Fq6LfV4EImOg/YBPgUFX5lTdp4JqLha5Eg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKr-LK; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 43/52] docs: infrastructure.rst: don't include firmware kernel-doc
Date:   Wed, 30 Sep 2020 15:25:06 +0200
Message-Id: <eaca248efdc9ef7a2bccde8bf4ddbc13223f333d.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are already documented at:

	Documentation/driver-api/firmware/request_firmware.rst

Including it twice is causing lots of warnings:

	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'request_firmware'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'firmware_request_nowarn'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'request_firmware_direct'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'firmware_request_platform'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'firmware_request_cache'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'request_firmware_into_buf'.
	./Documentation/driver-api/infrastructure.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/firmware/request_firmware'.
	Declaration is 'request_firmware_nowait'.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/infrastructure.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
index 06d98c4526df..e38d79be4e16 100644
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -28,9 +28,6 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/node.c
    :internal:
 
-.. kernel-doc:: drivers/base/firmware_loader/main.c
-   :export:
-
 .. kernel-doc:: drivers/base/transport_class.c
    :export:
 
-- 
2.26.2

