Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC52841F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgJEVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:12:56 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 14:12:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so1732549ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hKXwSMve9PnldoH43kS3Xgw5qsEbRZ3Kf03jpGjBYtg=;
        b=kdzNUrb1DhZ2jENYGiwAQKI6NwynyshSmiBq14W8rPg2MF0psG+TQ2FRmPIcYQW/bm
         YdinuQL1h+9HkZZ+MIFLcgfrLEpZT4Se5cjqeZOREyJ9Yx4wGfhrrE0KK9jDsBVjSGbd
         hlrOhl31YH5Otjhzo7Sg4w3G7dNl7mQUad1gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hKXwSMve9PnldoH43kS3Xgw5qsEbRZ3Kf03jpGjBYtg=;
        b=cDGCQwq4CwG0mvfaJKwFlKF+Gk/x87fXoIvzVLrOfyguRigsfxouiUG/sYgWcTkEf1
         UkZQPXQrcXURZ3YMRdimLvek5/6oPT/Bkamfzagz/8kZGlQFRG+yCOoEIE8glcNgBtbR
         ZU2B7qbMtut1HNhRmpZJZjao68zQ3oVRzpapAqPUtqh5WqgclkDvH+B3DQeclR94+bOy
         qb5txsMA5XyWH5p6LNTe9xoZebQyUAfrWWa/Y2hy4foWnKKBkDFfmyX0epMzqZrpYo2e
         TG7WAdCN1fP0fOlqqOqFRoNnbiifDGlN8pl+8Nt7Q+MTn8d4J3daV5NecziAg7mOxIcX
         qbHQ==
X-Gm-Message-State: AOAM531wTLcuHdNiGTDiGlr5bxrfhesMy9sAwyVBF7I7j3RuJe5OFV+v
        bs0p/0oC16KpiBSfxaaVds0kmhX1G+tKd/pKNfR+
X-Google-Smtp-Source: ABdhPJzIPIQeIy/04Z4P4HcGGP5E5bBjfX0fewLMGLvvvCgeX+bqmqNmYXQ/+bGXmMYqx2Lldqxmz4h9L1DJTUt3lrs=
X-Received: by 2002:a05:6e02:54d:: with SMTP id i13mr991738ils.219.1601932375822;
 Mon, 05 Oct 2020 14:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <87362stt1l.fsf@igel.home> <mhng-b2aa7eab-cb69-4113-8c32-b5fcbd7e9150@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-b2aa7eab-cb69-4113-8c32-b5fcbd7e9150@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 5 Oct 2020 14:12:44 -0700
Message-ID: <CAOnJCUKa82Faf0DLfhR10i3dSJrQ6JZWwmCiLWTaAQf173CYwQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 12:46 PM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Mon, 05 Oct 2020 11:40:54 PDT (-0700), schwab@linux-m68k.org wrote:
> > On Okt 05 2020, Palmer Dabbelt wrote:
> >
> >> On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
> >>> On Sep 14 2020, Aurelien Jarno wrote:
> >>>
> >>>> How should we proceed to get that fixed in time for 5.9? For the old=
er
> >>>> branches where it has been backported (so far 5.7 and 5.8), should w=
e
> >>>> just get that commit reverted instead?
> >>>
> >>> Why is this still broken?
> >>
> >> Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 w=
ith just
> >> CONFIG_HARDENED_USERCPOY=3Dy in addition to defconfig (on QEMU, though=
 I doubt
> >> that's relevant here).
> >
> > I don't see a boot failure either, but eventually you will get crashes
> > like this, and resources are not properly released:
> >
> > [ 4560.936645] usercopy: Kernel memory overwrite attempt detected to ke=
rnel text (offset 241626, size 16)!
> > [ 4560.945324] ------------[ cut here ]------------
> > [ 4560.949954] kernel BUG at mm/usercopy.c:99!
> > [ 4560.954030] Kernel BUG [#1]
> > [ 4560.956805] Modules linked in: nfsv3 nfs_acl rfkill mmc_block sf_pdm=
a i2c_ocores virt_dma spi_sifive uio_pdrv_genirq uio loop drm drm_panel_ori=
entation_quirks rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd gr=
ace fscache af_packet mscc macsec macb ptp pps_core phylink of_mdio fixed_p=
hy libphy pwm_sifive mmc_spi crc_itu_t crc7 of_mmc_spi mmc_core spi_bitbang=
 sunrpc sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> > [ 4560.995103] CPU: 2 PID: 23806 Comm: nis Not tainted 5.8.10-1-default=
 #1 openSUSE Tumbleweed (unreleased)
> > [ 4561.004563] epc: ffffffe00036140e ra : ffffffe00036140e sp : ffffffe=
004bc7d60
> > [ 4561.011679]  gp : ffffffe00127ee60 tp : ffffffe1b05d0000 t0 : ffffff=
e001297ca0
> > [ 4561.018886]  t1 : ffffffe001297c30 t2 : 0000000000000000 s0 : ffffff=
e004bc7d80
> > [ 4561.026093]  s1 : ffffffe00003afda a0 : 000000000000005b a1 : ffffff=
e1f7d67588
> > [ 4561.033298]  a2 : ffffffe1f7d6c108 a3 : 0000000000000000 a4 : ffffff=
e000043e80
> > [ 4561.040506]  a5 : ffffffe1f7d6be80 a6 : 0000000000000144 a7 : 000000=
0000000000
> > [ 4561.047712]  s2 : 0000000000000010 s3 : 0000000000000000 s4 : ffffff=
e00003afea
> > [ 4561.054918]  s5 : ffffffe1f7e00e80 s6 : 0000002af4a2c2e0 s7 : ffffff=
fffffff000
> > [ 4561.062124]  s8 : 0000003ffffff000 s9 : ffffffe19f985400 s10: 000000=
0000000010
> > [ 4561.069329]  s11: ffffffe1f7e00e80 t3 : 0000000000038fa8 t4 : 000000=
0000038fa8
> > [ 4561.076533]  t5 : 0000000000000001 t6 : ffffffe00128e062
> > [ 4561.081832] status: 0000000200000120 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [ 4561.089821] ---[ end trace a7c93e7595e9c2cc ]---
> > [ 4561.095589] BUG: Bad rss-counter state mm:00000000c54f4c29 type:MM_A=
NONPAGES val:1
>
> Ah, I must have misunderstood.  I guess I just assumed "init crashes" mea=
nt on
> boot, not just at some time later.  I just sent out a patch reverting thi=
s, LMK
> if it fixes the issue.  I have some work stuff to do, but I'll try to fin=
d some
> time tonight to look into fixing both of the bugs -- otherwise I'll just =
take
> the revert (assuming it does actually fix the issue for you and passes th=
e
> tests).
>
> I saw Atish post after I started writing this: I agree we need to sort of=
 the
> kernel's memory map, I just think it's too late for 5.9.
>

Yes. It is definitely a for-next material. I will try to take a stab
at this if nobody else has an objection.

> > Andreas.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
