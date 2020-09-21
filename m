Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E4271F96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIUKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgIUKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600682584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/zm5Y2Zo2/TPNP0q36DB3tiECpHWQ7DeNh07xXELbg=;
        b=c7nPNqfhKcFBBhygrN7YjqM6EDEo5QUZYdyd/XcJAAffx1U7aI85X6y48E3UdqonHaOdts
        ncw2PBHpRcBmDHCs8/wncj24C3u19w+1zx9uRLfmt/kDVRJk4St+Zwt9piDMUNj23E6FlZ
        JK2leCRXjhMVYxHskpf/uVbNkyWZ5hA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-oDxfn9XiMMeYq0y5N8Xr2g-1; Mon, 21 Sep 2020 06:02:57 -0400
X-MC-Unique: oDxfn9XiMMeYq0y5N8Xr2g-1
Received: by mail-ed1-f69.google.com with SMTP id x23so4451410eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/zm5Y2Zo2/TPNP0q36DB3tiECpHWQ7DeNh07xXELbg=;
        b=H6k/KqkyLGJBO+VA7kKBEKwMnnRFAVkk/ogB/typTHgy/hI5xR+2RrtSsxXpZnNHYs
         LUndSN3kQvPJ97OUORGcRAwt1jKVFbKcKteBeTSIYRXoqggcAD4VafDrXY65L+4usS7m
         CfTPH14/zeH9UVfIF8t86Jb4YASbJKCkmRKD5SK+J1+XNcHUjA1CadfR+Cd0QzCdl4Yv
         GCMp0P13mnBPzTsrpNaxNkNdRR7J/5taCtjMgv/B5UUB9X8Dlrnhq7qWyxVPFaiZm875
         BtNQW4UPdDXj2sZaWSORtjjhLTkEsthE24xHVfndsU41+B2qlyNof0dKJNf14G7w6JbB
         Hacg==
X-Gm-Message-State: AOAM531nXPcp/53TdlKhE6CUWRALwO+c4tiYFzN9a6GFcGP28AWYRWe7
        FePWUTUktwGOxgCv0Qd1pWLWAgu1TFGaE1Aji6RU3xO6Af3v9GwSiImzlHz09NPpF9D8dTadvH6
        Y6K8vnY3gpEJcCaxWJ0BBSl5j
X-Received: by 2002:a17:907:417c:: with SMTP id oe20mr47540905ejb.322.1600682576388;
        Mon, 21 Sep 2020 03:02:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdFuJUzzRKmA4e1doelYwQsgNYphu2cvSOFKzY/YOaAPYs14pE6te3mxqLARcsvRUZrh2mdA==
X-Received: by 2002:a17:907:417c:: with SMTP id oe20mr47540867ejb.322.1600682575968;
        Mon, 21 Sep 2020 03:02:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y24sm8180387eds.35.2020.09.21.03.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:02:55 -0700 (PDT)
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
 <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
 <DM6PR19MB2636626A94385EDC7C0CACF9FA3E0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <33666ec6-be47-2c33-d4c5-6b23b53f6185@redhat.com>
Date:   Mon, 21 Sep 2020 12:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636626A94385EDC7C0CACF9FA3E0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/20 6:18 PM, Limonciello, Mario wrote:
>>> Those are very different flows to get to and change the same "types" of
>> data.  By Dell's interface
>>> being Dell specific we can guarantee that the documented flow works how it
>> should.
>>
>> Documenting the flow could be part of the documentation for the
>> different passwd types.
> 
> In the concept of a "generic" API I don't think the word "password" is futureproof
> and it would need to be avoided.  I think a better term would be "authentication".

Ack.

>> For how things currently work the User and
>> Admin password attributed would have a type of "password", the hash
>> example you gave will have a different type for its password attribute,
>> e.g. "hotp" and not only the type could be different but also
>> the sysfs-attributes, e.g. the "Admin" password-dir which has a "type"
>> sysfs-atrribute which returns "htop" may not have a current_password
>> attribute at all, instead it may would have a hash attribute, making
>> it (more) clear that this one works differently.
> 
> In our definition `current_password` is intentionally not readable by userspace.
> One process could be writing it (think obtaining it from an escrow service) and
> another interacting with attributes, and their threat models might not match.

I completely agree that current_password should be write-only, I don't
see that s a problem.

> Furthermore - what's to say multiple authentication schemes might not be
> simultaneously supported and this needs to be expressed?  This can be a difference
> between OEM implementations.

Well if different schemes are supported and each scheme has its own type,
then I would expect there to be say / e.g.:

/sys/class/firmware-attributes/dell/authentication/admin-password
(with a type of "password") and:
/sys/class/firmware-attributes/dell/authentication/admin-hotp
(with a type of "hotp")

And then the user / userspace can choose which one to use,
I guess if the kernel knows that only hotp has been setup and
there is no standard password set, then it could hide the
/sys/class/firmware-attributes/dell/authentication/admin-password
password.

TBH I think all these things are (mostly) easily solvable if/when we
encounter them. I mean it is definitely good to keep these kind of things
in mind. But at some point we might get lost in all the what-ifs we
can come up with.

>> This would mean that existing userspace software can not work with
>> systems using the new "hotp" password atrributes, but that is
>> unavoidable.
> 
>>
>> I think that the current generic password flow will work well
>> for other vendors too, they may need to not cache it in the
>> kernel (instead sending it directly to the firmware once), but the basic
>> concept of having to write the plain-text bios Admin password before
>> being able to change protected settings seems like it is something which
>> matches how most current BIOS-es work.  And needing a way to re-lock the
>> settings also sounds like something which will be pretty common for most
>> implementations.
>>
> 
> OK so here is another place that I think vendors might have a different
> implementation.  When you have a BIOS admin password set, Dell requires that
> password to interact with any of these attributes.  Another vendor might
> only require it only for certain attributes they deemed protected.
> 
> So again, Dell's flow might not scale to everyone else.
> 
> I do acknowledge this might be mitigatable by adding a sysfs file to every
> attribute for Dell's implementation "is_authentication_required" that is always
> 1 when admin password required and in another implementation an OEM might choose
> to set that on a case by case basis.

If a vendor comes along where authentication is not necessary
for *all* attributes, then we could add the "is_authentication_required"
as an optional sysfs-attribute for the firmware-attributes and state
in the documentation that if that file is lacking that means that
authentication is always required. That way the Dell code would not
even have to have the "is_authentication_required" sysfs-attribute.


>>>> We could even do something like we have for .desktop files
>>>> fields, where we add something to the sysfs ABI documentation
>>>> that vendors may add vendor specific types prefixed with X-<vendorname>.
>>>>
>>>> So all in all I believe that we can make using the proposed sysfs ABI
>>>> a generic one work, and that this will be worth it to avoid having the
>>>> issue of eventually having both a couple of vendor specific APIs +
>>>> one grant unified generic API replacing those vendor-APIs
>>>> (where we can never drop the vendor specific APIs because of
>>>> backward compat. guarantees).
>>>
>>> I'm personally leaning on the right place to have a vendor agnostic view is
>> "outside"
>>> of the kernel in an userland library.  All the vendor drivers that change
>> settings can
>>> behave very similarly for the most part, but differences between vendor
>> implementations
>>> can be better expressed there.
>>
>> We have tried that before in several cases (that I'm aware of) and this never
>> works out. Esp. not when the basic kernel interface is reasonable sane,
>> then a lot of people / projects avoid the lib and just poke the kernel API
>> directly. We have seen this e.g. with hwmon-class devices and with v4l devices
>> and with backlight-class devices. Since I've seen this happen 3 times already
>> I'm not a big believer in adding a userspace library to hide the vendor
>> differences.
>>
>> Regards,
>>
>> Hans
> 
> Another area that comes to mind is Dell's value_modifier and modifier rules.  This
> dependency logic is handled and expressed by the firmware.  You'll notice the Dell
> driver only displays the information that came out of the firmware in sysfs and doesn't
> do any processing in driver.
> 
> So by using Dell's format, another vendor's driver will need to follow Dell's
> formatting and rule validation/generation which their firmware might not support and
> they will be forced to implement Dell's schema in their kernel driver.

Since we also seem to have some trouble to get these 2 properly documented
(I have not looked at v3 yet), I'm fine with making them dell specific by prefixing them
with dell-. I guess that that probably even makes sense.

> Lastly I want to caution that individual firmware items with the same name might have
> a different meaning across vendors.  Here is my hypothetical example:
> 
> Dell has an attribute called "Camera"  With V3 it populates under:
> /sys/devices/platform/dell-wmi-sysman/attributes/Camera
> 
> The description sysfs for it reads as "Enable Camera" and it's possible values are
> "Disabled;Enabled;".  For Dell this is pretty obviously it turns on and off the camera
> functionality.
> 
> For another vendor they might actually not offer to enable/disable the camera but instead
> To enable the control of an electromagnetic camera shutter from such an attribute.
> Their attribute could still be called "Camera" but the description might read as
> "Enable camera shutter control".  For them it would still read as "Disabled;Enabled;"
> for possible values but have a completely different meaning!
> 
> There is no standard for this, and again userspace will need to basically look at
> the directory and structure to figure out what the meaning actually is.

I can envision similar issues popping up between different generations / models
of Dell hardware even. Specifying what changing the attributes actually does falls
(way) outside of the scope of the sysfs ABI IMHO. That will always be the case
of please consult your Laptop's / Workstation's / Server's manual.
That is actually not much different from the current builtin
firmware setup utility experience where the help text is often,
well, not helpful.

For all I care there is an enum called "HWvirt" with a description of
"Hardware virtualization support" and values of "Enabled" and "Disabled"
which controls something somewhat or even totally different from what the
name and description suggest. That would be less then ideal, but not a problem
from the pov of the sysfs ABI for firmware-attributes. It would be a simple
case of the garbage in garbage out principle.

So this is one problem which I'm happy to punt to userspace and I guess Dell
might do a Dell specific utility, which only works one certain model Dell's,
which is a lot fancier then the basic sysfs functionality and e.g. consumes
the dell-value_modifier and dell-modifier sysfs-attribures.

The purpose behind having a unified userspace ABI is to e.g. allow configuring
firmware settings for a fleet of machines from:

https://wiki.gnome.org/Projects/FleetCommander

Using a generic plugin which works across different vendors.

And maybe have a simple vendor-agnostic pygtk3 UI which allows users to
poke at things, even if they have to figure out in which order they need
to change things in some cases (which again is actually not that
different from the current builtin firmware setup utility experience
for a lot of vendors).

I guess a could way to look at the generic sysfs firmware attributes
class I'm proposing is looking at it as a lowest common denominator
solution. With the addition of vendor specific extensions so that
vendors (e.g. Dell) are not limited to only offering functionality
offered by the generic, shared ABI. Does that make sense ?

Regards,

Hans

