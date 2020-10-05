Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526C1283EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgJESlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:41:01 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48009 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJESlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:41:01 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C4qDT3bBpz1qt4L;
        Mon,  5 Oct 2020 20:40:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C4qDS5R48z1r0lS;
        Mon,  5 Oct 2020 20:40:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dhxAh5FxZBrC; Mon,  5 Oct 2020 20:40:55 +0200 (CEST)
X-Auth-Info: wToZBNEoEF1rWN+IPsWKDZkac8E1RIC382M0Q6fDxQgtEkwRSbB5xQed0w7uOL0i
Received: from igel.home (ppp-46-244-175-195.dynamic.mnet-online.de [46.244.175.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  5 Oct 2020 20:40:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E303C2C2982; Mon,  5 Oct 2020 20:40:54 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
References: <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
X-Yow:  HOW could a GLASS be YELLING??
Date:   Mon, 05 Oct 2020 20:40:54 +0200
In-Reply-To: <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
        (Palmer Dabbelt's message of "Mon, 05 Oct 2020 09:39:51 -0700 (PDT)")
Message-ID: <87362stt1l.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 05 2020, Palmer Dabbelt wrote:

> On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
>> On Sep 14 2020, Aurelien Jarno wrote:
>>
>>> How should we proceed to get that fixed in time for 5.9? For the older
>>> branches where it has been backported (so far 5.7 and 5.8), should we
>>> just get that commit reverted instead?
>>
>> Why is this still broken?
>
> Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
> CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
> that's relevant here).

I don't see a boot failure either, but eventually you will get crashes
like this, and resources are not properly released:

[ 4560.936645] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 241626, size 16)!
[ 4560.945324] ------------[ cut here ]------------
[ 4560.949954] kernel BUG at mm/usercopy.c:99!
[ 4560.954030] Kernel BUG [#1]
[ 4560.956805] Modules linked in: nfsv3 nfs_acl rfkill mmc_block sf_pdma i2c_ocores virt_dma spi_sifive uio_pdrv_genirq uio loop drm drm_panel_orientation_quirks rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache af_packet mscc macsec macb ptp pps_core phylink of_mdio fixed_phy libphy pwm_sifive mmc_spi crc_itu_t crc7 of_mmc_spi mmc_core spi_bitbang sunrpc sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[ 4560.995103] CPU: 2 PID: 23806 Comm: nis Not tainted 5.8.10-1-default #1 openSUSE Tumbleweed (unreleased)
[ 4561.004563] epc: ffffffe00036140e ra : ffffffe00036140e sp : ffffffe004bc7d60
[ 4561.011679]  gp : ffffffe00127ee60 tp : ffffffe1b05d0000 t0 : ffffffe001297ca0
[ 4561.018886]  t1 : ffffffe001297c30 t2 : 0000000000000000 s0 : ffffffe004bc7d80
[ 4561.026093]  s1 : ffffffe00003afda a0 : 000000000000005b a1 : ffffffe1f7d67588
[ 4561.033298]  a2 : ffffffe1f7d6c108 a3 : 0000000000000000 a4 : ffffffe000043e80
[ 4561.040506]  a5 : ffffffe1f7d6be80 a6 : 0000000000000144 a7 : 0000000000000000
[ 4561.047712]  s2 : 0000000000000010 s3 : 0000000000000000 s4 : ffffffe00003afea
[ 4561.054918]  s5 : ffffffe1f7e00e80 s6 : 0000002af4a2c2e0 s7 : fffffffffffff000
[ 4561.062124]  s8 : 0000003ffffff000 s9 : ffffffe19f985400 s10: 0000000000000010
[ 4561.069329]  s11: ffffffe1f7e00e80 t3 : 0000000000038fa8 t4 : 0000000000038fa8
[ 4561.076533]  t5 : 0000000000000001 t6 : ffffffe00128e062
[ 4561.081832] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[ 4561.089821] ---[ end trace a7c93e7595e9c2cc ]---
[ 4561.095589] BUG: Bad rss-counter state mm:00000000c54f4c29 type:MM_ANONPAGES val:1

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
