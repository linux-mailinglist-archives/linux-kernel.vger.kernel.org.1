Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF32E2BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLYRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgLYRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 12:00:39 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09956C061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 08:59:43 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D2Y6s5NZdz1rtMh;
        Fri, 25 Dec 2020 17:58:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D2Y6r6lB6z1qr3y;
        Fri, 25 Dec 2020 17:58:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tmq1xZlJy0Sy; Fri, 25 Dec 2020 17:58:27 +0100 (CET)
X-Auth-Info: +mM6lJfV9Zm65W4CzQ9iQdJ3u18++WndNbaqbvDXm5JhNdQgE7AiMtr1JiOt+AHe
Received: from igel.home (ppp-46-244-182-139.dynamic.mnet-online.de [46.244.182.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 25 Dec 2020 17:58:27 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 2BBAB2C3600; Fri, 25 Dec 2020 17:58:27 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: riscv+KASAN does not boot
References: <CACT4Y+bpkSYTL_UwNoKVd0PDFF_xrNN6=y_S_v8W3YRaAcMm2g@mail.gmail.com>
X-Yow:  I have no actual hairline...
Date:   Fri, 25 Dec 2020 17:58:27 +0100
In-Reply-To: <CACT4Y+bpkSYTL_UwNoKVd0PDFF_xrNN6=y_S_v8W3YRaAcMm2g@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 25 Dec 2020 15:55:48 +0100")
Message-ID: <878s9lbz64.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 25 2020, Dmitry Vyukov wrote:

> qemu-system-riscv64 \
> -machine virt -bios default -smp 1 -m 2G \
> -device virtio-blk-device,drive=hd0 \
> -drive file=buildroot-riscv64.ext4,if=none,format=raw,id=hd0 \
> -kernel arch/riscv/boot/Image \
> -nographic \
> -device virtio-rng-device,rng=rng0 -object
> rng-random,filename=/dev/urandom,id=rng0 \
> -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
> virtio-net-device,netdev=net0 \
> -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
> panic_on_warn=1 panic=86400"

Do you get more output with earlycon=sbi?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
