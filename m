Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CE2A3C47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCF6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:58:18 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:49320 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:58:17 -0500
Received: from srv.home ([10.8.0.1] ident=heh12358)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kZpJ6-0006Tu-2a; Tue, 03 Nov 2020 13:56:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=ISCp/k9iAd9MHlIzbF+VLFLF2B9AGbwsrcc2H51zWw4=;
        b=xHIQoZoBsebAFKc9gusvWs/9bnxmnyNgCCxVl6mcrWJTZ/pheTl4CMf8DO9gRJKiwwrpLc3Rf8nckr1LDB46nq99B7q0oigFqIo5fmDCH1X66EJAwvw5yrM2Zc0hdzAIg4quf1kb6UfDN7z/NY7EEIG6o5mqoYwOrj0hwTr93kI=;
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
From:   Brad Campbell <brad@fnarfbargle.com>
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
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
Message-ID: <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
Date:   Tue, 3 Nov 2020 16:56:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
Content-Type: multipart/mixed;
 boundary="------------260640A5259521660CE4A5E1"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------260640A5259521660CE4A5E1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/20 10:56 am, Brad Campbell wrote:

> 
> I've examined the code in VirtualSMC and I'm not convinced we were not waiting on the wrong bits.
> 
> #define SMC_STATUS_AWAITING_DATA  BIT0  ///< Ready to read data.
> #define SMC_STATUS_IB_CLOSED      BIT1  /// A write is pending.
> #define SMC_STATUS_BUSY           BIT2  ///< Busy processing a command.
> #define SMC_STATUS_GOT_COMMAND    BIT3  ///< The last input was a command.
> #define SMC_STATUS_UKN_0x16       BIT4
> #define SMC_STATUS_KEY_DONE       BIT5
> #define SMC_STATUS_READY          BIT6  // Ready to work
> #define SMC_STATUS_UKN_0x80       BIT7  // error
> 
> Any chance you could try this patch? It's ugly, hacked together and currently fairly undocumented, but if it works I'll figure out how to clean it up (suggestions welcome).
> It works on my MacbookPro 11,1.

I had some time so I spent a bit of time refactoring and trying to clarify the magic numbers.

I also did some fuzzing of the SMC and figured out where we can loosen the masks.
This has some debug code in it to identify if any wait loops exceed 1 loop and if the SMC is reporting anything other than a clear "I'm waiting" prior to each command.

You might see some of these :
[   51.316202] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
[   60.002547] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
[   60.130754] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e

I did some heavy tests and found that with the delays at the bottom of the loop about 50% of calls required no delay at all before a read or write and the other 50% require a single delay.
I can count on one hand the number of times it's exceeded 1 loop, and the max thus far has been 5 loops.

We've been treating bit 0x04 as an ack, but from my testing on the machine and what I've seen in the SMC emulator code it actually means "I'm busy in the middle of a command". Bit 0x02 seems to mean "I'm doing something and I *will* ignore anything you send me".
Bit 0x08 means "The last thing I got was a valid command, so start sending me data".

By testing and waiting for 0x02 to clear before sending or reading I haven't seen any need for retries.

On my unit bit 0x40 is always active. It may not be on others. The emulator calls it a status ready, so it's tested for but that is consolidated in wait_status so it can be commented out if it doesn't work on your machine.

The thing with bit 0x04 is the SMC clears it when it's no longer busy. So the last byte of data sent for a command sees it clear that bit. That explains the timeouts but the command still works. As far as the SMC is concerned it's got all the data and gone off to do its thing, but applesmc was waiting for the bit to be set. When it's in the middle of a command (from the first command byte until the last data byte is received) I've never seen bit 0x04 cleared, so using it as an "ack" works, but as said upward in the thread "probably by accident".

So this code tests for an "idle" SMC before it sends a command. In this context idle just means bit 0x02 isn't set. If the SMC gets into an undefined state it can leave other bits set, but a new write with a valid command will reset the internal state machine and bring it back into line. Bit 0x08 should always be set after it has received a valid command.

I've gone belt and braces by checking the status before and after each command, but with the intention of trying to catch and log anything that goes awry. Like I said above, in 50% of cases I see zero delays required so I thought testing before the delay was a worthwhile win.

If anyone with a Mac having a conventional SMC and seeing issues on 5.9 could test this it'd be appreciated. I'm not saying this code is "correct", but it "works for me".

If anyone actually knows what they're doing and wants to "correct" me, it'd be appreciated also.

Regards,
Brad

--------------260640A5259521660CE4A5E1
Content-Type: text/plain; charset=UTF-8;
 name="smc.patch.5"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="smc.patch.5"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vYXBwbGVzbWMuYyBiL2RyaXZlcnMvaHdtb24v
YXBwbGVzbWMuYwppbmRleCBhMTg4ODc5OTBmNGEuLmFiYjA2ZmJlN2JjMSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9od21vbi9hcHBsZXNtYy5jCisrKyBiL2RyaXZlcnMvaHdtb24vYXBwbGVz
bWMuYwpAQCAtNDIsNiArNDIsMTYgQEAKIAogI2RlZmluZSBBUFBMRVNNQ19NQVhfREFUQV9M
RU5HVEggMzIKIAorLyogQXBwbGUgU01DIHN0YXR1cyBiaXRzICovCisjZGVmaW5lIFNNQ19T
VEFUVVNfQVdBSVRJTkdfREFUQSAgMHgwMSAgLy8vPCBEYXRhIHdhaXRpbmcgdG8gYmUgcmVh
ZAorI2RlZmluZSBTTUNfU1RBVFVTX0lCX0NMT1NFRCAgICAgIDB4MDIgIC8vLyBBIHdyaXRl
IGlzIHBlbmRpbmcgLyB3aWxsIGlnbm9yZSBpbnB1dAorI2RlZmluZSBTTUNfU1RBVFVTX0JV
U1kgICAgICAgICAgIDB4MDQgIC8vLzwgQnVzeSBpbiB0aGUgbWlkZGxlIG9mIGEgY29tbWFu
ZC4KKyNkZWZpbmUgU01DX1NUQVRVU19HT1RfQ09NTUFORCAgICAweDA4ICAvLy88IFRoZSBs
YXN0IGlucHV0IHdhcyBhIGNvbW1hbmQuCisjZGVmaW5lIFNNQ19TVEFUVVNfVUtOXzB4MTYg
ICAgICAgMHgxMAorI2RlZmluZSBTTUNfU1RBVFVTX0tFWV9ET05FICAgICAgIDB4MjAKKyNk
ZWZpbmUgU01DX1NUQVRVU19SRUFEWSAgICAgICAgICAweDQwICAvLyBSZWFkeSB0byB3b3Jr
CisjZGVmaW5lIFNNQ19TVEFUVVNfVUtOXzB4ODAgICAgICAgMHg4MCAgLy8gZXJyb3IKKwog
Lyogd2FpdCB1cCB0byAxMjggbXMgZm9yIGEgc3RhdHVzIGNoYW5nZS4gKi8KICNkZWZpbmUg
QVBQTEVTTUNfTUlOX1dBSVQJMHgwMDEwCiAjZGVmaW5lIEFQUExFU01DX1JFVFJZX1dBSVQJ
MHgwMTAwCkBAIC0xNTEsNjUgKzE2MSw4OCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGtleV9h
dF9pbmRleDsKIHN0YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqYXBwbGVzbWNfbGVk
X3dxOwogCiAvKgotICogd2FpdF9yZWFkIC0gV2FpdCBmb3IgYSBieXRlIHRvIGFwcGVhciBv
biBTTUMgcG9ydC4gQ2FsbGVycyBtdXN0Ci0gKiBob2xkIGFwcGxlc21jX2xvY2suCisgKiBX
YWl0IGZvciBzcGVjaWZpYyBzdGF0dXMgYml0cyB3aXRoIGEgbWFzayBvbiB0aGUgU01DCisg
KiBVc2VkIGJlZm9yZSBhbmQgYWZ0ZXIgd3JpdGVzLCBhbmQgYmVmb3JlIHJlYWRzCiAgKi8K
LXN0YXRpYyBpbnQgd2FpdF9yZWFkKHZvaWQpCisKK3N0YXRpYyBpbnQgd2FpdF9zdGF0dXMo
dTggdmFsLCB1OCBtYXNrKQogewotCXVuc2lnbmVkIGxvbmcgZW5kID0gamlmZmllcyArIChB
UFBMRVNNQ19NQVhfV0FJVCAqIEhaKSAvIFVTRUNfUEVSX1NFQzsKIAl1OCBzdGF0dXM7CiAJ
aW50IHVzOworCWludCBsb29wcyA9IDA7CisJdW5zaWduZWQgbG9uZyBlbmQgPSBqaWZmaWVz
ICsgKEFQUExFU01DX01BWF9XQUlUICogSFopIC8gVVNFQ19QRVJfU0VDOwogCisJLyogV2Ug
YWx3YXlzIGNoZWNrIGZvciBzdGF0dXMgcmVhZHkgKi8KKwl2YWwgfD0gU01DX1NUQVRVU19S
RUFEWTsKKwltYXNrIHw9IFNNQ19TVEFUVVNfUkVBRFk7CiAJZm9yICh1cyA9IEFQUExFU01D
X01JTl9XQUlUOyB1cyA8IEFQUExFU01DX01BWF9XQUlUOyB1cyA8PD0gMSkgewotCQl1c2xl
ZXBfcmFuZ2UodXMsIHVzICogMTYpOwogCQlzdGF0dXMgPSBpbmIoQVBQTEVTTUNfQ01EX1BP
UlQpOwotCQkvKiByZWFkOiB3YWl0IGZvciBzbWMgdG8gc2V0dGxlICovCi0JCWlmIChzdGF0
dXMgJiAweDAxKQorCQlpZiAoKHN0YXR1cyAmIG1hc2spID09IHZhbCkKIAkJCXJldHVybiAw
OwotCQkvKiB0aW1lb3V0OiBnaXZlIHVwICovCiAJCWlmICh0aW1lX2FmdGVyKGppZmZpZXMs
IGVuZCkpCiAJCQlicmVhazsKLQl9Ci0KLQlwcl93YXJuKCJ3YWl0X3JlYWQoKSBmYWlsOiAw
eCUwMnhcbiIsIHN0YXR1cyk7CisJCXVzbGVlcF9yYW5nZSh1cywgdXMgKiAxNik7CisJCWxv
b3BzICs9IDE7CisJCWlmIChsb29wcyA+IDEpCisJCQlwcl93YXJuKCJ3YWl0X3N0YXR1cyBs
b29waW5nICVpOiAweCUwMngsIDB4JTAyeCwgMHglMDJ4XG4iLCBsb29wcywgc3RhdHVzLCB2
YWwsIG1hc2spOworCQl9CisJcHJfd2Fybigid2FpdF9zdGF0dXMgdGltZW91dDogMHglMDJ4
LCAweCUwMngsIDB4JTAyeFxuIiwgc3RhdHVzLCB2YWwsIG1hc2spOwogCXJldHVybiAtRUlP
OwogfQogCiAvKgotICogc2VuZF9ieXRlIC0gV3JpdGUgdG8gU01DIHBvcnQsIHJldHJ5aW5n
IHdoZW4gbmVjZXNzYXJ5LiBDYWxsZXJzCisgKiBzZW5kX2J5dGVfZGF0YSAtIFdyaXRlIHRv
IFNNQyBkYXRhIHBvcnQuIENhbGxlcnMKICAqIG11c3QgaG9sZCBhcHBsZXNtY19sb2NrLgor
ICogUGFyYW1ldGVyIHNraXAgbXVzdCBiZSB0cnVlIG9uIHRoZSBsYXN0IHdyaXRlIG9mIGFu
eQorICogY29tbWFuZCBvciBpdCdsbCB0aW1lIG91dC4KICAqLwotc3RhdGljIGludCBzZW5k
X2J5dGUodTggY21kLCB1MTYgcG9ydCkKKworc3RhdGljIGludCBzZW5kX2J5dGVfZGF0YSh1
OCBjbWQsIHUxNiBwb3J0LCBib29sIHNraXApCiB7Ci0JdTggc3RhdHVzOwotCWludCB1czsK
LQl1bnNpZ25lZCBsb25nIGVuZCA9IGppZmZpZXMgKyAoQVBQTEVTTUNfTUFYX1dBSVQgKiBI
WikgLyBVU0VDX1BFUl9TRUM7CisJdTggd3N0YXQgPSAwOwogCisJaWYgKCFza2lwKQorCQl3
c3RhdCB8PSBTTUNfU1RBVFVTX0JVU1k7CisJaWYgKHdhaXRfc3RhdHVzKFNNQ19TVEFUVVNf
QlVTWSwKKwlTTUNfU1RBVFVTX0JVU1kgfCBTTUNfU1RBVFVTX0lCX0NMT1NFRCkpCisJCWdv
dG8gZmFpbDsKIAlvdXRiKGNtZCwgcG9ydCk7Ci0JZm9yICh1cyA9IEFQUExFU01DX01JTl9X
QUlUOyB1cyA8IEFQUExFU01DX01BWF9XQUlUOyB1cyA8PD0gMSkgewotCQl1c2xlZXBfcmFu
Z2UodXMsIHVzICogMTYpOwotCQlzdGF0dXMgPSBpbmIoQVBQTEVTTUNfQ01EX1BPUlQpOwot
CQkvKiB3cml0ZTogd2FpdCBmb3Igc21jIHRvIHNldHRsZSAqLwotCQlpZiAoc3RhdHVzICYg
MHgwMikKLQkJCWNvbnRpbnVlOwotCQkvKiByZWFkeTogY21kIGFjY2VwdGVkLCByZXR1cm4g
Ki8KLQkJaWYgKHN0YXR1cyAmIDB4MDQpCi0JCQlyZXR1cm4gMDsKLQkJLyogdGltZW91dDog
Z2l2ZSB1cCAqLwotCQlpZiAodGltZV9hZnRlcihqaWZmaWVzLCBlbmQpKQotCQkJYnJlYWs7
Ci0JCS8qIGJ1c3k6IGxvbmcgd2FpdCBhbmQgcmVzZW5kICovCi0JCXVkZWxheShBUFBMRVNN
Q19SRVRSWV9XQUlUKTsKLQkJb3V0YihjbWQsIHBvcnQpOwotCX0KLQotCXByX3dhcm4oInNl
bmRfYnl0ZSgweCUwMngsIDB4JTA0eCkgZmFpbDogMHglMDJ4XG4iLCBjbWQsIHBvcnQsIHN0
YXR1cyk7CisJaWYgKCF3YWl0X3N0YXR1cyh3c3RhdCwKKwlTTUNfU1RBVFVTX1JFQURZIHwg
U01DX1NUQVRVU19HT1RfQ09NTUFORCB8IFNNQ19TVEFUVVNfQlVTWSB8IFNNQ19TVEFUVVNf
SUJfQ0xPU0VEKSkKKwkJcmV0dXJuIDA7CitmYWlsOgorCXByX3dhcm4oInNlbmRfYnl0ZV9k
YXRhKDB4JTAyeCwgMHglMDR4KSBmYWlsXG4iLCBjbWQsIEFQUExFU01DX0NNRF9QT1JUKTsK
IAlyZXR1cm4gLUVJTzsKIH0KIAorLyoKKyAqIHNlbmRfY29tbWFuZCAtIFdyaXRlIGEgY29t
bWFuZCB0byB0aGUgU01DLiBDYWxsZXJzIG11c3QgaG9sZCBhcHBsZXNtY19sb2NrLgorICog
SWYgU01DIGlzIGluIHVuZGVmaW5lZCBzdGF0ZSwgYW4gbmV3IGNvbW1hbmQgd3JpdGUgcmVz
ZXRzIHRoZSBzdGF0ZSBtYWNoaW5lLgorICovCisKIHN0YXRpYyBpbnQgc2VuZF9jb21tYW5k
KHU4IGNtZCkKIHsKLQlyZXR1cm4gc2VuZF9ieXRlKGNtZCwgQVBQTEVTTUNfQ01EX1BPUlQp
OworCXU4IHN0YXR1czsKKworCWlmICh3YWl0X3N0YXR1cygwLAorCVNNQ19TVEFUVVNfSUJf
Q0xPU0VEKSkgeworCQlwcl93YXJuKCJzZW5kX2NvbW1hbmQgZmFpbCAxXG4iKTsKKwkJZ290
byBmYWlsOyB9CisKKwlzdGF0dXMgPSBpbmIoQVBQTEVTTUNfQ01EX1BPUlQpOworCWlmIChz
dGF0dXMgIT0gMHg0MCkKKwkJcHJfd2FybigiQXQgY29tbWFuZCBzdGFydCwgU3RhdHVzIHdh
cyAweCUyMHhcbiIsIHN0YXR1cyk7CisKKwlvdXRiKGNtZCwgQVBQTEVTTUNfQ01EX1BPUlQp
OworCWlmICh3YWl0X3N0YXR1cyhTTUNfU1RBVFVTX0JVU1kgfCBTTUNfU1RBVFVTX0dPVF9D
T01NQU5ELAorCVNNQ19TVEFUVVNfR09UX0NPTU1BTkQgfCBTTUNfU1RBVFVTX0JVU1kgfCBT
TUNfU1RBVFVTX0lCX0NMT1NFRCB8CisJU01DX1NUQVRVU19BV0FJVElOR19EQVRBKSkgewor
CQlwcl93YXJuKCJzZW5kX2NvbW1hbmQgZmFpbCAyXG4iKTsKKwkJZ290byBmYWlsOyB9CisJ
cmV0dXJuIDA7CitmYWlsOgorCXByX3dhcm4oInNlbmRfY21kKDB4JTAyeCwgMHglMDR4KSBm
YWlsXG4iLCBjbWQsIEFQUExFU01DX0NNRF9QT1JUKTsKKwlyZXR1cm4gLUVJTzsKIH0KIAog
c3RhdGljIGludCBzZW5kX2FyZ3VtZW50KGNvbnN0IGNoYXIgKmtleSkKQEAgLTIxNyw3ICsy
NTAsOCBAQCBzdGF0aWMgaW50IHNlbmRfYXJndW1lbnQoY29uc3QgY2hhciAqa2V5KQogCWlu
dCBpOwogCiAJZm9yIChpID0gMDsgaSA8IDQ7IGkrKykKLQkJaWYgKHNlbmRfYnl0ZShrZXlb
aV0sIEFQUExFU01DX0RBVEFfUE9SVCkpCisJLyogUGFyYW1ldGVyIHNraXAgaXMgZmFsc2Ug
YXMgd2UgYWx3YXlzIHNlbmQgZGF0YSBhZnRlciBhbiBhcmd1bWVudCAqLworCQlpZiAoc2Vu
ZF9ieXRlX2RhdGEoa2V5W2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQsIGZhbHNlKSkKIAkJCXJl
dHVybiAtRUlPOwogCXJldHVybiAwOwogfQpAQCAtMjMzLDEzICsyNjcsMTUgQEAgc3RhdGlj
IGludCByZWFkX3NtYyh1OCBjbWQsIGNvbnN0IGNoYXIgKmtleSwgdTggKmJ1ZmZlciwgdTgg
bGVuKQogCX0KIAogCS8qIFRoaXMgaGFzIG5vIGVmZmVjdCBvbiBuZXdlciAoMjAxMikgU01D
cyAqLwotCWlmIChzZW5kX2J5dGUobGVuLCBBUFBMRVNNQ19EQVRBX1BPUlQpKSB7CisJaWYg
KHNlbmRfYnl0ZV9kYXRhKGxlbiwgQVBQTEVTTUNfREFUQV9QT1JULCBmYWxzZSkpIHsKIAkJ
cHJfd2FybigiJS40czogcmVhZCBsZW4gZmFpbFxuIiwga2V5KTsKIAkJcmV0dXJuIC1FSU87
CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKSB7Ci0JCWlmICh3YWl0X3JlYWQo
KSkgeworCQlpZiAod2FpdF9zdGF0dXMoU01DX1NUQVRVU19BV0FJVElOR19EQVRBIHwgU01D
X1NUQVRVU19CVVNZLAorCQlTTUNfU1RBVFVTX0dPVF9DT01NQU5EIHwgU01DX1NUQVRVU19C
VVNZIHwgU01DX1NUQVRVU19JQl9DTE9TRUQgfAorCQlTTUNfU1RBVFVTX0FXQUlUSU5HX0RB
VEEpKSB7CiAJCQlwcl93YXJuKCIlLjRzOiByZWFkIGRhdGFbJWRdIGZhaWxcbiIsIGtleSwg
aSk7CiAJCQlyZXR1cm4gLUVJTzsKIAkJfQpAQCAtMjUwLDcgKzI4Niw3IEBAIHN0YXRpYyBp
bnQgcmVhZF9zbWModTggY21kLCBjb25zdCBjaGFyICprZXksIHU4ICpidWZmZXIsIHU4IGxl
bikKIAlmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykgewogCQl1ZGVsYXkoQVBQTEVTTUNfTUlO
X1dBSVQpOwogCQlzdGF0dXMgPSBpbmIoQVBQTEVTTUNfQ01EX1BPUlQpOwotCQlpZiAoIShz
dGF0dXMgJiAweDAxKSkKKwkJaWYgKCEoc3RhdHVzICYgU01DX1NUQVRVU19BV0FJVElOR19E
QVRBKSkKIAkJCWJyZWFrOwogCQlkYXRhID0gaW5iKEFQUExFU01DX0RBVEFfUE9SVCk7CiAJ
fQpAQCAtMjY5LDE0ICszMDUsMTQgQEAgc3RhdGljIGludCB3cml0ZV9zbWModTggY21kLCBj
b25zdCBjaGFyICprZXksIGNvbnN0IHU4ICpidWZmZXIsIHU4IGxlbikKIAkJcmV0dXJuIC1F
SU87CiAJfQogCi0JaWYgKHNlbmRfYnl0ZShsZW4sIEFQUExFU01DX0RBVEFfUE9SVCkpIHsK
KwlpZiAoc2VuZF9ieXRlX2RhdGEobGVuLCBBUFBMRVNNQ19EQVRBX1BPUlQsIGZhbHNlKSkg
ewogCQlwcl93YXJuKCIlLjRzOiB3cml0ZSBsZW4gZmFpbFxuIiwga2V5KTsKIAkJcmV0dXJu
IC1FSU87CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKSB7Ci0JCWlmIChzZW5k
X2J5dGUoYnVmZmVyW2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQpKSB7Ci0JCQlwcl93YXJuKCIl
czogd3JpdGUgZGF0YSBmYWlsXG4iLCBrZXkpOworCQlpZiAoc2VuZF9ieXRlX2RhdGEoYnVm
ZmVyW2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQsIChpID09IChsZW4tMSkpKSkgeworCQkJcHJf
d2FybigiJXM6IHdyaXRlIGRhdGEgZmFpbCBhdCAlaVxuIiwga2V5LCBpKTsKIAkJCXJldHVy
biAtRUlPOwogCQl9CiAJfQo=
--------------260640A5259521660CE4A5E1--
