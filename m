Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491FA2FCF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbhATLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:38:01 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:30386 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733251AbhATKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611139128; x=1642675128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gOQ4TyJlSdY2H8J0PHg0yGTMIu5bZqwgXv3CnZbFRxo=;
  b=tCAb4uGyad/J2Do1ssuUdC5tDCL3OOGpWAcZZo/eA1wpis4htgKz4Psd
   vBQtNoU8krPQHyrkJH1isl4UADr7+1EwIKHWBWkLiZa3ASqpqtYHD+uaw
   4giP4Lb7+l7zQAGHlPSlwASJGzs+3dTmrkTlGWlCMe6nR22u8wwsMfzHz
   Y=;
X-IronPort-AV: E=Sophos;i="5.79,360,1602547200"; 
   d="scan'208";a="76064764"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 Jan 2021 10:37:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D88BBA26E0;
        Wed, 20 Jan 2021 10:37:39 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 10:37:38 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 10:37:38 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.010;
 Wed, 20 Jan 2021 10:37:38 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re:  [tip:x86/pti 4/5] arch/x86/mm/tlb.c:319:6: warning: variable
 'cpu' set but not used
Thread-Topic: [tip:x86/pti 4/5] arch/x86/mm/tlb.c:319:6: warning: variable
 'cpu' set but not used
Thread-Index: AQHW7xhF66b0fj82KEilERo4lUNYOA==
Date:   Wed, 20 Jan 2021 10:37:38 +0000
Message-ID: <71f2a4567f0853b26048918ec1afff24ae87e5be.camel@amazon.com>
References: <202101161129.TiX15hOi-lkp@intel.com>
In-Reply-To: <202101161129.TiX15hOi-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D294C5BCDC630408CFF807E1D81DB54@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTE2IGF0IDExOjIxICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gDQo+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdGlwL3RpcC5naXQgeDg2L3B0aQ0KPiBoZWFkOiAgIDc2N2Q0NmFiNTY2ZGQ0ODk3
MzM2NjZlZmU0ODczMmQ1MjNjOGMzMzINCj4gY29tbWl0OiBiNjcyNGYxMThkNDQ2MDZmZGRkZTM5
MWJhNzUyNzUyNmIzY2FkMjExIFs0LzVdIHByY3RsOiBIb29rIEwxRCBmbHVzaGluZyBpbiB2aWEg
cHJjdGwNCj4gY29uZmlnOiBpMzg2LXJhbmRjb25maWctcjAyNi0yMDIxMDExNSAoYXR0YWNoZWQg
YXMgLmNvbmZpZykNCj4gY29tcGlsZXI6IGdjYy05IChEZWJpYW4gOS4zLjAtMTUpIDkuMy4wDQo+
IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6DQo+ICAgICAgICAgIyBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlwLmdpdC9jb21taXQv
P2lkPWI2NzI0ZjExOGQ0NDYwNmZkZGRlMzkxYmE3NTI3NTI2YjNjYWQyMTENCj4gICAgICAgICBn
aXQgcmVtb3RlIGFkZCB0aXAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdGlwL3RpcC5naXQNCj4gICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIHRpcCB4
ODYvcHRpDQo+ICAgICAgICAgZ2l0IGNoZWNrb3V0IGI2NzI0ZjExOGQ0NDYwNmZkZGRlMzkxYmE3
NTI3NTI2YjNjYWQyMTENCj4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8g
bGludXggYnVpbGQgdHJlZQ0KPiAgICAgICAgIG1ha2UgVz0xIEFSQ0g9aTM4Ng0KPg0KDQpUaGVy
ZSBpcyBhIG5ld2VyIHJldmlzaW9uIG9mIHRoZSBwYXRjaGVzIHBvc3RlZCBhdCANCiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwMTA4MTIxMDU2LjIxOTQwLTEtc2JsYmlyQGFtYXpv
bi5jb20vVC8NCg0Kd2hpY2ggc2hvdWxkIG5vdCBoYXZlIHRoaXMgcHJvYmxlbS9pc3N1ZS4NCg0K
QmFsYmlyIFNpbmdoLg0K
