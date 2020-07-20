Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D0227030
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGTVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 17:12:42 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:44190 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTVMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:12:42 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 172A5BC1AB;
        Mon, 20 Jul 2020 21:12:37 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] arm64: Replace HTTP links with HTTPS ones
Date:   Mon, 20 Jul 2020 23:12:31 +0200
Message-Id: <20200720211231.63831-1-grandmaster@al2klimov.de>
In-Reply-To: <CAMj1kXEzaa3BtNF9kgB=UGMx-uvosGwcUbdT3O2qZ1K0XhyUiQ@mail.gmail.com>
References: <CAMj1kXEzaa3BtNF9kgB=UGMx-uvosGwcUbdT3O2qZ1K0XhyUiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Now better?

 Documentation/arm64/arm-acpi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
index 872dbbc73d4a..8f675c38c244 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arm64/arm-acpi.rst
@@ -273,7 +273,7 @@ only use the _DSD Device Properties UUID [5]:
 
    - UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301
 
-   - http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+   - https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
 
 The UEFI Forum provides a mechanism for registering device properties [4]
 so that they may be used across all operating systems supporting ACPI.
-- 
2.27.0

