Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350128DBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgJNIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgJNIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602664867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAh1DeV7uIYRcIpZNM6oHtZxM4LU3Qd9ofxTIddzbBY=;
        b=VIcKEvaYRxf+gMKYKh2ykoS4g5qDPiCamSrIpo2n9udD9NzW/F+03FbF77UC/WDzrj3yRc
        HXl4nfw/YCud5/pfKIXnr2kDM9MRp9wUA7hQCYAVkNabbp+EqNsHsCi1YM9nORDj9I9zHt
        vLSIdkGs7xlIQsxTK0bptLeX03UGYjU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-rBmST02aNyOVcf-nzA5kjA-1; Wed, 14 Oct 2020 04:41:06 -0400
X-MC-Unique: rBmST02aNyOVcf-nzA5kjA-1
Received: by mail-ej1-f71.google.com with SMTP id ga21so896520ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 01:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAh1DeV7uIYRcIpZNM6oHtZxM4LU3Qd9ofxTIddzbBY=;
        b=ZkleKQ4x9Dy/ud94ELnwIjPu6gjyBJBZXIpL39AdZgUD3Cm+j7yoUEYO+oXDg/ZFoF
         NmQ7QV7s58G3tFxIi2apUYwFpCUuIpsmDuEvCwrjdkIUCQsW1axBJKqNYEPX5CrutFKJ
         rVCMgcnsV0CmbP6XreEqkzLjwEqKf6C8dYpHf5gz0Z7Es+RqeQhld2lpxk2BkQsmWp+m
         JttrYOZCjEud9p7HX0E0zQxFhpD/l1A6+G4a2G6bgvaRU8bhAcOvj82C8pJE3FgIi07o
         QOfZnt7ptc4BzUqj9KDKfYc5CWPwPlf/M9VEZm84fK0dgH+36nogM80RRBG0xojRWoVc
         a7GQ==
X-Gm-Message-State: AOAM531HUBQj9th9quciteG7MgRbD9htdOtIDHAVmXKEW+NBhMuSFNkE
        X2gLogi/k0+8HZtOSdivivDbO7IEaUCVNk6hmLgM4/1SWnRv4NZ87Bkx3+Mo9cWqO8f0q3fc37y
        BzH6f+VSLf9rDAnv3N2tCKPES
X-Received: by 2002:a50:a143:: with SMTP id 61mr4024251edj.57.1602664864304;
        Wed, 14 Oct 2020 01:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhgNnuUASC/K0403R4Hj2KqQnJqvhO67GV5RD4RfZH49AFrLY8TFt6Gtl+wXiSGWK51CtjSA==
X-Received: by 2002:a50:a143:: with SMTP id 61mr4024238edj.57.1602664864086;
        Wed, 14 Oct 2020 01:41:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m6sm1392648ejl.94.2020.10.14.01.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 01:41:03 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
Date:   Wed, 14 Oct 2020 10:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/20 11:40 PM, Ed W wrote:

<snip>

> Hans, can I ask you to look again at the history of this please. Bearing in mind the speed kernel
> stuff takes to get to end users, we are talking about a very small window of userland changes here.
> I would vote for simplifying this module and trying to reduce some baggage. However, my main goal is
> to get support in for APU5. Second goal is to reduce the duplicate LED devices. Beyond that I'm not
> so fussed?

Honestly I would prefer for you and Enrico to come to some sort of
consensus here, since you both know this code a lot better then I do.

If you cannot come to a consensus then I guess I will have to make
a decision here, but I would really prefer not to have to
arbitrate here.

Also note that I did already take a peek at the backlog before
Enrico's email and I was already wondering about the userspace
breakage _myself_ before Enrico chimed in. I did not reply then
because I only took a quick peek and decided to deal with the
backlog later.

As for the history of this all. Just because the userspace API
was broken once and we got away with it (IOW no body complained I
guess), does not mean that we should do this again.

Generally speaking there is a very hard rule that once shipped we
never break the userspace API and if I don't enforce that rule
then Torvalds will and in the process get angry at me
(been there done that). So sorry, but breaking userspace is
really not an option.

Also you mention in the commit messages for this patch that the
code is being removed because a new BIOS now enumerates them
through the new device-tree embedded in ACPI tables mechanism,
correct ?

That means that if people stick with the old BIOS and get a new
kernel they will loose all access to the LED functionality that
seems quite bad?  Note that also as a general, but certainly
as a pdx86 rule we try very hard to not rely on people installing
BIOS updates because whole troves of users do not install BIOS updates
(I understand that these boards are all kinds of special, so this may
apply here even more (or less so)).

So I have a suggested compromise:

Keep the current LED/gpio setup code, but make executing it conditional
on the BIOS version and skip the LED/gpio setup when the new BIOS is
present to avoid having duplicate LED entries, etc. in that case.

I guess this would still break userspace because if I understand things
correctly the new ACPI based setup uses different LED names ? That
seems unfortunate, but I guess that from the kernel pov we can just
blame the BIOS for this, and since we definitely do not want duplicate
LED entries for the same LED, this seems the least bad choice.

Enrico, would that work for you ?

Regards,

Hans

