Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2749C2B57AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKQDEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:04:48 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16112 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKQDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:04:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb33dd40000>; Mon, 16 Nov 2020 19:04:52 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 03:04:43 +0000
Received: from sandstorm.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Nov 2020 03:04:42 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     <jarkko.sakkinen@iki.fi>
CC:     <akpm@linux-foundation.org>, <andreyknvl@google.com>,
        <ast@kernel.org>, <clang-built-linux@googlegroups.com>,
        <daniel@iogearbox.net>, <elver@google.com>, <jarkko@kernel.org>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <masahiroy@kernel.org>, <miguel.ojeda.sandonis@gmail.com>,
        <natechancellor@gmail.com>, <ndesaulniers@google.com>,
        <sedat.dilek@gmail.com>, <vincenzo.frascino@arm.com>,
        <will@kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Date:   Mon, 16 Nov 2020 19:04:27 -0800
Message-ID: <20201117030427.61981-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104013447.GA21728@kapsi.fi>
References: <20201104013447.GA21728@kapsi.fi>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605582292; bh=p723JtS1pJNVabNwPxJOJJ9MW40U8eP5btKJWk1846o=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=h6SG+P3fwWiJQPLj7/ZIQAwecBaI1oNF0DJ6T+ljGCzRXbkm8LFDMApUWRLcoPMqM
         udVkSjFASc2KiIHWG/eQ1cWu99N031pnd49g2iwvmoT6tUAFQ85OpxA1fT7puID4/g
         hyUKn5vjMowxvpworxMFWf+h2EtmA10Cx+H0Ty4UESclYA8iHrOcpV1OQICgELptyJ
         dXo80uKYV69tuxm0SIIro3gd0kgfJwWQiMLTgGkOjSt2xKtk/UBYj/30byeBDz11Zw
         DRfAQwgJOlQGNiBep3Gv5ArmOAuok6zr62JLwKVRl08LHBJRX2yJWoDFlGMoDt5asd
         B0BPpzS6Ys/TQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just ran into this and it's a real pain to figure out, because even
with the very latest Fedora 33 on my test machine, which provides clang
version 11.0.0:

$ clang --version
clang version 11.0.0 (Fedora 11.0.0-2.fc33)
Target: x86_64-unknown-linux-gnu

...the bpftrace program still chokes on some, but not all commands, in
ways that invisible to normal debugging. For example:

$ sudo bpftrace -e 'tracepoint:syscalls:sys_enter_vmsplice { @[kstack()]
=3D count(); }'
/lib/modules/5.10.0-rc4-hubbard-github+/source/include/linux/compiler-clang=
.h:12:3:
error: Sorry, your version of Clang is too old - please use 10.0.1 or
newer.

But Jarkko's recommended fix works! In other words, applying the diff
below fixes it for me. So I'm replying in order to note that the problem
is real and hoping that the fix is applied soon.


diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index dd7233c48bf3..c2228b957fd7 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -7,9 +7,11 @@
 		     + __clang_minor__ * 100	\
 		     + __clang_patchlevel__)
=20
+#ifndef __BPF_TRACING__
 #if CLANG_VERSION < 100001
 # error Sorry, your version of Clang is too old - please use 10.0.1 or new=
er.
 #endif
+#endif
=20
 /* Compiler specific definitions for Clang compiler */
=20


thanks,
--
John Hubbard
NVIDIA
