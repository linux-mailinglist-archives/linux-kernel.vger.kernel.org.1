Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1C2EA911
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbhAEKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbhAEKoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:44:01 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD5E22515;
        Tue,  5 Jan 2021 10:43:20 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kwjo5-005Pae-Vx; Tue, 05 Jan 2021 10:43:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jan 2021 10:43:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        "David S. Miller" <davem@davemloft.net>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v7 0/7] arm64: Add framework to turn an IPI as NMI
In-Reply-To: <CAFA6WYNn0+yxntkebqDVnOoq50gxY4Zvi1wGLAZTJyWGc7VLkw@mail.gmail.com>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYNn0+yxntkebqDVnOoq50gxY4Zvi1wGLAZTJyWGc7VLkw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f1aae58230a81e63cd380d1a45d5a2ee@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, linux@armlinux.org.uk, tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, daniel.thompson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-05 10:34, Sumit Garg wrote:

> Do you have any further feedback on this patch-set?

None at the moment. We have tons of issues to solve with the arm64
interrupt entry code vs instrumentation at the moment, so it is
pretty much at the bottom of the priority list for now.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
