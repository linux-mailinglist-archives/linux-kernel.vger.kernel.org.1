Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEF2AABCB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgKHPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:10:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:37455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgKHPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604848216;
        bh=2U7Twia+KWF7ZCXIaRhk3lmYvbvEfN7RWuJCjzDjxYU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NuOuUB6z9cpcf++BVp39cJjTh91v87udKBeVvFv+74X5xSwqGpoUiKr6IE3WKGXzb
         yNTBOD9SVRm/QG771XV/ZckR8wrd3gkI9k94NmqnYRGEJ/p3sezBmUVZ4QncjgvWJH
         RMCXO8WPpiLi/mCwZ+lkks/J9qa+3X2B0mEonySw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1klEFO3IkE-00QzsV; Sun, 08
 Nov 2020 16:10:16 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: mtd: intel-spi: Improve formatting of shell commands
Date:   Sun,  8 Nov 2020 16:10:04 +0100
Message-Id: <20201108151005.1843666-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yiTBKBlvLRgXed6myindJcLlHXdjd5Ndqeo6M5NEKAQMZBU7YCj
 bzHbVOF0B9JpqcKGMNK/Ik6aXJdF3qBXeHBrgRIhTOkrHCerXM6Shum0kMi8TVN/dC0xIok
 OBcKp7Eqnrh8s2OujQH6lCELl81uCmH45fp0kJmv+WSZP0MQFx9vm6TUAY6+LlJ9vQMk06x
 AHcNNUFXLsW34zB9S0lxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wDctJC3Z0zA=:5DOU6b8hMjf8oAQ9iA5jFh
 Ul7TyFKoQJ4xI1O859qXoTVXkxsKbgGoEFcB2xzgli5edfcNgvoeUyZqkrOzOvf16A1mKSxBe
 47EOE66wAmPPbU+fyK9dUYagenRk7Z124eRuzjnu68AwrndMHJ74AXTvdcJ+3BTAS+PZS17Zn
 mKGdK/wSJP407iuv49U04rDYPweo/m9dn7CJDJGxLMv1Bhpw7JFfa4gNQUcTTYLXK5HEd5kBO
 G/zh+wBss5wVMMO/MHyUKL5iPsfXMmEA6znqpRtSkHvFXQvCX1gEvGlW4nKqV627CDX+2Ig2S
 L/w6Mzn3qY16FkYpcPCW+V4LSwKlxEoM8Zgjzz3GLSVdGY0FsN95yCM7rzdayXs53lf6w7nNK
 WajFS0eF8ufoLSspQUBFYwRxQN+mFDykAwHY+ky+i8K/TZIMJX+7BR7mpQ9+DryayvNsxXqia
 4sf9Rshhrh1gJ24uET/iSAtssqunf+NSknfnRVUDxUteIzKSTcueCDinStzP4J8dLzopBL7md
 B7HmDONPK2gQyl7QxaGMal6aJMOVIY2ADI5Y4lY2TkM42Ed2vLa7OlNSFeZkcsySPXkLnXv2I
 E9QWh81+07PYRJHgpsnTgXa8aiuLi5Esw7mimSpOMwXdNUx/blRSdTOaNRhchjQ7/8cNrLh3m
 fkZzpBG/Em20Pq0gUvZuszYQlMD7+2yDnwuyBOIWTnKaZCZIvJlmDmy6QWKXGX39fw+DHuqz+
 yLw29H4UCQashIlvoccXPD6sJhIEBYmz1YJRuN0r2nrGCJCqpEtjKG95MfPwg83CUlA8kB03A
 VuhDUVrsBu6cQKSg5saCNPOjWUFBSUQJ0Ry937eHWaXnN3XjITDF3vcTL1p0D3fOF19XBdvfi
 8nXn0zVCnR7+345a1p7p0wogz7bIQiijTIMwWNsXo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format the shell commands and output in steps 6 and 8 as code blocks,
for consistency with the rest of the document.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/mtd/intel-spi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/mtd/intel-spi.rst b/Documentation/dr=
iver-api/mtd/intel-spi.rst
index 0e6d9cd5388dd..0465f68792625 100644
=2D-- a/Documentation/driver-api/mtd/intel-spi.rst
+++ b/Documentation/driver-api/mtd/intel-spi.rst
@@ -52,7 +52,7 @@ Linux.
 	16384+0 records out
 	8388608 bytes (8.4 MB) copied, 10.0269 s, 837 kB/s

- 6) Verify the backup:
+ 6) Verify the backup::

 	# sha1sum /dev/mtd0ro bios.bak
 	fdbb011920572ca6c991377c4b418a0502668b73  /dev/mtd0ro
@@ -66,7 +66,7 @@ Linux.
 	# flash_erase /dev/mtd0 0 0
 	Erasing 4 Kibyte @ 7ff000 -- 100 % complete

- 8) Once completed without errors you can write the new BIOS image:
+ 8) Once completed without errors you can write the new BIOS image::

     # dd if=3DMNW2MAX1.X64.0092.R01.1605221712.bin of=3D/dev/mtd0

=2D-
2.28.0

