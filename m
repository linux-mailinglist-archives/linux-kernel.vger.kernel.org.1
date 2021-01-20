Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127182FCE48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbhATKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:20:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:62984 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbhATKLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:11:35 -0500
IronPort-SDR: Yl75W1c2bDz5RG7CWTuxihD4u6xBG72hM+6vu+6iEWg9JAJXZkECI/MGSmb64aKJ9XN3BagUpn
 lQRfSZMZbVHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179228308"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="179228308"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 02:10:50 -0800
IronPort-SDR: Y3q4iHQ39GKdIRFZJuHQUZndvahXpGhqws8lMBncjHvIY87iG83soE++lcwWFCbYh4Sg5tKHWb
 mAaau6gwipwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="355996544"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2021 02:10:48 -0800
Received: from irsmsx602.ger.corp.intel.com (163.33.146.8) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 10:10:47 +0000
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8]) by
 irsmsx602.ger.corp.intel.com ([163.33.146.8]) with mapi id 15.01.1713.004;
 Wed, 20 Jan 2021 10:10:47 +0000
From:   "Girdwood, Liam R" <liam.r.girdwood@intel.com>
To:     "anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH 0/7] ALSA: add virtio sound driver
Thread-Topic: [PATCH 0/7] ALSA: add virtio sound driver
Thread-Index: AQHW7xSF5+25jD6v60GKV9bYQ1UsAw==
Date:   Wed, 20 Jan 2021 10:10:47 +0000
Message-ID: <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8799E9B4388B3499FBC9D607BD6246A@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW50b24sDQoNCk9uIFdlZCwgMjAyMS0wMS0yMCBhdCAwMTozNiArMDEwMCwgQW50b24gWWFr
b3ZsZXYgd3JvdGU6DQo+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgYSBkcml2ZXIgcGFydCBvZiB0
aGUgdmlydGlvIHNvdW5kIGRldmljZQ0KPiBzcGVjaWZpY2F0aW9uIHY4IFsxXS4NCj4gDQo+IFRo
ZSBkcml2ZXIgc3VwcG9ydHMgUENNIHBsYXliYWNrIGFuZCBjYXB0dXJlIHN1YnN0cmVhbXMsIGph
Y2sgYW5kDQo+IGNoYW5uZWwgbWFwIGNvbnRyb2xzLiBBIG1lc3NhZ2UtYmFzZWQgdHJhbnNwb3J0
IGlzIHVzZWQgdG8gd3JpdGUvcmVhZA0KPiBQQ00gZnJhbWVzIHRvL2Zyb20gYSBkZXZpY2UuDQo+
IA0KPiBUaGUgc2VyaWVzIGlzIGJhc2VkIChhbmQgd2FzIGFjdHVhbGx5IHRlc3RlZCkgb24gTGlu
dXMncyBtYXN0ZXINCj4gYnJhbmNoIFsyXSwgb24gdG9wIG9mDQo+IA0KPiBjb21taXQgMWUyYTE5
OWY2Y2NkICgiTWVyZ2UgdGFnICdzcGktZml4LXY1LjExLXJjNCcgb2YgLi4uIikNCj4gDQo+IEFz
IGEgZGV2aWNlIHBhcnQgd2FzIHVzZWQgT3BlblN5bmVyZ3kgcHJvcHJpZXRhcnkgaW1wbGVtZW50
YXRpb24uDQo+IA0KPiBBbnkgY29tbWVudHMgYXJlIHZlcnkgd2VsY29tZS4NCj4gDQoNClRoaXMg
anVzdCBsb29rcyBsaWtlIHRoZSBndWVzdCBmcm9udCBlbmQgaGVyZSwgZG8geW91IGhhdmUgYSBm
b2xsb3cgdXANCnNlcmllcyBmb3IgdGhlIGhvc3QgYmFja2VuZCA/DQoNClRoYW5rcw0KDQpMaWFt
ICANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBDb3Jwb3JhdGlvbiAoVUspIExpbWl0ZWQKUmVnaXN0ZXJl
ZCBOby4gMTEzNDk0NSAoRW5nbGFuZCkKUmVnaXN0ZXJlZCBPZmZpY2U6IFBpcGVycyBXYXksIFN3
aW5kb24gU04zIDFSSgpWQVQgTm86IDg2MCAyMTczIDQ3CgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUg
dXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0
aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUg
YWxsIGNvcGllcy4K

