Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4661A1629
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDGToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 15:44:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:23170 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGToF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:44:05 -0400
IronPort-SDR: iO8uzdYAUeIOAB07BS6ADPMvwctWmKNHGAeljw4h6f6xw9MYsbA4CBOXBuItRLYDLF2PVFx64p
 P8qq212JQmGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 12:44:04 -0700
IronPort-SDR: G1jYB9XG5rcs4hnoYx8o9EQsud8YsaiGa5M7NvXf9xoSoeUS1E50mNWWxtkAgyxd234tSkRMli
 gS3ZGwz2gVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="451344143"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 12:44:04 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 12:44:04 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 12:44:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Thread-Topic: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Thread-Index: AQHV44XtZjQeEO5a+0S1UDXNX7ghZahuSK2A///nRZCAAKY3gP//jAlg
Date:   Tue, 7 Apr 2020 19:44:03 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5D494D@ORSMSX115.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
 <20200214222720.13168-6-tony.luck@intel.com> <20200407111047.GB9616@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F5D3DA2@ORSMSX115.amr.corp.intel.com>
 <20200407193710.GE9616@zn.tnic>
In-Reply-To: <20200407193710.GE9616@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gU3VyZS4gSXQgd2FzIHVzZWZ1bCB3aGlsZSBJIHdhcyBkZWJ1Z2dpbmcuIEJ1dCBJJ20gc3Vy
ZSBhbGwgdGhlIGJ1Z3MgYXJlDQo+PiBnb25lIG5vdyA6LSkNCj4NCj4gRG8geW91IG5lZWQgaXQg
Zm9yIGRlYnVnZ2luZz8NCg0KSSBkb3VidCBpdC4gSXQgd2FzIGhhbmR5IHRvIHNlZSB0aGF0IENF
Qy9FREFDL01DRUxPRyBoYWQgY29ycmVjdGx5DQpzZXQgdGhlaXIgb3duIGJpdHMgd2hpbGUgSSB3
YXMgdGVzdGluZy4NCg0KSWYgSSBldmVyIG5lZWQgdG8gc2VlIGl0IGFnYWluLCBJIGNhbiBwdXQg
YSBwcmludGsoKSBiYWNrIGluLg0KDQotVG9ueQ0K
