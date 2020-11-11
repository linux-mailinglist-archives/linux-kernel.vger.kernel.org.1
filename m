Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D881F2AFAED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgKKWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:00:39 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47698 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605132039; x=1636668039;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PdYNU1jv677uCYyrbOqBu2wDm1dDg/luctKGPIAv69Y=;
  b=fYBA/j2I7Qg8X9jOIM3yYpJyznBFQqUDVczJqIzfNgcDiIpdEt1jq5BB
   ShFRWyH41vL+jttbZAfpoan1ymzyOeM5+thPIWyDtIICXdO+UN5+WxfdN
   OwMuZEaqXaNRygEdxdIdn1gNOtDkfGx+99VaAma2r2vrTIMpvYlx8zw5E
   s=;
X-IronPort-AV: E=Sophos;i="5.77,470,1596499200"; 
   d="scan'208";a="63676999"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Nov 2020 22:00:31 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 96EBFA1FB7;
        Wed, 11 Nov 2020 22:00:26 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Nov 2020 22:00:26 +0000
Received: from Alexanders-MacBook-Air.local (10.43.160.21) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Nov 2020 22:00:15 +0000
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <vineeth@bitbyteword.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        "Antonio Gomez Iglesias" <antonio.gomez.iglesias@intel.com>,
        <konrad.wilk@oracle.com>, Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        <James.Bottomley@hansenpartnership.com>, <OWeisse@umich.edu>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        "Anand K. Mistry" <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
Date:   Wed, 11 Nov 2020 23:00:13 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.21]
X-ClientProxiedBy: EX13D49UWC001.ant.amazon.com (10.43.162.217) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAxMS4xMS4yMCAyMjoxNCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6Cj4gCj4gU29ycnksIGZv
cmdvdCB0byBDQyArVG9tIExlbmRhY2t5IC4gUGxlYXNlIHRha2UgYSBsb29rIFRvbSwgdGhhbmtz
Lgo+IAo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDQ6MTAgUE0gSm9lbCBGZXJuYW5kZXMgKEdv
b2dsZSkKPiA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4gd3JvdGU6Cj4+Cj4+IFNvbWUgaGFyZHdh
cmUgc3VjaCBhcyBjZXJ0YWluIEFNRCB2YXJpYW50cyBkb24ndCBoYXZlIGNyb3NzLUhUIE1EUy9M
MVRGCj4+IGlzc3Vlcy4gRGV0ZWN0IHRoaXMgYW5kIGRvbid0IGVuYWJsZSBjb3JlIHNjaGVkdWxp
bmcgYXMgaXQgY2FuCj4+IG5lZWRsZXNzbHkgc2xvdyB0aGUgZGV2aWNlIGRvbmUuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxqb2VsQGpvZWxmZXJuYW5kZXMu
b3JnPgo+PiAtLS0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyB8IDggKysrKysrKysK
Pj4gICBrZXJuZWwvc2NoZWQvY29yZS5jICAgICAgICB8IDcgKysrKysrKwo+PiAgIGtlcm5lbC9z
Y2hlZC9zY2hlZC5oICAgICAgIHwgNSArKysrKwo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYwo+PiBpbmRleCBkZWNlNzllNGQxZTkuLjBlNmU2
MWU0OWIyMyAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMKPj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMKPj4gQEAgLTE1Miw2ICsxNTIsMTQgQEAgdm9p
ZCBfX2luaXQgY2hlY2tfYnVncyh2b2lkKQo+PiAgICNlbmRpZgo+PiAgIH0KPj4KPj4gKy8qCj4+
ICsgKiBEbyBub3QgbmVlZCBjb3JlIHNjaGVkdWxpbmcgaWYgQ1BVIGRvZXMgbm90IGhhdmUgTURT
L0wxVEYgdnVsbmVyYWJpbGl0eS4KPj4gKyAqLwo+PiAraW50IGFyY2hfYWxsb3dfY29yZV9zY2hl
ZCh2b2lkKQo+PiArewo+PiArICAgICAgIHJldHVybiBib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdf
TURTKSB8fCBib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfTDFURik7CgpDYW4gd2UgbWFrZSB0aGlz
IG1vcmUgZ2VuZXJpYyBhbmQgdXNlciBzZXR0YWJsZSwgc2ltaWxhciB0byB0aGUgTDEgY2FjaGUg
CmZsdXNoaW5nIG1vZGVzIGluIEtWTT8KCkkgYW0gbm90IDEwMCUgY29udmluY2VkIHRoYXQgdGhl
cmUgYXJlIG5vIG90aGVyIHRocmVhZCBzaWJsaW5nIGF0dGFja3MgCnBvc3NpYmxlIHdpdGhvdXQg
TURTIGFuZCBMMVRGLiBJZiBJJ20gcGFyYW5vaWQsIEkgd2FudCB0byBzdGlsbCBiZSBhYmxlIAp0
byBmb3JjZSBlbmFibGUgY29yZSBzY2hlZHVsaW5nLgoKSW4gYWRkaXRpb24sIHdlIGFyZSBhbHNv
IHVzaW5nIGNvcmUgc2NoZWR1bGluZyBhcyBhIHBvb3IgbWFuJ3MgbWVjaGFuaXNtIAp0byBnaXZl
IGN1c3RvbWVycyBjb25zaXN0ZW50IHBlcmZvcm1hbmNlIGZvciB2aXJ0dWFsIG1hY2hpbmUgdGhy
ZWFkIApzaWJsaW5ncy4gVGhpcyBpcyBpbXBvcnRhbnQgaXJyZXNwZWN0aXZlIG9mIENQVSBidWdz
LiBJbiBzdWNoIGEgCnNjZW5hcmlvLCBJIHdhbnQgdG8gZm9yY2UgZW5hYmxlIGNvcmUgc2NoZWR1
bGluZy4KCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkty
YXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBT
Y2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJs
b3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkg
MjM3IDg3OQoKCg==

