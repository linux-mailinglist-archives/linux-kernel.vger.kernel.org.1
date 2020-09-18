Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40E26F743
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgIRHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:43:45 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:57148 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgIRHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:43:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1003472|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0438238-0.00273133-0.953445;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=liush@allwinnertech.com;NM=1;PH=DW;RN=12;RT=12;SR=0;TI=W4_5948689_DEFAULT_0AB101D6_1600414937784_o7001c71t;
Received: from WS-web (liush@allwinnertech.com[W4_5948689_DEFAULT_0AB101D6_1600414937784_o7001c71t]) by ay29a011140100202.et135 at Fri, 18 Sep 2020 15:43:39 +0800
Date:   Fri, 18 Sep 2020 15:43:39 +0800
From:   "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "paul.walmsley" <paul.walmsley@sifive.com>,
        "palmer" <palmer@dabbelt.com>, "aou" <aou@eecs.berkeley.edu>,
        "akpm" <akpm@linux-foundation.org>, "peterx" <peterx@redhat.com>,
        "walken" <walken@google.com>,
        "daniel.m.jordan" <daniel.m.jordan@oracle.com>,
        "vbabka" <vbabka@suse.cz>, "rppt" <rppt@kernel.org>,
        "linux-riscv" <linux-riscv@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
Message-ID: <ca550ec0-73f2-485e-84fd-036eacd0bcd9.liush@allwinnertech.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSByaXNjdjogZml4IHBmbl90b192aXJ0IGVyciBpbiBkb19wYWdl?=
  =?UTF-8?B?X2ZhdWx0KCku?=
X-Mailer: [Alimail-Mailagent][W4_5948689][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>,<20200917152518.GA8930@infradead.org>
x-aliyun-mail-creator: W4_5948689_DEFAULT_MzYTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODUuMC40MTgzLjEwMiBTYWZhcmkvNTM3LjM2zc
In-Reply-To: <20200917152518.GA8930@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLAo+IE9uIFRodSwgU2VwIDE3LCAyMDIwIGF0IDAzOjI1OjQ5UE0gKzA4MDAs
IGxpdXNoIHdyb3RlOgo+ID4gVGhlIGFyZ3VtZW50IHRvIHBmbl90b192aXJ0KCkgc2hvdWxkIGJl
IHBmbiBub3QgdGhlIHZhbHVlIG9mIENTUl9TQVRQLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBs
aXVzaCA8bGl1c2hAYWxsd2lubmVydGVjaC5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL3Jpc2N2L21t
L2ZhdWx0LmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L21tL2ZhdWx0LmMgYi9h
cmNoL3Jpc2N2L21tL2ZhdWx0LmMKPiA+IGluZGV4IDcxNmQ2NGUuLjliNGUwODggMTAwNjQ0Cj4g
PiAtLS0gYS9hcmNoL3Jpc2N2L21tL2ZhdWx0LmMKPiA+ICsrKyBiL2FyY2gvcmlzY3YvbW0vZmF1
bHQuYwo+ID4gQEAgLTIxMiw3ICsyMTIsNyBAQCBhc21saW5rYWdlIHZvaWQgZG9fcGFnZV9mYXVs
dChzdHJ1Y3QgcHRfcmVncyAqcmVncykKPiA+ICAgICAqIG9mIGEgdGFzayBzd2l0Y2guCj4gPiAg
ICAgKi8KPiA+ICAgIGluZGV4ID0gcGdkX2luZGV4KGFkZHIpOwo+ID4gLSAgcGdkID0gKHBnZF90
ICopcGZuX3RvX3ZpcnQoY3NyX3JlYWQoQ1NSX1NBVFApKSArIGluZGV4Owo+ID4gKyAgcGdkID0g
KHBnZF90ICopcGZuX3RvX3ZpcnQoY3NyX3JlYWQoQ1NSX1NBVFApICYgU0FUUF9QUE4pICsgaW5k
ZXg7Cgo+IFRoaXMgYWRkcyBhIGNyYXp5IGxvbmcgbGluZS4gIE9uZSBuaWNlIHdheSB0byBjbGVh
biB0aGlzIHVwIHdvdWxkIGJlIHRvCj4gYWRkIGEgbG9jYWwgcGZuIHZhcmlhYmxlLCBhcyBpdCB3
b3VsZCBhbHNvIG1ha2UgdGhlIGNvZGUgbW9yZSByZWFkYWJsZS4KClRoYW5rcywgaSdsbCBtb2Rp
ZnkgaXQgaW4gbmV4dCByZXZpc2lvbg==
