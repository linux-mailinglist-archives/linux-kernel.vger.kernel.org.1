Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26F2DA735
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgLOEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbgLOEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608007418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfuNulEUyZ4D9ITyUZwY93F2tD2DkQZvOHANb0nT6DU=;
        b=NDuvgkNHu/In84ggqyBesw5ahF3Zz13JbCcL7FFb4zR+Q23uGCtoUL4O7pByzc5GQRBBSl
        g7ATQAnXhatlJSES2c5PWyJ07E1Qie7+QpFax96Q+ZBJ3sdUbi5y+FfNL8hPOT+dRU7HYn
        hYPlmI3PPP7MmybLrjNkoBQYrEvtd3A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-Y_8XC7ByOUK9hhmHg7aL4w-1; Mon, 14 Dec 2020 23:43:34 -0500
X-MC-Unique: Y_8XC7ByOUK9hhmHg7aL4w-1
Received: by mail-qk1-f200.google.com with SMTP id l138so7966191qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WfuNulEUyZ4D9ITyUZwY93F2tD2DkQZvOHANb0nT6DU=;
        b=Qxkz9kkpxvvxhFa8YRuFHFAdoZhsXcHdJw9ID0x/kig6RdrvAcKZEQcGdnK4eWJPJD
         YQgyaVvsddAn8DcyKB3Bi8WZngx7wchM5e0VoB0x7gWXD87+f2NcfpzXKSW6e2BB4ddP
         kZZlr/vgOWe8Z0M2WADhZyJvT/ej22T12VHEqg0tXqz4l5UmUMRs+fdSABjUuSMkzYIE
         pjA2PgMgpkkI/R2VBEb5t4lvwLSClMpquWpvmkwLqa9u5scdmpupLaZbcbDoucz6PZ8l
         y9AotnYeMBpPZkEJMgJlQ+ZYXkKcThvVGyZzSHyqs5R4BAkbDvfrftOva7+OT1t1NYO5
         6LyA==
X-Gm-Message-State: AOAM531Xxfi21eEdb3iootE/ZvHxMmbifSFfKeuVviz5l+35h4lgqZqK
        U7Pkh0+WGPz0VzuF7LZOuV1bZUXFRPS99lUtenk3ft4bsDUevUYHnlWGdyokRXiQMLGMpYq8/aO
        EL5Ip24DkGhsM+/n8k5Rstl0H
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr33873537qtp.345.1608007414212;
        Mon, 14 Dec 2020 20:43:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw2Iqn6wYcAolL+BgzRwuOsAKOZ0vpMhN/4n3mV6+6pdjBPUafj7e7ZWksvdH3bY7lag+CjQ==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr33873521qtp.345.1608007413979;
        Mon, 14 Dec 2020 20:43:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a1sm9973010qkn.104.2020.12.14.20.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 20:43:33 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
 <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
 <20201215022206.GC14854@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <97d06583-ca99-67ae-55e1-ff714b47f8cb@redhat.com>
Date:   Mon, 14 Dec 2020 20:43:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201215022206.GC14854@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/20 6:22 PM, Xu Yilun wrote:
> On Mon, Dec 14, 2020 at 02:14:56PM -0800, Tom Rix wrote:
>> On 12/13/20 7:36 PM, Xu Yilun wrote:
>>> This patch adds description for UIO support for dfl devices on DFL
>>> bus.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>> v2: no doc in v1, add it for v2.
>>> ---
>>
>>> +components. They could instantiate a new private feature in the DFL, and then
>>> +get a DFL device in their system. In some cases users may need a userspace
>>> +driver for the DFL device:
>>> +
>>> +* Users may need to run some diagnostic test for their hardwares.
>> * Users may prototype the kernel driver in user space.
> Could we just add the line rather than replacing the previous line? I think this
> comment is describing a different usecase.

Yes, this is what i ment, please use your original.

I am offering another usecase, one I will use.

Add mine as well, if you want.

>
>>> +* Some hardware is designed for specific purposes and does not fit into one of
>>> +  the standard kernel subsystems.
>>> +
>>> +This requires the direct access to the MMIO space and interrupt handling in
>>> +userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
>> The dfl-uio-pdev module exposes
> Will change it.
>
>>> +interfaces. It adds the uio_pdrv_genirq platform device with the resources of
>>> +the DFL device, and let the generic UIO platform device driver provide UIO
>> the DLF device, and lets
> Will change it.
>
>>> +support to userspace.
>> Use FPGA_DFL_UIO_PDEV to enable this feature.
> I didn't get your idea for this.

I wanted the user to know which kconfig controls this feature.

Leave it out if you don't think it fits.

>
>>> +
>>> +The DFL UIO driver has a special matching algorithem. It will match any DFL
>>> +device which could not be handled by other DFL drivers. In this way, it will
>>> +not impact the functionality of the features which are already supported by the
>>> +system.
>> (not sure if this section is needed)
> I think we may keep it.

Ok.

Tom

>
> Thanks,
> Yilun
>

