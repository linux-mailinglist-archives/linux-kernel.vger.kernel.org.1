Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D902773C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIXOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:19:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59776 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgIXOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:19:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id C2C8929D17C
Subject: Re: [PATCH v3 16/16] ARM: Remove custom IRQ stat accounting
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernelci-results@groups.io, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-17-maz@kernel.org>
 <aa8ff875-bee8-26f8-46b0-df579f2067a7@collabora.com>
 <CAOMZO5COBv=JqxjvsNrqc66FeQqdVEd6=cWyy9zhAY=yNKKEvw@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <2a985dd2-9e56-605a-8ab7-a6ae35aba506@collabora.com>
Date:   Thu, 24 Sep 2020 15:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5COBv=JqxjvsNrqc66FeQqdVEd6=cWyy9zhAY=yNKKEvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2020 14:34, Fabio Estevam wrote:
> Hi Guillaume,
> 
> On Thu, Sep 24, 2020 at 6:01 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> 
>> This appears to be causing a NULL pointer dereference on
>> beaglebone-black, it got bisected automatically several times.
>> None of the other platforms in the KernelCI labs appears to be
>> affected.
> 
> Actually imx53-qsb is also affected:
> https://storage.kernelci.org/next/master/next-20200924/arm/imx_v6_v7_defconfig/gcc-8/lab-pengutronix/baseline-imx53-qsrb.html
> 
> kernelci marks it Boot result: PASS though.
> 
> Shouldn't kernelci flag a warning or error instead?

Thanks for bringing this up.  The status in the HTML log file is
a very coarse one, in this case the board booted "fine" since it
reached a login prompt.  The issue was detected later when
checking for errors in the kernel log.

But yes you're right, the issue is also impacting imx53-qsrb
indeed.  I didn't spot that because it was only reported as a
regression on staging.kernelci.org, whereas imx53-qsrb is in the
Pengutronix lab which is not sending results there at the moment.

The failures can be found on the production web dashboard though,
but not as regressions:

beaglebone-black:

  https://kernelci.org/test/case/id/5f6c7f1ab7c8c5472cbf9de9/

imx53-qsrb:

  https://kernelci.org/test/case/id/5f6c7ea6f89a9d0f4dbf9ddf/


I need to investigate why that is the case, knowing that the
regression was detected correctly on staging which is the
development KernelCI instance:

  https://staging.kernelci.org/test/plan/id/5f6bea67f724eb1b34dce581/


Thanks,
Guillaume


