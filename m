Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F232AA78C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgKGTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:08:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:53951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgKGTIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604776118;
        bh=jE5f7dstvHEPWrAikYGEZvkwxqFhebukYhL5FN0e4P4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=icWvyPr7lRWuATS4qVREJMC4BoUlXx5RMZAC7Fz0J6klumUGSPAZVe68/5fdnyP3e
         z4zwMezo1WJEJRob+FxV7fuSTI5qaURgyIMHpfhpMZJU4XCdIwlyOOxoBHCpAGe9Zi
         B7aHYbWb4jqMg13MnLVbGfPxom1sl8ErAgr0to1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1kS5uG1Lec-009LzP; Sat, 07
 Nov 2020 20:08:38 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: mtd: spi-nor: Fix formatting of text vs. diagrams
Date:   Sat,  7 Nov 2020 19:39:01 +0100
Message-Id: <20201107183902.1182809-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:osP9Os5JpTV2/9plSo7aStfBxw5Zfbcnv4TAnrPFogBjBiLbmTq
 eAgIQyvhWGwpH6EE5QTS/yegz9wdLIE9q9mimaF5Nbn/Xkp/f1gvdy8b7D4I1El9QrV/FKI
 ufENyTWdxVF7EBAmwzGpw7QIYwD67AuHiMZnnF0NtfH+gIOdaO3gQe9J6r2Wfks5hO4r0K0
 qbyKS8NVgqAsejrgGj9Qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+pAb+2ZeI3I=:ak5UwrOJvCabne+6EXnMM3
 0x9dCrPva9LC547UGMUz8SHbAfajs3AdFNDPQnBtBNxhzCH1D1ZS2IMVAEux06E8jvrp0kXwt
 C9RTH1bHyom5ld8Ku71zZfRjBm2kxcNG9grqHaAknepJ6GFHuknszPrHoP0NOLxjIiTcG8xkC
 jbdNXjVi/edhsnJBJk4FuGq8+Cj1QE2wvjp+CkONG+AkrgeqX+EtwT0frgveDHfGmbvwDdC41
 smodw10ydhRcCNH7K+YFc55nTQtXDN7qu7Skq0FMxc4t7/RwboOvtaoGdSaFfNmoBUgFdUCVs
 ZdWF9772LNroW3zGfV5ALk6iHnOcq0gIV9iOKrNFwmifRPBRO8oR2XzRkSi6CWGjiqNSjD9Fo
 eoyNQ3efcbuMIfTRq6chU5YdH8jxMfjhYjFqhgN143Q5upr+EGcRgzsHeDhMm7YaV5ORak6JG
 6hLLUcNcLpcjvF5ZgaPElQzBBp25WllOqTf5hgxwafl/BnO8NiE+NkvGTbwdy0J8ryHYZgANW
 bpeGAKepgwJasez9M7cbD6fk7AOcAN8euHU/LAcynRHvCbHxaFnOHlxrEiqipJIfxbTsV3Uhm
 n06G9G9qXZ2agSjCI5kM9CEtWV0R5plGXkq3uXBTckU6dan+wiwJQBnbCfx8CZhQW4dpCAcEp
 VwddmOVO6uhswICAddEf6EvwltuQE0HYSUzQB+my+6GaNXtI8VB4yC/eycXCeJUsds0Mn8cAy
 7XgaE8LjK/ErtDAum9b6Unhrlt7OvSkJFHmLXB3YLEQq6DPiDkStDfCs6EZoLAG3/Wrun/qR/
 NDqEVUfBL0Nfn/NsV4wZq9hl9JFIyi0r43A6aBG2ih/QCxmpeg6JoDlAzRn8zblRoiTQ9bRgf
 0dMa0S+STI0sLX1ORpFPDEx27hnakdJ/mCQglA3jo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrently, all diagrams below "Before this framework, the layer is like"
and the text in between are rendered as one monospace text block.
Instead, each individual diagram should be a monospace text block.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/mtd/spi-nor.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driv=
er-api/mtd/spi-nor.rst
index 1f0437676762b..4a3adca417fdb 100644
=2D-- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -34,7 +34,8 @@ Before this framework, the layer is like::
          ------------------------
 	        SPI NOR chip

-   After this framework, the layer is like:
+After this framework, the layer is like::
+
                    MTD
          ------------------------
               SPI NOR framework
@@ -45,7 +46,8 @@ Before this framework, the layer is like::
          ------------------------
 	       SPI NOR chip

-  With the SPI NOR controller driver (Freescale QuadSPI), it looks like:
+With the SPI NOR controller driver (Freescale QuadSPI), it looks like::
+
                    MTD
          ------------------------
               SPI NOR framework
=2D-
2.28.0

