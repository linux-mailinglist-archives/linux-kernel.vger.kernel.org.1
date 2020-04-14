Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B31A8E67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 00:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634294AbgDNWMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 18:12:51 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50997 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634196AbgDNWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:12:35 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CD6FB80237;
        Wed, 15 Apr 2020 10:12:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1586902347;
        bh=+6kc3E2+ilGoFnJMFyMnA2X2aiLhEyeMzGGPuTXvRew=;
        h=From:To:Cc:Subject:Date;
        b=S4W+3eigkdzrdebmXDJLW5kH0mWWG7KovQ+ODdUsueM28gRqND6Sr71eeL/JdSXUC
         TEdTIkaUD6LfiH5fH3/gwZFWwu69f398p0pd2fv6BqHwY5Qv/wCIMFwHfxbox1biPr
         KhAh1hFuU+XCFnZxDsZJA2rH2MqQXvqbYzxN25YlLYmRvccjJOowJd5heSgXknudFu
         rWbySK8aZ7WprwU2dZgSXO8xqZcKzccLlFQU5FE4+21PBrFTK3YgHLvNO73tqGrkIs
         UHrSr3fZqeW+5u9qBj/qpm580w2PAJW/CzgpAqH+kHYX6zkX4iZT1cFzhx92CG/z+5
         LWYQb14RMS9EQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e96354b0000>; Wed, 15 Apr 2020 10:12:27 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 0991113EF08;
        Wed, 15 Apr 2020 10:12:27 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8938C28006C; Wed, 15 Apr 2020 10:12:27 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, tglx@linutronix.de, Jason@zx2c4.com, arnd@arndb.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] docs: timekeeping: Use correct prototype for deprecated functions
Date:   Wed, 15 Apr 2020 10:12:22 +1200
Message-Id: <20200414221222.23996-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct prototypes for do_gettimeofday(), getnstimeofday() and
getnstimeofday64(). All of these returned void and passed the return
value by reference. This should make the documentation of their
deprecation and replacements easier to search for.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/core-api/timekeeping.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-=
api/timekeeping.rst
index c0ffa30c7c37..729e24864fe7 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -154,9 +154,9 @@ architectures. These are the recommended replacements=
:
=20
 	Use ktime_get() or ktime_get_ts64() instead.
=20
-.. c:function:: struct timeval do_gettimeofday( void )
-		struct timespec getnstimeofday( void )
-		struct timespec64 getnstimeofday64( void )
+.. c:function:: void do_gettimeofday( struct timeval * )
+		void getnstimeofday( struct timespec * )
+		void getnstimeofday64( struct timespec64 * )
 		void ktime_get_real_ts( struct timespec * )
=20
 	ktime_get_real_ts64() is a direct replacement, but consider using
--=20
2.25.1

