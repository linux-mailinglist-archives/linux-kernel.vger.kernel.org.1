Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB322AFB77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgKKWhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:37:13 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21079 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKKWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605134110; x=1636670110;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KItWozf+ZmCMhG2WY6HZC8mXq55fT7k6OJIXIJ8sJgE=;
  b=UH8yQAu3fk6GAR9l0RkhOW5LU7hcIWqtZG7xWPZ8WyVKHEMmG9t3zyLg
   eMNXDsGVVP5w8y4vOa1zJFcxFOMR5yhOhkZDL/EAD7+JFmdllkc0QHk7y
   ptqpgPYwpfR/vhKsRV5dduvOjbx/7kvgnPCO3iBkfcHfcF9naTnVqzZfi
   M=;
X-IronPort-AV: E=Sophos;i="5.77,470,1596499200"; 
   d="scan'208";a="93160450"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Nov 2020 22:29:53 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 485AAA0727;
        Wed, 11 Nov 2020 22:29:50 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Nov 2020 22:29:49 +0000
Received: from Alexanders-MacBook-Air.local (10.43.161.34) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Nov 2020 22:29:39 +0000
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <vineeth@bitbyteword.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        <konrad.wilk@oracle.com>, Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
Date:   Wed, 11 Nov 2020 23:29:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D49UWB001.ant.amazon.com (10.43.163.72) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAxMS4xMS4yMCAyMzoxNSwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6Cj4gCj4gT24gV2VkLCBO
b3YgMTEsIDIwMjAgYXQgNToxMyBQTSBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVz
Lm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDU6MDAgUE0gQWxleGFu
ZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gd3JvdGU6Cj4+PiBPbiAxMS4xMS4yMCAyMjoxNCwg
Sm9lbCBGZXJuYW5kZXMgd3JvdGU6Cj4+Pj4+IFNvbWUgaGFyZHdhcmUgc3VjaCBhcyBjZXJ0YWlu
IEFNRCB2YXJpYW50cyBkb24ndCBoYXZlIGNyb3NzLUhUIE1EUy9MMVRGCj4+Pj4+IGlzc3Vlcy4g
RGV0ZWN0IHRoaXMgYW5kIGRvbid0IGVuYWJsZSBjb3JlIHNjaGVkdWxpbmcgYXMgaXQgY2FuCj4+
Pj4+IG5lZWRsZXNzbHkgc2xvdyB0aGUgZGV2aWNlIGRvbmUuCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVn
cy5jCj4+Pj4+IGluZGV4IGRlY2U3OWU0ZDFlOS4uMGU2ZTYxZTQ5YjIzIDEwMDY0NAo+Pj4+PiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYwo+Pj4+PiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L2J1Z3MuYwo+Pj4+PiBAQCAtMTUyLDYgKzE1MiwxNCBAQCB2b2lkIF9faW5pdCBjaGVj
a19idWdzKHZvaWQpCj4+Pj4+ICAgICNlbmRpZgo+Pj4+PiAgICB9Cj4+Pj4+Cj4+Pj4+ICsvKgo+
Pj4+PiArICogRG8gbm90IG5lZWQgY29yZSBzY2hlZHVsaW5nIGlmIENQVSBkb2VzIG5vdCBoYXZl
IE1EUy9MMVRGIHZ1bG5lcmFiaWxpdHkuCj4+Pj4+ICsgKi8KPj4+Pj4gK2ludCBhcmNoX2FsbG93
X2NvcmVfc2NoZWQodm9pZCkKPj4+Pj4gK3sKPj4+Pj4gKyAgICAgICByZXR1cm4gYm9vdF9jcHVf
aGFzX2J1ZyhYODZfQlVHX01EUykgfHwgYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX0wxVEYpOwo+
Pj4KPj4+IENhbiB3ZSBtYWtlIHRoaXMgbW9yZSBnZW5lcmljIGFuZCB1c2VyIHNldHRhYmxlLCBz
aW1pbGFyIHRvIHRoZSBMMSBjYWNoZQo+Pj4gZmx1c2hpbmcgbW9kZXMgaW4gS1ZNPwo+Pj4KPj4+
IEkgYW0gbm90IDEwMCUgY29udmluY2VkIHRoYXQgdGhlcmUgYXJlIG5vIG90aGVyIHRocmVhZCBz
aWJsaW5nIGF0dGFja3MKPj4+IHBvc3NpYmxlIHdpdGhvdXQgTURTIGFuZCBMMVRGLiBJZiBJJ20g
cGFyYW5vaWQsIEkgd2FudCB0byBzdGlsbCBiZSBhYmxlCj4+PiB0byBmb3JjZSBlbmFibGUgY29y
ZSBzY2hlZHVsaW5nLgo+Pj4KPj4+IEluIGFkZGl0aW9uLCB3ZSBhcmUgYWxzbyB1c2luZyBjb3Jl
IHNjaGVkdWxpbmcgYXMgYSBwb29yIG1hbidzIG1lY2hhbmlzbQo+Pj4gdG8gZ2l2ZSBjdXN0b21l
cnMgY29uc2lzdGVudCBwZXJmb3JtYW5jZSBmb3IgdmlydHVhbCBtYWNoaW5lIHRocmVhZAo+Pj4g
c2libGluZ3MuIFRoaXMgaXMgaW1wb3J0YW50IGlycmVzcGVjdGl2ZSBvZiBDUFUgYnVncy4gSW4g
c3VjaCBhCj4+PiBzY2VuYXJpbywgSSB3YW50IHRvIGZvcmNlIGVuYWJsZSBjb3JlIHNjaGVkdWxp
bmcuCj4+Cj4+IE9rLCAgSSBjYW4gbWFrZSBpdCBuZXcga2VybmVsIGNvbW1hbmQgbGluZSBvcHRp
b24gd2l0aDoKPj4gY29yZXNjaGVkPW9uCj4+IGNvcmVzY2hlZD1zZWN1cmUgKG9ubHkgaWYgSFcg
aGFzIE1EUy9MMVRGKQo+PiBjb3Jlc2NoZWQ9b2ZmCj4gCj4gQWxzbywgSSB3b3VsZCBrZWVwICJz
ZWN1cmUiIGFzIHRoZSBkZWZhdWx0LiAgKEFuZCBwcm9iYWJseSwgd2Ugc2hvdWxkCj4gbW9kaWZ5
IHRoZSBpbmZvcm1hdGlvbmFsIG1lc3NhZ2VzIGluIHN5c2ZzIHRvIHJlZmxlY3QgdGhpcy4uKQoK
SSBhZ3JlZSB0aGF0ICJzZWN1cmUiIHNob3VsZCBiZSB0aGUgZGVmYXVsdC4gQ2FuIHdlIGFsc28g
aW50ZWdyYXRlIGludG8gCnRoZSAibWl0aWdhdGlvbnMiIGtlcm5lbCBjb21tYW5kIGxpbmVbMV0g
Zm9yIHRoaXM/CgoKQWxleAoKWzFdIApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCNuMjgzOQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0
c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdl
biBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejog
QmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

