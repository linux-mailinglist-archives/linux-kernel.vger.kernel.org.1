Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6272A76C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgKEFFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:05:46 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:48828 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKEFFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:05:46 -0500
Received: from srv.home ([10.8.0.1] ident=heh2281)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kaXSo-0008QJ-QT; Thu, 05 Nov 2020 13:05:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=HdmY1nXEw7mPert+rZODyMxtkHXZAf8qIUlHp8nOook=;
        b=hUQXDN4g2qCnH0Ks8dy+DSYXCYnRZ8CLEyTW+8BfljfmcAcbFprgSY4YZK5MgGqzqXV2Y1Pzy2THhNjM23XmGlbi5gcgNgH7ycflHg5hCc+i++oa7lyn69E+HgrL5SDkMRVeAxx8KFg22X6IuZHhCjzQ5rsU25R+i4U5ijLLS6w=;
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
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
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
Date:   Thu, 5 Nov 2020 16:05:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
Content-Type: multipart/mixed;
 boundary="------------B15AE43E2E2F2EC8D19EEB68"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B15AE43E2E2F2EC8D19EEB68
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/11/20 3:43 pm, Guenter Roeck wrote:
> On 11/4/20 6:18 PM, Brad Campbell wrote:
>> On 5/11/20 12:20 am, Andreas Kemnade wrote:
>>> On Tue, 3 Nov 2020 16:56:32 +1100
>>> Brad Campbell <brad@fnarfbargle.com> wrote:
>>
>>>> If anyone with a Mac having a conventional SMC and seeing issues on 5.9 could test this it'd be appreciated. I'm not saying this code is "correct", but it "works for me".
>>>>
>>> Seems to work here.
>>>    dmesg  | grep applesmc
>>>
>>> [    1.350782] applesmc: key=561 fan=1 temp=33 index=33 acc=0 lux=2 kbd=1
>>> [    1.350922] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>> [   17.748504] applesmc: wait_status looping 2: 0x4a, 0x4c, 0x4f
>>> [  212.008952] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>>> [  213.033930] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>>> [  213.167908] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>>> [  219.087854] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>>>
>>> Tested it on top of 5.9
>>
>> Much appreciated Andreas.
>>
>> I'm not entirely sure where to go from here. I'd really like some wider testing before cleaning this up and submitting it. It puts extra checks & constraints on the comms with the SMC that weren't there previously.
>>
>> I guess given there doesn't appear to have been a major outcry that the driver broke in 5.9 might indicate that nobody is using it, or that it only broke on certain machines?
>>
>> Can we get some guidance from the hwmon maintainers on what direction they'd like to take? I don't really want to push this forward without broader testing only to find it breaks a whole heap of machines on the basis that it fixes mine.
>>
> 
> Trick question ;-).
> 
> I'd suggest to keep it simple. Your patch seems to be quite complicated
> and checks a lot of bits. Reducing that to a minimum would help limiting
> the risk that some of those bits are interpreted differently on other
> systems.
> 
> Guenter
> 
> 
Appreciate the feedback.

This would be the bare minimum based on the bits use in the original code. If the original code worked "well enough" then this should be relatively safe.

Tested on both machines I have access to.

Regards,
Brad

--------------B15AE43E2E2F2EC8D19EEB68
Content-Type: text/plain; charset=UTF-8;
 name="smc.patch.9"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="smc.patch.9"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vYXBwbGVzbWMuYyBiL2RyaXZlcnMvaHdtb24v
YXBwbGVzbWMuYwppbmRleCBhMTg4ODc5OTBmNGEuLjIyY2M1MTIyY2U5YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9od21vbi9hcHBsZXNtYy5jCisrKyBiL2RyaXZlcnMvaHdtb24vYXBwbGVz
bWMuYwpAQCAtNDIsNiArNDIsMTEgQEAKIAogI2RlZmluZSBBUFBMRVNNQ19NQVhfREFUQV9M
RU5HVEggMzIKIAorLyogQXBwbGUgU01DIHN0YXR1cyBiaXRzIGZyb20gVmlydHVhbFNNQyAq
LworI2RlZmluZSBTTUNfU1RBVFVTX0FXQUlUSU5HX0RBVEEgIDB4MDEgIC8vLzwgRGF0YSB3
YWl0aW5nIHRvIGJlIHJlYWQKKyNkZWZpbmUgU01DX1NUQVRVU19JQl9DTE9TRUQgICAgICAw
eDAyICAvLy8gQSB3cml0ZSBpcyBwZW5kaW5nIC8gd2lsbCBpZ25vcmUgaW5wdXQKKyNkZWZp
bmUgU01DX1NUQVRVU19CVVNZICAgICAgICAgICAweDA0ICAvLy88IEJ1c3kgaW4gdGhlIG1p
ZGRsZSBvZiBhIGNvbW1hbmQuCisKIC8qIHdhaXQgdXAgdG8gMTI4IG1zIGZvciBhIHN0YXR1
cyBjaGFuZ2UuICovCiAjZGVmaW5lIEFQUExFU01DX01JTl9XQUlUCTB4MDAxMAogI2RlZmlu
ZSBBUFBMRVNNQ19SRVRSWV9XQUlUCTB4MDEwMApAQCAtMTUxLDY1ICsxNTYsNzcgQEAgc3Rh
dGljIHVuc2lnbmVkIGludCBrZXlfYXRfaW5kZXg7CiBzdGF0aWMgc3RydWN0IHdvcmtxdWV1
ZV9zdHJ1Y3QgKmFwcGxlc21jX2xlZF93cTsKIAogLyoKLSAqIHdhaXRfcmVhZCAtIFdhaXQg
Zm9yIGEgYnl0ZSB0byBhcHBlYXIgb24gU01DIHBvcnQuIENhbGxlcnMgbXVzdAotICogaG9s
ZCBhcHBsZXNtY19sb2NrLgorICogV2FpdCBmb3Igc3BlY2lmaWMgc3RhdHVzIGJpdHMgd2l0
aCBhIG1hc2sgb24gdGhlIFNNQworICogVXNlZCBiZWZvcmUgYW5kIGFmdGVyIHdyaXRlcywg
YW5kIGJlZm9yZSByZWFkcwogICovCi1zdGF0aWMgaW50IHdhaXRfcmVhZCh2b2lkKQorCitz
dGF0aWMgaW50IHdhaXRfc3RhdHVzKHU4IHZhbCwgdTggbWFzaykKIHsKIAl1bnNpZ25lZCBs
b25nIGVuZCA9IGppZmZpZXMgKyAoQVBQTEVTTUNfTUFYX1dBSVQgKiBIWikgLyBVU0VDX1BF
Ul9TRUM7CiAJdTggc3RhdHVzOwogCWludCB1czsKIAogCWZvciAodXMgPSBBUFBMRVNNQ19N
SU5fV0FJVDsgdXMgPCBBUFBMRVNNQ19NQVhfV0FJVDsgdXMgPDw9IDEpIHsKLQkJdXNsZWVw
X3JhbmdlKHVzLCB1cyAqIDE2KTsKIAkJc3RhdHVzID0gaW5iKEFQUExFU01DX0NNRF9QT1JU
KTsKLQkJLyogcmVhZDogd2FpdCBmb3Igc21jIHRvIHNldHRsZSAqLwotCQlpZiAoc3RhdHVz
ICYgMHgwMSkKKwkJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSB2YWwpCiAJCQlyZXR1cm4gMDsK
IAkJLyogdGltZW91dDogZ2l2ZSB1cCAqLwogCQlpZiAodGltZV9hZnRlcihqaWZmaWVzLCBl
bmQpKQogCQkJYnJlYWs7Ci0JfQotCi0JcHJfd2Fybigid2FpdF9yZWFkKCkgZmFpbDogMHgl
MDJ4XG4iLCBzdGF0dXMpOworCQl1c2xlZXBfcmFuZ2UodXMsIHVzICogMTYpOworCQl9CisJ
cHJfd2Fybigid2FpdF9zdGF0dXMgdGltZW91dDogMHglMDJ4LCAweCUwMngsIDB4JTAyeFxu
Iiwgc3RhdHVzLCB2YWwsIG1hc2spOwogCXJldHVybiAtRUlPOwogfQogCiAvKgotICogc2Vu
ZF9ieXRlIC0gV3JpdGUgdG8gU01DIHBvcnQsIHJldHJ5aW5nIHdoZW4gbmVjZXNzYXJ5LiBD
YWxsZXJzCisgKiBzZW5kX2J5dGVfZGF0YSAtIFdyaXRlIHRvIFNNQyBkYXRhIHBvcnQuIENh
bGxlcnMKICAqIG11c3QgaG9sZCBhcHBsZXNtY19sb2NrLgorICogUGFyYW1ldGVyIHNraXAg
bXVzdCBiZSB0cnVlIG9uIHRoZSBsYXN0IHdyaXRlIG9mIGFueQorICogY29tbWFuZCBvciBp
dCdsbCB0aW1lIG91dC4KICAqLwotc3RhdGljIGludCBzZW5kX2J5dGUodTggY21kLCB1MTYg
cG9ydCkKKworc3RhdGljIGludCBzZW5kX2J5dGVfZGF0YSh1OCBjbWQsIHUxNiBwb3J0LCBi
b29sIHNraXApCiB7Ci0JdTggc3RhdHVzOwotCWludCB1czsKLQl1bnNpZ25lZCBsb25nIGVu
ZCA9IGppZmZpZXMgKyAoQVBQTEVTTUNfTUFYX1dBSVQgKiBIWikgLyBVU0VDX1BFUl9TRUM7
CisJdTggd3N0YXQgPSBTTUNfU1RBVFVTX0JVU1k7CiAKKwlpZiAoc2tpcCkKKwkJd3N0YXQg
PSAwOworCWlmICh3YWl0X3N0YXR1cyhTTUNfU1RBVFVTX0JVU1ksCisJU01DX1NUQVRVU19C
VVNZIHwgU01DX1NUQVRVU19JQl9DTE9TRUQpKQorCQlnb3RvIGZhaWw7CiAJb3V0YihjbWQs
IHBvcnQpOwotCWZvciAodXMgPSBBUFBMRVNNQ19NSU5fV0FJVDsgdXMgPCBBUFBMRVNNQ19N
QVhfV0FJVDsgdXMgPDw9IDEpIHsKLQkJdXNsZWVwX3JhbmdlKHVzLCB1cyAqIDE2KTsKLQkJ
c3RhdHVzID0gaW5iKEFQUExFU01DX0NNRF9QT1JUKTsKLQkJLyogd3JpdGU6IHdhaXQgZm9y
IHNtYyB0byBzZXR0bGUgKi8KLQkJaWYgKHN0YXR1cyAmIDB4MDIpCi0JCQljb250aW51ZTsK
LQkJLyogcmVhZHk6IGNtZCBhY2NlcHRlZCwgcmV0dXJuICovCi0JCWlmIChzdGF0dXMgJiAw
eDA0KQotCQkJcmV0dXJuIDA7Ci0JCS8qIHRpbWVvdXQ6IGdpdmUgdXAgKi8KLQkJaWYgKHRp
bWVfYWZ0ZXIoamlmZmllcywgZW5kKSkKLQkJCWJyZWFrOwotCQkvKiBidXN5OiBsb25nIHdh
aXQgYW5kIHJlc2VuZCAqLwotCQl1ZGVsYXkoQVBQTEVTTUNfUkVUUllfV0FJVCk7Ci0JCW91
dGIoY21kLCBwb3J0KTsKLQl9Ci0KLQlwcl93YXJuKCJzZW5kX2J5dGUoMHglMDJ4LCAweCUw
NHgpIGZhaWw6IDB4JTAyeFxuIiwgY21kLCBwb3J0LCBzdGF0dXMpOworCWlmICghd2FpdF9z
dGF0dXMod3N0YXQsCisJU01DX1NUQVRVU19CVVNZKSkKKwkJcmV0dXJuIDA7CitmYWlsOgor
CXByX3dhcm4oInNlbmRfYnl0ZV9kYXRhKDB4JTAyeCwgMHglMDR4KSBmYWlsXG4iLCBjbWQs
IEFQUExFU01DX0NNRF9QT1JUKTsKIAlyZXR1cm4gLUVJTzsKIH0KIAorLyoKKyAqIHNlbmRf
Y29tbWFuZCAtIFdyaXRlIGEgY29tbWFuZCB0byB0aGUgU01DLiBDYWxsZXJzIG11c3QgaG9s
ZCBhcHBsZXNtY19sb2NrLgorICogSWYgU01DIGlzIGluIHVuZGVmaW5lZCBzdGF0ZSwgYW55
IG5ldyBjb21tYW5kIHdyaXRlIHJlc2V0cyB0aGUgc3RhdGUgbWFjaGluZS4KKyAqLworCiBz
dGF0aWMgaW50IHNlbmRfY29tbWFuZCh1OCBjbWQpCiB7Ci0JcmV0dXJuIHNlbmRfYnl0ZShj
bWQsIEFQUExFU01DX0NNRF9QT1JUKTsKKwl1OCBzdGF0dXM7CisKKwlpZiAod2FpdF9zdGF0
dXMoMCwKKwlTTUNfU1RBVFVTX0lCX0NMT1NFRCkpIHsKKwkJcHJfd2Fybigic2VuZF9jb21t
YW5kIFNNQyB3YXMgYnVzeVxuIik7CisJCWdvdG8gZmFpbDsgfQorCisJc3RhdHVzID0gaW5i
KEFQUExFU01DX0NNRF9QT1JUKTsKKworCW91dGIoY21kLCBBUFBMRVNNQ19DTURfUE9SVCk7
CisJaWYgKCF3YWl0X3N0YXR1cyhTTUNfU1RBVFVTX0JVU1ksCisJU01DX1NUQVRVU19CVVNZ
KSkKKwkJcmV0dXJuIDA7CitmYWlsOgorCXByX3dhcm4oInNlbmRfY21kKDB4JTAyeCwgMHgl
MDR4KSBmYWlsXG4iLCBjbWQsIEFQUExFU01DX0NNRF9QT1JUKTsKKwlyZXR1cm4gLUVJTzsK
IH0KIAogc3RhdGljIGludCBzZW5kX2FyZ3VtZW50KGNvbnN0IGNoYXIgKmtleSkKQEAgLTIx
Nyw3ICsyMzQsOCBAQCBzdGF0aWMgaW50IHNlbmRfYXJndW1lbnQoY29uc3QgY2hhciAqa2V5
KQogCWludCBpOwogCiAJZm9yIChpID0gMDsgaSA8IDQ7IGkrKykKLQkJaWYgKHNlbmRfYnl0
ZShrZXlbaV0sIEFQUExFU01DX0RBVEFfUE9SVCkpCisJLyogUGFyYW1ldGVyIHNraXAgaXMg
ZmFsc2UgYXMgd2UgYWx3YXlzIHNlbmQgZGF0YSBhZnRlciBhbiBhcmd1bWVudCAqLworCQlp
ZiAoc2VuZF9ieXRlX2RhdGEoa2V5W2ldLCBBUFBMRVNNQ19EQVRBX1BPUlQsIGZhbHNlKSkK
IAkJCXJldHVybiAtRUlPOwogCXJldHVybiAwOwogfQpAQCAtMjMzLDEzICsyNTEsMTUgQEAg
c3RhdGljIGludCByZWFkX3NtYyh1OCBjbWQsIGNvbnN0IGNoYXIgKmtleSwgdTggKmJ1ZmZl
ciwgdTggbGVuKQogCX0KIAogCS8qIFRoaXMgaGFzIG5vIGVmZmVjdCBvbiBuZXdlciAoMjAx
MikgU01DcyAqLwotCWlmIChzZW5kX2J5dGUobGVuLCBBUFBMRVNNQ19EQVRBX1BPUlQpKSB7
CisJaWYgKHNlbmRfYnl0ZV9kYXRhKGxlbiwgQVBQTEVTTUNfREFUQV9QT1JULCBmYWxzZSkp
IHsKIAkJcHJfd2FybigiJS40czogcmVhZCBsZW4gZmFpbFxuIiwga2V5KTsKIAkJcmV0dXJu
IC1FSU87CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKSB7Ci0JCWlmICh3YWl0
X3JlYWQoKSkgeworCQlpZiAod2FpdF9zdGF0dXMoU01DX1NUQVRVU19BV0FJVElOR19EQVRB
IHwgU01DX1NUQVRVU19CVVNZLAorCQlTTUNfU1RBVFVTX0FXQUlUSU5HX0RBVEEgfCBTTUNf
U1RBVFVTX0JVU1kgfAorCQlTTUNfU1RBVFVTX0lCX0NMT1NFRCkpIHsKIAkJCXByX3dhcm4o
IiUuNHM6IHJlYWQgZGF0YVslZF0gZmFpbFxuIiwga2V5LCBpKTsKIAkJCXJldHVybiAtRUlP
OwogCQl9CkBAIC0yNTAsNyArMjcwLDcgQEAgc3RhdGljIGludCByZWFkX3NtYyh1OCBjbWQs
IGNvbnN0IGNoYXIgKmtleSwgdTggKmJ1ZmZlciwgdTggbGVuKQogCWZvciAoaSA9IDA7IGkg
PCAxNjsgaSsrKSB7CiAJCXVkZWxheShBUFBMRVNNQ19NSU5fV0FJVCk7CiAJCXN0YXR1cyA9
IGluYihBUFBMRVNNQ19DTURfUE9SVCk7Ci0JCWlmICghKHN0YXR1cyAmIDB4MDEpKQorCQlp
ZiAoIShzdGF0dXMgJiBTTUNfU1RBVFVTX0FXQUlUSU5HX0RBVEEpKQogCQkJYnJlYWs7CiAJ
CWRhdGEgPSBpbmIoQVBQTEVTTUNfREFUQV9QT1JUKTsKIAl9CkBAIC0yNjMsMjAgKzI4Mywy
MSBAQCBzdGF0aWMgaW50IHJlYWRfc21jKHU4IGNtZCwgY29uc3QgY2hhciAqa2V5LCB1OCAq
YnVmZmVyLCB1OCBsZW4pCiBzdGF0aWMgaW50IHdyaXRlX3NtYyh1OCBjbWQsIGNvbnN0IGNo
YXIgKmtleSwgY29uc3QgdTggKmJ1ZmZlciwgdTggbGVuKQogewogCWludCBpOworCXU4IGVu
ZCA9IGxlbi0xOwogCiAJaWYgKHNlbmRfY29tbWFuZChjbWQpIHx8IHNlbmRfYXJndW1lbnQo
a2V5KSkgewogCQlwcl93YXJuKCIlczogd3JpdGUgYXJnIGZhaWxcbiIsIGtleSk7CiAJCXJl
dHVybiAtRUlPOwogCX0KIAotCWlmIChzZW5kX2J5dGUobGVuLCBBUFBMRVNNQ19EQVRBX1BP
UlQpKSB7CisJaWYgKHNlbmRfYnl0ZV9kYXRhKGxlbiwgQVBQTEVTTUNfREFUQV9QT1JULCBm
YWxzZSkpIHsKIAkJcHJfd2FybigiJS40czogd3JpdGUgbGVuIGZhaWxcbiIsIGtleSk7CiAJ
CXJldHVybiAtRUlPOwogCX0KIAogCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykgewotCQlp
ZiAoc2VuZF9ieXRlKGJ1ZmZlcltpXSwgQVBQTEVTTUNfREFUQV9QT1JUKSkgewotCQkJcHJf
d2FybigiJXM6IHdyaXRlIGRhdGEgZmFpbFxuIiwga2V5KTsKKwkJaWYgKHNlbmRfYnl0ZV9k
YXRhKGJ1ZmZlcltpXSwgQVBQTEVTTUNfREFUQV9QT1JULCAoaSA9PSBlbmQpKSkgeworCQkJ
cHJfd2FybigiJXM6IHdyaXRlIGRhdGEgZmFpbCBhdCAlaVxuIiwga2V5LCBpKTsKIAkJCXJl
dHVybiAtRUlPOwogCQl9CiAJfQo=
--------------B15AE43E2E2F2EC8D19EEB68--
