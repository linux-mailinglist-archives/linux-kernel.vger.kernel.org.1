Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716DD1FCA96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:16:21 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65424C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:16:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49n1Dw45gvz9sSg;
        Wed, 17 Jun 2020 20:16:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592388978;
        bh=VpnojUfZvzc1jD45rNjZmQOrHUNS3Ez8W1Vr9svA5gs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rVePF/SNLlw42VJ/FE8J8DFyaHW4QhbXRnFyFXRqXS63pbbSJDo6VqHs+2MIMVsHE
         ep7Pe0HPaC2DsqRxhK766JjJBFDXIabDUSDyJXNHNzFphcG96FfppS7JZkh6edam7U
         EPmYWcTP+j9VK89dBFP32gCxKZa1mE75MTtJ5TdkLxf4rj4HCmTrM32BkQ12RovoGM
         aZBlTysJvKS/kLOUlC/7lFILCgW8eE+FUdY3fL9Ij1ftnTxqszHIv5tUoaBFDvozKb
         ZxKQAMVV6GwgktrqBt8jGVwliMUYV6/qiASqbGX91gPSCv5YqGMehYIM+gsUlu7IQe
         UOkENCnwGe5Mw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
In-Reply-To: <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu> <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu> <20200616002720.GA1307277@ubuntu-n2-xlarge-x86> <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com> <20200616181630.GA3403678@ubuntu-n2-xlarge-x86> <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com>
Date:   Wed, 17 Jun 2020 20:16:43 +1000
Message-ID: <87bllidmk4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Simek <michal.simek@xilinx.com> writes:
> On 16. 06. 20 20:16, Nathan Chancellor wrote:
>> On Tue, Jun 16, 2020 at 04:45:20PM +0200, Michal Simek wrote:
>>> On 16. 06. 20 2:27, Nathan Chancellor wrote:
>>>> On Thu, May 21, 2020 at 04:55:52PM +0000, Christophe Leroy wrote:
>>>>> From: Michal Simek <michal.simek@xilinx.com>
>>>>>
>>>>> The latest Xilinx design tools called ISE and EDK has been released in
>>>>> October 2013. New tool doesn't support any PPC405/PPC440 new designs.
>>>>> These platforms are no longer supported and tested.
>>>>>
>>>>> PowerPC 405/440 port is orphan from 2013 by
>>>>> commit cdeb89943bfc ("MAINTAINERS: Fix incorrect status tag") and
>>>>> commit 19624236cce1 ("MAINTAINERS: Update Grant's email address and maintainership")
>>>>> that's why it is time to remove the support fot these platforms.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>
>>>> This patch causes qemu-system-ppc to fail to load ppc44x_defconfig:
<snip>

> I have took a look at it and was able to run qemu and also saw your
> issue. What happened is that when xilinx platforms were removed zImage
> is generated but it is not u-boot legacy image.
> Don't know details about zImage/uImage in ppc world but if you dump
> zImage you should see this.

<snip>

> It means only Xilinx platforms have been asking for uImage format and
> bamboo doesn't require it. It also looks like that qemu expect uImage
> format.

Yeah, prior to the patch the result of make ppc44x_defconfig contains
CONFIG_DEFAULT_UIMAGE, afterward it doesn't.

That means previously arch/powerpc/boot/zImage was just a hardlink to
the uImage:

  $ ls -li build~/arch/powerpc/boot/{z,u}Image
  7472 -rw-rw-r-- 2 michael michael 3073824 Jun 17 20:02 build~/arch/powerpc/boot/uImage
  7472 -rw-rw-r-- 2 michael michael 3073824 Jun 17 20:02 build~/arch/powerpc/boot/zImage

  $ file build~/arch/powerpc/boot/zImage
  build~/arch/powerpc/boot/zImage: u-boot legacy uImage,
  Linux-5.7.0-rc2-00247-g0bdad33d6\037\213\010, Linux/PowerPC, OS Kernel
  Image (gzip), 3073760 bytes, Wed Jun 17 10:14:32 2020, Load Address:
  0x00000000, Entry Point: 0x00000000, Header CRC: 0xF0283815, Data CRC:
  0x5E5A4D98

> You should know what format qemu expects.
> Anyway if you build it by make uImage and then pass it to qemu you
> should boot just fine.

Yep so you can explicitly build the uImage with:

$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux- O=out/ppc distclean ppc44x_defconfig uImage

> Or if bamboo requires uImage to be built by default you can do it via
> Kconfig.
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
> index 39e93d23fb38..300864d7b8c9 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -13,6 +13,7 @@ config BAMBOO
>         select PPC44x_SIMPLE
>         select 440EP
>         select FORCE_PCI
> +       select DEFAULT_UIMAGE
>         help
>           This option enables support for the IBM PPC440EP evaluation board.

Who knows what the actual bamboo board used. But I'd be happy to take a
SOB'ed patch to do the above, because these days the qemu emulation is
much more likely to be used than the actual board.

cheers
