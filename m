Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB92FF4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAUThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbhAUTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:35:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9398B23A22;
        Thu, 21 Jan 2021 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611257671;
        bh=5u4+4WSvcmuVwGyVoTQTPGQ9yg/AtS+p3lohLtBG2Eg=;
        h=From:To:Cc:Subject:Date:From;
        b=QyXqg8Hy+leXBi1vryiKTBya8ZITVFERD463lgRrXbP5drKIZWaz8ouBeK8ZabSNu
         u5TevDtYH3ko/tun//mIpD4tAoYNAAv5MviylfD5DPcb+v/r0JT/toJ7NOgIn7NXKc
         zfeMpjVC3ax+14fv2yq/KWXKPx7f489e3ngn43ouIoriReUMX+P2hjHbNABTtNm0K/
         pGTf1Tl8Tevk6etMAMjZjynAoFm+DuzyMPbKsTgXkXGfGxg7J9pGDOZi8DM7G9D8zp
         woqbpxsnrwbbUxkYxcQEbKl0Bmxos0Sr8wZ46bFyPAmOs6GT0wGkRWrSCkpgSL975Z
         4fXhNF0xhHtpw==
Received: by pali.im (Postfix)
        id 4114A774; Thu, 21 Jan 2021 20:34:29 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: arm: Fix marvell file name
Date:   Thu, 21 Jan 2021 20:34:17 +0100
Message-Id: <20210121193418.22678-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/index.rst                   | 2 +-
 Documentation/arm/{marvel.rst => marvell.rst} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/arm/{marvel.rst => marvell.rst} (100%)

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index a2e9e1bba7b9..b4bea32472b6 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -33,7 +33,7 @@ SoC-specific documents
 
    ixp4xx
 
-   marvel
+   marvell
    microchip
 
    netwinder
diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvell.rst
similarity index 100%
rename from Documentation/arm/marvel.rst
rename to Documentation/arm/marvell.rst
-- 
2.20.1

