Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCD2E85CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAAWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 17:22:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:47757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbhAAWWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 17:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609539590;
        bh=jMwXiMjRPNgjy8AA61m/2S9siVt4OWWaNSlKQ33wBSk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UHfQ+4E8+6bt7niXqDPg9a/Bs8CVJccbrLd7hichakV7H7Wi1WmZeaHIhWtCdri4V
         zyFBSGZDT+hzmXhMwg3bdU4JEOM0V4nnt83oivBV4ns2F8fbRdhcSzPhckcxzx8bdx
         sPEGWOzBsfEUjG1j/q/hc1wHQQnp892KYhzBYHQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1kPRwY2E1k-00ewkT; Fri, 01
 Jan 2021 23:19:50 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ALSA: Fix reference to mixart.rst
Date:   Fri,  1 Jan 2021 23:19:42 +0100
Message-Id: <20210101221942.1068388-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u4OdV2KYuu67DbBoGJ+25LQDNFC8odVCZqA11wCKXavaJOYVKwA
 pcmu2JFhX/flR4D295h0ysUXE/v10ePDzBCr9IcbGlq0JWlwb6h7OWQC1bcDQ46QmQdk8tq
 L4W/P8d00ttRVpzgMypWKdezTwGZ18VkVUIiuNlfbs//F0mQEi7GdSiGLvfeVZdUOSzcTNH
 STehxjVcTlsvITUojTv0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n+OgFaAHS4w=:sAJG1ANtldmAofN6xRLV+u
 e0siHJqME3EYMHQ/iVVlV0bwsjj9QHlSHYm18twbi4ELiu4RkcRu6xT8eQadCEP05Qg+KW/tL
 PEInvzoLsz71c+6u+rbSmtGhn33gQxPNi0cz8EpKS5rKzBUaPUF7Pm++NhM+QHdwSRxwqOQAo
 xabZOhEQ7uD7A+BUyrTqPzIVaAiiBR2GCDPd5x6s4cENQZgKkUsNQf3Ca0IOBxvNjqlwA8WxK
 jdL14vi4QJl2zVYQN7NjLd8c5FSxQIQXGMdbFjJ8X0i0ogyr5KjdYiuhF5e4zxW/EvxWmB9vn
 gklr3msPag3uIhPZ/e0fXJoBuoVQIwOzUVzbxjC16uIFZC4+EFwwPHNYN1botom4xNUhzkpSa
 M662+Bk01E+bSrGKGe81v8oqmh+ncGt1XH+TXuOhCyRnOfkphN5WhWGq3fcfl/W/ho4txXAv/
 P79l2ZfAiB5QSaZ0bOAK4Rm/0H1qAGlBnhBTd767Cw+1WLyw8BZZQfphEPkoVVKBLArrAdKXn
 8eAT8SAJsewfUK/1l7i4BirIdAB5tXiF0m3InKZ9j66dexUkMpAUGoqb6C/6LIJcph9S6gr0b
 Lz9WBBLXLYW2IGO3ludLk/jVUPK04X6YPtoCnZvSsZO/LQmXJVVSkET1ICASPjU5tC5XzEWIg
 LB6v3Kxhi6x0zi9AfgHoX2ns1BJ2VdzaPqpB8xwpJ2OUnzEyKAQn7jKoFemY8FgrXsOid0tPp
 0n0VdrQGBUl1MIdpKBzCpNs56kNKqNRHg0G3jDoGE+eBENRqgHsTKjBVXpf2dea0HrNNDEsu4
 olls2alLEG7/8PT0VpHdx7BTqs01mzo+UqU///Kc1PXYyUdtyKx878Q3dF1LQdceafP5NUAoi
 H12oeTUaUnKu6Fb9ZL0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIXART.txt has been converted to ReST and renamed. Fix the reference
in alsa-configuration.rst.

Fixes: 3d8e81862ce4 ("ALSA: doc: ReSTize MIXART.txt")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/sound/alsa-configuration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/so=
und/alsa-configuration.rst
index fe52c314b7639..b36af65a08edf 100644
=2D-- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -1501,7 +1501,7 @@ Module for Digigram miXart8 sound cards.

 This module supports multiple cards.
 Note: One miXart8 board will be represented as 4 alsa cards.
-See MIXART.txt for details.
+See Documentation/sound/cards/mixart.rst for details.

 When the driver is compiled as a module and the hotplug firmware
 is supported, the firmware data is loaded via hotplug automatically.
=2D-
2.29.2

