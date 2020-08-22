Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A324E71F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 13:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHVLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 07:35:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHVLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:35:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598096111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=VrTlXfTQ0mr2r4PG9tHDj5g5/zcZ7e5Apyec8R4JO80=;
        b=QPH6iu1f2Q5BcdlrzLVmIwbKY+XxWNDtVWxVQQhfdCPvKNJpjUqVVBU3R7Ug0j43YfWjlW
        G1YHJ0uMze7bIVDoVAKvGpAzH5QhcC/0jTEfVYDa99032n/tyPUdLLpvteJImeYKTL2dS9
        OtkkGU+gKHeCDf86yY6D8B3UAePYSJIgEp3/12u5Td/LJg4+ivzZ65KWFsDmEKKVtlzSVT
        6P06fovRtEVhB/u0eT6qSlv8vRNVwjCjlOhP6GXM5CT7yRmobl1hYvZkPIZ0+T/DsQdpey
        k13Mzq0lI1cx/eym0XEAS0ScTmL9grRKngwWaEyteyskV8FPr4brgjBObiD+KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598096111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=VrTlXfTQ0mr2r4PG9tHDj5g5/zcZ7e5Apyec8R4JO80=;
        b=TnP9JVmRGc0tq/EbKUL718L8usNdSBujbufvse1Z4S/5Tk/xcMFzpptVbjoIYFZW5ZRYPD
        DeaOeD/dXFJQoQBQ==
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] genirq/proc: Show percpu irq affinity
In-Reply-To: <aa537126-4646-08e2-6bea-833f71b20ade@huawei.com>
Date:   Sat, 22 Aug 2020 13:35:10 +0200
Message-ID: <87mu2moqvl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22 2020 at 17:33, Yunfeng Ye wrote:
> On 2020/8/13 16:27, Thomas Gleixner wrote:
> For example, the cmdline "irqaffinity=3D0,1,126,127" on the 128 cores sys=
tem=EF=BC=9A
>
> [root@localhost ~]# cat /proc/irq/4/smp_affinity_list
> 0-1,126-127
>
> The irq 4 is "arch_timer" interrupt, which is a percpu interrupt.
>
> So is it necessary to show the percpu irq affinity correct?

Yes, it makes sense to do so, but you used the wrong check. The correct
one is:

irq_settings_is_per_cpu_devid()

which will not wreckage the output for other per cpu marked interrupts
which never set the percpu_affinity pointer with the obvious
consequences... The pointer would need a NULL check in any case, but it
might be more straight forward to update affinity when percpu_affinity
is initialized. Haven't looked in detail though.

Thanks,

        tglx
