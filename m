Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C31DA490
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgESW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 18:29:29 -0400
Received: from foss.arm.com ([217.140.110.172]:42462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgESW33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:29:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F318030E;
        Tue, 19 May 2020 15:29:28 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A10343F52E;
        Tue, 19 May 2020 15:29:27 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-2-maz@kernel.org> <jhj8shnr28o.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 01/11] genirq: Add fasteoi IPI flow
In-reply-to: <jhj8shnr28o.mognet@arm.com>
Date:   Tue, 19 May 2020 23:29:25 +0100
Message-ID: <jhj7dx7r22i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/20 23:25, Valentin Schneider wrote:
> Tied to the following patch, does that want something like
>
> +	if (!irq_settings_is_no_accounting(desc))
> +		__kstat_incr_irqs_this_cpu(desc);
> +

And ofc after updating my inbox I see this has already been suggested, oh
well.
