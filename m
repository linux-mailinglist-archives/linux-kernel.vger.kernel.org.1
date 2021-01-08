Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0534F2EF28F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbhAHMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:30:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:40265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAHMaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610108899;
        bh=KpCMpUy6VUc1Hr1ym6ONwZxAKziozlsCHoXJ7ei23Ng=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VhrhkA5jCNfY4F7ZNWFTV+NJnx/jcSBlqxBx4UlyovLhD0tSxToceN0NOdgaPW7nl
         xMbfH8jVDU/3UyckUd0HEcpo11VN2ua7NPMJCboedPy/GgLEoAJZ+l+ZoAQ//8y0Bi
         6iirT0SKEbNMnYskGIPBaAVTkbNG6gg8floEISUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1kv73d068E-0063as; Fri, 08
 Jan 2021 13:28:19 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: nuvoton: Clarify that interrupt of timer 0 should be specified
Date:   Fri,  8 Jan 2021 13:28:03 +0100
Message-Id: <20210108122804.359258-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+I2sI3Dy+uSuRw4shPx2VBxLIOPM5YM/mSuhVlLMSX1EyJVcYS5
 U24ERaShIptBAGYfJhC/vf6h180d1PakfL9R8FkqI6cV//Td77xXkjmBg/3OSws+lIfx22t
 9ZEuSWRowbqvvyMYsvBcLdRG+4thuWNfwjc6cvIHGi13OqrsziYDl8mtvFdLuKflKM7AhY0
 KKMo/TemmlIfo46wwPiSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzb1sPHW5bc=:iXNlcqZO2fIPkLZTiNhn9E
 XmbFtGpgB9//v6Nu+wyMJPsOVw+/qN6qE5N1R8gUozACB0uUi25+S4m3lmecy0K3fVuVWOK0m
 SMXU+nSvZgmC6zNvZ7ZB1R1L9sPAKDT5om93oS16S3kWqQslnMEzEDlbQPWujzmUjRq8KWUeR
 APQhePupMKhgub8j7XblgRKMXTjODEwrWO7XN5IGnr3r3nal0mb9phcL6G7/A9y2TOD1WqQxk
 wArRMt4IAOx06iuouipgaQmkQnMQzsThpPRKTJkhp9QYXFxBXs1P90Cy632cqLmTcd6cUvrj1
 jOl1X0/HB4+/5GpQtH7vayOJHXXiYRwhmltdVN2FlZB2Jsl686mrw78yKeTaxsvZDZrW/7w2/
 Ca9Qn1G2Jaa8F0l4Czhe4nybmFaK11DySDFEs+s6pQ9gBj13e2P35tZkqRwpVWAaCkjsT8gZa
 4lldftBgaKjgXZb3K7XvpEzjrSPUeGmzwd8OdS13tBBnLuEjAAC72wRyWQR7CdAiBRKIY4nX0
 bma6Inr8BR2xnXAcWyz5QTpBjuubyPzcB7PhtGUs+H4+AdM3H350TtAORmFZ1GVoydr/gyrmv
 2akipmFkrMH+rHLrrLgt61NLOvREheZOVssTxyUB5jl6/dMTfwHjP+24GihkIibZZ4LXDLveH
 Evzg7vglw7TzDvKrgpgbiWji9Bp8E6/hA6o1GjInblTQyz6OrNh+/JevR9ej5JS7PjerJvkkS
 bPwriwrEJSbWlB2po2aVfhX+TzIdQbiP61LMS1anG44LwjYP0pt8i3otAVA3HzhBiPfaRjpKY
 Td+IhMtL10eYZB/XmT0C4QbE8gavCyLBj92g7Cl6WcclEVIKfPp0L3sRIZO3QOlG8AB82fRRR
 YiWxmKbaGj+MjrPeiJsA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NPCM750 Timer/Watchdoc Controller has multiple interrupt lines,
connected to multiple timers. The driver uses timer 0 for timer
interrupts, so the interrupt line corresponding to timer 0 should be
specified in DT.

I removed the mention of "flags for falling edge", because the timer
controller uses high-level interrupts rather than falling-edge
interrupts, and whether flags should be specified is up the interrupt
controller's DT binding.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt        | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer=
.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
index ea22dfe485bee..97258f1a1505b 100644
=2D-- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -6,8 +6,7 @@ timer counters.
 Required properties:
 - compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
 - reg             : Offset and length of the register set for the device.
=2D- interrupts      : Contain the timer interrupt with flags for
-                    falling edge.
+- interrupts      : Contain the timer interrupt of timer 0.
 - clocks          : phandle of timer reference clock (usually a 25 MHz cl=
ock).

 Example:
=2D-
2.29.2

