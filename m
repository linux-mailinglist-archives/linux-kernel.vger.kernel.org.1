Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9B2FCF85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbhATLhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:37:09 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20745 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbhATK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611138537; x=1642674537;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=489DuV0HCs+0NG/MZ6LtIWG534Vfpey933FbltHxdbY=;
  b=e6eeI4jrJc+MG7fzFOdAeHT5+RgsbwHO4FIbdCAsRT1mGW8UukMO3hy6
   DrQ8mbCMHYBnmhTM3nG5cCs5SNmvcMAFba+ApWadU08HKo+ryWhT35cC3
   96jubmxPpXs3T2BduZ8kutE/pm9MF3jxtD6Aa8XMok3pmKf2WEk+cA6G3
   o=;
X-IronPort-AV: E=Sophos;i="5.79,360,1602547200"; 
   d="scan'208";a="76063297"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 Jan 2021 10:28:10 +0000
Received: from EX13D16EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 9E8E4A1E65;
        Wed, 20 Jan 2021 10:28:09 +0000 (UTC)
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.162.94) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 10:28:04 +0000
Subject: Re: [PATCH] nitro_enclaves: set master in the procedure of NE probe
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <arei.gonglei@huawei.com>, <linux-kernel@vger.kernel.org>,
        <lexnv@amazon.com>, <alcioa@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20210119033059.1467-1-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <2d00a341-1442-9c1f-8114-7b7ded7f4d2e@amazon.com>
Date:   Wed, 20 Jan 2021 12:27:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119033059.1467-1-longpeng2@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D37UWA001.ant.amazon.com (10.43.160.61) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAxOS8wMS8yMDIxIDA1OjMwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBBY2NvcmRpbmcg
dGhlIFBDSSBzcGVjOgo+ICAgIEJ1cyBNYXN0ZXIgRW5hYmxlIOKAkyBDb250cm9scyB0aGUgYWJp
bGl0eSBvZiBhIFBDSSBFeHByZXNzCj4gICAgRW5kcG9pbnQgdG8gaXNzdWUgTWVtb3J5IGFuZCBJ
L08gUmVhZC9Xcml0ZSBSZXF1ZXN0cywgYW5kCj4gICAgdGhlIGFiaWxpdHkgb2YgYSBSb290IG9y
IFN3aXRjaCBQb3J0IHRvIGZvcndhcmQgTWVtb3J5IGFuZAo+ICAgIEkvTyBSZWFkL1dyaXRlIFJl
cXVlc3RzIGluIHRoZSBVcHN0cmVhbSBkaXJlY3Rpb24KPgo+IFNldCBCdXNNYXN0ZXIgdG8gbWFr
ZSB0aGUgZHJpdmVyIHRvIGJlIFBDSSBjb25mb3JtYW50LgoKQ291bGQgdXBkYXRlIHRoZSBjb21t
aXQgdGl0bGUgYW5kIG1lc3NhZ2UgYm9keSB0byByZWZsZWN0IG1vcmUgdGhlIHdoeSAKYW5kIHdo
YXQgZm9yIHRoZSBjaGFuZ2UuIE9uZSBvcHRpb24gY2FuIGJlOgoKbml0cm9fZW5jbGF2ZXM6IFNl
dCBCdXMgTWFzdGVyIGZvciB0aGUgTkUgUENJIGRldmljZQoKRW5hYmxlIEJ1cyBNYXN0ZXIgZm9y
IHRoZSBORSBQQ0kgZGV2aWNlLCBhY2NvcmRpbmcgdG8gdGhlIFBDSSBzcGVjCmZvciBzdWJtaXR0
aW5nIG1lbW9yeSBvciBJL08gcmVxdWVzdHM6CiDCoCBCdXMgTWFzdGVyIEVuYWJsZSAuLi4KCgoK
UGxlYXNlIGluY2x1ZGUgdGhlIGNoYW5nZWxvZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgZm9yIHRo
ZSBuZXh0IHJldmlzaW9uKHMpLgoKKyBHcmVnIGluIENDLCBhcyB0aGUgcGF0Y2hlcyBmb3IgdGhl
IE5pdHJvIEVuY2xhdmVzIGtlcm5lbCBkcml2ZXIgYXJlIApmaXJzdCBpbmNsdWRlZCBpbiB0aGUg
Y2hhciBtaXNjIHRyZWUsIHRoZW4gaW4gdGhlIGxpbnV4IG5leHQgYW5kIGZpbmFsbHkgCmluIHRo
ZSBtYWlubGluZS4KCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyhNaWtlKSA8bG9uZ3Blbmcy
QGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfcGNp
X2Rldi5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9wY2lfZGV2LmMgYi9kcml2
ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfcGNpX2Rldi5jCj4gaW5kZXggYjljMWRlNC4uMTQz
MjA3ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfcGNpX2Rl
di5jCj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX3BjaV9kZXYuYwo+IEBA
IC00ODAsNiArNDgwLDggQEAgc3RhdGljIGludCBuZV9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYg
KnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiAgICAgICAgICAgICAgICAg
IGdvdG8gZnJlZV9uZV9wY2lfZGV2Owo+ICAgICAgICAgIH0KPgo+ICsgICAgICAgcGNpX3NldF9t
YXN0ZXIocGRldik7CgpJIHdhcyBsb29raW5nIGlmIHdlIG5lZWQgdGhlIHJldmVyc2UgZm9yIHRo
aXMgLSBwY2lfY2xlYXJfbWFzdGVyKCkgWzFdIC0gCm9uIHRoZSBlcnJvciBhbmQgcmVtb3ZlIC8g
c2h1dGRvd24gY29kZWJhc2UgcGF0aHMsIGJ1dCAKcGNpX2Rpc2FibGVfZGV2aWNlKCkgc2VlbXMg
dG8gaW5jbHVkZSB0aGUgYnVzIG1hc3RlciBkaXNhYmxlIGxvZ2ljIFsyXVszXS4KClRoYW5rcywK
QW5kcmEKClsxXSAKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9wY2kvcGNpLmM/aD12NS4xMS1yYzQj
bjQzMTIKWzJdIApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL3BjaS9wY2kuYz9oPXY1LjExLXJjNCNu
MjEwNApbM10gCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvcGNpL3BjaS5jP2g9djUuMTEtcmM0I240
MjQyCgo+ICsKPiAgICAgICAgICByYyA9IHBjaV9yZXF1ZXN0X3JlZ2lvbnNfZXhjbHVzaXZlKHBk
ZXYsICJuaXRyb19lbmNsYXZlcyIpOwo+ICAgICAgICAgIGlmIChyYyA8IDApIHsKPiAgICAgICAg
ICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkVycm9yIGluIHBjaSByZXF1ZXN0IHJlZ2lv
bnMgW3JjPSVkXVxuIiwgcmMpOwo+IC0tCj4gMS44LjMuMQo+CgoKCgpBbWF6b24gRGV2ZWxvcG1l
bnQgQ2VudGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBTZi4gTGF6
YXIgU3RyZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1LCBSb21h
bmlhLiBSZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIyLzI2MjEv
MjAwNS4K

