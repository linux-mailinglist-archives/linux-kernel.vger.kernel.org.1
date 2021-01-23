Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8133013C5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAWHeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:34:31 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55978 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbhAWHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:34:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UMaaSVg_1611387208;
Received: from IT-C02Z45M7LVCF.local(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0UMaaSVg_1611387208)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Jan 2021 15:33:28 +0800
Subject: Re: [PATCH] RISC-V: probes: Treat the instruction stream as
 host-endian
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        penberg@kernel.org, me@packi.ch, mhiramat@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel test robot <lkp@intel.com>
References: <20210123033429.2072716-1-palmer@dabbelt.com>
From:   Guo Ren <guoren@linux.alibaba.com>
Message-ID: <beee96f4-2cf4-9be7-a891-3f6d5ee4baa9@linux.alibaba.com>
Date:   Sat, 23 Jan 2021 15:33:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210123033429.2072716-1-palmer@dabbelt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On 2021/1/23 上午11:34, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Neither of these are actually correct: the instruction stream is defined
> (for versions of the ISA manual newer than 2.2) as a stream of 16-bit
> little-endian parcels, which is different than just being little-endian.
> In theory we should represent this as a type, but we don't have any
> concrete plans for the big endian stuff so it doesn't seem worth the
> time -- we've got variants of this all over the place.
>
> Instead I'm just dropping the unnecessary type conversion, which is a
> NOP on LE systems but causes an sparse error as the types are all mixed
> up.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>   arch/riscv/kernel/probes/decode-insn.c | 2 +-
>   arch/riscv/kernel/probes/kprobes.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> index 0876c304ca77..0ed043acc882 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -16,7 +16,7 @@
>   enum probe_insn __kprobes
>   riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
>   {
> -	probe_opcode_t insn = le32_to_cpu(*addr);
> +	probe_opcode_t insn = *addr;
>   
>   	/*
>   	 * Reject instructions list:
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e60893bd87db..a2ec18662fee 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -57,7 +57,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>   	}
>   
>   	/* copy instruction */
> -	p->opcode = le32_to_cpu(*p->addr);
> +	p->opcode = *p->addr;
>   
>   	/* decode instruction */
>   	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {

