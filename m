Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD482AAB2B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 14:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKHN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 08:27:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:41321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHN1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 08:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604842057;
        bh=T7Xe8tav6QRhkQpuspeX38ghh0S5/oNx/90ZgXYVPDo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=B9xVFzuiAMPs8rMUXWhX/WI7k82cOCRxG7YF+X3CBn1SR92zBGaTcCwdRgxxqWLOV
         C7qCH2nOempCIesbnYn92I1S9Y5uII30HfUnks1RWWgF4u48MqNCWuDEyBTJwTnGsT
         7kZrWPt6M9bUinVxcyO6ML4E0PnSw61hBQWiOiOM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1kopc92oFM-00Uv9S; Sun, 08
 Nov 2020 14:27:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: link ubifs-authentication.rst without .rst extension
Date:   Sun,  8 Nov 2020 14:24:14 +0100
Message-Id: <20201108132415.1789142-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikyazVVcjfy9C1ET4A6XP9MiiFh3O7M5WELcj95LGGrlI40OG2N
 daAdwDZta8Z6/ALshIGbpdJe6mqPs6wyZSDI6+rx3n7VS/pOueZ4ywYkqIcaamma319cE4N
 1195lBYUAzNQjMWym0zl4OvSyEYsp+Y3htjF2qc+f8UZQVlU0gjOHXsUljhnyJYrdWfYc7u
 FF0xYCv87WbYs70yZ/umg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ct/SGRPJ0hk=:IqDQUjeIbSnuuiIjlQhtCw
 TTjFEGRbJB2cU5/mLItVDIAPKGRXyhan5A7P61Y2v/EheHEJ7ZogQF9qyFVvkVCqmMmHLEljw
 eJgABtEDegk+VP3qeaWzt07L9uXHON5tD7jL7MzQvKOecv15xZLu0a6HXeQ7/kcWJtMAd2tax
 ZoTxcgaGy0rkH02guItmIjTEDynnlWSChfgKpCdYLyhV8Qv/R0AtYapdtd+Inl8ue/FSQ4OQ3
 KkRRNczY9RxpeM5KjtqPwuUpe8xXPDVa8dnNmgLxSJMHSydfMYMBLDb/o20APqKzWnMKLHa07
 /IFMcGpNEouH1ygJwXsf9JUUPDifPuZtDBqLzP0WloEnPG2Cne0zwUiC8q8i6SGGB8+WuDufb
 xRvShvAjlc2sfq0kolpNlX4bejGQPaEt70dZ0VRE28vHVpKB6wSkCPQhn4AiB/qWygVx9GJ87
 q9sndKhanPD2coD4gb1CmIyAmDBbGMD9QS/WOHqt9B/YEYwoHbEMwkmTmzABxhH8uPCuQyXKC
 J/V240a+6r+hmDCLUxEUpINtalOIIwc1VBBOwlZpq88lji8dw0QsvWdegskGM9Bihp8A6t2dE
 PXnHideDj+d5NMYcYLWIQulMe5PPF2cddv4LkXaB0tTbGR5CZWKYHr2i7KpPFjiY5hcaHODQP
 aLvF+mpa9an/8WK6TdB0XZRjPRoq5yWfY2zCetCB4G8vrcZNoibw8XOc2fQKnouPn8gM6Z8hb
 AJM9LfvBQnsF67yPVZZqvubxiUD+0BwdCmn4fVrzIn3w0MaJiwt9WHI42RO8OC2zwB5ifuNUe
 k2UJD8Mk5MODD7eK0+CuRyqeomnwbB7skb6hml8XAqJoaUAex5zVXmajZmFneYYhhkMwWwT6X
 ABfh6aUqU2cM/dI4YA8BT3QyBYycQBUewP2WpWo84=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying the .rst extension doesn't cause any problems AFAICT, but
it's uncommon.

Fixes: 688f118e3139f ("docs: filesystems: convert ubifs-authentication.rst=
.txt to ReST")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyste=
ms/index.rst
index 98f59a8642420..7be9b46d85d9b 100644
=2D-- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -113,7 +113,7 @@ Documentation for filesystem implementations.
    sysv-fs
    tmpfs
    ubifs
-   ubifs-authentication.rst
+   ubifs-authentication
    udf
    virtiofs
    vfat
=2D-
2.28.0

