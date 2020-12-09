Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA02D4521
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgLIPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgLIPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:09:46 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C232C061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:09:06 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so2609969ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79/2jrypfqHh2ex0HWeRFQIgc+5jz50G2Xkqb1V3C4s=;
        b=AxsF0AS/C2w6AQnjQjWH1ODawHIswlZmOmW8/ig0ZhTpPtMMgmL5hT7o1UGDZnchpX
         QaTx7l01DuBOK+09rpybArRBMOGjKkESF80bpdK6JfIwi55OZ6njUkp4wBzgGnDG/5/N
         qc0XQ2iWIPYp0KWmSdfnnD8MGqLYI6/lDaO5xqqwtFcdt2hvczUG5VLSN9CkoPkf11FK
         CdonBLwwb3BUH07KlgXKfzWJmSDlaYpimyI3PNTAp8nXIMIdv4ggVIkDMYDDhJGNPe78
         mZTFMjLIr6/DGPW0qb+/p7DDhKWneMGpo13QOWjieOWcwgry5lXfYFrzm2xiXkyZNaXv
         oCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79/2jrypfqHh2ex0HWeRFQIgc+5jz50G2Xkqb1V3C4s=;
        b=rbb2bAmNq2ETnWz0caUiQpK02nIXf3KusIdJGLf2oCDOLTfdDk4ZleiSSpZgQNP9fk
         EhQdTozPdXGxnve50200hcMwr4M4IhZ/ph/XVMiArHnEF1PmAfF+fxXcPCBB7OnGWgjv
         OecCaeqRpj6niqgz4DtcT5KZcedT9HUKMa/K5YUbP0pCE2L3F9KWAyj8d16x2GJZGfQ6
         uvY92F7Lh1AUDtIbwP5+ZtjlDvHlLSb3uxHFHRVQm3aVfHJeKsnKr3MfZ6ZPzldRZbX+
         qLt4MsdQBMCZJl23wHQkKHtkNMABTE0+cQwdcCw6bFt63KYMAd4OXC27jqQ4nM7goTzZ
         rCLw==
X-Gm-Message-State: AOAM531mPUWdt0k2kBnO0bkT7nSxiCc2B161DZmpTCWgzop0x155/qCJ
        e42b1wjVPs65zk+CJExTZsLEKiLxzFJR/JO2bZbkMQ==
X-Google-Smtp-Source: ABdhPJwsrAbx//pTmhaEk+6TPSWTGQ8c5D5jVVHlcwz650vAClP+F5Qece/SACvDa7prNfMlOUffaj3C5a8Ys/aTm9o=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr2386437eju.375.1607526544599;
 Wed, 09 Dec 2020 07:09:04 -0800 (PST)
MIME-Version: 1.0
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
In-Reply-To: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Dec 2020 20:38:52 +0530
Message-ID: <CA+G9fYuK9a7gSWBmcc9DZ+sJEKYBhSLVYib5Qxk_+EC1ow_PyA@mail.gmail.com>
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 at 22:32, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> The directed MSIs are delivered to CPUs whose address is
> written to the MSI message data. The current code assumes
> that a CPU logical number (as it is seen by the kernel)
> is also that CPU address.
>
> The above assumption is not correct, as the CPU address
> is rather the value returned by STAP instruction. That
> value does not necessarily match the kernel logical CPU
> number.
>
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 743f257cf2cb..75217fb63d7b 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>  {
>         struct msi_desc *entry = irq_get_msi_desc(data->irq);
>         struct msi_msg msg = entry->msg;
> +       int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));

While building S390 the following kernel warning / error noticed
on stable -rc 5.4 branch with gcc-8, gcc-9 and gcc-10 and defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/6/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc' vmlinux
arch/s390/pci/pci_irq.c: In function 'zpci_set_irq_affinity':
arch/s390/pci/pci_irq.c:106:17: error: implicit declaration of
function 'smp_cpu_get_cpu_address'
[-Werror=implicit-function-declaration]
  106 |  int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime docker --target-arch s390 --toolchain gcc-9
--kconfig defconfig


metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
    target_arch: s390
    toolchain: gcc-9
    git_describe: v5.4.82-36-gc45075765dae
    kernel_version: 5.4.83-rc1


full build log link,
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/899272224

-- 
Linaro LKFT
https://lkft.linaro.org
