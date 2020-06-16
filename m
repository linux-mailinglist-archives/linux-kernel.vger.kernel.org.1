Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822581FBDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgFPSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFPSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:16:32 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:16:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d4so2293681otk.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcuAK03LOqO5mTPh575e+XVmEJ631aNvRC62w67+4Es=;
        b=VwXlS1g8JndYAbL6AkbODMzW9aRCCeCGS0qDzu9RlCSgpRk4sUz1xBpcwv3bWNtcPB
         W5PbX2EDusVm2vo3oUJSBM4wom1W/b3YCDLBAfKfoGGI9EC2NuLeh4tg7aiN4QaJJUbi
         a1vhJXJJ02M2DXWZ5xxm1S/yEeNog5tFnNQmKawPyccleEVlnq2MkNWb/BXT30lb4oSh
         qnEDSuE/QLwmUe2FJM+olU2Jipye8MCJbU7d5AMO8s5QufzyKU2y7qVm3ocuMb+ahVrI
         5EgNpM2mbvKXkj1x10zQh0QhEK2v/1Lww3KG8+vNLaoGZBEP1u8nVQwBYPE0ePKD9Akj
         0hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcuAK03LOqO5mTPh575e+XVmEJ631aNvRC62w67+4Es=;
        b=kI2vzLlJ12+Etb5tkZoHREHSv8egqJ54KbWMDdsXatsOK19i+PKJTIBNsjySIFpIdD
         tJs38Hxf5az1ohUMk34hr5/IU9yOsNRBY1k00SNAYxwsUcMN+5aZGYIX5rBb6XLDQK87
         FBQQw3i0LTfJ2aHWOajnVzM30y4malzwag3a3vU5uW8Ah7kDfV4S1b7vw1cMTcy31e7p
         +lBLPIYUaPy/ATpSJ9Dl+qVKaFyGSSdp137cpSN/JcFNRF9KmjEr3wK3x95vdUVlCx/2
         6nFWQwROg6/W6bYP9KOGbkcD4DvZ6GNyjHbz4BJo8HtDG8KAncvcriqn5qpar2bRjGbb
         ALMQ==
X-Gm-Message-State: AOAM5308RU/Nwm1OryARtLOWhP6rnsAD+v3ODuTLPflhCM3rm8o9lCmb
        ADwOibZnTx4AZXIZOEKVBtsJi/sg
X-Google-Smtp-Source: ABdhPJwoE+mTtd0wmJ6Kg/2ki2jL/MPCf6DRi0jct0cmYlu66QwZ4K5VQV/Otr0QY9SFijmmPVCXBw==
X-Received: by 2002:a9d:604e:: with SMTP id v14mr3605300otj.39.1592331391962;
        Tue, 16 Jun 2020 11:16:31 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id k84sm4329177oia.3.2020.06.16.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:16:31 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:16:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
Message-ID: <20200616181630.GA3403678@ubuntu-n2-xlarge-x86>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
 <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
 <20200616002720.GA1307277@ubuntu-n2-xlarge-x86>
 <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Jun 16, 2020 at 04:45:20PM +0200, Michal Simek wrote:
> 
> 
> On 16. 06. 20 2:27, Nathan Chancellor wrote:
> > On Thu, May 21, 2020 at 04:55:52PM +0000, Christophe Leroy wrote:
> >> From: Michal Simek <michal.simek@xilinx.com>
> >>
> >> The latest Xilinx design tools called ISE and EDK has been released in
> >> October 2013. New tool doesn't support any PPC405/PPC440 new designs.
> >> These platforms are no longer supported and tested.
> >>
> >> PowerPC 405/440 port is orphan from 2013 by
> >> commit cdeb89943bfc ("MAINTAINERS: Fix incorrect status tag") and
> >> commit 19624236cce1 ("MAINTAINERS: Update Grant's email address and maintainership")
> >> that's why it is time to remove the support fot these platforms.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > This patch causes qemu-system-ppc to fail to load ppc44x_defconfig:
> > 
> > $ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux- O=out/ppc distclean ppc44x_defconfig zImage
> > 
> > $ timeout --foreground 30s unbuffer \
> > qemu-system-ppc \
> > -machine bamboo \
> 
> Did you bisect it that you found that this patch is causing problem for
> you on any bamboo machine?
> 
> Or this was caused by the whole series?
> 
> Thanks,
> Michal

Yes, this conclusion was the result of the following bisect:

$ cat test.sh
#!/usr/bin/env bash

cd "${HOME}"/src/linux || exit 125

set -x

PATH=${HOME}/toolchains/gcc/10.1.0/bin:${PATH} \
make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux- O=out/ppc32 distclean ppc44x_defconfig zImage || exit 125

"${HOME}"/cbl/github/boot-utils/boot-qemu.sh -a ppc32 -k out/ppc32 -t 30s

$ git bisect start v5.8-rc1 v5.7
...

$ git bisect run test.sh
...

$ git bisect log
# bad: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
# good: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
git bisect start 'v5.8-rc1' 'v5.7'
# good: [ee01c4d72adffb7d424535adf630f2955748fa8b] Merge branch 'akpm' (patches from Andrew)
git bisect good ee01c4d72adffb7d424535adf630f2955748fa8b
# bad: [6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7] Merge tag 'dma-mapping-5.8-2' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad 6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7
# skip: [828f3e18e1cb98c68fc6db4d5113513d4a267775] Merge tag 'arm-drivers-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect skip 828f3e18e1cb98c68fc6db4d5113513d4a267775
# good: [c46241a370a61f0f264791abb9fc869016e749ce] powerpc/pkeys: Check vma before returning key fault error to the user
git bisect good c46241a370a61f0f264791abb9fc869016e749ce
# good: [3f0be4df50a7854a831c80a74d7cf2cfd61f2fde] Merge tag 'versatile-dts-v5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into arm/dt
git bisect good 3f0be4df50a7854a831c80a74d7cf2cfd61f2fde
# bad: [bd55e792de0844631d34487d43eaf3f13294ebfe] powerpc/module_64: Use special stub for _mcount() with -mprofile-kernel
git bisect bad bd55e792de0844631d34487d43eaf3f13294ebfe
# good: [303e6a9ddcdc168e92253c78cdb4bbe1e10d78b3] powerpc/watchpoint: Convert thread_struct->hw_brk to an array
git bisect good 303e6a9ddcdc168e92253c78cdb4bbe1e10d78b3
# good: [0755e85570a4615ca674ad6489d44d63916f1f3e] powerpc/xive: Do not expose a debugfs file when XIVE is disabled
git bisect good 0755e85570a4615ca674ad6489d44d63916f1f3e
# bad: [b4ac18eead28611ff470d0f47a35c4e0ac080d9c] powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple hv-24x7 events run
git bisect bad b4ac18eead28611ff470d0f47a35c4e0ac080d9c
# bad: [3aacaa719b7bf135551cabde2480e8f7bfdf7c7d] powerpc/40x: Don't save CR in SPRN_SPRG_SCRATCH6
git bisect bad 3aacaa719b7bf135551cabde2480e8f7bfdf7c7d
# bad: [1b5c0967ab8aa9424cdd5108de4e055d8aeaa9d0] powerpc/40x: Remove support for IBM 403GCX
git bisect bad 1b5c0967ab8aa9424cdd5108de4e055d8aeaa9d0
# good: [0bdad33d6bd7b80722e2f9e588d3d7c6d6e34978] powerpc/64: Refactor interrupt exit irq disabling sequence
git bisect good 0bdad33d6bd7b80722e2f9e588d3d7c6d6e34978
# bad: [2c74e2586bb96012ffc05f1c819b05d9cad86d6e] powerpc/40x: Rework 40x PTE access and TLB miss
git bisect bad 2c74e2586bb96012ffc05f1c819b05d9cad86d6e
# bad: [7ade8495dcfd788a76e6877c9ea86f5207369ea4] powerpc: Remove Xilinx PPC405/PPC440 support
git bisect bad 7ade8495dcfd788a76e6877c9ea86f5207369ea4
# first bad commit: [7ade8495dcfd788a76e6877c9ea86f5207369ea4] powerpc: Remove Xilinx PPC405/PPC440 support
