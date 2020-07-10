Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB621BE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGJT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 15:58:38 -0400
Received: from foss.arm.com ([217.140.110.172]:37510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgGJT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:58:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D17B631B;
        Fri, 10 Jul 2020 12:58:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3933F819;
        Fri, 10 Jul 2020 12:58:36 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <jhjmu4rgg04.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 00/17] arm/arm64: Turning IPIs into normal interrupts
In-reply-to: <jhjmu4rgg04.mognet@arm.com>
Date:   Fri, 10 Jul 2020 20:58:27 +0100
Message-ID: <jhjpn93kuqk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/06/20 19:24, Valentin Schneider wrote:
> I have a few extra nits/comments in some patches, but it's all fairly minor
> so FWIW you can also add, for patches [01-10, 14-15]:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> I haven't really looked at those other irqchips, but I can give it a shot
> if no one else shows up. Also I'll most likely look at the arm side, but
> I'm afraid I'm too well-done right now to pay much more attention to
> details.

Had a look at the arm side (and a took a refresher on the arm64 side);
LGTM, so you can extend that to: [01-10, 14-17].
