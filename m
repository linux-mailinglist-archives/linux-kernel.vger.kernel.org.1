Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6962928DFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgJNL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729919AbgJNL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602674986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaTsnB/NmKVi1NdOeJ8x36SBfiUo2Aw3Dr5NQTlitH8=;
        b=L9ozmRE373JG0pB5f+UUvYq0nZYncriZZ8Q/nymKstcAx9a08htrAHUqRXlwE9geho2toX
        CKE6Lir9Gk8n3Mr/AZ0omdFbwwf7+uZo3eg9P0kMF7tpw2q0TrHcC1Fm5mnP2wNgkvaDdp
        GVTOW6ocHEPp6nzAXEXXtzxjvcffsBA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-0wI13JxvNSWg2docutOBvQ-1; Wed, 14 Oct 2020 07:29:42 -0400
X-MC-Unique: 0wI13JxvNSWg2docutOBvQ-1
Received: by mail-ed1-f72.google.com with SMTP id 28so1067833edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QaTsnB/NmKVi1NdOeJ8x36SBfiUo2Aw3Dr5NQTlitH8=;
        b=le31+pv5HQ4Yrh9QzV008UphOl55TQ/cMbU9BcsNBoNDnGSDXpkiUoeSTbkqTiIudU
         Is0yGukw/zegV3UtdV2qvwnon82z7B1R5go/ST0in/51idBUXD4RJz4DcRavio8UjGo8
         cjVa1ZPnDWM9dvxdoZG1J9Be62gcK+pf0ld3a6RN+Vk/0WEhvmPR+37rH7IVpKtjC+R5
         ZkkZ0huC3Gj3rsrf4apyZveh2Gyzt7wgXctqcy9S9s6e2huWDOKsWG0fPgalXX6ycsiP
         p4eV4XCLu9OQeWI3jMWvHXIVY3w05qjEzk0RkfkflKyBBL0vM9UBafHuF2fKJaVJtYhH
         XP8g==
X-Gm-Message-State: AOAM531YYg9wYUK+Mfnpu3A+Oaf4yiel2Tym2wj1CNCDZP8j/Y1lXeU1
        DJvPj0n4v7igPd2AKcui6r35gPEKqZfq5VyF5kMO1zqGFzCguv980IyMB9N4W8LjzuWUKNBewjQ
        363K4P2yML2/orGE6gBMlr3XE
X-Received: by 2002:a17:906:647:: with SMTP id t7mr4893227ejb.428.1602674981326;
        Wed, 14 Oct 2020 04:29:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGwyGFjVIKKl7Lf54hI7fTvEm7ElH89Mrc1DoIC7JOvVhmBSc+i8q8DLy1qpxgvj3X6UtjYA==
X-Received: by 2002:a17:906:647:: with SMTP id t7mr4893207ejb.428.1602674981114;
        Wed, 14 Oct 2020 04:29:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m16sm1398566edj.37.2020.10.14.04.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:29:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed W <lists@wildgooses.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
 <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d0d91191-cad2-94a1-6373-0f3ff4e38376@redhat.com>
Date:   Wed, 14 Oct 2020 13:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/20 1:21 PM, Ed W wrote:
> On 14/10/2020 09:41, Hans de Goede wrote:
>>
>> So I have a suggested compromise:
>>
>> Keep the current LED/gpio setup code, but make executing it conditional
>> on the BIOS version and skip the LED/gpio setup when the new BIOS is
>> present to avoid having duplicate LED entries, etc. in that case.
>>
>> I guess this would still break userspace because if I understand things
>> correctly the new ACPI based setup uses different LED names ? That
>> seems unfortunate, but I guess that from the kernel pov we can just
>> blame the BIOS for this, and since we definitely do not want duplicate
>> LED entries for the same LED, this seems the least bad choice.
>>
>> Enrico, would that work for you ?
> 
> 
> I'm cool with this. Enrico?
> 
> I may have some time imminently to have a stab at a new patch. Obviously any help structuring this
> would be appreciated - it feels clumsy using the existing detection mechanism, I think whatever I
> come up with you should kick back and recommend a new board detection structure, but perhaps we can
> shortcut that step with a few comments up front?

I'm afraid I do not have any wisdom to share here. I would use the DMI bios-version
or bios-date strings for the detection, but I guess that is obvious.

Other then I guess I would do a preparation patch restructuring the code so that
the whole conditional part becomes a single if, e.g.:

	if (old_bios()) {
		ret = register_leds_and_gpio_for_old_bios()
		if (ret)
			goto error_cleanup;
	}

So in a separate preparation commit put all the code which you tried to
remove earlier in a single helper function (feel free to pick a different name).

And then in that prep patch the above would look like this:

	ret = register_leds_and_gpio_for_old_bios()
	if (ret)
		goto error_cleanup;

And a follow-up commit adding the new/old bios detection would
introduce the if.

And do the same for the cleanup parts for module unloading.

I hope this helps...

Regards,

Hans

