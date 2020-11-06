Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C62A8BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgKFBG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:06:58 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52746 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733237AbgKFBGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:06:55 -0500
Received: from [10.130.0.73] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx33+ioaRfRw4HAA--.8595S3;
        Fri, 06 Nov 2020 09:06:43 +0800 (CST)
Subject: Re: [PATCH] arm64: Change the location of DISCARDS
To:     Will Deacon <will@kernel.org>
References: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
 <20201105214738.GB8600@willie-the-truck>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, ardb@kernel.org
From:   tangyouling <tangyouling@loongson.cn>
Message-ID: <759a51ad-8b2e-24bd-52f5-99769ff5557c@loongson.cn>
Date:   Fri, 6 Nov 2020 09:06:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20201105214738.GB8600@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx33+ioaRfRw4HAA--.8595S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7k0a2IF6w1UM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
        6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F
        4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY
        62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7V
        C2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0
        c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
        6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
        sGvfC2KfnxnUUI43ZEXa7IU8jhF7UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will

In the include/asm-generic/vmlinux.lds.h:978, the description is as follows:
DISCARDS must be the last of output section definitions so that such archs
put those in earlier section definitions.

Thanks,

Youling


On 11/06/2020 05:47 AM, Will Deacon wrote:
> In the include/asm-generic/vmlinux.lds.h file

