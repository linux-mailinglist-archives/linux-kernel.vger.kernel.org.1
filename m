Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4FA2331C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgG3MOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:14:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgG3MOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:14:50 -0400
Message-Id: <20200730102337.888613724@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596111289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3jdMdqBVzAXea4ozYLU4U7+dIzC1u7E6DG02pekIDAE=;
        b=RINL3lofMTBKTziye/eRt2AqixN7UwL5WJncNC0vUP/yA11BfrfFcDyk4Z5vKcRxP3QHPw
        usnDHqUK7M+UWRw/0L4j+LS/UxX+elO39NQAzh8vIBJr1UGyy4t3+RLeQheLjwlQo1bNwF
        pcNaT+09hc8ppVIPyVRn/cEMEuy77mCN6RlNWJ+idSnLp0S5wsW83/cEl3z/FdiaOUqyKx
        4YwYxRKzFB8F9lp3AQePWLwRNcvnwgY1HTIOJJYmLVc6g2jfZTrA01zxjIEXvu65YwMs1O
        oeHUUaLdp8s6SckE4/SFFQBtOIpdl3eER2Fn5jLMxMz9lNXhpBlRdvbc7Ri9BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596111289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3jdMdqBVzAXea4ozYLU4U7+dIzC1u7E6DG02pekIDAE=;
        b=n8VaEACjuLkbNFCXGBLao3CDKfOCpmWOuCJRVucVzs+xwkD7d2o8Tu3/ZKlm+Qjz694JIE
        1TglhpneutrbazCg==
Date:   Thu, 30 Jul 2020 12:14:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V3 3/3] x86: Select POSIX_CPU_TIMERS_TASK_WORK
References: <20200730101404.956367860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move POSIX CPU timer expiry and signal delivery into task context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API

