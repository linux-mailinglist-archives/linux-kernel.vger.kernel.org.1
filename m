Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61071284D39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgJFOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC0021789;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=gUMKHRsSkag9sGYAdZZcK6zac528ogHWJuf9idLgph4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwvUNQFc/rdALpIypZ/l0mFipjAwwuC4c3AGPYN2P1K7J31Z+xo8KVrPHmon2MdFo
         QWYSTfRkfQ9iiCahnqHVokepePEZq8yeRIrlNy7NFggtV9Ez6cDhhvyb7SJOv22Gpf
         p6i5x9oWmsTinXuEdIKd/qUKCmRSCfkPOi0QUKnM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019FN-Uv; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/52] math64.h: kernel-docs: Convert some markups into normal comments
Date:   Tue,  6 Oct 2020 16:03:16 +0200
Message-Id: <6eb8eefed58512d53ee65738b4155255e24d818d.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several functions at math64.h that are also
defined at div64.c. As both are included at kernel-api.rst,
Sphinx 3.x complains about symbol duplication:

	./lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'div_s64_rem'.
	./lib/math/div64.c:104: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'div64_u64_rem'.
	./lib/math/div64.c:144: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'div64_u64'.
	./lib/math/div64.c:172: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'div64_s64'.

In order to avoid Sphinx warnings about duplication, change the kernel-doc
markups to just comments at math64.h.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/math64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 3381d9e33c4e..66deb1fdc2ef 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -28,7 +28,7 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 	return dividend / divisor;
 }
 
-/**
+/*
  * div_s64_rem - signed 64bit divide with 32bit divisor with remainder
  * @dividend: signed 64bit dividend
  * @divisor: signed 32bit divisor
@@ -42,7 +42,7 @@ static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 	return dividend / divisor;
 }
 
-/**
+/*
  * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
  * @dividend: unsigned 64bit dividend
  * @divisor: unsigned 64bit divisor
@@ -56,7 +56,7 @@ static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 	return dividend / divisor;
 }
 
-/**
+/*
  * div64_u64 - unsigned 64bit divide with 64bit divisor
  * @dividend: unsigned 64bit dividend
  * @divisor: unsigned 64bit divisor
@@ -68,7 +68,7 @@ static inline u64 div64_u64(u64 dividend, u64 divisor)
 	return dividend / divisor;
 }
 
-/**
+/*
  * div64_s64 - signed 64bit divide with 64bit divisor
  * @dividend: signed 64bit dividend
  * @divisor: signed 64bit divisor
-- 
2.26.2

