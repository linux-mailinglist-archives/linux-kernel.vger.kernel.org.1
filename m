Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1A303FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbhAZOFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405695AbhAZOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:04:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948EC0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:03:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so16602022wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hg6fbk2hPzJeVcc0/n/hzZnSJhxa5oFlovCgSGcU67s=;
        b=P6Tpm4BVnKOzhXoaIat518LzAthKeb+ZWTBK9MuSdjOT97YNNIxOI8cdDf7/LoO/v6
         a3E22//ZnT+owpQ92sTpjZ6VwuvNtbR0pWZxEpaHPszMi+eo00cbW+mUzCj1/gRA4Trk
         /tylNLzhFPs9YiVkfx2D36x0WfOXi1uAw4zqlVX3ZfNLhtBNAMpJFCVu9z1zTdpz+++p
         N+Ort/gq47Dh5Lx6pQ6Fm2kVPSZjXPrWsjkXb34pGI+VIR9yMtOGk85WRq6QUTB5PnvB
         E/8JLUH/bkI0N7rGFdrm0c4EdC8N8opOp9sWj1XSNJwWFLLWLyMA59kh2RVO0QSR0k14
         2NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hg6fbk2hPzJeVcc0/n/hzZnSJhxa5oFlovCgSGcU67s=;
        b=qAKmkD3hkbOogdwl7EyL7AnmCrHjHpS/QnAdWelAUbpWI2XucezCk6SAi7J24Fm235
         fiKmaVZwJqMBzfH9Sma2hBmNMjIB7dC8xmh6uUeMbwyzOj7T4CnVo4bp8EBZhGntKWwJ
         +Ugyv/8VttgiGNHnxjOB96I1b9fT5FyldyFHnpQ5m1L9bGgLkNk/WTWqo5XeUiVjvCwu
         pimZr/huaW3P3iU/UUR7Ec3HyFd7NvOyVhJW/Pb5MS0k2Hdi7lhiVlAANgNDAGkFdVCF
         DCYxeAw6wIZw7lhIn7sTh6dk0mESznQQpmzNfGAVef5Mmr35ByvDyFSZFxdNO9wcqZXM
         u90w==
X-Gm-Message-State: AOAM530q4io4l9Pd+eTRgVlpGOAPhtWnYjbp2WQj4dX8Qi4UCWdC/qRF
        101Nvf/zp3yixj5GeW0+ZxM6wg==
X-Google-Smtp-Source: ABdhPJydvaUg5BFfRO/xEY6wVKn8k7gUjr+DsnZmxrmdhVUocszh4txZ+l25z36Vfxepv+6W9/V9ug==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr6202939wru.201.1611669811563;
        Tue, 26 Jan 2021 06:03:31 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n125sm3703525wmf.30.2021.01.26.06.03.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:03:30 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] ASoC: soc-component: add
 snd_soc_component_read/write_field()
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
 <20210126133612.GB4839@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6816a9fe-9b71-6a39-485e-1b6ce2b732ed@linaro.org>
Date:   Tue, 26 Jan 2021 14:03:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210126133612.GB4839@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2021 13:36, Mark Brown wrote:
> On Tue, Jan 26, 2021 at 12:20:19PM +0000, Srinivas Kandagatla wrote:
> 
>> +#define __soc_component_field_shift(x) (__builtin_ffs(x) - 1)
> 
> Why not have this be a static inline?

Sure, that makes it even better to validate the mask aswell!

> 
>> +unsigned int snd_soc_component_read_field(struct snd_soc_component *component,
>> +					  unsigned int reg, unsigned int mask)
>> +{
>> +	unsigned int val;
>> +
>> +	mutex_lock(&component->io_mutex);
>> +	val = soc_component_read_no_lock(component, reg);
>> +	if (mask)
>> +		val = (val & mask) >> __soc_component_field_shift(mask);
> 
> I don't understand why this is open coding the locking when it's just a
> simple read and then shift?

I agree! something like this should be good I guess:

unsigned int snd_soc_component_read_field(...)
{
	unsigned int val;

	val = snd_soc_component_read(component, reg);

	val = (val & mask) >> __soc_component_field_shift(mask);

	return val;
}

> 
>> +	mutex_lock(&component->io_mutex);
>> +
>> +	old = soc_component_read_no_lock(component, reg);
>> +
>> +	val = val << __soc_component_field_shift(mask);
>> +
>> +	new = (old & ~mask) | (val & mask);
>> +
>> +	change = old != new;
>> +	if (change)
>> +		ret = soc_component_write_no_lock(component, reg, new);
>> +
>> +	mutex_unlock(&component->io_mutex);
> 
> This needs the lock as it's a read/modify/write but could also be
> implemented in terms of the existing update_bits() operation rather than
> open coding it.
True!, we could simplify this to :

int snd_soc_component_write_field(struct snd_soc_component *component,
				  unsigned int reg, unsigned int mask,
				  unsigned int val)
{
	val = (val << __soc_component_field_shift(mask)) & mask;

	return snd_soc_component_update_bits(component, reg, mask, val);
}

Does that look okay to you?


--srini
> 
