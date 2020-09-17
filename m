Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E6326D897
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgIQKNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgIQKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600337587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+hwi7YJI4TPq52R5OLk88Dp9POsN+S8ypLkGLER598=;
        b=LjORgp9qPy/t3RJ4S08+kX/GlZd+L9l6jBfYZICvgM3Jik6m/DKBjBEJI3pglNZEycY9hd
        zGxuDmwaolv4GILIVHWFFT0+MlMGSzq7XeQmtv9ekCd+Xy0PFL+eIHinKG0FMSyLRRbohC
        Fts1a7yGAoIWQI1rdlGTqg6eNiEAq6w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-ExyKMq0ANvSZ4DJRTzYXGA-1; Thu, 17 Sep 2020 06:12:00 -0400
X-MC-Unique: ExyKMq0ANvSZ4DJRTzYXGA-1
Received: by mail-ej1-f71.google.com with SMTP id b23so701799ejv.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+hwi7YJI4TPq52R5OLk88Dp9POsN+S8ypLkGLER598=;
        b=k7KILyM2JxOXexW/yiw7Gb8Z+l5Vh53NugdwbvwTP8oS36M54YpAFgGt7fUY5/aV1J
         hxgk+BDFZVxiw4FyAKBh+9siXeCW6LQawP8dHfEIljB9dFgm6q9rIL7JI5iDClumxHq0
         s2LUG41Te8HjimBrbhwwANpc7vHDc2lIz4sS6w/qSdiLJ90m+INPgSxlWP8Uf8vne6gO
         j/FgDSsDAlF6Wc59vrw/WzB2L2K1XJDMHrfR9fm4TAXhb97HbbNS6u/Dayjhb4ugYEIn
         9WefwWVvnwCFj974IlHZPKKRFIt+2H/O/yfLmrM7nfoN2d3UOd2uIHac+zSX0o/xuNHD
         PVdQ==
X-Gm-Message-State: AOAM5327W7pKlqVTc6EVmfJ5fyRVkhBP2eS4HtQNHPHpxOus1f5EK65C
        wTXwiA9TIOHQhBLUrGgaMvyf3Ss41jzccmISoemAeS/NbVD7yInbqFkLhJfc/67g3ogazemH0wo
        non4qVdFFM2+OItE0RmS9t6tf
X-Received: by 2002:a17:906:2681:: with SMTP id t1mr12738623ejc.474.1600337519024;
        Thu, 17 Sep 2020 03:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybIGHkD8kwpiGJiP6DgXfRE0e5iPW7jHUNnU1jQVMT35HfYCcHXwr0TLVt5lpCv+19PBFmpg==
X-Received: by 2002:a17:906:2681:: with SMTP id t1mr12738606ejc.474.1600337518717;
        Thu, 17 Sep 2020 03:11:58 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id e15sm11355614ejm.68.2020.09.17.03.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 03:11:58 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Richard Hughes <rhughes@redhat.com>,
        Jared Dominguez <jaredz@redhat.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
 <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
 <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
Date:   Thu, 17 Sep 2020 12:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 6:06 PM, Limonciello, Mario wrote:
>> So my thinking here is as follows:
>>
>> 1. AFAIK other vendors may want to do something similar in the near future
>> 2. The interface you (Dell) have come up with looks pretty generic / complete
>> to me

<snip>

>>> Dell sets precedent here by having the first driver.
>>
>> Right and normally I may have wanted to wait until a second vendor implements
>> a similar mechanism under Linux so that we can find common ground between the
>> 2 implementations for the generic userspace API for this.
>>
> 
> I think in terms of the basic sysfs files and their contents, a generic API makes
> fine sense, but I'm hung specifically up on the flow when the firmware interface is
> locked down.

Ok.

>> The problem with that approach is that because we do not break userspace,
>> we then get to carry the "temporary" vendor-specific implementation of the
>> userspace API around for ever, since it may very well have existing users
>> before we replace it with the generic API.
>>
>> This scenario would mean that after some point in time (when the generic API
>> gets
>> added to the kernel) Dell needs to support 2 userspace APIs the one which is
>> being introduced by this patch + the generic one going forward.
>>
>> Since to me the current API/ABI Dell is proposing is pretty generic I'm
>> trying to avoid this having 2 maintain 2 different userspace APIs problem
>> by making this the generic API from the get go.
> 
> I'm worried that we actually end up in a situation that the "generic" one supports
> these basic features.  This is very similar to the Dell one, but misses certain
> enhancements that are not in the generic one so you have to use the Dell one to get
> those features.  And then how do you know which one to select from the kernel config?
> 
> It gets messy quickly.

If there are 2 interfaces then yes it can get messy, but having 2 interfaces is
exactly what I'm trying to avoid here.

>>> 2) Dell has some extensions planned for other authentication mechanisms than
>> password.
>>> That is *definitely* going to be Dell specific, so should it be done in this
>> vendor
>>> agnostic directory?
>>
>> Well each property:
>>
>> /sys/class/firmware-properties/dell-bios/<property-name>
>>
>> Will have a type attribute:
>>
>> /sys/class/firmware-properties/dell-bios/<property-name>/type
>>
>> You can use dell-special-auth-mechanism as type for this and
>> then it is clear it is dell specific. As mentioned above I
>> fully expect new types to get added over this and userspace tools
>> will be expected to just skip properties with unknown types
>> (possibly with a warning).
> 
> So I think the nuance that is missed here is the actual flow for interacting with
> an attribute when password security is enabled in today's patch set (both v1 and v2).
> 
> Userspace would perform like this:
> 1) Check "is_password_set" attribute to determine if admin password required
> 2) If yes write password into the current_password attribute (location changed in 2 patches)
> 3) write new attribute value(s)
> 4) If necessary clear current_password attribute
> 
> This works like a "session" today with admin password.  So if you have a generic interface
> representing things as attributes you need to also have a generic attribute indicating
> authentication required.  That would mean ALL attributes need to have a "authentication_required"
> type of attribute.
> 
> And then that comes back to the point that authentication flow is definitely not generic.
> Dell requires you to write the password in every WMI call today, but the sysfs interface actually
> behaves like a session and caches the password in memory for the next call.
> 
> As a completely hypothetical idea what if another vendor also supports an admin password but decides for
> their threat model it's actually a password hashed appended with a nonce and hashed and hence
> needs to be set every time from sysfs?
> 
> Their flow might look something like this:
> 1) Check auth_required attribute
> 2) Write hash(password|nonce) to current_password
> 3) Write attribute
> 4) Write hash(password|nonce) to current_password
> 5) Not necessary to clear current_password
> 
> Those are very different flows to get to and change the same "types" of data.  By Dell's interface
> being Dell specific we can guarantee that the documented flow works how it should.

Documenting the flow could be part of the documentation for the
different passwd types. For how things currently work the User and
Admin password attributed would have a type of "password", the hash
example you gave will have a different type for its password attribute,
e.g. "hotp" and not only the type could be different but also
the sysfs-attributes, e.g. the "Admin" password-dir which has a "type"
sysfs-atrribute which returns "htop" may not have a current_password
attribute at all, instead it may would have a hash attribute, making
it (more) clear that this one works differently.

This would mean that existing userspace software can not work with
systems using the new "hotp" password atrributes, but that is
unavoidable.

I think that the current generic password flow will work well
for other vendors too, they may need to not cache it in the
kernel (instead sending it directly to the firmware once), but the basic
concept of having to write the plain-text bios Admin password before
being able to change protected settings seems like it is something which
matches how most current BIOS-es work.  And needing a way to re-lock the
settings also sounds like something which will be pretty common for most
implementations.

>> We could even do something like we have for .desktop files
>> fields, where we add something to the sysfs ABI documentation
>> that vendors may add vendor specific types prefixed with X-<vendorname>.
>>
>> So all in all I believe that we can make using the proposed sysfs ABI
>> a generic one work, and that this will be worth it to avoid having the
>> issue of eventually having both a couple of vendor specific APIs +
>> one grant unified generic API replacing those vendor-APIs
>> (where we can never drop the vendor specific APIs because of
>> backward compat. guarantees).
> 
> I'm personally leaning on the right place to have a vendor agnostic view is "outside"
> of the kernel in an userland library.  All the vendor drivers that change settings can
> behave very similarly for the most part, but differences between vendor implementations
> can be better expressed there.

We have tried that before in several cases (that I'm aware of) and this never
works out. Esp. not when the basic kernel interface is reasonable sane,
then a lot of people / projects avoid the lib and just poke the kernel API
directly. We have seen this e.g. with hwmon-class devices and with v4l devices
and with backlight-class devices. Since I've seen this happen 3 times already
I'm not a big believer in adding a userspace library to hide the vendor
differences.

Regards,

Hans

