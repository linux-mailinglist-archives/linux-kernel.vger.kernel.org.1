Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55890281B62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgJBTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:12:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:39473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJBTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:12:24 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 15:12:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601665940;
        bh=Qo+NFbpxT2mOiv4NL6hQq+Wa/wH05wcrAlFfPLL4Wws=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CyFd+I+RnQgKqDEp8C9tRknx4VA9WPhA+C3H6E59bt8PX9Wd0HaQj3SyukIciCjkB
         IQQBGid6bIidFKTpqhSQAzCBRrV/+/nLfgr5cgMmJZ2gK5jNad/6bACfOkw5IqQPS4
         X2lggvuSfKMMx1ZM36YAuWxx+Fp82ShikEpqXrm0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1klKax0J5x-00q9gb; Fri, 02
 Oct 2020 21:06:30 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] Documentation/x86: incorrect reference zero-page.txt
Date:   Fri,  2 Oct 2020 21:06:23 +0200
Message-Id: <20201002190623.7489-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UshxEsPWn7K7HokVrHA3P88dbV1UW6P7NogprcntMKUl6OpJy9u
 m7YT+8RPs42IK8ICGWw4ruH8twuT/z4l7NqiF6RPGFLGwP5gJo00Hh2c7cwWEsm1Hwpg5nO
 1b15WLZiMOD4r9aTApC6Xxo3MPgAYr8OIvm2ecLPanR0ZroQuqUArTjqUEJR15oktw+mle7
 U8cs3sj+j0+Hv3yutaOdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1rvfBlyx9r0=:jw2iCS5TBu4P4ZNQ1rYFLv
 6Uly99zQAufOGiOG9HqaAEvs9c1rC/6Wb+OcwXMzI5N0PWGBk3E2x2mL0SKBBF14Xdnwb8zQl
 YnKWsqQYIEt5GRblgCdvFjWgg79DOT6pHrNHX2kMuNoZH9/svKAuiMkO65APz1BDpVP6kZk5D
 +JGMB2/cIbjcDiMpO6ziabOrG7H7DmWqR49mx2ewrApBRFNYrL9SkTK0izKcgc1AJlDBjgsuZ
 q2SzPE8ze0eUgn9McNK2fD0CoE9NpzU5ZVjQx6LT4z4HSPgzceFZw3HOlm+JGEArqVAg82IvV
 kzodNd4C7tJmxxd7BMQL5Tww5Jhz/ciYlPQq/s+raPaw5Q+wEYuIWRUoSpU2QQn52Hffw25Z7
 VlCzyF9u04KQZZ3x9ry/kNk4MDlcSFjkrxcheEaSuuOOniWLkmfLRrjcU4W4lDrWjRogPdapW
 uPLsPpcLgtB9d6VJAsu7BK85z6SBM8EXA5tCVWkPOuWflbxROHIRH/g6pMRq2PQfSnmBPAsJX
 Uv/pxVysxCikWvtOmMzc9ev/OEserQegWBDUej/8d1sxETQQnrCgfBqRJ4ll3JosYfwN+gbG5
 TA6/ClYBkPWN8rbi7ba/ddHIGM/caq9wslAXH+b32dupO/VL1wQUkAMPykkQsVEM8J2jYLXmH
 aKi0zqRp+USpmqbVnVmorp5b04ny89WEBPXc3lYMoKB8PhDRkYC5JkUFhoIoF26khCo3KHstt
 DlsR1U4soCy0g4WL9vra0oewf4a9VsDyT6YlD8kd3VkJZGL8AiYk2ePCj7fQaiR8RoqQlRBL4
 VDqpmNmNSQFMlDms6uGJJn+2/6Im+kmBRZDKVNMsatVIzp5rza9zeZQyAorvGkxdqNMOmkBQ4
 WTYjN8ugI/hwe7Xl0MIc2lYsVDkXxD/QlAY8STS3gWVo2Z6w2C1f616RR8Co2RKQTtoT9Uo0d
 WYeuMVwKKKdlWBxncalRD8gr4iAjUOpIx6zVUktId3st2gBcyyw+tReRE5LfDEphebUF2iMQq
 L4BtkIPZHiF9S+1+BO558zfopWbYk/6sSCb9ro/qk6NmKgghYe+jBOO3I4DVveJJDfczKGNSi
 482xWwyqXPbSA/9h7Y1p57RDWmn8W2zuNX+ATFFCMwVJwwRM3Ty9ytzGhzKGGAGzWtAaZs4xH
 JXgd8ZrPCCn4n2Z6rCxxJdPKsKIc5Hs0mX0Siwo+BdaXqa9fLHlr85EMeWDRPb1hbjtrOC5Ip
 bGrEfav/GtiinAeViARvSii5sS/gUkfxqZOlS+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File zero-page.txt does not exit. Add links for zero-page.rst.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/x86/boot.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 5325c71ca877..49c3ebe8a439 100644
=2D-- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1342,8 +1342,8 @@ follow::

 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
-also fill the additional fields of the struct boot_params as that
-described in zero-page.txt.
+also fill the additional fields of the struct boot_params as
+described in chapter :doc:`zero-page`.

 After setting up the struct boot_params, the boot loader can load the
 32/64-bit kernel in the same way as that of 16-bit boot protocol.
@@ -1379,7 +1379,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in zero-page.txt.
+in chapter :doc:`zero-page`.

 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
=2D-
2.28.0

