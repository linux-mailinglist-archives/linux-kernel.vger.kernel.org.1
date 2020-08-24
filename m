Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3E2504FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHXRKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Aug 2020 13:10:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgHXRJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:09:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940281FB;
        Mon, 24 Aug 2020 10:09:57 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AADB13F71F;
        Mon, 24 Aug 2020 10:09:46 -0700 (PDT)
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused constant definitions
In-reply-to: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 24 Aug 2020 18:09:41 +0100
Message-ID: <jhjeenwdl7u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 24/08/20 16:39, Andy Shevchenko wrote:
> Compilation of almost each file ends up with
>
>  In file included from .../include/linux/energy_model.h:10,
>                 from .../include/linux/device.h:16,
>                 from .../drivers/spi/spi.c:8:
>  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
>     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>  ...
>
> Make compiler happy by annotating the static constants with __maybwe_unused.
>

That should see some use as long as the build is for SMP. This whole region
is guarded by #ifdef CONFIG_SMP, so an !SMP build shouldn't trigger this.

With what config/kernel are you getting this?
