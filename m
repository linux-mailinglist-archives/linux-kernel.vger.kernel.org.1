Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB82545CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgH0NUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 09:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgH0NOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:14:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C546206F0;
        Thu, 27 Aug 2020 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598534028;
        bh=+SfWQaUMwBUFQX43bYlEQZ0bA0dMogEYzjgpWIMuvfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LKIbzFIoE310AengrPQqShaINt18hDkoM1Lccb3bi5Mx4pWL7Rs8Wb1eTyjpmUm3B
         fRbN4Wvg7cRWLjb7uLQFMBYWocTVFcN/C6EVSRWeAntkH/So2eWrl1olen5tugfC1g
         AnusWtk4A8ibqbZRt+Ds54oIyuchUfPwF6IkQdR0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: Add security docs to SECURITY CONTACT
Date:   Thu, 27 Aug 2020 15:13:30 +0200
Message-Id: <20200827131330.3732-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the documents related to kernel security workflow, notify
the security mailing list as its concerned by this.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8107b3d5d6df..a1e07d0f3205 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15620,6 +15620,8 @@ F:	include/uapi/linux/sed*
 
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
+F:	Documentation/admin-guide/security-bugs.rst
+F:	Documentation/process/embargoed-hardware-issues.rst
 S:	Supported
 
 SECURITY SUBSYSTEM
-- 
2.17.1

