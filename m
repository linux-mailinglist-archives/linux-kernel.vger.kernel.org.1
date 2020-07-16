Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E4222CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGPUWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgGPUWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D8FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:22:16 -0700 (PDT)
Message-Id: <20200716202044.951928607@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1AHha6ykM2xHENZQU52BioHcs1MMCfPSN0kS6hVE16E=;
        b=Tp6ieF0frjN98DK940tBKf9dZ0KFugFwIlwpqRbkz1c8E2a2QwkjhPVQRP31mfTiRb5ARv
        ap+x1KE8sBmCkDK7lS83Jd9rPtKetZy5ET/59KtlHc2fPCHXdVR1MDhWUB8t+qmduiq56y
        C/Or/gdTwPoTTl0B7d1+oOi4QOq0cnXO573sOwNsdhBE2GiC+HeIhvvwrfM9UWBkNx+5rA
        kCsF2bn6thrCuGp4vwudMyLSsXNguMPgopCCz9X7s8tuiAuG8uOhE9670CSRzU8NhzGbCe
        olqIPxFS4jhr3fHxafjrGIAVNeCro+b7FwESc0qVLJ+BSY7MW/p288kqRmIk0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1AHha6ykM2xHENZQU52BioHcs1MMCfPSN0kS6hVE16E=;
        b=5MXu5iIKnitJixpId1DkFxKECQek5y5eh5KHVPQ0e61vmq5unWSGumBIaleSe7pd2YnBnx
        FnJD1R3cOeCecwDw==
Date:   Thu, 16 Jul 2020 22:19:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 5/5] x86: Select POSIX_CPU_TIMERS_TASK_WORK
References: <20200716201923.228696399@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move POSIX CPU timer expiry and signal delivery into task context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -224,6 +224,7 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
+	select POSIX_CPU_TIMERS_TASK_WORK
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB

