Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F792791CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIYUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgIYULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:11:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601064667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztp4baZQGLFiSERC0jFiTHiuuAoK78Oz0tRocIWkjFg=;
        b=BhEZYaaOypNXPifSE/IE5fySxlFm7scafKUqUXcJWnSRFcGe84/x5dgXlnJRESMvQ1lXaS
        VGRK+fSswWhYwCrBUd4sh6GLIunciiPWMhMwmAFgGC/NkNw0v5gYzKXPeA6YF2a22ZdU+e
        8QrDaNibb2XjrSAOvvaEI+FdveXAQPY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-YTB3gP2gPA6eL6PZ4lGXRw-1; Fri, 25 Sep 2020 15:40:32 -0400
X-MC-Unique: YTB3gP2gPA6eL6PZ4lGXRw-1
Received: by mail-ej1-f69.google.com with SMTP id ce9so1405510ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztp4baZQGLFiSERC0jFiTHiuuAoK78Oz0tRocIWkjFg=;
        b=Kg09JCyRM/uIryomd/aIO+GND64CHiYXkr8zwqfvyyslR6/Wz69k+jRvA13JhrKvmZ
         vSxtLWxvZOvHD2NDEWdP2QSqLD2nl0woVV9GAaBK4t8Xumnpg9uH2t6D9m99EGvM2qzq
         zHND9XHZD33snZlNL0LC/+2DJyXek1edhpok5etn54xVl3WLEUz+FXZb1gJQryc4mgVV
         9EFX+82uJrc/D3C8ebb65WyfrQHq0+O7qcn/U/gABBoVNGwO4ebyfImim/PKHnQOdnGa
         5lBOAZ+KCsrXE+r/gk800iNJjpu7URwxRH2amvDeisl2sSIsmAVGJ0EXqplnriS3xWkz
         e8vg==
X-Gm-Message-State: AOAM532GrV2y9Q3lepJ2lijpu6qaMH7m6f2mZpbSxc4Oq/nTY2WZhUd2
        8r+/wMqklFj8NXOwBWS6oMVW11jCFWO9dcbv0My9swh5h9Mr1y9TL2Pkht9Tuohc2aZtOZrKxWy
        lxh3r1PyvnIhuG+W2Sbmstyo7
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr3087029edq.80.1601062831456;
        Fri, 25 Sep 2020 12:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUTeKx8oOlxutBxVc5nMYaZQv73Cmwyu7nvKUK2nXUkz6ZqG83d6mmRymKXRZkDa8CPVcJOg==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr3087009edq.80.1601062831122;
        Fri, 25 Sep 2020 12:40:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p17sm2492875ejw.125.2020.09.25.12.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:40:30 -0700 (PDT)
Subject: Re: [PATCH v4] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Mark Pearson <mpearson@lenovo.com>
References: <20200923113015.110980-1-divya.bharathi@dell.com>
 <fc8315b6-a726-5c43-3858-b3201c2b525f@redhat.com>
 <DM6PR19MB2636AC4989C990760933AE39FA360@DM6PR19MB2636.namprd19.prod.outlook.com>
 <cb53d57f-212e-d74f-7842-dd74501fb53f@redhat.com>
 <DM6PR19MB263641DF4B7442CEE31BEAB5FA360@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df6e2dc8-0906-0e1f-4aef-47f929b98647@redhat.com>
Date:   Fri, 25 Sep 2020 21:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB263641DF4B7442CEE31BEAB5FA360@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/25/20 8:37 PM, Limonciello, Mario wrote:

<snip>

>>> So a user would see the different authentication mechanisms available
>>> by looking At the contents of /sys/class/firmware-
>> attributes/*/authentication
>>> and if they don't understand it's purpose they look at the type sysfs file.
>>
>> But one role can still have multiple mechanisms, so for Dell in the future
>> we could have say:
>>
>> /sys/class/firmware-attributes/dell/authentication/Admin-password
>> /sys/class/firmware-attributes/dell/authentication/Admin-hotp
>> /sys/class/firmware-attributes/dell/authentication/System-password
>>
>> So although I'm fine with taking the role_name directly from WMI
>> (combined with a roll attribute with standardized values) I think
>> we still need to postfix a -password to it now, to allow room
>> for adding say a -hotp mechanism for the same role_name in the
>> future ?
> 
> Could this be captured in the role attribute instead perhaps?  So the role
> attributes values could hypothetically be:
> bios-admin-password
> power-on-password
> 
> And if HOTP is added some day these could be added:
> bios-admin-hotp
> power-on-hotp

I would rather have the auth-mechanism-type in a separate mechanism sysfs-file
which could then contain e.g. "password" or "hotp".

But that does not solve the bit which I'm worried about,
what I'm worried about is a future scenario where there are multiple
auth mechanisms for the Admin role, and assuming we use one dir per
auth-mechanism then we would need 2 Admin sub-dirs which is not
allowed of course.

I assume that that is what the symlink suggestion you did:

 > I was going to suggest that if necessary a compatible way to add these would
 > be symlinks.  So if the directory right now was Admin and later was had
 > split to something like AdminHotp/AdminPassword
 > but wanted to discriminate between the old Admin it could be Admin->AdminPassword
 > or vice versa.

Is meant to address. So for now we go with just Admin and then if
the 2 auth-mechanisms for Admin at the same time scenario happens
add the "-<mechanism>" suffix to the directory name at that point.
Or I guess we could even add a ".%d" suffix for duplicates, since
the mechanism info would already be in the separate mechanism
sysfs file.  Then we can also avoid the symlink since we can just
leave out the .%d suffix when the integer for %d is 0, there is
precedence for that.

So TL;DR: yes we could put the mechanism in a sysfs file too,
in that case I would prefer to go with a separate file though,
rather then concatenating it to the role and storing it in the
role sysfs file.

If we have both the role and mechanism (hardcoded to "password"
for now) as sysfs-files in say a:

/sys/class/firmware-attributes/dell/authentication/Admin

Dir then indeed we will not need the "-password" suffix. And if
we get more then one auth-mechanism for say the "Admin" role then
we can just name the second subdir Admin.1, etc.

So compared to the current sysfs API from the v4 patch that would
mean adding the role ("admin", or "power-on") and mechanism
(always "password" for now) sysfs files and otherwise no changes.

Oh and can we rename the "is_authentication_set" sysfs file to "is_enabled"
please?  Being set is well defined for a password, but not so much for possible
other authentication-mechanisms.

<snip>

>>>> ###
>>>>
>>>> So as with the actual firmware-attributes I have also been comparing the
>>>> authentication
>>>> bits for the Dell case with the community thinkpad_wmi code. And again
>> things
>>>> are a pretty
>>>> good match already, including being able to query a minimum and maximin
>>>> password length.
>>>>
>>>> The only thing which is different, which I think would be good to add now,
>> is
>>>> a password_encoding sysfs-attribute. The Lenovo password interface supports
>>>> 2 encodings, "ascii" and "scancodes". Although I wonder if scancodes still
>>>> works on modern UEFI based platforms.
>>>>
>>>> Since the Dell password code uses UTF8 to UTF16 translation routines, I
>> guess
>>>> the encoding for the Dell password is UTF8 (at the sysfs level). So I would
>>>> like to propose
>>>> an extra password-authentication attribute like:
>>>>
>>>> 	password_encoding:  A file that can be read to obtain the encoding used
>>>> by
>>>> 			    the current_password and new_password attributes.
>>>> 			    The value returned should be one of: "utf8", "ascii".
>>>> 			    In some cases this may return a vendor-specific encoding
>>>> 			    like, e.g. "lenovo-scancodes".
>>>>
>>>> And for the Dell driver this would just be hardcoded to utf8.
>>>
>>> I don't really believe that another vendor's implementation would be likely
>> to
>>> use scan codes for the input into the WMI method.
>>
>> I did not make that example up, Lenovo really as a scan-codes encoding for
>> their password authentication mechanism, see:
>>
>> https://download.lenovo.com/pccbbs/mobiles_pdf/kbl-r_deploy_01.pdf
>>

<snip>

> The documentation you linked doesn't seem to indicate when to use scancodes or
> ASCII to me, so I can't draw any conclusions if certain models support one or
> the other.
> 
> I would suggest yes please don't support scancodes from the sysfs perspective for
> another vendor's implementation.  We should probably keep sysfs as utf8 and let
> any conversions be hidden in the kernel driver if necessary.

Doing the conversions in kernel is not really ideal, the kernels i18n support
is very limited. But yes for utf8->ascii and utf8->utf16 we can do the conversion
in kernel.

>> Even then there still is the unicode (utf8
>> in sysfs, utf16 at the WMI level for Dell) vs ascii issue and it would be nice
>> if a UI for this could give an error when the user tries to use non ascii
>> chars in a password for a vendor implementation...
> 
> I think that the kernel driver can certainly parse and provide -EINVAL in this
> context.

True, but the advantage of having userspace know it needs to be ascii is
that it can provide a much more sensible error message to the user when
the user tries to use non ascii in the password.

So I think that in the non utf8 case it would still be good to have
a password_encoding file. With that said, as discussed this sysfs-file
will be optional too, so for the "Systems Management Driver over WMI for Dell
Systems" we can just leave it out and then revisit when we merge a driver
which does not support utf8 for passwords.

>>> I would much prefer that this attribute only be added if it's actually
>> deemed
>>> necessary.  Or to my point that all attributes can be considered optional,
>> Dell's
>>> implementation would just not offer it.
>>
>> I guess that would work (Dell not offering it). Which makes me realize that
>> we should specify somewhere in the doc that all sysfs files which contain
>> a string value, the encoding is UTF8 unless explicitly specified otherwise.
>> (for that specific sysfs-attribute).
> 
> Yeah.  I guess the very top where we will modify to mention that all attributes
> are optional we can also mention that the encoding is UTF8 unless otherwise
> specified.

Ack.

Regards,

Hans

