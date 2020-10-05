Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B87F284205
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgJEVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgJEVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:17:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612DC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 14:17:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so7735910pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R3FoEKph5/Q3zh1qrp1x58plkH4C/W9lj4keUROU3cc=;
        b=XzxTTE1wtNhw53A9/iFePIvAcbbSu+HVKVR5DHAVb9SRuPyIMeDNJJScDfbo3YBGzA
         neGayHxBTB8hPKq4ntKqfnA5r0RiDBgbN/QJzQMXDX6w+Cf8fTxBScRHxmjqNRkQdIJk
         BglxRAWtRA5v57pTecb/nTSengAobRq0GKBoFAHdWubYO9rel24WYpfOU+3Pmgy3Y59i
         jTj4bp85fm6bTpzYRNr5MdT5TL3iBzZBgT3AF5NTgLihovbkYMXvoC7uAfMcZ34D3xwD
         8pvELZ+XB+Li7mbQrkEPQkV9b/kDKBGR4YQ/LuyR2ocxCwkwEGfQjGDgmOz7wd6W3qBh
         d8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R3FoEKph5/Q3zh1qrp1x58plkH4C/W9lj4keUROU3cc=;
        b=reVsNh/nuSmxKmYXIQ8vtoCeZpOwtvj59X9t2AGC6AqsqNnUitThhu1wgXXJ69DxHp
         pN1XCXmRZ6HgswJmvXfLpQaQauSvoj2anYeQarGlQofksnd/PMxR/VSXfTOqIa01Hvv2
         uMXDE+Pa/ON5R0sIrLLNB9MAeuHtiYIKnc6iEQbrGmbcp7v9Vq7r76E2nufEA4unQ3hy
         f9Ye7HptEzR2gVtV6OaJX/97qBCVW5RPCACsCft/LYA9iDTAiRT15McMmJfTkjR7/bRS
         USC3r9EUkfJzuXoW3wCqyZ8EMcjXvZHTUgLn3r9CsszEcOeue/JFv0zuKLn5Umsz+oTj
         cykA==
X-Gm-Message-State: AOAM531waVR+UXj5e93emXsOrC2F7ymYVp9jUrxB5WHXHYBtQpwFE1Lg
        petBpFeNw2zn3RN+7WTC8RUsZQ==
X-Google-Smtp-Source: ABdhPJzqPxSu7Lo6DsMZ31HZZm4hY6RkD+7hfHkT7Ug0G/Ht4dwCV2BFR+3u9B+7D24nzWgpj4MoNQ==
X-Received: by 2002:a05:6a00:2d5:b029:13c:1611:653b with SMTP id b21-20020a056a0002d5b029013c1611653bmr1494841pft.13.1601932664202;
        Mon, 05 Oct 2020 14:17:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t9sm559534pgp.90.2020.10.05.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 14:17:43 -0700 (PDT)
Date:   Mon, 05 Oct 2020 14:17:43 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Oct 2020 14:17:41 PDT (-0700)
Subject:     Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
In-Reply-To: <CAOnJCUKa82Faf0DLfhR10i3dSJrQ6JZWwmCiLWTaAQf173CYwQ@mail.gmail.com>
CC:     schwab@linux-m68k.org, tycho@tycho.ws, aou@eecs.berkeley.edu,
        nickhu@andestech.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@linux.alibaba.com, guoren@kernel.org, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        greentime.hu@sifive.com, tglx@linutronix.de,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-e2ceb9e5-81ae-41b8-96c5-72112854f475@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 14:12:44 PDT (-0700), atishp@atishpatra.org wrote:
> On Mon, Oct 5, 2020 at 12:46 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Mon, 05 Oct 2020 11:40:54 PDT (-0700), schwab@linux-m68k.org wrote:
>> > On Okt 05 2020, Palmer Dabbelt wrote:
>> >
>> >> On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
>> >>> On Sep 14 2020, Aurelien Jarno wrote:
>> >>>
>> >>>> How should we proceed to get that fixed in time for 5.9? For the older
>> >>>> branches where it has been backported (so far 5.7 and 5.8), should we
>> >>>> just get that commit reverted instead?
>> >>>
>> >>> Why is this still broken?
>> >>
>> >> Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
>> >> CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
>> >> that's relevant here).
>> >
>> > I don't see a boot failure either, but eventually you will get crashes
>> > like this, and resources are not properly released:
>> >
>> > [ 4560.936645] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 241626, size 16)!
>> > [ 4560.945324] ------------[ cut here ]------------
>> > [ 4560.949954] kernel BUG at mm/usercopy.c:99!
>> > [ 4560.954030] Kernel BUG [#1]
>> > [ 4560.956805] Modules linked in: nfsv3 nfs_acl rfkill mmc_block sf_pdma i2c_ocores virt_dma spi_sifive uio_pdrv_genirq uio loop drm drm_panel_orientation_quirks rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache af_packet mscc macsec macb ptp pps_core phylink of_mdio fixed_phy libphy pwm_sifive mmc_spi crc_itu_t crc7 of_mmc_spi mmc_core spi_bitbang sunrpc sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>> > [ 4560.995103] CPU: 2 PID: 23806 Comm: nis Not tainted 5.8.10-1-default #1 openSUSE Tumbleweed (unreleased)
>> > [ 4561.004563] epc: ffffffe00036140e ra : ffffffe00036140e sp : ffffffe004bc7d60
>> > [ 4561.011679]  gp : ffffffe00127ee60 tp : ffffffe1b05d0000 t0 : ffffffe001297ca0
>> > [ 4561.018886]  t1 : ffffffe001297c30 t2 : 0000000000000000 s0 : ffffffe004bc7d80
>> > [ 4561.026093]  s1 : ffffffe00003afda a0 : 000000000000005b a1 : ffffffe1f7d67588
>> > [ 4561.033298]  a2 : ffffffe1f7d6c108 a3 : 0000000000000000 a4 : ffffffe000043e80
>> > [ 4561.040506]  a5 : ffffffe1f7d6be80 a6 : 0000000000000144 a7 : 0000000000000000
>> > [ 4561.047712]  s2 : 0000000000000010 s3 : 0000000000000000 s4 : ffffffe00003afea
>> > [ 4561.054918]  s5 : ffffffe1f7e00e80 s6 : 0000002af4a2c2e0 s7 : fffffffffffff000
>> > [ 4561.062124]  s8 : 0000003ffffff000 s9 : ffffffe19f985400 s10: 0000000000000010
>> > [ 4561.069329]  s11: ffffffe1f7e00e80 t3 : 0000000000038fa8 t4 : 0000000000038fa8
>> > [ 4561.076533]  t5 : 0000000000000001 t6 : ffffffe00128e062
>> > [ 4561.081832] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
>> > [ 4561.089821] ---[ end trace a7c93e7595e9c2cc ]---
>> > [ 4561.095589] BUG: Bad rss-counter state mm:00000000c54f4c29 type:MM_ANONPAGES val:1
>>
>> Ah, I must have misunderstood.  I guess I just assumed "init crashes" meant on
>> boot, not just at some time later.  I just sent out a patch reverting this, LMK
>> if it fixes the issue.  I have some work stuff to do, but I'll try to find some
>> time tonight to look into fixing both of the bugs -- otherwise I'll just take
>> the revert (assuming it does actually fix the issue for you and passes the
>> tests).
>>
>> I saw Atish post after I started writing this: I agree we need to sort of the
>> kernel's memory map, I just think it's too late for 5.9.
>>
>
> Yes. It is definitely a for-next material. I will try to take a stab
> at this if nobody else has an objection.

WFM.  Thanks!

>
>> > Andreas.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
