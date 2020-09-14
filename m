Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B82687B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgINI6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:58:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgINI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600073877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEum23t+svlghEHDrkfiWQI1PF+qJnq2D7g9bZsVKfA=;
        b=UkmgSxsCZb6Ki7ISCkuXZtS+55Owd8FkoyN4VQncaslfSzS4escwp7cb0J5lgPVcW2BD/d
        liGURXz84Flfi43a5C/bnfRv6c5kIhSFp2D5y2ffhfFLLsNqWxqdPg4awU3fa+9zP9Dkwu
        FDq64pjMbb272QwO9rHKS4k+dGAMv6Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-g477LoYpMtCAZu6i5V2WCw-1; Mon, 14 Sep 2020 04:57:56 -0400
X-MC-Unique: g477LoYpMtCAZu6i5V2WCw-1
Received: by mail-ed1-f70.google.com with SMTP id i23so1021513edr.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEum23t+svlghEHDrkfiWQI1PF+qJnq2D7g9bZsVKfA=;
        b=BByYXFpCOuvCmaRtxrLMv9VbZHwP9xvN03HftIKolC+tjLJxCQmWqTKGibUE/lR4wF
         xODTZStlByydoSl8VWwJnn3tOUtYTbSpK71GUKknIO1x5QwUGfTYSsSfyTPp4k+Ok2py
         qpH2c8rxNyBmGJWMRkz+kJEuIPiSVGBx29IAIilUn/VUe4/nQZSQPvY9mwixdRrusGQU
         9yp77OzOp0viRfnOaWPRd3Zl3FH0OQqQfY9ZjzAMfEqT/Qb7WXuyJw+Q8Xhe4vi4hqCD
         37ogZo0zD5vdAfCJvv8GY2sNxSgikzOeihaqhhuC2hyLmjSzWiR1V5qbysR4NYdeKQyq
         1iDw==
X-Gm-Message-State: AOAM530emvzvYn5J4mALlEOLy5AGY2DZRRQvhXOMHgSMwnPd1jINWMrg
        DnqGCJ2dX6EndukdOZsYf6tuHvqN0GRm5YmPCo8+MiYRmXn52kVTqs0PxcBkIjRfAkHG4IkbxD8
        UIBczl71GspBPquVd0uX+MkQO
X-Received: by 2002:a50:fc08:: with SMTP id i8mr16508805edr.257.1600073875044;
        Mon, 14 Sep 2020 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzng0e3crIM0MRmKRuvBPIqhmdf3VOfEgrWBfiTtfm3AqYj3npyUr1SsG6ROGW4UluC5pO7Ug==
X-Received: by 2002:a50:fc08:: with SMTP id i8mr16508791edr.257.1600073874850;
        Mon, 14 Sep 2020 01:57:54 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id d6sm8987645edm.31.2020.09.14.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:57:54 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <aa23d8b8-6c6b-b6f2-e916-1defff8a9b26@redhat.com>
 <DM6PR19MB26362B2A2CDFE73BE167FD34FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <c5a6e340-66ec-e03b-a9a8-9c61b9f388d5@redhat.com>
Message-ID: <25c9e901-ed28-eb87-bd89-652c3710b62b@redhat.com>
Date:   Mon, 14 Sep 2020 10:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5a6e340-66ec-e03b-a9a8-9c61b9f388d5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 10:45 AM, Hans de Goede wrote:

<snip>

>>>> +           lower_bound:    A file that can be read to obtain the lower
>>>> +           bound value of the <attr>
>>>> +
>>>> +           modifier:       A file that can be read to obtain attribute-level
>>>> +           dependency rule which has to be met to configure <attr>
>>>> +
>>>> +           scalar_increment:       A file that can be read to obtain the
>>>> +           resolution of the incremental value this attribute accepts.
>>>> +
>>>> +           upper_bound:    A file that can be read to obtain the upper
>>>> +           bound value of the <attr>
>>>
>>> Are these integers or also possibly floats? I guess possibly also floats, right?
>>> Then at a minimum this should specify which decimal-separator is used (I assume
>>> we will go with the usual '.' as decimal separator).
>>
>> In practice they're integers, but I don't see why they couldn't be floats.
> 
> Hmm, that is a bit hand-wavy, for an userspace ABI we really need to define
> this clearly. Either it is integers (which is fine), or it is floats and we need
> to define a decimal-separator as part of the ABI.
> 
> Note the reason why I started wondering about this in the first place is the
> scalar_increment attribute. I think that can use some clarification too.

p.s.

I just realized that the lower_ / upper_bound attributes would be
better if they were renamed to min_value and max_value then everyone
will immediately understand what they are without even needing to
consult the docs.

Regards,

Hans

