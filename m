Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFA27A843
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgI1HHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:07:42 -0400
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:57322 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1HHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:07:41 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 03:07:39 EDT
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id 7AAB7483EB2;
        Mon, 28 Sep 2020 14:59:45 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEgA2wDqDe0-PVocRYFgJaoK.3.1601276385471.Hmail.bailu.lin@vivo.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com,
        Wang Qing <wangqing@vivo.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gRG9jdW1lbnRhdGlvbjogQ2hpbmVzZSB0cmFuc2xhdGlvbiBvZiBEb2N1bWVudGF0aW9uL2FybTY0L3BlcmYucnN0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 14.29.82.33
In-Reply-To: <8d7eec7d-5a62-9cc6-75de-10490b999e7a@linux.alibaba.com>
MIME-Version: 1.0
Received: from bailu.lin@vivo.com( [14.29.82.33) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 28 Sep 2020 14:59:45 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p6X55m96bmt?= <bailu.lin@vivo.com>
Date:   Mon, 28 Sep 2020 14:59:45 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh4eSUJNH05PH0lKVkpNS0pJTE1IQ05OT01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU5DQ05ITk9NTk9NN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Phw6SQw*Cj8eS1YrLRQYKSI9HDEaFDBVSFVKTUtKSUxNSENOQkNLVTMWGhIXVRkaEhcOVRcS
        FTsNEg0UVRgUFkVZV1kSC1lBWUpPVUlCVUNJVUhIWVdZCAFZQU5ITUg3Bg++
X-HM-Tid: 0a74d38298eb93b5kuws7aab7483eb2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PuWcqCAyMDIwLzkvMjcg5LiK5Y2INDoxNSwgSm9uYXRoYW4gQ29yYmV0IOWGmemBkzoKPj4gT24g
U2F0LCAyNiBTZXAgMjAyMCAyMjozNTo1MSArMDgwMAo+PiBBbGV4IFNoaSA8YWxleC5zaGlAbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+PiAKPj4+IFdoeSB5b3VyIHBhdGNoIHJlcGVhdGx5IGhh
cyBlbmNvZGluZyBpc3N1ZSB3aGljaCBmYWlscyBvbiAnZ2l0IGFtJwo+Pj4gQ291bGQgeW91IGxp
a2UgdG8gY2hlY2sgdGhlIHByb2JsZW0gYmVmb3JlIHNlbmQgb3V0Pwo+Pj4gQ291bGQgeW91IHBs
ZWFzZSBmaXggeW91ciBlZGl0b3IgaXNzdWUgYnkgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2VtYWls
LWNsaWVudHMucnN0Cj4+PiBvciBzZW5kIHBhdGNoIGJ5IGdpdCBzZW5kLWVtYWlsLgo+Pj4KPj4+
IEFuZCBwbGVhc2UgZG9uJ3Qgd2FzdGUgb3RoZXIgdGltZSBvbiBtZWFuaW5nbGVzcyBpc3N1ZSBh
Z2FpbiEKPj4gCj4+IFRoZSB3YXkgdG8gYmUgc3VyZSB5b3UgaGF2ZSBzb2x2ZWQgdGhpcyBraW5k
IG9mIHByb2JsZW0gaXMgdG8gZmlyc3QgZW1haWwKPj4gdGhlIHBhdGNoIHRvIHlvdSwgdGhlbiBi
ZSBzdXJlIHRoYXQgd2hhdCB5b3UgcmVjZWl2ZSBjYW4gYmUgYXBwbGllZC4KPj4gUGxlYXNlIGdl
dCB0byB0aGUgcG9pbnQgd2hlcmUgdGhhdCB3b3JrcywgdGhlbiBJJ2xsIGJlIGdsYWQgdG8gYXBw
bHkgeW91cgo+PiB0cmFuc2xhdGlvbnMuCj4+IAo+Cj5DQyBRaW5nLAo+Cj5UaGVyZSBhcmUgZmV3
IGRvY3VtZW50cyBvZiBob3cgdG8gam9pbiB0aGUgY29tbXVuaXR5IGRldmVsb3BtZW50Cj4gIGh0
dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3RyYW5zbGF0aW9ucy96aF9DTi9p
bmRleC5odG1sCj5TaG9ydGx5LCBzdGggY291bGQgYmUgc3VtbWFyaWVkIGFzIGZvbGxvd2luZyBp
biBwYXJpdGljdWxhciBkb2N1bWVudHMuCj4KPjEsIHNldHVwIHdlbGwgeW91ciBlbWFpbCBjbGll
bnQsIHRvIGJlIHN1cmUgYWxsIHlvdXIgcGF0Y2ggZnJvbSB5b3VyIGVtYWlsIHN5c3RlbQo+Y291
bGQgYmUgYXBwbGllZCBieSAnZ2l0IGFtJy4gQ3VycmVudCBlbWFpbCBjbGllbnQgb2Z0ZW4gY292
ZXIgdGhlIGVuZGNvZGluZyBpc3N1ZQo+YnV0IGdpdCB3aWxsIGZhaWxlZCBvbiB0aGF0Lgo+Cj4y
LCAnbWFrZSBoZWxwJyBzaG93IGNvdXBsZSBvZiBkb2MgcmVsYXRlZCBvcHRpb25zOgo+ICBodG1s
ZG9jcyAgICAgICAgLSBIVE1MCj4gIGxhdGV4ZG9jcyAgICAgICAtIExhVGVYCj4gIHBkZmRvY3Mg
ICAgICAgICAtIFBERgo+ICBlcHViZG9jcyAgICAgICAgLSBFUFVCCj4gIHhtbGRvY3MgICAgICAg
ICAtIFhNTAo+ICBsaW5rY2hlY2tkb2NzICAgLSBjaGVjayBmb3IgYnJva2VuIGV4dGVybmFsIGxp
bmtzCj4gICAgICAgICAgICAgICAgICAgICh3aWxsIGNvbm5lY3QgdG8gZXh0ZXJuYWwgaG9zdHMp
Cj4gIHJlZmNoZWNrZG9jcyAgICAtIGNoZWNrIGZvciByZWZlcmVuY2VzIHRvIG5vbi1leGlzdGlu
ZyBmaWxlcyB1bmRlcgo+ICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uCj4gIGNsZWFu
ZG9jcyAgICAgICAtIGNsZWFuIGFsbCBnZW5lcmF0ZWQgZmlsZXMKPgo+RG8gJ21ha2UgbGlua2No
ZWNrZG9jcy9yZWZjaGVja2RvY3MvaHRtbGRvY3MnLCBhbmQgY2hlY2sgaWYgdGhlIHJlc3VsdCB3
b3JrcyBhcwo+ZXhwZWN0ZWQsIG9mIGNvdXJzZSBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgeW91IGNh
biBtYWtlL2NoZWNrIGFsbCB0eXBlIGRvY3MsIGJ1dAo+YXQgbGVhc3QgZmluaXNoIGFib3ZlIDMg
a2luZHMgb2YgY2hlY2tzLgo+Cj4zLCBBcyB0byByZWxhdGVkIGRvY3MsIHNlbmRpbmcgdGhlbSBh
cyBhIGNvdXBsZSBzZXJpZXMgY291bGQgaGVscCBwZW9wbGUgcmV0cmlldmUKPmVhc3kuCj4KPmxv
b2tpbmcgZm9yd2FyZCBmb3IgeW91ciBuZXcgdHJhbnNsYXRpb24gZG9jcy4KPgoKU29ycnkgZm9y
IGJyaW5naW5nIHRyb3VibGUuIEkgdXNlZCAnZ2l0IHNlbmQtZW1haWwnIHdpdGggVVRGLTgsIGFs
c28gYnVpbHQgd2l0aCAKJ21ha2UgaHRtbGRvY3MnLiBJIHRoaW5rIHRoYXQgY2F1c2VkIGJ5IHR3
byBwYXRjaGVzKHRyYW5zbGF0aW9uIG9mIApEb2N1bWVudGF0aW9uL2FybTY0L2h1Z2V0bGJwYWdl
LnJzdCBhbmQgRG9jdW1lbnRhdGlvbi9hcm02NC9wZXJmLnJzdCkKc2VxdWVuY2UsIGh1Z2V0bGJw
YWdlIGZpcnN0IHBlcmYucnN0IHNlY29uZC4gSXQncyBteSBtaXN0YWtlLEknbGwgc2VuZCB3aXRo
IHBhdGNoClNlcmllcyBmb3IgdGhpcyB0d28gcGF0Y2guCgpUaGFua3MKQmFpbHUKCj5UaGFua3MK
PkFsZXgKPgoKDQoNCg==
