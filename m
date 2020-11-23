Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD832C0564
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgKWMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729270AbgKWMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606133998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeeoAM4hcE2Tqdj1kMierMvn1UuzyrNRXJg0gIbWESE=;
        b=jM6wQ1QafSoYVBz4LjnedpMBDzbE5qtHGtEMLfWp4JokYqjfst8o1vPXQtjz2UIu2sztMU
        I4xGsj4whWPWDqnpEla8OA4NeKzpe0KMYBFB3rZIn2sTus+6ZaZ+ffgywx46mv84lYu5NR
        ey/JJBKPqeQMgxvo9pYAKX+QnGXGZFE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-xadySo5GNP2kyTUrIdwATw-1; Mon, 23 Nov 2020 07:19:56 -0500
X-MC-Unique: xadySo5GNP2kyTUrIdwATw-1
Received: by mail-ej1-f69.google.com with SMTP id a9so5498671ejy.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qeeoAM4hcE2Tqdj1kMierMvn1UuzyrNRXJg0gIbWESE=;
        b=JNM48rReHdOHO4b0I4DjBPq5HYdtxExxh/VuCiHGO5rn6NqDTgg6RhBnrpfruD2x3h
         85SNknm8ExKsr+uf2hyObkDwQBAe1P37ztb+71ffitF/lZQprAgvFHzTdQ4Z6/+4GC7I
         jVS+zHOwztMbcFe7JyR98Zial8D6o1E2MCdY9OgNAwRpYF0ebEoT4JKUeJzABQ52dG6Z
         bTlbB95EhHn+rUbnP33ZYe82+Lnhx1kaiC2HCeHUSROORca2vUYtQ5rflz9vqUw3/Tzc
         JhzGTNBUrp2jJILKgC0hlxYWEp9RjnbVtw4yCmbnbD1laN0Snodr/MFoCnPz9b8muOx7
         Yb6A==
X-Gm-Message-State: AOAM530gSeCXC+tR2/AcfcIwPLwninSXh9jBaI5XOzwgWYVCaPTw9Whq
        EWMn+Tp+OSLIgHGxE8sb9dy7ECqniGX+ly9NRoRBdiL/qQ+0fyV9YXpa05HHtu8j2H6VKBmM9Ph
        FOAKW3XqEOvDzkjbqgt0ULgyt
X-Received: by 2002:a17:907:20ac:: with SMTP id pw12mr15813618ejb.245.1606133994793;
        Mon, 23 Nov 2020 04:19:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCl6Est+5O33dD1/yIKWd+wwfQ8dObfaPnfKKKa4No6mpzqBFG+RaxPcyjk/JdrcxX1xjM2Q==
X-Received: by 2002:a17:907:20ac:: with SMTP id pw12mr15813584ejb.245.1606133994369;
        Mon, 23 Nov 2020 04:19:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id u7sm4196388ejt.33.2020.11.23.04.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:19:53 -0800 (PST)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com> <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
 <87a6vdb7l2.fsf@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <161ade15-5e13-361a-572b-78dbbd1f764a@redhat.com>
Date:   Mon, 23 Nov 2020 13:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87a6vdb7l2.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/20 6:05 PM, Jerry Snitselaar wrote:
> 
> Hans de Goede @ 2020-11-19 07:42 MST:
> 
>> Hi,
>>
>> On 11/19/20 7:36 AM, Jerry Snitselaar wrote:
>>>
>>> Matthew Garrett @ 2020-10-15 15:39 MST:
>>>
>>>> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>>>>
>>>>> There is a misconfiguration in the bios of the gpio pin used for the
>>>>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>>>>> driver code this results in an interrupt storm. This was initially
>>>>> reported when we attempted to enable the interrupt code in the tpm_tis
>>>>> driver, which previously wasn't setting a flag to enable it. Due to
>>>>> the reports of the interrupt storm that code was reverted and we went back
>>>>> to polling instead of using interrupts. Now that we know the T490s problem
>>>>> is a firmware issue, add code to check if the system is a T490s and
>>>>> disable interrupts if that is the case. This will allow us to enable
>>>>> interrupts for everyone else. If the user has a fixed bios they can
>>>>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>>>>> kernel command line.
>>>>
>>>> I think an implication of this is that systems haven't been
>>>> well-tested with interrupts enabled. In general when we've found a
>>>> firmware issue in one place it ends up happening elsewhere as well, so
>>>> it wouldn't surprise me if there are other machines that will also be
>>>> unhappy with interrupts enabled. Would it be possible to automatically
>>>> detect this case (eg, if we get more than a certain number of
>>>> interrupts in a certain timeframe immediately after enabling the
>>>> interrupt) and automatically fall back to polling in that case? It
>>>> would also mean that users with fixed firmware wouldn't need to pass a
>>>> parameter.
>>>
>>> I believe Matthew is correct here. I found another system today
>>> with completely different vendor for both the system and the tpm chip.
>>> In addition another Lenovo model, the L490, has the issue.
>>>
>>> This initial attempt at a solution like Matthew suggested works on
>>> the system I found today, but I imagine it is all sorts of wrong.
>>> In the 2 systems where I've seen it, there are about 100000 interrupts
>>> in around 1.5 seconds, and then the irq code shuts down the interrupt
>>> because they aren't being handled.
>>
>> Is that with your patch? The IRQ should be silenced as soon as
>> devm_free_irq(chip->dev.parent, priv->irq, chip); is called.
>>
> 
> No that is just with James' patchset that enables interrupts for
> tpm_tis. It looks like the irq is firing, but the tpm's int_status
> register is clear, so the handler immediately returns IRQ_NONE. After
> that happens 100000 times the core irq code shuts down the irq, but it
> isn't released so I could still see the stats in /proc/interrupts.

I see, yes I have seen this behavior on the X1C8 with a pre-production BIOS.

> With
> my attempt below on top of that patchset it releases the irq. I had to
> stick the check prior to it checking the int_status register because it
> is cleared and the handler returns,

Ack.

> and I couldn't do the devm_free_irq
> directly in tis_int_handler, so I tried sticking it in tpm_tis_send
> where the other odd irq testing code was already located. I'm not sure
> if there is another place that would work better for calling the
> devm_free_irq.

Adding it together with the other IRQ testing related code seems fine
to me.

>> Depending on if we can get your storm-detection to work or not,
>> we might also choose to just never try to use the IRQ (at least on
>> x86 systems). AFAIK the TPM is never used for high-throughput stuff
>> so the polling overhead should not be a big deal (and I'm getting the feeling
>> that Windows always polls).
>>
> 
> I was wondering about Windows as well. In addition to the Lenovo systems
> which the T490s had Nuvoton tpm, the system I found yesterday was a development
> system we have from a partner with an Infineon tpm. Dan Williams has
> seen it internally at Intel as well on some system.

Sounds to me like Windows never uses the IRQ, so we get the fun of finding
all the untested firmware bugs.

So if we cannot get this detection code to work reliable, maybe we should
just not use the IRQ at all, at least on X86 + ACPI systems?

Anyways lets try this storm-detection thing first, but I have the feeling
we should not spend too much time on this. Just outright disabling IRQ
support might be better.

REgards,

Hans

