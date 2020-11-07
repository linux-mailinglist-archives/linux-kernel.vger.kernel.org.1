Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2032AA56F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgKGNel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:34:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:42515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgKGNek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604756033;
        bh=mTjCLBPoUnUm5mv2iC4xNF5c9rw+uX5O8rOaunwsyHI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YpG05YhngRx5/Qhp2ZD7+gaoSI3Di75w2V44f/tWqoS0ocHhILt2cQsEA6yp/oK7l
         UYAlcA05oQ/O9B6RkGEhNYelKjGaT5ffdm8Y2Qyk/yeI3EXK66L/tJYbCOUW4TdVho
         tLQ+BwDsv6gzeqHuVwihHhsFXHbzsloBlpdv/tjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1jvzba492s-00oJvo; Sat, 07
 Nov 2020 14:33:53 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Eggers <ceggers@arri.de>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] eeprom: at25: Add example part numbers
Date:   Sat,  7 Nov 2020 14:33:35 +0100
Message-Id: <20201107133337.1066271-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OQlHIy0HMWRSw2jDTyLDFT3weIIvwbZf2uYNtMdiQPpYs0cB7x8
 pCsC4Izmqwm4u367mgMDy2juhpP2cd4k+ZBtCcROVGhItK6DTiYKWFc34qaErZgfj5npD5h
 havw/85c++d2hf1TzVzE/fi00hqEgDqgDBidqW/ydwm3A+cdQSlc2RXFW/4McpqMzUFd77t
 US1IisWhe8XncftQMsrsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jkBpQ0NJZaU=:luYZovjqW5Pktj2Hsi3Gct
 LH1fRwFMDoZnhCrgLnekJfKMxcL+DELPw58bdAvgfrKiO/h45Fx0o3WdAbvRpyh7E5R41/cbh
 hemUEj8NV+92ianalrsfXu2JAsoBi4EQTVRGEF0As1GUUmKKJcteTkdMwTEB87gjg/SWQrioG
 QQjrTuKVbTkVrtuEHas5xTKN7r5kFFBX43F/Xrm9uIw8V6+WagE7gFRMqT2ymb24qz1yEVMGD
 Yk5t/lSof1LkvTxyRf1Ct4pMXja5VzAy0H1qC4ENdUf6x+0Wi/z17+lwPjh0s744mLNF0xgtA
 yyxlgF6/T7pSpXioidLmcW6zpFB4+cQnORn5Dod+OwD2I/fyqkp4lDEoXWy4mlt6kltrUu2pD
 Rug4W/2A0ouGyeixmbX4OtufzzWNkimJPvJsWo/WScJEqR1NlKuA6HDRXd2aZ3GURc3WF6GeI
 KOEQUGSJynPh6tgpg64ieX6ME/o+SbKzykqBRd3bwnkHBohC6u7Xh8xv6WaAJmEIcK1ZsZJ6V
 K+N0Vrma5yEfr4/ZAdPKxmq8JCrq+CAZmRzM4dv1Eoe8ywEUqqX2SsJt7zgXtXFToPaiL0qcZ
 b9vwVsMXTA270WixOWyLVOZ0Z/FvssHG0K1SuwhcDKJeLeFDeupjwXY23DqJzg5AD1k/oR5wq
 FYuVnlBjvbenL1BlvsIXgc1NXaHB3FEJFf9wkihCtmySKv2KIoBhxQKKzZoyYA+QWM8f5iHc2
 XF/LN1/kJ6hv9HLWDFgeelzQ15EThyvqZIp/j83W4TeYJESjd+t/J+ZKFAc32Hs/tWUrfCRBy
 2YXJd5a2/Us2igG3zE/GnAaFozzzI3gky41irhNBZta5KLwCcKy77TxbJpAR3kfBkpITcSGY9
 TMBPWXhzGUMNqb9Gq2eIzildhIun1azdF+5u0s0Ds=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To save the interested reader some time, add examples of AT25 part
numbers that correspond to EEPROMs rather than flashes.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/misc/eeprom/at25.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 3b7d8b7584f4d..b76e4901b4a49 100644
=2D-- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -22,6 +22,9 @@
  * mean that some AT25 products are EEPROMs, and others are FLASH.
  * Handle FLASH chips with the drivers/mtd/devices/m25p80.c driver,
  * not this one!
+ *
+ * EEPROMs that can be used with this driver include, for example:
+ *   AT25M02, AT25128B
  */

 struct at25_data {
=2D-
2.28.0

