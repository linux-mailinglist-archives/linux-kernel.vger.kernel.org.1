Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB22A996E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgKFQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:26:35 -0500
Received: from mailrelay1-2.pub.mailoutpod1-cph3.one.com ([46.30.212.0]:60050
        "EHLO mailrelay1-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgKFQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-type:in-reply-to:mime-version:date:message-id:references:cc:to:from:
         subject:from;
        bh=SxG8W321K37P/2Nept94VZxZoM7KKo/nS12XQk8CKNk=;
        b=SFsmAipPQwR2Ej+GWfwALmQG1dY9mUnDiQ0xGUQCM8C/SnrvRvcpWQtpLf92UF/q6QxgfqxvnBZaZ
         X+imnkYcJ/31lzotgGQeIImNvUUW0QcEY4jRac6eM7Wqu5JU6owF+ReiocL2luudvkrPIslNlk3ByB
         kyLqGnqeZNLl7R4WuUtxyun5eiwFWbt8GR+x+EZj1m1e4jtOTo3dSyPxrIVfe9CdhU51Bj0eStE995
         RuaiVMcdCloPKMGf/+FlWUZ/mc+YsqxSXTz6+qBn2sl586S28o7UdgF2JU4fTr9/stHGE9Uy71yPgM
         TeX4Psatzlf8fkuLF1ojxrry7dHy0qQ==
X-HalOne-Cookie: 163c5e454e45403160b48d3b89fde72e40892aa8
X-HalOne-ID: d2c0e733-204c-11eb-9654-d0431ea8a283
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id d2c0e733-204c-11eb-9654-d0431ea8a283;
        Fri, 06 Nov 2020 16:26:29 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
From:   Henrik Rydberg <rydberg@bitmath.org>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
Message-ID: <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
Date:   Fri, 6 Nov 2020 17:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
Content-Type: multipart/mixed;
 boundary="------------B6F41B33EAEA186500550465"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B6F41B33EAEA186500550465
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I can't guarantee it won't break older machines which is why I've 
>> asked for help testing it. I only have a MacbookPro 11,1 and an iMac 
>> 12,2. It fixes both of those.
>>
>> Help testing would be much appreciated.
> 
> I see, this makes much more sense. I may be able to run some tests 
> tonight. Meanwhile, looking at the patch, the status variable in 
> send_command looks superfluous now that there is a wait_status() before it.

Ok, it took some time to get the machines up to speed, but so far I have 
managed to run some tests on an MacBookAir1,1. I only managed to upgrade 
up to 4.15, so I had to revert the inputdev polling patch, but the rest 
applied without problems. I recovered an old test program I used to use 
(attached), and checked for failures and reads per second

*** hwmon: (applesmc) switch to using input device polling mode

At this point in the tree, with this reverted, I see 0 failures and 55 
reads per second.

*** hwmon: (applesmc) avoid overlong udelay()

With this applied, I see 0 failures and 16 reads per second.

*** hwmon: (applesmc) check status earlier.

With this applied, I see 0 failures and 16 reads per second.

*** (HEAD -> stable) applesmc: Re-work SMC comms v2

With this applied, the kernel hangs in module probe, and the kernel log 
is flooded with read failures.

So as it stands, it does not work at all. I will continue to check 
another machine, and see if I can get something working.

Henrik

--------------B6F41B33EAEA186500550465
Content-Type: application/x-shellscript;
 name="applesmc-test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="applesmc-test.sh"

IyEvYmluL2Jhc2gKIwojIFRoaXMgc2NyaXB0IHRlc3RzIHRoZSBwcmVzZW5jZSBhbmQgcGVy
Zm9ybWFuY2Ugb2YKIyB0aGUgYXBwbGVzbWMgbW9kdWxlIG9uIEFwcGxlIG1hY3RlbCBjb21w
dXRlcnMuCiMKIyBrb3N1bWk2OEB1YnVudHVmb3J1bXMub3JnCiMKCmlmIFsgYHdob2FtaWAg
IT0gInJvb3QiIF07IHRoZW4KICAgIGVjaG8gInNjcmlwdCBtdXN0IGJlIHJ1biBhcyByb290
IChydW4gd2l0aCBzdWRvKSIKICAgIGV4aXQgMQpmaQoKZGV2PS9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS9hcHBsZXNtYy43NjgKCmVjaG8gLW4gIm1vZGVsOiAiCmRtaWRlY29kZSAtcyBzeXN0
ZW0tcHJvZHVjdC1uYW1lCmVjaG8KCiMgQWNjZWxlcm9tZXRlcgplY2hvIC1uICJhY2NlbGVy
b21ldGVyOiIKaWYgWyAtYSAkZGV2L3Bvc2l0aW9uIF07IHRoZW4KICAgIGVjaG8gLW4gIiBw
cmVzZW50IgogICAgb3V0PWBjYXQgJGRldi9wb3NpdGlvbiAyPi9kZXYvbnVsbGAKICAgIGlm
IFsgJD8gPSAwIF07IHRoZW4KICAgICAgICBlY2hvIC1uICIsIHJlYWRhYmxlLCBvdXRwdXQ6
ICRvdXQiCiAgICBlbHNlCiAgICAgICAgZWNobyAtbiAiLCBub3QgcmVhZGFibGUiCiAgICBm
aQplbHNlCiAgICBlY2hvIC1uICIgbm90IHByZXNlbnQiCmZpCmVjaG8KCiMgRmFuIC0gb25s
eSBjaGVjayBmaXJzdCBmYW4KZWNobyAtbiAiZmFuOiAgICAgICAgICAiCmlmIFsgLWEgJGRl
di9mYW4xX291dHB1dCBdOyB0aGVuCiAgICBlY2hvIC1uICIgcHJlc2VudCIKICAgIG91dD1g
Y2F0ICRkZXYvZmFuMV9vdXRwdXQgMj4vZGV2L251bGxgCiAgICBpZiBbICQ/ID0gMCBdOyB0
aGVuCiAgICAgICAgZWNobyAtbiAiLCByZWFkYWJsZSwgb3V0cHV0OiAkb3V0IgogICAgZWxz
ZQogICAgICAgIGVjaG8gLW4gIiwgbm90IHJlYWRhYmxlIgogICAgZmkKZWxzZQogICAgZWNo
byAtbiAiIG5vdCBwcmVzZW50IgpmaQplY2hvCgojIExpZ2h0CmVjaG8gLW4gImxpZ2h0OiAg
ICAgICAgIgppZiBbIC1hICRkZXYvbGlnaHQgXTsgdGhlbgogICAgZWNobyAtbiAiIHByZXNl
bnQiCiAgICBvdXQ9YGNhdCAkZGV2L2xpZ2h0IDI+L2Rldi9udWxsYAogICAgaWYgWyAkPyA9
IDAgXTsgdGhlbgogICAgICAgIGVjaG8gLW4gIiwgcmVhZGFibGUsIG91dHB1dDogJG91dCIK
ICAgIGVsc2UKICAgICAgICBlY2hvIC1uICIsIG5vdCByZWFkYWJsZSIKICAgIGZpCmVsc2UK
ICAgIGVjaG8gLW4gIiBub3QgcHJlc2VudCIKZmkKZWNobwoKIyBMZWRzCmxlZHM9YGxzICRk
ZXYvbGVkcy8qL2JyaWdodG5lc3MgMj4vZGV2L251bGxgCmVjaG8gLW4gImxlZHM6ICAgICAg
ICAgIgppZiBbICIkbGVkcyIgIT0gIiIgXTsgdGhlbgogICAgZWNobyAiIHByZXNlbnQsIgog
ICAgZm9yIHggaW4gJGxlZHM7IGRvCiAgICAgICAgZWNobyAtbiAiIGxlZDogICAgICAgICAg
ICAgICAgICAgIgogICAgICAgIG91dD1gY2F0ICR4IDI+L2Rldi9udWxsYAogICAgICAgIGlm
IFsgJD8gPSAwIF07IHRoZW4KICAgICAgICAgICAgZWNobyAtbiAicmVhZGFibGUsIG91dHB1
dDogJG91dCIKICAgICAgICBlbHNlCiAgICAgICAgICAgIGVjaG8gLW4gIm5vdCByZWFkYWJs
ZSIKICAgICAgICBmaQogICAgICAgIGVjaG8KICAgIGRvbmUKZWxzZQogICAgZWNobyAiIG5v
dCBwcmVzZW50IgpmaQoKIyBUZW1wZXJhdHVyZXMKdGVtcHM9YGxzICRkZXYvdGVtcCppbnB1
dCAyPi9kZXYvbnVsbGAKZWNobyAtbiAidGVtcGVyYXR1cmVzOiAiCmlmIFsgIiR0ZW1wcyIg
IT0gIiIgXTsgdGhlbgogICAgZWNobyAiIHByZXNlbnQsIgogICAgZm9yIHggaW4gJHRlbXBz
OyBkbwogICAgICAgIGVjaG8gLW4gIiB0ZW1wZXJhdHVyZTogICAgICAgICAgICIKICAgICAg
ICBvdXQ9YGNhdCAkeCAyPi9kZXYvbnVsbGAKICAgICAgICBpZiBbICQ/ID0gMCBdOyB0aGVu
CiAgICAgICAgICAgIGVjaG8gLW4gInJlYWRhYmxlLCBvdXRwdXQ6ICRvdXQiCiAgICAgICAg
ZWxzZQogICAgICAgICAgICBlY2hvIC1uICJub3QgcmVhZGFibGUiCiAgICAgICAgZmkKICAg
ICAgICBlY2hvCiAgICBkb25lCmVsc2UKICAgIGVjaG8gIiBub3QgcHJlc2VudCIKZmkKCiMg
UGVyZm9ybWFuY2UKZWNobyAtbiAicGVyZm9ybWFuY2U6ICAgIgppZiBbICIkdGVtcHMiICE9
ICIiIF07IHRoZW4KICAgIGVjaG8gInJlYWRpbmcgYWxsIHRlbXBlcmF0dXJlcyIKICAgIHR5
cGVzZXQgLWkgaT0wCiAgICB0eXBlc2V0IC1pIGU9MAogICAgdHlwZXNldCAtaSBuPTUwMAog
ICAgdHlwZXNldCAtaSB0MT1gZGF0ZSArJXNgCiAgICB3aGlsZSBbICRpIC1sdCAkbiBdOyBk
bwogICAgICAgIG91dD1gY2F0ICR0ZW1wcyAyPi9kZXYvbnVsbGAKICAgICAgICBpZiBbICQ/
ICE9IDAgXTsgdGhlbgogICAgICAgICAgICBlPSRlKzEKICAgICAgICBmaQogICAgICAgIGk9
JGkrMQogICAgZG9uZQogICAgdHlwZXNldCAtaSB0Mj1gZGF0ZSArJXNgCiAgICBmYWlsPWBl
Y2hvIHNjYWxlPTMnOycgJGUvJG4gfCBiY2AKICAgIHNwZWVkPWBlY2hvICRuLycoJyR0Mi0k
dDEnKScgfCBiY2AKICAgIGVjaG8gIiBmYWlsIGZyZXF1ZW5jeTogICAgICAgIiAkZmFpbAog
ICAgZWNobyAiIHJlYWRzIHBlciBzZWNvbmQ6ICAgICAiICRzcGVlZAplbHNlCiAgICBlY2hv
ICIgbm90IHBlcmZvcm1lZCIKZmkKZWNobwoKY2QgJGRldgoKIyBGYW4gY29udHJvbCB2ZXJz
aW9uCmVjaG8gLW4gInNtYy1mYW46ICIKCnR5cGVzZXQgLWkgbXRfaXg9MAp0eXBlc2V0IC1p
IHNmX2l4PTAKdHlwZXNldCAtaSBpeD0xCnR5cGVzZXQgLWkgaXhtYXg9YGNhdCBrZXlfY291
bnRgCgojIGZpbmQgdGhlIGluZGV4IG9mIHRoZSBNdCBhbmQgU2YgcmVnaXN0ZXJzCndoaWxl
IFsgJGl4IC1sdCAkaXhtYXggXTsgZG8KICAgIGVjaG8gLW4gJGl4ID4ga2V5X2F0X2luZGV4
CiAgICBuYW1lPWBjYXQga2V5X2F0X2luZGV4X25hbWUgMj4gL2Rldi9udWxsYAogICAgaWYg
WyAiJG5hbWUiID0gIkYwTXQiIF07IHRoZW4KCWVjaG8gLW4gIiBNdCIKCW10X2l4PSRpeAog
ICAgZmkKICAgIGlmIFsgIiRuYW1lIiA9ICJGMFNmIiBdOyB0aGVuCgllY2hvIC1uICIgU2Yi
CglzZl9peD0kaXgKICAgIGZpCiAgICBpeD0kaXgrMQpkb25lCgppZiBbICRtdF9peCA9IDAg
LWEgJHNmX2l4ICE9IDAgXTsgdGhlbgogICAgZWNobyAtbiAiIHR5cGUgQSIKZmkKCmlmIFsg
JG10X2l4ICE9IDAgLWEgJHNmX2l4ICE9IDAgXTsgdGhlbgogICAgZWNobyAtbiAiIHR5cGUg
QiIKZmkKCmlmIFsgJG10X2l4ICE9IDAgLWEgJHNmX2l4ID0gMCBdOyB0aGVuCiAgICBlY2hv
IC1uICIgdHlwZSBDIgpmaQplY2hvCg==
--------------B6F41B33EAEA186500550465--
