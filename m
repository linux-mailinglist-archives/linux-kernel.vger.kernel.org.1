Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9902A37A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKCARt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:17:49 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:42512 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCARs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:17:48 -0500
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 19:17:46 EST
Received: from srv.home ([10.8.0.1] ident=heh27878)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kZjgM-0006HY-R4; Tue, 03 Nov 2020 07:56:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=MYzpXa7Pz9hemsf0dmKOWn5cCpqeksbON08+DLuGqF4=;
        b=oMaBZbemWGUmPzf5OQJvaegiWVL/2930KivzBX4eDplW6usD2s5Iot+Z/Ryh4MToxJHDGtAjM/k+SDKDMSB0Gp6yP0X8+7jE34m1G1HNDmUlyfMaf/QPT/uu5EWXMH4x94uATBJIfouRcK9Q7GwbUVByt7Cg0laYuE/pcpSuuOE=;
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Andreas Kemnade <andreas@kemnade.info>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
Date:   Tue, 3 Nov 2020 10:56:11 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20201006090226.4275c824@kemnade.info>
Content-Type: multipart/mixed;
 boundary="------------950FE4B4FE2534C610E592AB"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------950FE4B4FE2534C610E592AB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/20 6:02 pm, Andreas Kemnade wrote:
> On Thu, 1 Oct 2020 21:07:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 10/1/20 3:22 PM, Andreas Kemnade wrote:
>>> On Wed, 30 Sep 2020 22:00:09 +0200
>>> Arnd Bergmann <arnd@arndb.de> wrote:
>>>    
>>>> On Wed, Sep 30, 2020 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On Wed, Sep 30, 2020 at 10:54:42AM +0200, Andreas Kemnade wrote:
>>>>>> Hi,
>>>>>>
>>>>>> after the $subject patch I get lots of errors like this:
>>>>>
>>>>> For reference, this refers to commit fff2d0f701e6 ("hwmon: (applesmc)
>>>>> avoid overlong udelay()").
>>>>>     
>>>>>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>>>>>> [  120.378621] applesmc: LKSB: write data fail
>>>>>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>>>>>> [  120.512787] applesmc: LKSB: write data fail
>>>>>>
>>>>>> CPU sticks at low speed and no fan is turning on.
>>>>>> Reverting this patch on top of 5.9-rc6 solves this problem.
>>>>>>
>>>>>> Some information from dmidecode:
>>>>>>
>>>>>> Base Board Information
>>>>>>          Manufacturer: Apple Inc.
>>>>>>          Product Name: Mac-7DF21CB3ED6977E5
>>>>>>          Version: MacBookAir6,2
>>>>>>
>>>>>> Handle 0x0020, DMI type 11, 5 bytes OEM Strings         String 1: Apple ROM Version.  Model:       …,
>>>>>> Handle 0x0020, DMI type 11, 5 bytes
>>>>>> OEM Strings
>>>>>>          String 1: Apple ROM Version.  Model:        MBA61.  EFI Version:  122.0.0
>>>>>>          String 2: .0.0.  Built by:     root@saumon.  Date:         Wed Jun 10 18:
>>>>>>          String 3: 10:36 PDT 2020.  Revision:     122 (B&I).  ROM Version:  F000_B
>>>>>>          String 4: 00.  Build Type:   Official Build, Release.  Compiler:     Appl
>>>>>>          String 5: e clang version 3.0 (tags/Apple/clang-211.10.1) (based on LLVM
>>>>>>          String 6: 3.0svn).
>>>>>>
>>>>>> Writing to things in /sys/devices/platform/applesmc.768 gives also the
>>>>>> said errors.
>>>>>> But writing 1 to fan1_maunal and 5000 to fan1_output turns the fan on
>>>>>> despite error messages.
>>>>>>     
>>>>> Not really sure what to do here. I could revert the patch, but then we'd gain
>>>>> clang compile failures. Arnd, any idea ?
>>>>
>>>> It seems that either I made a mistake in the conversion and it sleeps for
>>>> less time than before, or my assumption was wrong that converting a delay to
>>>> a sleep is safe here.
>>>>
>>>> The error message indicates that the write fails, not the read, so that
>>>> is what I'd look at first. Right away I can see that the maximum time to
>>>> retry is only half of what it used to be, as we used to wait for
>>>> 0x10, 0x20, 0x40, 0x80, ..., 0x20000 microseconds for a total of
>>>> 0x3fff0 microseconds (262ms), while my patch went with the 131ms
>>>> total delay based on the comment saying "/* wait up to 128 ms for a
>>>> status change. */".
>>>>   
>>> Yes, that is also what I read from the code. I just thought there must
>>> be something simple, which just needs a short look from another pair of
>>> eyes.
>>>    
>>>> Since there is sleeping wait, I see no reason the timeout couldn't
>>>> be extended a lot, e.g. to a second, as in
>>>>
>>>> #define APPLESMC_MAX_WAIT 0x100000
>>>>
>>>> If that doesn't work, I'd try using mdelay() in place of
>>>> usleep_range(), such as
>>>>
>>>>             mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC)));
>>>>
>>>> This adds back a really nasty latency, but it should avoid the
>>>> compile-time problem.
>>>>
>>>> Andreas, can you try those two things? (one at a time,
>>>> not both)
>>>
>>> Ok, I tried. None of them works. I rechecked my work and created real
>>> git commits out of them and CONFIG_LOCALVERSION_AUTO is also set so
>>> the usual stupid things are rules out.
>>> In detail:
>>> On top of 5.9-rc6 + *reverted* patch:
>>> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
>>> index fd99c9df8a00..2a9bd7f2b71b 100644
>>> --- a/drivers/hwmon/applesmc.c
>>> +++ b/drivers/hwmon/applesmc.c
>>> @@ -45,7 +45,7 @@
>>>   /* wait up to 128 ms for a status change. */
>>>   #define APPLESMC_MIN_WAIT	0x0010
>>>   #define APPLESMC_RETRY_WAIT	0x0100
>>> -#define APPLESMC_MAX_WAIT	0x20000
>>> +#define APPLESMC_MAX_WAIT	0x8000
>>>   
>>>   #define APPLESMC_READ_CMD	0x10
>>>   #define APPLESMC_WRITE_CMD	0x11
>>>    
>>
>> Oh man, that code is so badlys broken.
>>
>> send_byte() repeats sending the data if it was not immediately successful.
>> That is done for both data and commands. Effectively that happens if
>> the command is not immediately accepted. However, send_argument()
>> clearly assumes that each data byte is sent exactly once. Sending
>> it more than once will mess up the key that is supposed to be sent.
>> The Apple SMC emulation code in qemu confirms that data bytes can not
>> be written more than once.
>>
>> Of course, theoretically it may be that the first data byte was not
>> accepted (after all, the ACK bit is not set), but the ACK bit is
>> not checked again after udelay(APPLESMC_RETRY_WAIT), so it may
>> well have been set in the 256 uS between its check and re-writing
>> the data.
>>
>> In other words, this entire code only works accidentally to start with.
>>
>> If you like, you could play around with the code and find out if and
>> when exactly bit 1 (busy) is set, if and when bit 2 (ack) is set, and
>> if and when any other bit is set. We could also try to read port 0x31e
>> (the error port). Maybe the we can figure out what the error actually
>> is. But then I don't really know what we could do with that information.
>>
> Smoe research results: the second data byte seems to cause problems, not the
> command byte.
> 
>> Other than that, the only useful idea I have is something crazy like
>> 	if (us < 10000)
>> 		udelay(us);
>> 	else
>> 		mdelay(DIV_ROUND_CLOSEST(udelay, 1000));
>> in the hope that clang doesn't convert that back into a
>> compile-time constant and udelay().
>>
>> Overall it seems like the apple protocol may expect to receive data
>> bytes faster than 1ms apart, because that is the only real difference
>> between the original code and the new code using mdelay().
> 
> Yes, that explanation makes sense. If I am trying something like that, only
> the last byte requires more than APPLESMC_MIN_WAIT. I have seen max. 256us.
> So we could probably even use msleep for us > 1000 and udelay for anything below.
> 
> Regards,
> Andreas
> 

G'day Andreas,

I've examined the code in VirtualSMC and I'm not convinced we were not waiting on the wrong bits.

#define SMC_STATUS_AWAITING_DATA  BIT0  ///< Ready to read data.
#define SMC_STATUS_IB_CLOSED      BIT1  /// A write is pending.
#define SMC_STATUS_BUSY           BIT2  ///< Busy processing a command.
#define SMC_STATUS_GOT_COMMAND    BIT3  ///< The last input was a command.
#define SMC_STATUS_UKN_0x16       BIT4
#define SMC_STATUS_KEY_DONE       BIT5
#define SMC_STATUS_READY          BIT6  // Ready to work
#define SMC_STATUS_UKN_0x80       BIT7  // error

Any chance you could try this patch? It's ugly, hacked together and currently fairly undocumented, but if it works I'll figure out how to clean it up (suggestions welcome).
It works on my MacbookPro 11,1.

I've also attached a script I adapted from https://github.com/floe/smc_util.git that I use to hammer the SMC with reads.
The behavior pre 5.9 and post this patch is the same.

Regards,
Brad

--------------950FE4B4FE2534C610E592AB
Content-Type: text/plain; charset=UTF-8;
 name="smc.patch.2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="smc.patch.2"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vYXBwbGVzbWMuYyBiL2RyaXZlcnMvaHdtb24v
YXBwbGVzbWMuYwppbmRleCBhMTg4ODc5OTBmNGEuLjI1MDBjYzdlYmNhNSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9od21vbi9hcHBsZXNtYy5jCisrKyBiL2RyaXZlcnMvaHdtb24vYXBwbGVz
bWMuYwpAQCAtMTUxLDY1ICsxNTEsNTggQEAgc3RhdGljIHVuc2lnbmVkIGludCBrZXlfYXRf
aW5kZXg7CiBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmFwcGxlc21jX2xlZF93
cTsKIAogLyoKLSAqIHdhaXRfcmVhZCAtIFdhaXQgZm9yIGEgYnl0ZSB0byBhcHBlYXIgb24g
U01DIHBvcnQuIENhbGxlcnMgbXVzdAotICogaG9sZCBhcHBsZXNtY19sb2NrLgorICogV2Fp
dCBmb3Igc3BlY2lmaWMgc3RhdHVzIGJpdHMgb24gdGhlIFNNQwogICovCi1zdGF0aWMgaW50
IHdhaXRfcmVhZCh2b2lkKQorCitzdGF0aWMgaW50IHdhaXRfc3RhdHVzKHU4IHZhbCwgdTgg
bWFzaykKIHsKLQl1bnNpZ25lZCBsb25nIGVuZCA9IGppZmZpZXMgKyAoQVBQTEVTTUNfTUFY
X1dBSVQgKiBIWikgLyBVU0VDX1BFUl9TRUM7CiAJdTggc3RhdHVzOwogCWludCB1czsKKwl1
bnNpZ25lZCBsb25nIGVuZCA9IGppZmZpZXMgKyAoQVBQTEVTTUNfTUFYX1dBSVQgKiBIWikg
LyBVU0VDX1BFUl9TRUM7CiAKIAlmb3IgKHVzID0gQVBQTEVTTUNfTUlOX1dBSVQ7IHVzIDwg
QVBQTEVTTUNfTUFYX1dBSVQ7IHVzIDw8PSAxKSB7Ci0JCXVzbGVlcF9yYW5nZSh1cywgdXMg
KiAxNik7CiAJCXN0YXR1cyA9IGluYihBUFBMRVNNQ19DTURfUE9SVCk7Ci0JCS8qIHJlYWQ6
IHdhaXQgZm9yIHNtYyB0byBzZXR0bGUgKi8KLQkJaWYgKHN0YXR1cyAmIDB4MDEpCisJCWlm
ICgoc3RhdHVzICYgbWFzaykgPT0gdmFsKQogCQkJcmV0dXJuIDA7Ci0JCS8qIHRpbWVvdXQ6
IGdpdmUgdXAgKi8KIAkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgZW5kKSkKIAkJCWJyZWFr
OwotCX0KLQotCXByX3dhcm4oIndhaXRfcmVhZCgpIGZhaWw6IDB4JTAyeFxuIiwgc3RhdHVz
KTsKKwkJdXNsZWVwX3JhbmdlKHVzLCB1cyAqIDE2KTsKKwkJfQorCXByX3dhcm4oIndhaXRf
c3RhdHVzIHRpbWVvdXQ6IDB4JTAyeFxuIiwgc3RhdHVzKTsKIAlyZXR1cm4gLUVJTzsKIH0K
LQorCQogLyoKICAqIHNlbmRfYnl0ZSAtIFdyaXRlIHRvIFNNQyBwb3J0LCByZXRyeWluZyB3
aGVuIG5lY2Vzc2FyeS4gQ2FsbGVycwogICogbXVzdCBob2xkIGFwcGxlc21jX2xvY2suCiAg
Ki8KLXN0YXRpYyBpbnQgc2VuZF9ieXRlKHU4IGNtZCwgdTE2IHBvcnQpCi17Ci0JdTggc3Rh
dHVzOwotCWludCB1czsKLQl1bnNpZ25lZCBsb25nIGVuZCA9IGppZmZpZXMgKyAoQVBQTEVT
TUNfTUFYX1dBSVQgKiBIWikgLyBVU0VDX1BFUl9TRUM7CiAKK3N0YXRpYyBpbnQgc2VuZF9i
eXRlX2RhdGEodTggY21kLCB1MTYgcG9ydCwgYm9vbCBza2lwKQoreworCXU4IHdzdGF0PTB4
NDQ7CisJaWYgKHNraXApCisJCXdzdGF0PTB4NDA7CisJaWYgKHdhaXRfc3RhdHVzKDB4NDQs
IDB4RjYpKQorCQlnb3RvIGZhaWw7CiAJb3V0YihjbWQsIHBvcnQpOwotCWZvciAodXMgPSBB
UFBMRVNNQ19NSU5fV0FJVDsgdXMgPCBBUFBMRVNNQ19NQVhfV0FJVDsgdXMgPDw9IDEpIHsK
LQkJdXNsZWVwX3JhbmdlKHVzLCB1cyAqIDE2KTsKLQkJc3RhdHVzID0gaW5iKEFQUExFU01D
X0NNRF9QT1JUKTsKLQkJLyogd3JpdGU6IHdhaXQgZm9yIHNtYyB0byBzZXR0bGUgKi8KLQkJ
aWYgKHN0YXR1cyAmIDB4MDIpCi0JCQljb250aW51ZTsKLQkJLyogcmVhZHk6IGNtZCBhY2Nl
cHRlZCwgcmV0dXJuICovCi0JCWlmIChzdGF0dXMgJiAweDA0KQotCQkJcmV0dXJuIDA7Ci0J
CS8qIHRpbWVvdXQ6IGdpdmUgdXAgKi8KLQkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgZW5k
KSkKLQkJCWJyZWFrOwotCQkvKiBidXN5OiBsb25nIHdhaXQgYW5kIHJlc2VuZCAqLwotCQl1
ZGVsYXkoQVBQTEVTTUNfUkVUUllfV0FJVCk7Ci0JCW91dGIoY21kLCBwb3J0KTsKLQl9Ci0K
LQlwcl93YXJuKCJzZW5kX2J5dGUoMHglMDJ4LCAweCUwNHgpIGZhaWw6IDB4JTAyeFxuIiwg
Y21kLCBwb3J0LCBzdGF0dXMpOworCWlmICghIHdhaXRfc3RhdHVzKHdzdGF0LCAweEZFKSkK
KwkJcmV0dXJuIDA7CitmYWlsOgorCXByX3dhcm4oInNlbmRfYnl0ZV9kYXRhKDB4JTAyeCwg
MHglMDR4KSBmYWlsXG4iLCBjbWQsIEFQUExFU01DX0NNRF9QT1JUKTsKIAlyZXR1cm4gLUVJ
TzsKIH0KIAogc3RhdGljIGludCBzZW5kX2NvbW1hbmQodTggY21kKQogewotCXJldHVybiBz
ZW5kX2J5dGUoY21kLCBBUFBMRVNNQ19DTURfUE9SVCk7CisJaWYgKHdhaXRfc3RhdHVzKDB4
NDAsIDB4RjIpKSB7IHByX3dhcm4oInNlbmRfY29tbWFuZCBmYWlsIDFcbiIpOworCQlnb3Rv
IGZhaWw7fQorCW91dGIoY21kLCBBUFBMRVNNQ19DTURfUE9SVCk7CisJaWYgKHdhaXRfc3Rh
dHVzKDB4NEMsIDB4RkYpKSB7IHByX3dhcm4oInNlbmRfY29tbWFuZCBmYWlsIDJcbiIpOwor
CQlnb3RvIGZhaWw7fQorCXJldHVybiAwOworZmFpbDoKKwlwcl93YXJuKCJzZW5kX2NtZCgw
eCUwMngsIDB4JTA0eCkgZmFpbFxuIiwgY21kLCBBUFBMRVNNQ19DTURfUE9SVCk7CisJcmV0
dXJuIC1FSU87CiB9CiAKIHN0YXRpYyBpbnQgc2VuZF9hcmd1bWVudChjb25zdCBjaGFyICpr
ZXkpCkBAIC0yMTcsNyArMjEwLDcgQEAgc3RhdGljIGludCBzZW5kX2FyZ3VtZW50KGNvbnN0
IGNoYXIgKmtleSkKIAlpbnQgaTsKIAogCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspCi0JCWlm
IChzZW5kX2J5dGUoa2V5W2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQpKQorCQlpZiAoc2VuZF9i
eXRlX2RhdGEoa2V5W2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQsZmFsc2UpKQogCQkJcmV0dXJu
IC1FSU87CiAJcmV0dXJuIDA7CiB9CkBAIC0yMzMsMTMgKzIyNiwxMyBAQCBzdGF0aWMgaW50
IHJlYWRfc21jKHU4IGNtZCwgY29uc3QgY2hhciAqa2V5LCB1OCAqYnVmZmVyLCB1OCBsZW4p
CiAJfQogCiAJLyogVGhpcyBoYXMgbm8gZWZmZWN0IG9uIG5ld2VyICgyMDEyKSBTTUNzICov
Ci0JaWYgKHNlbmRfYnl0ZShsZW4sIEFQUExFU01DX0RBVEFfUE9SVCkpIHsKKwlpZiAoc2Vu
ZF9ieXRlX2RhdGEobGVuLCBBUFBMRVNNQ19EQVRBX1BPUlQsZmFsc2UpKSB7CiAJCXByX3dh
cm4oIiUuNHM6IHJlYWQgbGVuIGZhaWxcbiIsIGtleSk7CiAJCXJldHVybiAtRUlPOwogCX0K
IAogCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykgewotCQlpZiAod2FpdF9yZWFkKCkpIHsK
KwkJaWYgKHdhaXRfc3RhdHVzKDB4NDUsMHhGRikpIHsKIAkJCXByX3dhcm4oIiUuNHM6IHJl
YWQgZGF0YVslZF0gZmFpbFxuIiwga2V5LCBpKTsKIAkJCXJldHVybiAtRUlPOwogCQl9CkBA
IC0yNjksMTQgKzI2MiwxNCBAQCBzdGF0aWMgaW50IHdyaXRlX3NtYyh1OCBjbWQsIGNvbnN0
IGNoYXIgKmtleSwgY29uc3QgdTggKmJ1ZmZlciwgdTggbGVuKQogCQlyZXR1cm4gLUVJTzsK
IAl9CiAKLQlpZiAoc2VuZF9ieXRlKGxlbiwgQVBQTEVTTUNfREFUQV9QT1JUKSkgeworCWlm
IChzZW5kX2J5dGVfZGF0YShsZW4sIEFQUExFU01DX0RBVEFfUE9SVCxmYWxzZSkpIHsKIAkJ
cHJfd2FybigiJS40czogd3JpdGUgbGVuIGZhaWxcbiIsIGtleSk7CiAJCXJldHVybiAtRUlP
OwogCX0KIAogCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykgewotCQlpZiAoc2VuZF9ieXRl
KGJ1ZmZlcltpXSwgQVBQTEVTTUNfREFUQV9QT1JUKSkgewotCQkJcHJfd2FybigiJXM6IHdy
aXRlIGRhdGEgZmFpbFxuIiwga2V5KTsKKwkJaWYgKHNlbmRfYnl0ZV9kYXRhKGJ1ZmZlcltp
XSwgQVBQTEVTTUNfREFUQV9QT1JULChpPT0obGVuLTEpKSkpIHsKKwkJCXByX3dhcm4oIiVz
OiB3cml0ZSBkYXRhIGZhaWwgYXQgJWlcbiIsIGtleSwgaSk7CiAJCQlyZXR1cm4gLUVJTzsK
IAkJfQogCX0K
--------------950FE4B4FE2534C610E592AB
Content-Type: application/x-shellscript;
 name="smc_dump_linux.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="smc_dump_linux.sh"

IyEvYmluL2Jhc2gKCmk9MAptYXg9JChjYXQgL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9h
cHBsZXNtYy9hcHBsZXNtYy43Njgva2V5X2NvdW50KQoKd2hpbGUgWyAkaSAtbHQgJG1heCBd
IDsgZG8KCWVjaG8gJGkgPiAvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2FwcGxlc21jL2Fw
cGxlc21jLjc2OC9rZXlfYXRfaW5kZXggCglrZXluYW1lPSQoY2F0IC9zeXMvYnVzL3BsYXRm
b3JtL2RyaXZlcnMvYXBwbGVzbWMvYXBwbGVzbWMuNzY4L2tleV9hdF9pbmRleF9uYW1lKQoJ
a2V5dHlwZT0kKGNhdCAvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2FwcGxlc21jL2FwcGxl
c21jLjc2OC9rZXlfYXRfaW5kZXhfdHlwZSkKCWNhc2UgIiRrZXl0eXBlIiBpbiAKCQkidWk4
ICIpCgkJCWtleWRhdGE9JChjYXQgL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9hcHBsZXNt
Yy9hcHBsZXNtYy43Njgva2V5X2F0X2luZGV4X2RhdGEgfCBvZCAtQW4gLXZ0dTEpCgkJCTs7
CgkJdWkxNikKCQkJa2V5ZGF0YT0kKGNhdCAvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2Fw
cGxlc21jL2FwcGxlc21jLjc2OC9rZXlfYXRfaW5kZXhfZGF0YSB8IG9kIC1BbiAtdnR1MiAt
LWVuZGlhbj1iaWcpCgkJCTs7CgoJCSopCgkJCWtleWRhdGE9JChjYXQgL3N5cy9idXMvcGxh
dGZvcm0vZHJpdmVycy9hcHBsZXNtYy9hcHBsZXNtYy43Njgva2V5X2F0X2luZGV4X2RhdGEg
fCB4eGQgLWMgMzIgLWcgMSAtcCkKCQkJOzsKCWVzYWMKCWVjaG8gIiAgJGtleW5hbWUgIFsk
a2V5dHlwZV0gICRrZXlkYXRhIiAkaQoJaT0kKCgkaSsxKSkKZG9uZQo=
--------------950FE4B4FE2534C610E592AB--
