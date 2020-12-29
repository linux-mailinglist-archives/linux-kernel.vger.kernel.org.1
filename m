Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE112E72CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2RrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:47:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:36889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2RrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609263933;
        bh=SMvJUYLsYaFE8UbAU1ywRHM9rHku6Ga8cqoeePCgLjM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=ZV44uno3w8ibDGH2iYnugootpt73yt88Ox2UYvmyX6GkBZvx7P8SVcg6E4drtYSlv
         rx9BfSdk3WjNk/ROb1ipDisoEX8ntzZOZHaBMYp6ps8/i5dm2lzVCE43k9yptWsYaL
         tNyMR+ngznzzc/gFlr8Ri/HXLaTbI3ti470ESy3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.173.132]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1k3r6A0Etz-00sv7N; Tue, 29
 Dec 2020 18:45:33 +0100
Date:   Tue, 29 Dec 2020 18:45:29 +0100
From:   Helge Deller <deller@gmx.de>
To:     Kalesh Singh <kaleshsingh@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH] mm: fix extend calculation for move_page_tables()
Message-ID: <20201229174517.GA31435@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:mX03h7atanc4UE4P/M1gmVe202c5lrlo9ssG8IpDsB5+CVDMyIG
 c2NqXlNwXc9BlCpMHkAhLiV52+p0C0zgcOHSQQbTx0drbZ6fiX3sByhLo38FCwuBeSNL0ai
 keFJPWjFYtMeuZy88aQefYbHAnV62x0rHUUawDKqu3BnFiOPxcoWKr4E3sqp2T+LAlZg6wx
 xy9Lboba7zIjEiOhsou8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8IX/T319RtI=:pQnNCcbTgjkLClJwM4dyJV
 SxGpKWI/noO2/mtTZViOUS7B1auLdMU9gfpFcn8RW+CSV37h1pSra/c3jB+MeStuPHlndfHjp
 klE59jbxhQLwKPBNq/movySFs9rBjL7VCOSH3KHHgTCkpFX0JtQXeSoOiKei1U4Xt9JNtSgxl
 IxGodip1WKmsG/jGBdHtP69bfg10wW9QtVIl0hI4u4iZMiTe+5vJpNT8sIiGadVu4fF88Pt6V
 ZDDwVZXzFFVyTkaFjpsZs80FLc04XGnb8gm8sXviA+yvK+p/MpyuFJy0znxReOfBZDetjNSAJ
 ovtOZ6uzlKaMl2hPoVgwY3ejYMjpXT8XECfaQqz4FtHa1vTqv8KGsxnUkDPaCIAnPrIr8qXKG
 wlqCGWSB1ME/zuJVLRTKKb+4wws2maXojJsSaPs1/u/IYZ/1SXzUqONuFN5hLpVvIUjmpOI/j
 1vcyC9zAc+8O16v5u7wsdAjxWk7EiIr45ix7DYRqLQ2FCje2lpVTrVj9qHuFQ7GZCQ7OqQ0Og
 6ZxfKrox7YRBx0GjvOfF/zxCT3Y0ZjUK76hDR/61VrAfpRGKtJtck5HzvdpHSEwAJmUCyeiE1
 P15S5xnPSpH7E55dJF9QwhZL2B4Hwr6NhM72QNjtx6bo/4qZ/0JA7SLc0wSIIVm7C1OvCSfzI
 NMMdPNxraC1NFzYzeNVVJqBX7lSNXpc0NVDpEJw9dZ0pLPUINnpN9LZIJCzuNi1cyxIZI/KPg
 wWnBuhEqXlTMFj0XkAV99XIJyBOCYwFtdOrgD5YbrTJrffDbbzEKxYeX4gJ4qeDEERnjZKMoP
 cZqvWDiaOjHN/CBSmALLyg5sPZE3D3WrnWp49FkDS2eNqgUy35bHLZx/WswKZHnLirOnBn++1
 LkPZcPCy2c6MK3aZmfmw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On parisc the kernel fails to start the init process because in
shift_arg_pages() in fs/exec.c, move_page_tables() is called to e.g.
move pages from start addr 0xffeff000 to the new start addr 0xf9ccb000
with a length of 0x1000 bytes, but move_page_tables() instead returns
that it apparently moved 0x57000 bytes. Since the number of bytes is
different than the number of bytes which should have been moved,
shift_arg_pages() aborts with -ENOMEM.

Debugging shows that commit c49dd34018026 ("mm: speedup mremap on
1GB or larger regions") is the culprit.
In this commit, the extent calculation was tried to be optimized, but
got it wrong for this case.
The patch below reverts to the previous way to calculate the extent and
thus fixes the boot problem.

Fixes: c49dd34018026 ("mm: speedup mremap on 1GB or larger regions")
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

=2D--

diff --git a/mm/mremap.c b/mm/mremap.c
index c5590afe7165..f554320281cc 100644
=2D-- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -358,7 +358,9 @@ static unsigned long get_extent(enum pgt_entry entry, =
unsigned long old_addr,

 	next =3D (old_addr + size) & mask;
 	/* even if next overflowed, extent below will be ok */
-	extent =3D (next > old_end) ? old_end - old_addr : next - old_addr;
+	extent =3D next - old_addr;
+	if (extent > old_end - old_addr)
+		extent =3D old_end - old_addr;
 	next =3D (new_addr + size) & mask;
 	if (extent > next - new_addr)
 		extent =3D next - new_addr;
