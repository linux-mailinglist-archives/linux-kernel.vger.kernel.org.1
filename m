Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05482279025
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgIYSQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbgIYSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:16:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601057779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/50R4KfOHV2OxWmPVluhVpFzhZUBcr333kJPSCxRhrI=;
        b=OapqOWIV37oxXgqvBC5SfLuIMdBeJ3e5rZDuFmFCRQWysDYr2GHRD4TPToWzKShFT1p5mM
        h4DvP0LCnMRemZPvWHWyx70ywPVscOEuNGv5oNifDdVQpegCoPabavhmH1ssIXwkWxldiw
        tmgHWjydp1HuVKDM2PiEOrbX/UuGUto=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-q9wZE8zwM2yimJlULJpbdA-1; Fri, 25 Sep 2020 14:16:04 -0400
X-MC-Unique: q9wZE8zwM2yimJlULJpbdA-1
Received: by mail-ed1-f72.google.com with SMTP id n16so1482892edw.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/50R4KfOHV2OxWmPVluhVpFzhZUBcr333kJPSCxRhrI=;
        b=eCr1UkXWY1a4XrBP+09Eyvkvm6jcOZCCQmqdheUM0JEZzVg74aS4VEP2pZA6bu6uUT
         cmamCDf+ECU+BMPc6HSTyhyQvlHZs5t+w6OtI1iRQcWDNOcdO6Bl8piMzQgcuWTtWZqO
         WjNWryRWOBqUlB8WaP1LV3iqLG6Yn3xo8mW2ImS4GOUpmW0LanI+zw5k5jq1Qeb+0JGx
         1fDAcqFaXRvnLtC18qjug4J1iSQ41sIJ2w8a4DCbne4N5C418TdL7LbchVOkLVwDo4cB
         765bXbhJQK9+zlDMw/3+mGeRSh3WZmgEydAgYSPjkL4gF7e74GoASWyGJdGv8Q4GoVP1
         2KTQ==
X-Gm-Message-State: AOAM531CNYMQZK7zCaWDlL8py7QuO2hbX/ypxcZZk3RS0ZdJSetpLlUI
        ztZvhs+26E4O39gGPEAhBfkOs+DmJVyyS9fdgbgaBOGEBzt1Pga47C9SiCBTkmNKYQlamrl98+l
        tkiallC35t83UNwqyBDN4ZTel
X-Received: by 2002:a50:cd5e:: with SMTP id d30mr2643072edj.190.1601057762391;
        Fri, 25 Sep 2020 11:16:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbr4czrCZd/+U5/UipnwZN9VGdbE+lLriaq5pTMBF6qw+xOZlj1Z58+n0dYE1Ld+GMxD4q/A==
X-Received: by 2002:a50:cd5e:: with SMTP id d30mr2643038edj.190.1601057761934;
        Fri, 25 Sep 2020 11:16:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id la17sm2380237ejb.62.2020.09.25.11.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:16:01 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb53d57f-212e-d74f-7842-dd74501fb53f@redhat.com>
Date:   Fri, 25 Sep 2020 20:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636AC4989C990760933AE39FA360@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/25/20 5:32 PM, Limonciello, Mario wrote:
> So I do want to preface this response by mentioning that Dell's implementation
> is based off the PLDM specification from the DMTF.
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0247_1.0.0.pdf
> 
> A lot of the nomenclature that has been already proposed to change followed
> nomenclature previously used in the PLDM specification.  In the spirit of matching
> that specification in the Linux implementation we may consider to change things
> like proposed to be renamed min_value back to lower_bound, but that's up to your
> decision.

I really prefer min_value and max_value here, those have 2 advantages:

1. min/max is used almost everywhere in the kernel/sysfs for things like this,
    upper-/lower-bound feels a bit like archaic Enlish to me.

2. The _value postfix makes it immediately clear that they are the bounds for
    the current_value attribute.

Also in case of the password sysfs inteface min/max_lenght is used, not
e.g. password_length_lower_bound. So again using min/max seems more consistent.

>> This list seems to miss a "type" sysfs attribute, which tells which type
>> the firmware-attribute in question is. Sorry for not noticing that sooner.
> 
> Whoops :)
> 
>>
>>> +
>>> +		current_value:	A file that can be read to obtain the current
>>> +		value of the <attr>
>>
>> Can you indent the continuation on the second line to align with the start
>> of the description on the first line please?, e.g.:
>>
>> 		current_value:	A file that can be read to obtain the current
>> 				value of the <attr>
>>
>> This goes for all the sysfs-attribute description texts.
>>
>>> +
>>> +		This file can also be written to in order to update
>>> +		the value of a <attr>
>>> +
>>> +		default_value:	A file that can be read to obtain the default
>>> +		value of the <attr>
>>> +
>>> +		display_name:	A file that can be read to obtain a user friendly
>>> +		description of the at <attr>
>>> +
>>> +		display_name_language_code:	A file that can be read to obtain
>>> +		the IETF language tag corresponding to the "display_name" of the
>> <attr>
>>> +
>>> +		"enumeration"-type specific properties:
>>> +
>>> +		possible_values: A file that can be read to obtain the possible
>>> +		values of the <attr>. Values are separated using semi-colon.
>>
>> As non-native English speaker I had to lookup semi-colon to make sure that
>> it indeed is ';' as I already sorta expected. So can we add "(';')" (without
>> the "") behind the semi-colon to make this easier to parse for non-native
>> English
>> speakers?
> 
> 
> Some parts of the kernel documentation seem to use semi-colon (``;``) - example of
> admin-guide/bootconfig.rst
> 
> and others just set semi-colon - example of admin-guide/device-mapper/dm-init.rst.
> 
> But I don't see a problem with this change.
> 
>>
>>> +		"integer"-type specific properties:
>>> +
>>> +		min_value:	A file that can be read to obtain the lower
>>> +		bound value of the <attr>
>>> +
>>> +		max_value:	A file that can be read to obtain the upper
>>> +		bound value of the <attr>
>>> +
>>> +		scalar_increment:	A file that can be read to obtain the
>>> +		resolution of the incremental value this attribute accepts.
>>
>> Can we have an example here? I guess if for some reason only even/odd values
>> are allowed then this would contain "2" ?
> 
> Maybe adopting the PLDM description is better to explain it.
> 
> "The scalar value that is used for the increments to this integer"
>>
>>> +
>>> +		"string"-type specific properties:
>>> +
>>> +		max_length:	A file that can be read to obtain the maximum
>>> +		length value of the <attr>
>>> +
>>> +		min_length:	A file that can be read to obtain the minimum
>>> +		length value of the <attr>
>>
>> So I have been taking a look at a community written driven to allow changing
>> BIOS-settings / firmware-attributes on some Lenovo laptops:
>>
>> https://github.com/iksaif/thinkpad-wmi
>>
>> My main reason for doing so is to check if other vendors also support things
>> like "display_name", "default_value", etc.
>>
>> So for the normal attributes, it seems that for the Thinkpad WMI interface
>> they
>> are all enums and the do contain possible_values. So that is fine.
>>
>> But they do not have a separate display_name only a name-name, nor do they
>> have a default_value.
>>
>> So I think we should mark the display_name, display_name_language_code and
>> default_value sysfs-attributes optional, e.g. make the description look like
>> this:
>>
>> 		default_value:	An optional file that can be read to obtain the
>> 				default value of the <attr>
>>
> 
> At this point, why don't we just make a declaration at the top that all
> attributes are optional?  If you want this to scale to non-BIOS implementations
> of settings you couldn't know what they'll be able to offer and it sets
> an expectation that userspace to need to look for every sysfs file exists rather
> than just the vendor specific ones.

Sure I would be happy to have it documented that all firmware-attributes sysfs-files
are optional *except for type and current_value*. If you prefer that go for it.

> 
> +
>>> +		Drivers may emit a CHANGE uevent when a password is set or unset
>>> +		userspace may check it again.
>>
>> First of all some generic remarks:
>>
>> Currently the "Admin" and "System" names come directly from the Dell WMI
>> interface. I have 2 concerns with this:
>>
>> 1) What if we do get multiple authentication mechanisms for a single user,
>> e.g. both a type == "pasword" and type == "hotp" authentication. The way I
>> have
>> been thinking about that sofar, is that we then get 2 admin dirs under the
>> /sys/class/firmware-attributes/*/authentication dir, with a type attribute
>> per dir, following how we do the attributes. So we would get e.g. these 2
>> dirs:
>>
>> /sys/class/firmware-attributes/dell/authentication/admin-password
>> /sys/class/firmware-attributes/dell/authentication/admin-hotp
>>
>> For the admin user. If want to do it like this in the future we should
>> add some indirection between the WMI username and the dir which is created
>> now and create the Admin dir as admin-password starting now.
> 
> Yeah I think if HOTP is added to some vendor some day that's how it would work.
> The indirection can be added at that time.  One way to do this is to add

It seems you never finished your sentence here?

>> 2) The "Admin" name is clear enough, but the "System" name is somewhat
>> ambiguous and other vendors may call this differently, I think I have
>> at least seen it called the "User" password in some cases and Lenovo
>> seems to call it a power-on-password. I think that just calling it the
>> "boot" password makes sense. My main concern is that "System" is a bit
>> too vague. So then for now we would get:
>>
>> /sys/class/firmware-attributes/dell/authentication/admin-password
>> /sys/class/firmware-attributes/dell/authentication/boot-password
> 
> I want to be cognizant that vendors are going to call things differently
> in their attributes and we want the specifications and/or whitepapers that
> vendors use to refer to this to make sense to the system's administrator.
> 
> Dell uses the nomenclature "System" in all of it's documentation. If the Linux
> implementation calls it "boot password" or "power on password" it will be
> confusing to decode when someone see it.
> 
> Dell also has other terms used such as Master password and HDD password.
> They're not exposed in this interface but these all might have a different
> connotation across vendors.
> 
> So instead I would propose that within the folder the "type" attribute
> correspond to something decodable.  So the name the vendor uses is the
> folder and the type of password is within a sysfs file "type".
> 
> Proposed types:
> * "bios-admin"
> * "power-on"
> 
> Those two types can then be hardcoded by the implementation.

If re-using the WMI names is important for you, then having a sysfs-attribute
with some standardized value to say what is what inside the authentication-sub-dir
is fine with me.

Except that I would not call it type, when thinking about authentication-types
I think about things like password / totp / hotp. Can we call the sysfs-attribute
for this "role" instead ?

> So a user would see the different authentication mechanisms available
> by looking At the contents of /sys/class/firmware-attributes/*/authentication
> and if they don't understand it's purpose they look at the type sysfs file.

But one role can still have multiple mechanisms, so for Dell in the future
we could have say:

/sys/class/firmware-attributes/dell/authentication/Admin-password
/sys/class/firmware-attributes/dell/authentication/Admin-hotp
/sys/class/firmware-attributes/dell/authentication/System-password

So although I'm fine with taking the role_name directly from WMI
(combined with a roll attribute with standardized values) I think
we still need to postfix a -password to it now, to allow room
for adding say a -hotp mechanism for the same role_name in the
future ?

(I guess this also ties into your unanswered question from above.

>> The spec. should also specify that the part before the first '-' is the
>> username, and the part after it is the authentication type. E.g. the
>> docs for this could look something like this:
>>
>> 	Directories under /sys/class/firmware-attributes/*/authentication/
>> 	use the following directory-name pattern:
>> 	<username>-<authentication_method>
>>
>> 	Where username must be one of: "admin" or "boot":
> 
> Username is inappropriate in this context, especially since firmware doesn't
> have a concept of multi-user.  It's a configurable permissions scheme to what
> you are allowed to do in firmware.

Ack, so as I asked above, what do you think of using "role" here instead?


>> 	admin	If any authentication_method is enabled for the admin user, then
>> 		authentication as the admin user is required to modify BIOS
>> settings.
>> 	boot	If any authentication_method is enabled for the admin user, then
>> 		authentication as the boot user is required to boot the machine.
>>
>> 	And where authentication_method must be "password". Note in the future
>> 	both more usernames and more authentication_method-s may be added.
>>
>> 	All authentication_methods must have the following sysfs-attributes:
>>
>> 	is_enabled:  This reads "1" if the authentication_method is enabled,
>> 		     and "0" if its disabled
>>
>> 	Any changes to authentication_methods will generate a change uevent,
>> 	upon receiving this event applications should recheck the authentication
>> 	settings such as the is_enabled flag.
>>
>> 	Password authentication_method specific sysfs-attributes:
>>
>> 	max_password_length: ... (continue with the old text)
>>
>> Note:
>>
>> 1) This is a proposal to make the authentication bits a bit more generic /
>>      future proof. This is very much open for discussion.
>>
>> 2) The new generic is_enabled sysfs-attribute replaces the
>> is_authentication_set flag
>>
>> ###
>>
>> So as with the actual firmware-attributes I have also been comparing the
>> authentication
>> bits for the Dell case with the community thinkpad_wmi code. And again things
>> are a pretty
>> good match already, including being able to query a minimum and maximin
>> password length.
>>
>> The only thing which is different, which I think would be good to add now, is
>> a password_encoding sysfs-attribute. The Lenovo password interface supports
>> 2 encodings, "ascii" and "scancodes". Although I wonder if scancodes still
>> works on modern UEFI based platforms.
>>
>> Since the Dell password code uses UTF8 to UTF16 translation routines, I guess
>> the encoding for the Dell password is UTF8 (at the sysfs level). So I would
>> like to propose
>> an extra password-authentication attribute like:
>>
>> 	password_encoding:  A file that can be read to obtain the encoding used
>> by
>> 			    the current_password and new_password attributes.
>> 			    The value returned should be one of: "utf8", "ascii".
>> 			    In some cases this may return a vendor-specific encoding
>> 			    like, e.g. "lenovo-scancodes".
>>
>> And for the Dell driver this would just be hardcoded to utf8.
> 
> I don't really believe that another vendor's implementation would be likely to
> use scan codes for the input into the WMI method.

I did not make that example up, Lenovo really as a scan-codes encoding for
their password authentication mechanism, see:

https://download.lenovo.com/pccbbs/mobiles_pdf/kbl-r_deploy_01.pdf

> Think back to how this all works on Windows...

<snip>

> So if you had to manually convert to scancodes, that would not at all user friendly.

It definitely is not user-friendly.

Note when calling the Lenovo WMI functions you can specify in which encoding
(ascii or scancodes) you are providing the data and all Lenovo's examples
use the ascii encoding.  But there also is a bitfield with supported encodings
and I guess some older firmware may only support the scancodes variant?

It is all somewhat not nice, which is why I prefixed the scancodes encoding
with lenovo- to make it clear that it is non-standard.

But lets say all Lenovo models support the ascii encoding and we never expose
the scancodes bit to userspace. Even then there still is the unicode (utf8
in sysfs, utf16 at the WMI level for Dell) vs ascii issue and it would be nice
if a UI for this could give an error when the user tries to use non ascii
chars in a password for a vendor implementation...

> I would much prefer that this attribute only be added if it's actually deemed
> necessary.  Or to my point that all attributes can be considered optional, Dell's
> implementation would just not offer it.

I guess that would work (Dell not offering it). Which makes me realize that
we should specify somewhere in the doc that all sysfs files which contain
a string value, the encoding is UTF8 unless explicitly specified otherwise.
(for that specific sysfs-attribute).

Regards,

Hans

