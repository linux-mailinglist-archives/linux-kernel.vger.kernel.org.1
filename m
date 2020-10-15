Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2082528EF33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgJOJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgJOJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:13:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFEC061755;
        Thu, 15 Oct 2020 02:13:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so2510525wre.4;
        Thu, 15 Oct 2020 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5VqVZaCxXPdKV0bJ6e/lxbXj3PVs7Fd+/vx+IhRFsc=;
        b=h3DdtBPXe4J+VunFr8LqpY18tJf9rTH9HJEsmp8EvUOZK+jnA08olp8uDK3lTC69Fp
         bOdKJjubfdgKAsufE4rpYqtTj+zuKYm4kNxb24GhXlhXe380SQoDV2Xfm7vC7C5K4ujI
         NUTL38uf1p/fnpgsgkMDBsRtwVZmfV0a/l5RvJm8gKkUx8S5impL+5Nwho+e3DdQgeiP
         rNJzrHs7K0j391iiDzf8LVq6X9pEDqZQ6sEWDLQABmXnQS+g6xG1uiyqj4uL4w1CHL2x
         jr4Xe58aGLZgJsSZ6Iq7V26MchlrcBphi2cpUCxQfGH3V/ikX1A9VLfwpIVWFPMuQtlb
         FkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5VqVZaCxXPdKV0bJ6e/lxbXj3PVs7Fd+/vx+IhRFsc=;
        b=VwS8+AAPL5FOJnPP++Ow+K7Li1MDdgTm78Jy30ARZYxR2CkO2VgBVzcXKuWYr03gcL
         ZCa5EF7tqma0sYc9ZvqQNDcwIetpKad2sQ26NBbTY7Xti5eRlSJBKUxrbI4dfERrzKvU
         ReNf+gpdopNP2uW0EKeRz1Ox0qssx51WIM5CjEQhILaUr2/xm5HTI6wsgmHIFTV+7mw2
         N2TvqZtMbjo4x2qFvy2AlWJXbXb8Z5cbOYb/1YB3SCNarU4J8iWMKT9to+JKlfgsEydc
         xkuXZeBRjEb/xLtlwUZf9j5gwLsNVEVijj5SoNikcgNWFklClLJGB2bRYJBpGwyP+Ypw
         p8/Q==
X-Gm-Message-State: AOAM533mM2VrM0+TKj5077Pqo5Sok/X6ryva8harw4CgYT1E0WGx3g8r
        VeO0rAKxUSaw3WJP+HDWhuYdX+XhN42vEA==
X-Google-Smtp-Source: ABdhPJzFwvWaKtfDPdwDPVvA9EabbSQw9Ukdhfdkgwnoo5xuU9VSbTIlTrGeB7ahBceyeanZcP/arg==
X-Received: by 2002:adf:a345:: with SMTP id d5mr3414231wrb.55.1602753229966;
        Thu, 15 Oct 2020 02:13:49 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id d7sm3233985wmd.48.2020.10.15.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 02:13:49 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
 <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
 <c41ec664-73a0-3c63-a31c-48c89028dfac@gmail.com>
 <1602124514.28301.17.camel@mtkswgap22> <1602728017.11536.5.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <bf202a0f-49e3-c618-5d74-934fe739dd18@gmail.com>
Date:   Thu, 15 Oct 2020 11:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1602728017.11536.5.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2020 04:13, Neal Liu wrote:
> On Thu, 2020-10-08 at 10:35 +0800, Neal Liu wrote:
>> On Wed, 2020-10-07 at 12:44 +0200, Matthias Brugger wrote:
>>>
>>> On 27/08/2020 05:06, Neal Liu wrote:
> [...]
> 
>>>> +static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>>>> +{
>>>> +	void __iomem *pd_vio_shift_sta_reg;
>>>> +	void __iomem *pd_vio_shift_sel_reg;
>>>> +	void __iomem *pd_vio_shift_con_reg;
>>>> +	int min_shift_group;
>>>> +	int ret;
>>>> +	u32 val;
>>>> +
>>>> +	pd_vio_shift_sta_reg = ctx->infra_base +
>>>> +			       ctx->data->vio_shift_sta_offset;
>>>> +	pd_vio_shift_sel_reg = ctx->infra_base +
>>>> +			       ctx->data->vio_shift_sel_offset;
>>>> +	pd_vio_shift_con_reg = ctx->infra_base +
>>>> +			       ctx->data->vio_shift_con_offset;
>>>> +
>>>> +	/* Find the minimum shift group which has violation */
>>>> +	val = readl(pd_vio_shift_sta_reg);
>>>> +	if (!val)
>>>> +		return false;
>>>
>>> So bit 0 of selection register (pd_vio_shift_sel_reg) does not represent a
>>> violation group?
>>> I don't know how the HW works, but is seems odd to me. In case that's bit 0
>>> actually doesn't represent anything: how can an interrupt be triggered without
>>> any debug information present (means val == 0)?
>>
>> This check implies HW status has something wrong. It cannot get any
>> debug information for this case.
>> It won't happen in normal scenario. Should we remove this check?
>>
> 
> Sorry, I missed the most common part. Is function is in the while loop:
> while (devapc_sync_vio_dbg(ctx))
> ...
> 
> We keep find the minimum bit in pd_vio_shift_sta_reg to get the
> violation information, (pd_vio_shift_sta_reg might raise multiple bits)
> until all raised bit (shift group) has been handled.
> So I don't think it's necessary to add WARN message in this case.
> Thanks
> 

Correct we would get a warning every time once we have read and cleared all 
violations, but we are only concerned about the IRQ triggered with no violation 
present. But we can skip that check for now, if we see that there could be a HW 
error we can think about it in the future.

Regards,
Matthias
