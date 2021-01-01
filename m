Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469172E8404
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 15:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAAOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 09:48:43 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47083 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbhAAOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 09:48:42 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvLie-001psl-VO; Fri, 01 Jan 2021 15:47:56 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvLie-003IBd-6y; Fri, 01 Jan 2021 15:47:56 +0100
Subject: Re: [sh] smp-shx3.c: error: ignoring return value of 'request_irq',
 declared with attribute warn_unused_result
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sh@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <CA+G9fYuNKqyvku1im6_zS5PjK9nG3Jf6qNwpQjaB8WRWO5BXzA@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <b516dd0d-787e-96bc-0f0d-3811c4be1642@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 15:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYuNKqyvku1im6_zS5PjK9nG3Jf6qNwpQjaB8WRWO5BXzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Naresh!

On 12/9/20 6:26 PM, Naresh Kamboju wrote:
> Linux next 20201209 tag the arch 'sh' defconfig build failed to build with
> gcc-8, gcc-9 and gcc-10.
> 
> arch/sh/kernel/cpu/sh4a/smp-shx3.c: In function 'shx3_prepare_cpus':
> arch/sh/kernel/cpu/sh4a/smp-shx3.c:76:3: error: ignoring return value
> of 'request_irq', declared with attribute warn_unused_result
> [-Werror=unused-result]
>    request_irq(104 + i, ipi_interrupt_handler,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         IRQF_PERCPU, "IPI", (void *)(long)i);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I can't reproduce this issue on Linus' current tree as of today.

Maybe the issue has been fixed in the meantime?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

