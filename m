Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8728F9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391816AbgJOTlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 15:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391809AbgJOTle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:41:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 262B9206D9;
        Thu, 15 Oct 2020 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790894;
        bh=+EMalpWr2Ka81KeEZ2XybfpF9n2q64cluqtKKXP/XXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yRz4wRgxdQ1EfHnJNpYYmj4rE9Ezb70ZaiKj6v6QdCOr/F59VaErxZyPbljsKri/T
         keAbZhMi08sQDrjL8DdA563p1SZSx8/FKgQqSpQXaYOCt9q9WiPjJd31H1Yof1NMDa
         UFN6IuiT/+qRj5Ok6PYOWHdFnWY6zFsIIXrdaBkQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kT980-001TIX-6Q; Thu, 15 Oct 2020 20:41:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Oct 2020 20:41:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <20201015171829.GB5636@duo.ucw.cz>
References: <20201015101222.GA32747@amd>
 <87imbba7qk.fsf@nanos.tec.linutronix.de>
 <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
 <20201015171829.GB5636@duo.ucw.cz>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pavel@ucw.cz, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-15 18:18, Pavel Machek wrote:
> Hi!
> 
>> > > I'm getting build problems in 5.10-rc0 in config for n900. ARM board.
>> > >
>> > > CONFIG_SMP=y
>> > > CONFIG_SMP_ON_UP=y
>> 
>> On its own, this doesn't break anything with multi_v7_defconfig.
> 
> I sent config off-list. Let me know if it does not arrive or if you
> need more info.

Try this for size:

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10a5aff4eecc..db923e0da162 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -81,6 +81,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS

  # Generic IRQ IPI support
  config GENERIC_IRQ_IPI
+	select IRQ_DOMAIN_HIERARCHY
  	bool

  # Generic MSI interrupt support


         N,
-- 
Jazz is not dead. It just smells funny...
