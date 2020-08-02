Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE16239CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHBWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 18:36:35 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:20565 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHBWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 18:36:34 -0400
Date:   Sun, 02 Aug 2020 22:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1596407792;
        bh=uqkGqPHbw5SoGB+pvlSksm3A26SLfe0aDo1kq7+qs7U=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=vnv9ed0OT286DLgLvXEI6uD8tCjYwmwpRZDJ8xHNqfnzZN5AmxFpbXPHFOMfqd02b
         fN4abzMew2dkyhvw/0yzvy3QRF5nl9vK2btPCPrnTjEsaoPOmEYf2g68bHUDY9Dt/E
         E8817ZLizl/kV2WJAVTqp7Skfbiq8TzbMH5jgDH4=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH] staging: most: dim2: Add missing identifier name to function argument
Message-ID: <20200802223615.924307-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function definition argument should have an identifier name according
to checkpatch:

WARNING: function definition argument 'struct platform_device *' should
also have an identifier name

Name it pdev as that name is already used throughout the code.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 drivers/staging/most/dim2/dim2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/d=
im2.c
index 509c8012d20b..b34e3c130f53 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -100,12 +100,12 @@ struct dim2_hdm {
 =09struct medialb_bus bus;
 =09void (*on_netinfo)(struct most_interface *most_iface,
 =09=09=09   unsigned char link_state, unsigned char *addrs);
-=09void (*disable_platform)(struct platform_device *);
+=09void (*disable_platform)(struct platform_device *pdev);
 };
=20
 struct dim2_platform_data {
-=09int (*enable)(struct platform_device *);
-=09void (*disable)(struct platform_device *);
+=09int (*enable)(struct platform_device *pdev);
+=09void (*disable)(struct platform_device *pdev);
 };
=20
 #define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_ifac=
e)
--=20
2.28.0


