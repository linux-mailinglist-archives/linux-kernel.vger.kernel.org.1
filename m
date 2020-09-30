Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0927E9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgI3N2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6EC221E8;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472320;
        bh=KHebwQrhnWQS8kf7lQllhn5MPwCnK0DbjhAhG6LIh/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcW1xvTg8PamgevOG/r6HWiQHqhI+xeOe9umZcZ+I8+DY+qLTaaGzHe+hnMH7qbap
         dnCBS3WLphJXhWCgB1zpuwIGtuwMxnxM1phDkrvuBkBJvdQofXX15iAzweWTZFYIl7
         P83RlnwuWVC7y66+ZFsE5JjVyDh7QSIzo9K9qc38=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XJd-HZ; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/52] math64.h: kernel-docs: Convert some markups into normal comments
Date:   Wed, 30 Sep 2020 15:24:41 +0200
Message-Id: <97e7afe71713d70c2399a7277a114c071e54a8e0.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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

