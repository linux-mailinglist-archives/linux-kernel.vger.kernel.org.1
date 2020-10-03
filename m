Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C81282455
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgJCNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 09:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgJCNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 09:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601732358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M7e4lIsCrzIGf7633HTEOQCv2O7TpnRjrbQ+L1jCps=;
        b=h9DO+OPUaRk76DvrbEFVstsH4hduCemYGb3U/sD02aPgizoGT+yMHArghUZYqNoMfpGiYg
        UaIBg69kbPukHP9n2HTD2km2hItxMH436lAgq8pQzEWZYKRd/duyyLMNrxI2iPhVkDPk3i
        LEhlw/TloMfs+Iqbxh3Q2MQN2nolVcw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-sOMgRXt2NVeH9SKn_jq5Ng-1; Sat, 03 Oct 2020 09:39:16 -0400
X-MC-Unique: sOMgRXt2NVeH9SKn_jq5Ng-1
Received: by mail-ed1-f71.google.com with SMTP id j6so2251009edl.21
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8M7e4lIsCrzIGf7633HTEOQCv2O7TpnRjrbQ+L1jCps=;
        b=KmbiTJjyO7pRFAkCi7aHzJG4TV1QHk+f75CUhnTi5VJ74VY5Q8pa68wloaQa6VQg2V
         N9JqvhnXRwc2YOBoECsNM7L4uJOSa39O0uQiUYA11FeIz7ZZgjVSSV4sy3AgRNwOPFkV
         YNYlX8OUUMAkEvMgyYwcIjQWbzk4VmTd3r960PA8fpjkJCv3T5bF6vKpKmdlwOAXKOer
         Wdq+hG5e67bJvA0w37s41mXGGQQPgmzm+rPfKNi/CYvy2gfVEPfHe9kEOIwvIrYGZYE5
         pcyoRaorzDHDVU/YBV6Nn7DB8HQ6VqXriByHWutI1pfUjAeDeMLCXBpZrH/2kto9bXRb
         PTXw==
X-Gm-Message-State: AOAM532xJc20iATpeRPpEqmaxRRd5edctpxEo1yH433hI5qOMbTqCVZS
        KQDFFrfsP0jER84S9N67iI5tu9VtVy+4BqFfJcKaYNO0Ds4i2W/wsEC9Q7EZ0+bVkYmUzBC/Ik6
        ev5Cl84dVBEZqz1e7QPh4CBHy
X-Received: by 2002:a05:6402:155a:: with SMTP id p26mr8652930edx.178.1601732355492;
        Sat, 03 Oct 2020 06:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX1eRSwaIKAlLcSeLEYrz8kiWIM1N+hxxRa99xXnEHb2oygDOhJkjJCKXqwVTA0PWPd2r+Pw==
X-Received: by 2002:a05:6402:155a:: with SMTP id p26mr8652913edx.178.1601732355341;
        Sat, 03 Oct 2020 06:39:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g11sm4413115edj.85.2020.10.03.06.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 06:39:14 -0700 (PDT)
Subject: Re: [RFC 0/1] Documentation: Add documentation for new
 performance_profile sysfs class
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201003131938.9426-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <18b2f906-240e-68ba-8604-0d93065fcc5e@redhat.com>
Date:   Sat, 3 Oct 2020 15:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003131938.9426-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/20 3:19 PM, Hans de Goede wrote:
> Hi All,
> 
> Recently 2 different patches have been submitted for drivers under
> drivers/platform/x86 to configure the performance-profile of
> modern laptops (see the actual RFC patch for what I mean with
> a performance-profile). One for the thinkpad_acpi driver and
> one for the hp-wmi driver.
> 
> Since I don't want each pdx86 driver to invent its own userspace API
> for this I have started a dicussion about coming up with a standardized /
> common sysfs class / API for this on the pdx86 list:
> https://www.spinics.net/lists/platform-driver-x86/msg22794.html
> 
> The sysfs API proposal which I'm sending out as RFC in this email
> thread is the result of me trying to distill that discussion into
> a concrete proposal.
> 
> I have Cc-ed the linux-pm and linux-acpi lists because even though
> the trigger for doing this is 2 different pdx86 drivers, the resulting
> API should (must even) also be suitable for other platforms. I can
> e.g. see various modern ARM platforms also having similar functionality
> which they may want to export to userspace and the ideally the userspace
> code for allowing the end-user to configure/select a profile would be
> the same under ARM and x86.
> 
> Talking about userspace I've also Cc-ed Bastien and Benjamin who are
> working on the userspace side of this.

p.s.

About the type part of the proposed sysfs API for this, the idea
here is that e.g. the Intel pstate driver could also export a
performance-profile interface, mirroring the custom interface it
currently has for this.

The performance-profile-daemon (p-p-d) Bastien is working on already
talks to the pstate driver in some cases.  Currently it does this using
the pstate drivers own/custom API, but that does not really scale. If
ARM or AMD chips get similar functionality in the future then ideally
these would export a /sys/class/performance-profile with a type
of "cpu" and then p-p-d would just need to talk to the performance-profile
API, instead of needing to have its own internal HAL to deal with
different CPU vendors.

Regards,

Hans

