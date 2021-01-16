Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F43B2F8A84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAPBgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:36:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:37195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbhAPBgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610760854;
        bh=DQQZnUMbUtwZPh7yTU29MprFxwRzkiuslGETPcaqJo8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cog9hvUmq55W6byV1TS48av1bEZ7PXysxyCGgKApmcCYynqhCO2lQn+h+AiGRA94t
         OgFJF5T/QNSzaxG0TCp9IELKiKgIHidDZDYj4TI+sSO2r45QpCqrFoVM+uCAX92MlI
         QQK0T1mGyDe8XSmyupOPDj5Zc6wq9neOT53Ctsk0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1lwyQ61BB6-00wRfe; Sat, 16
 Jan 2021 02:34:14 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: mt8192-mt6359: Fix indentation
Date:   Sat, 16 Jan 2021 02:34:03 +0100
Message-Id: <20210116013403.3490518-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pw6fFpTH4JgulBV4NAW8Xpyamk7kKZTHxe+JZ4cc993vURc1kCj
 7EySxi7Gz78sAu5+8TKulKiDoT2+ooilj9mV/eUYqsZNVDTaK24TueQik0HEwxhLaiYO4bk
 6n97hGj7Ss3y2IbPuuhsoi+0Y7OHlbRAyMvn1FGGtfqknwAbxeDQFeYqVdcaCOMfFkAxczn
 RCvSujcPzFrr4RsfqbLEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IPBpfBkRmAk=:zl2DPbIfK5owXrw1MFdPo9
 jw90m3gH6cgXufM313n574GMBIwSMGynz3n+S/ZuZrze3DN9v/dcqv2O14pJ8o3VACuorRSKk
 V9u8sgGEE+cLqabZrDM5mkn73R7Vdh6NyuNfCkglJHBsI92A4gifOTCDmqV1AlsaMm0zn/p2e
 rIC+ddHeq4x73wQxbeEkyvjI0YTb+9ffoJbfKaKxSWcRZNdfOlPD+L4ytL/w7bTJR7KTiQJot
 V4wglot2Gu/IHfIREXDDg4+RgrpmhpAX47LOmpHgBH/avkJeVUp8XKHdyFAGCOZ4Tkk/y0W++
 0ZOyQgtTQnAY43gkhofYd/Uuuy/xnu7zS7aR/7iP7zUguOifpre9pcAEIvaxG6/fVe01XOd0N
 6bODbQRUBlkpOv3oRYABJ9DVqxD06cuF49mkEPQFCVyY5nd96mGyZxYfGiu2yRR/jDr7RIQFC
 dB67pKUqHKj9VyNkzefS2hCL0X3lYpECvsu9T5J5o0IM9edWdmW2DJD6uPxsv+rjAO0CEdR4R
 Pp6eOGTrZTQgsPAWjWO1EUZ6kXz7FePk4bObyR3e1qPsE1BjqoaDfmJSqNVXd72njM9HoUZK3
 P0M1DirTom+CxISI0hHxtrSwrZwX2LjV3Mb+9FQQRdh1mgr1xqH3AaQB5pD1zzzIDUjzVuT1W
 cTLIJos3piVPQNdVWUQH6MLx95Mz8rtSkHDejh1QsdoaUX+QHrq3tdzQR3BCPq5ozhZaGBgXf
 /lFubO7bQExU69QcPWDKW0CHjMsRPBTCkYCM3k8mxYE6PEXQSJ1SMPI4dixbQTcyJDVRgnq3S
 sL/xCXPGVgb95m9DOp+jPVwLJkwLVFFJl2U3FRCKRUGzce2snZth40I2UG7vZw/18rat8XlI9
 wzNrHJFgtZIJY4hMc7NQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The items of the 'maintainers' list are indented with three spaces.
Use the usual two spaces instead, for consistency and to silence
yamllint.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-=
rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015=
-rt5682.yaml
index bf8c8ba25009d..54650823b29a4 100644
=2D-- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt568=
2.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.=
yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Mediatek MT8192 with MT6359, RT1015 and RT5682 ASoC sound card dri=
ver

 maintainers:
-   - Jiaxin Yu <jiaxin.yu@mediatek.com>
-   - Shane Chien <shane.chien@mediatek.com>
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+  - Shane Chien <shane.chien@mediatek.com>

 description:
   This binding describes the MT8192 sound card.
=2D-
2.29.2

