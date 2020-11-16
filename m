Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4795A2B48DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgKPPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:12:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729217AbgKPPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605539569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGx9VTVE9xrpd7TRsclbo/UztTFDKECkKQ0QsjPjJB8=;
        b=XSMJKdvqPLVcWvg2lhitP8Ww8ENvP7AgQQUXkDx4wq+/mpybegzzGS1ldNWvxKjn+UENve
        7tqCFXsC80ocju2xFcM6eoXlQQ7tIp5GaPN7wheAzeJDcX3Rg4Zxk2p5qBvIQiGzGsJcoL
        DkC1wFAcnZ1pEL1BnX4UHaQpqeSu6JI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-vdQ9U6c1OoqGllsBmRIIsg-1; Mon, 16 Nov 2020 10:11:52 -0500
X-MC-Unique: vdQ9U6c1OoqGllsBmRIIsg-1
Received: by mail-qk1-f197.google.com with SMTP id s9so11813897qks.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OGx9VTVE9xrpd7TRsclbo/UztTFDKECkKQ0QsjPjJB8=;
        b=QX/oJdVQoVJ6Acq4vI6gmOY19msZAIg8GRLdVGLZzfFFkDth+fkqzzG+FtSuA+Go0g
         QZrtwhbZL6CtvOhEOwu7nXlQd//9Txz1CzJta+q+FK/0r/KtpDiqYT66OGUtqmRL4MU8
         kG3PpZUvtptabMTj8n2WE3XChbYzDWam/tMVu+DBd5b8dEzqzC20pi+XlATFhVf3Uym/
         2dh5TzBRdOuTmjYntThrgLZ0bzAKmRFOqT4S3pD0vbhkjwiw7Ku6Vv9hD3X9jRFQh9pK
         P3MSNP3V2/quFk1BSRssFOY4ptzg6LBAl70Pb9uU/qM+piipKVVu03M0Blv1zDlPyKOT
         Rfzw==
X-Gm-Message-State: AOAM533NbLdYw3Pofo2OCl5USEFcUyQoFJllJXz79BsXPpgzEDK1BNbX
        bztCsKuK6ai/N/xe/RiKONYHYIbbpfudTMnujEmAvvfUBV20uznf5OCRfMZBlOF+SkaHmCjNvvg
        0RVNh3fxcSSdNUboZUtOCl54U
X-Received: by 2002:ac8:5c47:: with SMTP id j7mr15238834qtj.62.1605539511761;
        Mon, 16 Nov 2020 07:11:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOAN/fykwbTByJ3lPL54lAYfP0o9Whbe5l7+LWEx0FBqjIa2HK8fyxDntVIqhpaP38dkIenA==
X-Received: by 2002:ac8:5c47:: with SMTP id j7mr15238799qtj.62.1605539511500;
        Mon, 16 Nov 2020 07:11:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f202sm11870849qke.112.2020.11.16.07.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:11:50 -0800 (PST)
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
 <e7b815c1-e153-2bed-7793-0affd4d74f9e@linux.intel.com>
 <a63cb1f6-4bb4-9f7d-e1b0-8054e8d4a21b@redhat.com>
 <50204b8d-91dd-e1d4-45f0-9b3e21d7309b@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <30a35bbd-f1c1-4f80-c3b4-ae5aa409ec4c@redhat.com>
Date:   Mon, 16 Nov 2020 07:11:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <50204b8d-91dd-e1d4-45f0-9b3e21d7309b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 5:50 AM, Richard Gong wrote:
> Hi Tom,
>
>
> On 11/14/20 9:59 AM, Tom Rix wrote:
>>
>> On 11/14/20 6:52 AM, Richard Gong wrote:
>>> Hi Tom,
>>>
>>>>>        prior to OS boot up.
>>>>>    - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>>>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
>>>>
>>>> The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.
>>>>
>>>
>>> The original list is not in alphabetical order. The order of partial-fpga-config, external-fpga-config and encrypted-fpga-config here follows the implementation in the of-fpga-region.c file.
>>>
>>> So authenticate-fpga-config should follow the way, correct?
>>>
>> This is why i say 'mostly' ..
>>
>> In general when listing options for a user to read, you should make it easy for them to find
>>
>> the option they are looking for.  Ordering them alphabetically is an obvious but not the only
>>
>> way.  I am not asking for you to fix the whole table, just what you are adding. If there is
>>
>> a better way to organize them please propose the method.
>>
>
> How about put authenticate-fpga-config above partial-fpga-config? I would like to group all xxx-fpga-config flags together.

Ok that sounds fine.

Tom

>
>
> Regards,
> Richard
>
>> Tom
>>
>>>> Improve what you mean by 'authentication' similar to my comment in the first patch.
>>>>
>>>
>>> Will do in the version 2 submission.
>>>
>>> Regards,
>>> Richard
>>>
>>>> Tom
>>>>
>>>>>    - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>>>>        bridges to successfully become enabled after the region has been
>>>>>        programmed.
>>>>
>>>
>>
>

