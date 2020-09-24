Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216DA27772B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgIXQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:49:12 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:26898 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:49:11 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 8119E20008CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 16:49:09 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VAaoh+7n"
Date:   Thu, 24 Sep 2020 16:48:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1600966146;
        bh=Y10D90neOQngdhCpcc29Apq+nLgK9oeAEVdyUTw8os4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=VAaoh+7ny3E7HqyHBe2Dlll9BjVSG85I4124g5x9vB7Yq+Ea1FF8NqpS/SlK2F1NJ
         jf60y6Qu4lmWRkWNs15ZHx0qXgD2aJHHAM6qfk966O05emRTNA+xU8gob3azkYq4gu
         yos7zmeY75rlVGN8y1ZylcMhc+lYn5YeR5Psl1tQ=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH] fault-injection: handle EI_ETYPE_TRUE
Message-ID: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit af3b854492f351d1ff3b4744a83bf5ff7eed4920
("mm/page_alloc.c: allow error injection")
introduced EI_ETYPE_TRUE, but did not extend
 * lib/error-inject.c:error_type_string(), and
 * kernel/fail_function.c:adjust_error_retval()
to accommodate for this change.

Handle EI_ETYPE_TRUE in both functions appropriately by
 * returning "TRUE" in error_type_string(),
 * adjusting the return value to true (1) in adjust_error_retval().

Furthermore, simplify the logic of handling EI_ETYPE_NULL
in adjust_error_retval().

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 kernel/fail_function.c | 6 +++---
 lib/error-inject.c     | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 63b349168da7..4fdea01c0561 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -37,9 +37,7 @@ static unsigned long adjust_error_retval(unsigned long ad=
dr, unsigned long retv)
 {
 =09switch (get_injectable_error_type(addr)) {
 =09case EI_ETYPE_NULL:
-=09=09if (retv !=3D 0)
-=09=09=09return 0;
-=09=09break;
+=09=09return 0;
 =09case EI_ETYPE_ERRNO:
 =09=09if (retv < (unsigned long)-MAX_ERRNO)
 =09=09=09return (unsigned long)-EINVAL;
@@ -48,6 +46,8 @@ static unsigned long adjust_error_retval(unsigned long ad=
dr, unsigned long retv)
 =09=09if (retv !=3D 0 && retv < (unsigned long)-MAX_ERRNO)
 =09=09=09return (unsigned long)-EINVAL;
 =09=09break;
+=09case EI_ETYPE_TRUE:
+=09=09return 1;
 =09}

 =09return retv;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index aa63751c916f..c73651b15b76 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -180,6 +180,8 @@ static const char *error_type_string(int etype)
 =09=09return "ERRNO";
 =09case EI_ETYPE_ERRNO_NULL:
 =09=09return "ERRNO_NULL";
+=09case EI_ETYPE_TRUE:
+=09=09return "TRUE";
 =09default:
 =09=09return "(unknown)";
 =09}
--
2.28.0


