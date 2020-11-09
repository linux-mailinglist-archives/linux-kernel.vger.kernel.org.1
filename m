Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43E2AAF1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgKICKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:10:50 -0500
Received: from mail.djicorp.com ([14.21.64.4]:56013 "EHLO mail.djicorp.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728006AbgKICKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:10:50 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2020 21:10:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dji.com; s=djiselector;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Z240+qv+bpaWBtHoaivfTDQOaAe0/mMdBO5J3b33XmQ=;
  b=srUAoI+arnciVZvOdZW54MCe3rXEdOgGzPT/6YHgdr1FQCoN+lCs9uY+
   nkZsZh8N+sDvHiHeDQkYeJjjLi8ahwRSaNixeFykgfxt3pbH4VZZTMlBc
   dW8E+HUnjx3ShibgDl4XH8pejsZsAYpjr9UmFP3IghIiLKpQimP0SWagG
   k=;
IronPort-SDR: vet+B9TNl9UDuD8I/xDFVhhzTrZHaqch6D1CpYvya6TELaRVv5K08EEJpBtxjd8vPu1wvcwV2t
 f+hB9LLvf3Mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EIBQBCoKhf/7IBCgpiHgEBCxIMR4N?=
 =?us-ascii?q?DgmOEM6tjgWgLAQEBAQEBAQEBCRMcBAEBhEoZgXomOBMCAwEBCwEBBgEBAQE?=
 =?us-ascii?q?BBgQCAoZPC4cKPwYSAQYPDygEMBcBDgEEDg2XO5t+CYEwGgKIcIFCCQGBAC6?=
 =?us-ascii?q?BZYo8gS2BTT8mgSGCDCJshAkBEgGDNIJjBJAdEo13mgAHDoJigRULmWQrgxi?=
 =?us-ascii?q?KEoU3A48Mk06cK4RDgWuBC3BwgzpPFwKOOBeBAgECjSGBLAIGAQkBAQMJjTe?=
 =?us-ascii?q?BEQEB?=
X-IPAS-Result: =?us-ascii?q?A2EIBQBCoKhf/7IBCgpiHgEBCxIMR4NDgmOEM6tjgWgLA?=
 =?us-ascii?q?QEBAQEBAQEBCRMcBAEBhEoZgXomOBMCAwEBCwEBBgEBAQEBBgQCAoZPC4cKP?=
 =?us-ascii?q?wYSAQYPDygEMBcBDgEEDg2XO5t+CYEwGgKIcIFCCQGBAC6BZYo8gS2BTT8mg?=
 =?us-ascii?q?SGCDCJshAkBEgGDNIJjBJAdEo13mgAHDoJigRULmWQrgxiKEoU3A48Mk06cK?=
 =?us-ascii?q?4RDgWuBC3BwgzpPFwKOOBeBAgECjSGBLAIGAQkBAQMJjTeBEQEB?=
X-IronPort-AV: E=Sophos;i="5.77,462,1596470400"; 
   d="scan'208";a="60263688"
Received: from unknown (HELO mail.dji.com) ([10.10.1.178])
  by mail.djicorp.com with ESMTP; 09 Nov 2020 10:03:12 +0800
Received: from MAIL-MBX-cwP04.dji.com (10.10.17.104) by djimail04-in.dji.com
 (10.10.1.178) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Mon, 9 Nov
 2020 10:03:11 +0800
Received: from MAIL-MBX-cwP02.dji.com (10.10.17.102) by MAIL-MBX-cwP04.dji.com
 (10.10.17.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Nov
 2020 10:03:11 +0800
Received: from MAIL-MBX-cwP02.dji.com ([fe80::f109:aaff:cc3f:6c6e]) by
 MAIL-MBX-cwP02.dji.com ([fe80::f109:aaff:cc3f:6c6e%17]) with mapi id
 15.00.1497.006; Mon, 9 Nov 2020 10:03:11 +0800
From:   Tim Li <tim.li@dji.com>
To:     "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question: gadget: How to realize uvc and uac composite function?
Thread-Topic: Question: gadget: How to realize uvc and uac composite function?
Thread-Index: Ada2PEqQqZapFjGpRP6iM/G2ZHY0Ig==
Date:   Mon, 9 Nov 2020 02:03:11 +0000
Message-ID: <883ccf2fb0a34c7d8466db09b3f26e72@MAIL-MBX-cwP02.dji.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.8.101]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpWZXJzaW9uOiA0LjkgYW5kIHVhYzEgZHJpdmVyIGlzIFY1LjkuIEkgdGVzdGVkIGl0IGJh
c2VkIG9uIDQuOSB3aXRoIGJhY2twb3J0ZWQgZHdjMyBkcml2ZXIgZnJvbWUgdjUuOS4NCjEuIEFj
Y29yZGluZyB0byBjb25maWdmcy11c2ItZ2FkZ2V0LXV2YywgUEMoV2luZG93cyAxMCkgY2FuIGdl
dCBJU08gZGF0YSBub3JtYWxseTsNCjIuIEFjY29yZGluZyB0byBjb25maWdmcy11c2ItZ2FkZ2V0
LXVhYzEsIFBDKFdpbmRvd3MgMTApIGNhbiAgaW5zdGFsbCBhdWRpbyBkcml2ZXIgbm9ybWFsbHko
QUMgSW50ZXJmYWNlLC9DYXB0dWUgSW5wdXQgdGVybWluYWwvU3BlYWtlcik7DQozoaJ1dmMrdWFj
MSBjb21wb3NpdGUgZGV2aWNlLCBQQyhXaW5kb3dzIDEwKSBjYW4gZ2V0IElTTyBkYXRhIG5vcm1h
bGx5LCBidXQgUEMgc2hvd3MgdGhhdCB0aGUgdWFjMSBkcml2ZXIgaW5zdGFsbGF0aW9uIGZhaWxl
ZChBQyBJbnRlcmZhY2UvQ2FwdHVyZSBJbmFjdGl2ZS9QbGF5YmFjayBJbmFjdGl2ZSkuIEFDIElu
dGVyZmFjZS9DYXB0dXJlIEluYWN0aXZlL1BsYXliYWNrIEluYWN0aXZlIGFsbCBzaG93IHRoZSBk
ZXZpY2UgY2Fubm90IHN0YXJ0IGNvZGUgMTAsIFRoZSBzZXR0aW5ncyBvZiB0aGUgSS9PIGRldmlj
ZSBhcmUgaW5jb3JyZWN0IG9yIHRoZSBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMgb2YgdGhlIGRy
aXZlciBhcmUgaW5jb3JyZWN0LiBUaHJvdWdoIHRoZSBVU0IgYW5hbHl6ZXIgdG8gY2FwdHVyZSB0
aGUgcGFja2V0LCBJIGZvdW5kIHRoYXQgdGhlIEluZGV4IHZhbHVlIHNlZW1zIHRvIGJlIHdyb25n
IHdoZW4gUEMgaG9zdCB0byBnZXQgdGhlIGRlc2NyaXB0b3IuIFRoZSBhY3F1aXNpdGlvbiBpcyBQ
bGF5YmFjayBJbmFjdGl2ZSBhbmQgQ2FwdHVyZSBJbmFjdGl2ZSwgYW5kIHRoZSBQQyBkaWQgbm90
IHNlbmQgdGhlIGNvbW1hbmQgcGFja2V0IGFib3V0IHVhYzEuIEl0IGlzIGRpZmZpY3VsdCB0byBk
ZWJ1ZyBpdC4NCg0KIEkgc2luY2VyZWx5IGhvcGUgdGhhdCBldmVyeW9uZSBjYW4gZ2l2ZSBzb21l
IHN1Z2dlc3Rpb25zIG9yIHJlbGF0ZWQgcGF0Y2hlcyB0byBoZWxwIG1lLiBUaGFua3MgdmVyeSBt
dWNoIQ0KDQpSZWdhcmRzLA0KcGVuZ2NoZW5nDQpUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgdGhlcmV0byBtYXkgY29udGFpbiBwcml2YXRlLCBjb25maWRlbnRpYWwsIGFuZCBwcml2aWxl
Z2VkIG1hdGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudC4g
QW55IHJldmlldywgY29weWluZywgb3IgZGlzdHJpYnV0aW9uIG9mIHRoaXMgZW1haWwgKG9yIGFu
eSBhdHRhY2htZW50cyB0aGVyZXRvKSBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBhbmQgcGVybWFuZW50bHkgZGVsZXRlIHRoZSBvcmlnaW5hbCBh
bmQgYW55IGNvcGllcyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdGhlcmV0by4N
Cg0KtMu159fT08q8/rywuL28/sv5sPy6rMTayN2+39PQu/rD3NDUo6zH0r32z97T2r3TytXIy8q5
08Oho860vq3UytDto6y9+9a5tdrI/cjL1MS2waGiuLTWxrvytKuypbjDtefX09PKvP7W0LXEyM66
ztDFz6Kho8jnufvE+rK7yvTT2tLUyc+159fT08q8/rXExL+x6r3TytXV36Osx+vE+sGivLTNqNaq
t6LLzcjLsqLJvrP91K2159fT08q8/rywxuTP4LnYtcS4vbz+oaMNCg==
