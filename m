Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E858290552
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407668AbgJPMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407655AbgJPMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6BC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:37:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602851870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=bHdGbwda/Tf95ESm9sgsxnndbQYDUzkNSb0GZm05SFU=;
        b=L0b7ayKLvS+r1NnT7BPggrpnk8HH+PtHBX8TS8oU4RuUJwMW25wrjPiL0yqzeBNrMS8edD
        U6CfMf7WTUGB9FcDnv9N+xS60dPSE2Ri0xD638jN/kDVpu21yxymxnmiKZcw3o23xA8Mul
        eIomt0tLz7CUIRx3k4LNOW4ZNUg1TCqrkzkKCV2KoFEVD1JxSl46Tt7s78eisTcgBQStCk
        rblaVb0jgInxlB6swNMOHDkYjg/PJ0JN4edHFXKDubDAD0FmzZWsDn4S/YYLxhfTy+95/x
        rG1zpQGmuY9XsVN4PN0F2agZv/aX+fKahiNGpGqI1lw8bNBFmBo4guX/UulXaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602851870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=bHdGbwda/Tf95ESm9sgsxnndbQYDUzkNSb0GZm05SFU=;
        b=8PEL/IWVp9Luujm9N88awRZHFvpbZrrmIzhBJGmBMVDwM51AerDjlVXQG3szVO1pzVTP2o
        LnFEuJMdweeqZNCw==
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michael =?utf-8?Q?We?= =?utf-8?Q?i=C3=9F?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
In-Reply-To: <20201014220502.GD23262@fieldses.org>
Date:   Fri, 16 Oct 2020 14:37:50 +0200
Message-ID: <87pn5itkgx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce,

On Wed, Oct 14 2020 at 18:05, J. Bruce Fields wrote:
> On Mon, Oct 12, 2020 at 05:13:08PM -0400, J. Bruce Fields wrote:
>> On Fri, Oct 09, 2020 at 10:08:15PM +0200, Thomas Gleixner wrote:
>> I'll give it a shot.
>
> I took your code above verbatim, but should I really be following the
> example of ktime_mono_to_any()?  (With the seqlock, and maybe also the
> more general prototype in case someone needs the other conversions.)--b.

Having ktime_boot/real_to_any() makes sense.

Vs. the sequence count: In ktime_mono_to_any() it's required for 32bit,
but now that I look at it again it's pointless for 64bit.

For ktime_real_to_any() and ktime_boot_to_any() the sequence count is
obviously mandatory for 32bit, but it's also needed for 64bit, because it
needs to apply two offsets.

So
      read();
      sub(offs_real)
      set_timeofday()
      add(offs_boot)
      consume_result()

is not any different from:

      read();
      sub(offs_real)
      add(offs_boot)
      set_timeofday()
      consume_result()

Same thing for suspend_resume() instead of set_timeofday()

The only case which needs the sequence count even on 64bit is:

      read();
      sub(offs_real)
      set_timeofday();
      suspend_resume();
      add(offs_boot)
      consume_result();

No matter what, the conversion is a best effort approach and only
accurate when the offsets did not change between the point where the
input time was acquired and the point of conversion. But that's not any
different to the approach you have so far in sunrpc.

Something like the untested below. Needs to be split in several patches
and gain the wrapper inlines.

Thanks,

        tglx
---
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -58,6 +58,7 @@ extern time64_t ktime_get_real_seconds(v
  */
 
 enum tk_offsets {
+	TK_OFFS_MONO,
 	TK_OFFS_REAL,
 	TK_OFFS_BOOT,
 	TK_OFFS_TAI,
@@ -68,6 +69,8 @@ extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
+extern ktime_t ktime_boot_to_any(ktime_t tboot, enum tk_offsets offs);
+extern ktime_t ktime_real_to_any(ktime_t treal, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -855,7 +855,10 @@ u32 ktime_get_resolution_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
 
-static ktime_t *offsets[TK_OFFS_MAX] = {
+static const ktime_t zero_offset;
+
+static const ktime_t * const offsets[TK_OFFS_MAX] = {
+	[TK_OFFS_MONO]	= &zero_offset,
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
 	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
@@ -864,8 +867,9 @@ static ktime_t *offsets[TK_OFFS_MAX] = {
 ktime_t ktime_get_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
-	ktime_t base, *offset = offsets[offs];
+	ktime_t base;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -885,8 +889,9 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset)
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
-	ktime_t base, *offset = offsets[offs];
+	ktime_t base;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -906,13 +911,26 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_
  * ktime_mono_to_any() - convert mononotic time to any other time
  * @tmono:	time to convert.
  * @offs:	which offset to use
+ *
+ * The conversion is a best effort approach and only correct when the
+ * offset of the selected target time has not changed since @tmono was
+ * read.
  */
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
-	ktime_t *offset = offsets[offs];
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
 	ktime_t tconv;
 
+	/*
+	 * 64bit can spare the sequence count. The read is safe
+	 * and checking the sequence count does not make it
+	 * more consistent.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT))
+		return ktime_add(tmono, *offset);
+
+	/* 32bit requires it to access the 64bit offset safely */
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		tconv = ktime_add(tmono, *offset);
@@ -922,6 +940,56 @@ ktime_t ktime_mono_to_any(ktime_t tmono,
 }
 EXPORT_SYMBOL_GPL(ktime_mono_to_any);
 
+static ktime_t ktime_to_any(ktime_t tfrom, ktime_t *from_offset,
+			    enum tk_offsets to_offs)
+{
+	const ktime_t *to_offset = offsets[to_offs];
+	unsigned int seq;
+	ktime_t tconv;
+
+	/*
+	 * Use the sequence count even on 64bit to keep at least the two
+	 * offsets consistent.
+	 */
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		tconv = ktime_sub(tfrom, *from_offset);
+		tconv = ktime_add(tconv, *to_offset);
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return tconv;
+}
+
+/**
+ * ktime_boot_to_any() - convert boot time to any other time
+ * @tboot:	time to convert.
+ * @offs:	which offset to use
+ *
+ * The conversion is a best effort approach and only correct when the boot
+ * time offset and the offset of the selected target time has not changed
+ * since @tboot was read.
+ */
+ktime_t ktime_boot_to_any(ktime_t tboot, enum tk_offsets offs)
+{
+	return ktime_to_any(tboot, &tk_core.timekeeper.offs_boot, offs);
+}
+EXPORT_SYMBOL_GPL(ktime_boot_to_any);
+
+/**
+ * ktime_real_to_any() - convert real time to any other time
+ * @treal:	time to convert.
+ * @offs:	which offset to use
+ *
+ * The conversion is a best effort approach and only correct when the real
+ * time offset and the offset of the selected target time has not changed
+ * since @treal was read.
+ */
+ktime_t ktime_real_to_any(ktime_t treal, enum tk_offsets offs)
+{
+	return ktime_to_any(treal, &tk_core.timekeeper.offs_real, offs);
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_any);
+
 /**
  * ktime_get_raw - Returns the raw monotonic time in ktime_t format
  */
