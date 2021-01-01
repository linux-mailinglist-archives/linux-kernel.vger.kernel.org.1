Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861212E85A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbhAAVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:16:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:59441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbhAAVQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609535695;
        bh=EKEVVd/s9tWN96Ad2B4i4FpP9FS4G/rnReNDGVpjXPU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eCdm30by0JYfMhc5OtCGhNwPHZ6aaCBDwo/FOyOSbmeLy5XlX1ZtxyhrdlDdpx+bK
         r0umZ7XrIexDELiOeIGSmK9M55topqKx8uhVSd5HwiZMmeRmqS/vVMY+v7PGDtmCmB
         NRwOElSd13JIrFO+wdFhdtgYEhW+H/wxm5O6b93E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1kfHmu1lRT-00P7la; Fri, 01
 Jan 2021 22:14:55 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Romuald Brunet <romuald@chivil.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: binfmt-misc: Fix .rst formatting
Date:   Fri,  1 Jan 2021 22:14:47 +0100
Message-Id: <20210101211447.1021412-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t3sMNTfmY9HCo0M1fE0BCba6iJEC26+jQKWLSWtIRm6it40px68
 XsQbvSSjVpJ4VJPVLIzYUhgWj1cF9m2jeL5onx8rhe7cCL/wNCuCkIwN4KzfknMfTmB8CVs
 F0edKfWCvy+EIxOtrHiv8sB4V8dl278bYqKna1X47YPa5XRCfQ8Jj4IKhrznJTF+MED+eRi
 ybPolgtclyNkqetfgmk+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n2VNFGgek5k=:XztQpNDFENjzTDGeTkVtkT
 7O9pckC5bpMkc/F12u8QXX3LSMAjIQhN82g9PDry/hvPm6dTLckyVaPEAT2MVGYZen0CjmO9D
 md5cHKQvx9b6inK0oXymbARRtW9cqRnQ/4omOitJyv4UOQ5qfIhgZGfzxwpmTax9+/cK7KPqu
 Iu1sdUJOJ9e4hpvhnacw7/PENqif2uBjC+9J00wQofhh13Cqu1mspiyxM1l1a/0xbhUidK7jj
 uFTysf0A91iVoXRRtdyTuyqPTihGk2IlPwqW2np17CHGEkwAOtWrRfgdI1jFIFM2Uu2h/vPv5
 9comF1E/OyEsud2nFovXJ+iK0e8OTC7V5cn30JI1TJeO+SUxMYnoonJ75GscMIs9eO9lMb+JI
 NbNu3WGq3eVzAwtFE0WAsMic6q0//sap92Fcg0Ojx+cuvX84IKd0NpJxJPnPyRqtO/hWdkFJF
 UmjvAWOh8lJZBI6UudFtUWQFZni4qHvBLuLHdWMHnEeyMnQ+xX4lRNNAIqEjwggFWKZUXMV1s
 wrDu3ZnaOapZmpQ551D2Vr2FkNORDtd653Z5WRcXqGLv0T1knJ/39wy4ZIIliaOiybSTcV+o2
 xjbTxGmUJ0GqF1kjmLC3V33QHgnnETuPCOiTr4S22I9/zKvf4jKtjS39mq78plWMBS2I8laDn
 5esIqB67jr9eO4T3t3vp15BQNEafMiYH+nkWQSk9AUYHvMRJdsBmFv/eKIheZaWkkc2P7P/GD
 VuqMbAs+kozCuUDnyKMzznViQCzxHCX6JXYPiEiEIFIKIz0N4FBB6UgJBi2E1jMnWyU5Zsuhs
 CQedlMuoKB/EkZu1h/eJgdOF4M4+2OVh4OO86/BNzCM/0nnWLtq9JmrL6pYZtvyFHxnxz5SbR
 sdHQsyh6fy5JJutTdGng==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"name below" is not part of the /proc path and should not be formatted
in monospace.

"doesn``t" is rendered in HTML with a double backtick. Revert it back to
"doesn't".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/binfmt-misc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/adm=
in-guide/binfmt-misc.rst
index 7a864131e5ea7..59cd902e35497 100644
=2D-- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -23,7 +23,7 @@ Here is what the fields mean:

 - ``name``
    is an identifier string. A new /proc file will be created with this
-   ``name below /proc/sys/fs/binfmt_misc``; cannot contain slashes ``/`` =
for
+   name below ``/proc/sys/fs/binfmt_misc``; cannot contain slashes ``/`` =
for
    obvious reasons.
 - ``type``
    is the type of recognition. Give ``M`` for magic and ``E`` for extensi=
on.
@@ -83,7 +83,7 @@ Here is what the fields mean:
       ``F`` - fix binary
             The usual behaviour of binfmt_misc is to spawn the
 	    binary lazily when the misc format file is invoked.  However,
-	    this doesn``t work very well in the face of mount namespaces and
+	    this doesn't work very well in the face of mount namespaces and
 	    changeroots, so the ``F`` mode opens the binary as soon as the
 	    emulation is installed and uses the opened image to spawn the
 	    emulator, meaning it is always available once installed,
=2D-
2.29.2

