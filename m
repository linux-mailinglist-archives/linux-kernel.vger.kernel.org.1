Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D62EB186
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbhAERh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:37:56 -0500
Received: from vern.gendns.com ([98.142.107.122]:59106 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbhAERhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KWt7Z7nj5fnpVzsa9K1vPpco4+qBE5NY/g/JbrcmWFU=; b=YnDkq2sEJEHSEewppiiReTFX0B
        l+Fz3fskqFNDNRADJyxsP34DmZHNxYB9OU804pNxv0iWzZwzfs971jHnDpCou1HviCgk5i/sUdeYp
        iynL9iM3DJcRC3yBfsunjCv2v6zaHPTDlqa5W56bPSkTa0QJo6fUeaYoob6/blyEZtlfDYA35TCBO
        RRhCKfaxLUPCPt+tTdUBXAZC/cZhpZ4REzB0VQwiOrGw7nTaiW0fQHXq3INX0MtxuaKVZJXncQ3FZ
        nIDFogujewo5E2xz7T0agqETwRuBD2IRvpME0Z6cCaoEQOANCyQuGeZTa9YbAmW4cMH9gLcQQWxrv
        G9srlAjQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39598 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kwqGd-00026C-UC; Tue, 05 Jan 2021 12:37:12 -0500
Subject: Re: [PATCH] irqchip/irq-pruss-intc: implement set_type() callback
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210104183656.333256-1-david@lechnology.com>
 <02075e85faa562e19b3aeccd53635cbc@kernel.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <d339e351-4231-0890-5aba-4614784bb4f6@lechnology.com>
Date:   Tue, 5 Jan 2021 11:37:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02075e85faa562e19b3aeccd53635cbc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 2:47 AM, Marc Zyngier wrote:
> On 2021-01-04 18:36, David Lechner wrote:
>> This implements the irqchip set_type() callback for the TI PRUSS
>> interrupt controller. This is needed for cases where an event needs
>> to be active low.
>>
>> According to the technical reference manual, the polarity should always
>> be set to high, however in practice, the polarity needs to be set low
>> for the McASP Tx/Rx system event in conjunction with soft UART PRU
>> firmware for TI AM18XX SoCs, otherwise it doesn't work.
> 
> I remember asking about this when I reviewed the patch series, and
> was told that there was no need to handle anything *but* level high.
> As a consequence, the DT binding doesn't have any way to express
> the trigger configuration.
> 
> Now this? What is going to drive the configuration?

I made it work by setting IRQF_TRIGGER_LOW in devm_request_irq().

I can try to see if there is a way to change the (10 year old)
firmware instead.

Hopefully someone from TI can shed more light on the subject?

> 
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>  drivers/irqchip/irq-pruss-intc.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
>> index 5409016e6ca0..f882af8a7ded 100644
>> --- a/drivers/irqchip/irq-pruss-intc.c
>> +++ b/drivers/irqchip/irq-pruss-intc.c
>> @@ -334,6 +334,32 @@ static void pruss_intc_irq_unmask(struct irq_data *data)
>>      pruss_intc_write_reg(intc, PRU_INTC_EISR, hwirq);
>>  }
>>
>> +static int pruss_intc_irq_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +    struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
>> +    u32 reg, bit, val;
>> +
>> +    if (type & IRQ_TYPE_LEVEL_MASK) {
>> +        /* polarity register */
>> +        reg = PRU_INTC_SIPR(data->hwirq / 32);
>> +        bit = BIT(data->hwirq % 32);
>> +        val = pruss_intc_read_reg(intc, reg);
>> +
>> +        /*
>> +         * This check also ensures that IRQ_TYPE_DEFAULT will result
>> +         * in setting the level to high.
>> +         */
>> +        if (type & IRQ_TYPE_LEVEL_HIGH)
>> +            val |= bit;
>> +        else
>> +            val &= ~bit;
>> +
>> +        pruss_intc_write_reg(intc, reg, val);
> 
> RMW  of a shared register without locking?
> 
>> +    }
>> +
>> +    return 0;
> 
> What happens when this is passed an edge configuration? It should at
> least return an error.

This is probably a moot point if we are not going to allow
changing the type, but there is another register for selecting
edge or level. But the manual says similarly says it should
always be set to level.

> 
>> +}
>> +
>>  static int pruss_intc_irq_reqres(struct irq_data *data)
>>  {
>>      if (!try_module_get(THIS_MODULE))
>> @@ -389,6 +415,7 @@ static struct irq_chip pruss_irqchip = {
>>      .irq_ack        = pruss_intc_irq_ack,
>>      .irq_mask        = pruss_intc_irq_mask,
>>      .irq_unmask        = pruss_intc_irq_unmask,
>> +    .irq_set_type        = pruss_intc_irq_set_type,
>>      .irq_request_resources    = pruss_intc_irq_reqres,
>>      .irq_release_resources    = pruss_intc_irq_relres,
>>      .irq_get_irqchip_state    = pruss_intc_irq_get_irqchip_state,
> 
> Thanks,
> 
>          M.

