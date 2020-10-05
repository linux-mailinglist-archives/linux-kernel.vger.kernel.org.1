Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BF283FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgJETpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgJETpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:45:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7400C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:45:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d6so38018plo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kPwILm2H0sETNXBahvwPUIdNPmK2c87ErCJPYr1DBUI=;
        b=m2E4KR0nmc7nJQL45uZ4PanuHrj5odtDbQBDOB9b+hB128UBGEFMMSZqSp5my3UeJA
         GHsHd5UHZwWED6mgBNJugsvH1Ea/rHiPQy/xjEouuwrAlG+gT/7gy3JwBDmGFzLH93CV
         Xm0PCwh54oNPtCkr0GLxjxGy2vLehqiElOI5qB1I7XaHI9tfTqMlZJ8nq4iU1rsCR/S7
         Mmao5mBGDbnzbTciPvzbnke+Yx+gdW62tHmYdDZDh9jJAGh1dfLDEcU48WcIC42RMRfT
         zXMNdOYHXkjTc9uXK0DMXgFv1Pv6FG1c84MxTpiQ1ruItd2tXUJpOif/HLfUaLrrkev6
         X44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kPwILm2H0sETNXBahvwPUIdNPmK2c87ErCJPYr1DBUI=;
        b=SJn7ixv1GAc84+7QyAE/0YJ6+eSTXtpSLTyzvYFFmTsaa+284c1AeHOj+q+JZ4+AG0
         ayD2s0CNMNeoQwfYNY4vAdihUdoGjvcxyp7qmmDIbSY5p0nk2s1nyPGY4cpEQtYCB4ls
         trySMXJQ9t6DfcwfGxfDmbOxm+H3J7V4S5hRDF65LdxYM27Cdih2TYICRSulUJS0WAkb
         zPgj6YpEkmI7SyD97GwTMrWd4m3z8D/cuvh2+9eRE6DzlWh0eyu2tUV/EaQ2W6DnLRB7
         iTX/bOp98De+oYO1wXvoCqSmoKoYqA2lQHQTumB0s4+9AZT0e/2Zg882QNbWaYmYmrQK
         bJzQ==
X-Gm-Message-State: AOAM532MtpmYU/Wm5uYuRAPtERLsi6576J4zAojf3gloJRch17Wj4CVn
        A+nuKAFcUuT9WSotaPkDotLqSA==
X-Google-Smtp-Source: ABdhPJw3SWHhkUaAg1XjvyB5XCCd63EQ7AAIIkxuPFRbDh3KD8mHwG2uISU/uJBrT0shZwpkiz1nGw==
X-Received: by 2002:a17:90a:be05:: with SMTP id a5mr1071892pjs.118.1601927153154;
        Mon, 05 Oct 2020 12:45:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 189sm470140pfw.123.2020.10.05.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 12:45:52 -0700 (PDT)
Date:   Mon, 05 Oct 2020 12:45:52 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Oct 2020 12:45:44 PDT (-0700)
Subject:     Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
In-Reply-To: <87362stt1l.fsf@igel.home>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-b2aa7eab-cb69-4113-8c32-b5fcbd7e9150@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 11:40:54 PDT (-0700), schwab@linux-m68k.org wrote:
> On Okt 05 2020, Palmer Dabbelt wrote:
>
>> On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
>>> On Sep 14 2020, Aurelien Jarno wrote:
>>>
>>>> How should we proceed to get that fixed in time for 5.9? For the older
>>>> branches where it has been backported (so far 5.7 and 5.8), should we
>>>> just get that commit reverted instead?
>>>
>>> Why is this still broken?
>>
>> Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
>> CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
>> that's relevant here).
>
> I don't see a boot failure either, but eventually you will get crashes
> like this, and resources are not properly released:
>
> [ 4560.936645] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 241626, size 16)!
> [ 4560.945324] ------------[ cut here ]------------
> [ 4560.949954] kernel BUG at mm/usercopy.c:99!
> [ 4560.954030] Kernel BUG [#1]
> [ 4560.956805] Modules linked in: nfsv3 nfs_acl rfkill mmc_block sf_pdma i2c_ocores virt_dma spi_sifive uio_pdrv_genirq uio loop drm drm_panel_orientation_quirks rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache af_packet mscc macsec macb ptp pps_core phylink of_mdio fixed_phy libphy pwm_sifive mmc_spi crc_itu_t crc7 of_mmc_spi mmc_core spi_bitbang sunrpc sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 4560.995103] CPU: 2 PID: 23806 Comm: nis Not tainted 5.8.10-1-default #1 openSUSE Tumbleweed (unreleased)
> [ 4561.004563] epc: ffffffe00036140e ra : ffffffe00036140e sp : ffffffe004bc7d60
> [ 4561.011679]  gp : ffffffe00127ee60 tp : ffffffe1b05d0000 t0 : ffffffe001297ca0
> [ 4561.018886]  t1 : ffffffe001297c30 t2 : 0000000000000000 s0 : ffffffe004bc7d80
> [ 4561.026093]  s1 : ffffffe00003afda a0 : 000000000000005b a1 : ffffffe1f7d67588
> [ 4561.033298]  a2 : ffffffe1f7d6c108 a3 : 0000000000000000 a4 : ffffffe000043e80
> [ 4561.040506]  a5 : ffffffe1f7d6be80 a6 : 0000000000000144 a7 : 0000000000000000
> [ 4561.047712]  s2 : 0000000000000010 s3 : 0000000000000000 s4 : ffffffe00003afea
> [ 4561.054918]  s5 : ffffffe1f7e00e80 s6 : 0000002af4a2c2e0 s7 : fffffffffffff000
> [ 4561.062124]  s8 : 0000003ffffff000 s9 : ffffffe19f985400 s10: 0000000000000010
> [ 4561.069329]  s11: ffffffe1f7e00e80 t3 : 0000000000038fa8 t4 : 0000000000038fa8
> [ 4561.076533]  t5 : 0000000000000001 t6 : ffffffe00128e062
> [ 4561.081832] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [ 4561.089821] ---[ end trace a7c93e7595e9c2cc ]---
> [ 4561.095589] BUG: Bad rss-counter state mm:00000000c54f4c29 type:MM_ANONPAGES val:1

Ah, I must have misunderstood.  I guess I just assumed "init crashes" meant on
boot, not just at some time later.  I just sent out a patch reverting this, LMK
if it fixes the issue.  I have some work stuff to do, but I'll try to find some
time tonight to look into fixing both of the bugs -- otherwise I'll just take
the revert (assuming it does actually fix the issue for you and passes the
tests).

I saw Atish post after I started writing this: I agree we need to sort of the
kernel's memory map, I just think it's too late for 5.9.

> Andreas.
