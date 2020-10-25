Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F018129820F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416596AbgJYOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416579AbgJYOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:25:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A7C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 07:25:46 -0700 (PDT)
Date:   Sun, 25 Oct 2020 14:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603635942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3oHQmFLI3ZWvwlX7k40gjcfNBGSMCodAFSsSZZO0ttc=;
        b=eI5OXQK1YeZ+hMltjkuOadUpumB8YFpFPMx4Rd4JJR2DElKQDSDMCvWtnUQ501uOE2udAO
        pki0w3+ZeCzO4SE7uTzY0OOJmHSGcPnoePQw2EWDBw5JkXP6/TBtQiTtCTh9bK5rI+14VO
        OJ2lJ3YDE1AaTnxpOpKOhkYhUdg+JlKYtsrYzz+Fui6zsSU6kwEzLbd0zU1GSzqc7GrhJC
        fLMaq6hBQGL5OdDW1rMVf1EmAofcvEMzU2mQ9Q7ocS3cguOP6KIk3EjkCXFCOAWMyNi3qb
        ebgpphI83rZOErqanoD/ToS8eETiJO68/BenIofFeM3ohHN/VH5xXGbR3/usDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603635942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3oHQmFLI3ZWvwlX7k40gjcfNBGSMCodAFSsSZZO0ttc=;
        b=vRjJyPxOpyNV+KNp0BMglm2yjAv4GxPS3v6lhrik60bl7z9e4hnqYSQeMN8JnNK4efe1j6
        tXX0siHuRTq3/9DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.10-rc1
References: <160363590465.1234.11586095980767794789.tglx@nanos>
Message-ID: <160363590585.1234.15412286970681035533.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-25

up to:  f3d301c1f2f5: perf: correct SNOOPX field offset


A single fix to compute the field offset of the SNOOPX bit in the data
source bitmask of perf events correctly.

Thanks,

	tglx

------------------>
Al Grant (1):
      perf: correct SNOOPX field offset


 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..b95d3c485d27 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
 /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT	37
+#define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
 #define PERF_MEM_LOCK_NA	0x01 /* not available */

