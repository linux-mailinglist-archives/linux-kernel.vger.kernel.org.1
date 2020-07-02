Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A189211DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgGBIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 04:05:52 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60102 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbgGBIFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:05:51 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn99Tlf1eOmFOAA--.2652S3;
        Thu, 02 Jul 2020 16:05:40 +0800 (CST)
Subject: Re: [PATCH v4 02/14] irqchip/csky-apb-intc: Fix potential resource
 leaks
To:     Markus Elfring <Markus.Elfring@web.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
 <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
 <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
 <971c649e-fe07-3771-6fea-f5aaeaf090ad@web.de>
 <c7cc848a-1ce0-e877-aa44-ebafe4b5985c@loongson.cn>
 <41b48aa5-e5b2-0257-8b3d-07e1b86634b4@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0726ddc2-6b01-2ac8-d5bf-74c3df36b6ef@loongson.cn>
Date:   Thu, 2 Jul 2020 16:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <41b48aa5-e5b2-0257-8b3d-07e1b86634b4@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn99Tlf1eOmFOAA--.2652S3
X-Coremail-Antispam: 1UD129KBjvJXoW7JF48ur1fZr4DXFWDZFW8WFg_yoW8Jr1UpF
        WUur15ZFs3Jw18ur1q93yku345Zryjgr4qvws7Jrn2vr48Xrn5Wr40v3Z8uF4DCrnrXa1F
        van3A34ru3WUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUx6wCDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 03:19 PM, Markus Elfring wrote:
>>>> +++ b/drivers/irqchip/irq-csky-apb-intc.c
> …
>>> I suggest to recheck the parameter alignment for such a function call.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=7c30b859a947535f2213277e827d7ac7dcff9c84#n93
>> OK, thank you, like this:
>>
>> -       ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
>> -                       "csky_intc", handle_level_irq,
>> -                       IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0, 0);
>> -       if (ret) {
>> +       if (irq_alloc_domain_generic_chips(root_domain, 32, 1,
>> +                                          "csky_intc", handle_level_irq,
>> +                                          IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0, 0)) {
>>                  pr_err("C-SKY Intc irq_alloc_gc failed.\n");
> …
>
> Would you like to use also horizontal tab characters for the corresponding indentation?

Sorry, I do not quite understanding what you mean, maybe like this?

         if (irq_alloc_domain_generic_chips(root_domain, 32, 1,
                 "csky_intc", handle_level_irq,
                 IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0, 0)) {
                 pr_err("C-SKY Intc irq_alloc_gc failed.\n");
                 goto err_domain_remove;
         }

>
> Regards,
> Markus

