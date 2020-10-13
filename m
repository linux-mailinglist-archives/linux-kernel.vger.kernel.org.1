Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9328CD78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgJML77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbgJMLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:43 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B86223EA;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=J74G5kQSa0vkKhBu17975/ADBNsJSxOJrcSKfNRKnzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeXInMEOMZRPCfSKOTHNV1jNR5U8Kg5A8ZRYu/+jklvXpaUAGb014su9vt5k+h0Z0
         KwgxVURLwr64PxgINi9001Z05l7PayO3NQoHEtIOXokBiwBRQa9AcMRxhAADdX1LHH
         5rPI7s9LFW9KbzoqNLzo+qsu6u5SemFwT5UkwD+Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CV7-TL; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 43/80] docs: infrastructure.rst: don't include firmware kernel-doc
Date:   Tue, 13 Oct 2020 13:53:58 +0200
Message-Id: <ea3381684003d71c5e8bdc492cd142c9470ff614.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

