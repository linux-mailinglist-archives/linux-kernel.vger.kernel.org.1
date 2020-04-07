Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C321A11F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:43:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:7271 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgDGQnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:43:31 -0400
IronPort-SDR: kpfJNqJj8SJ/Thj/COWTajz+GksIZYviqdRtt+mF1eLTJc3DrPy7RcSL+rCYg+Nc+0VOn8LuW9
 BCuxJMx1HlKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 09:43:31 -0700
IronPort-SDR: Cc37kck4Z2H0OT+gU8UpL12ENKzQ6R4FvnLcfdJ6QxHyQmB52rBGk6WMzTJ13h6oveBbaEdAnq
 W8f8/9jlRv5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,355,1580803200"; 
   d="scan'208";a="286278294"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2020 09:43:31 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 09:43:30 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.107]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 09:43:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Thread-Topic: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Thread-Index: AQHV44XtZjQeEO5a+0S1UDXNX7ghZahuSK2A///nRZA=
Date:   Tue, 7 Apr 2020 16:43:29 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5D3DA2@ORSMSX115.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
 <20200214222720.13168-6-tony.luck@intel.com> <20200407111047.GB9616@zn.tnic>
In-Reply-To: <20200407111047.GB9616@zn.tnic>
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

Pj4gKwlpZiAobS0+a2ZsYWdzKQ0KPj4gKwkJcHJfZW1lcmcoSFdfRVJSICJrZmxhZ3MgPSAweCVs
bHhcbiIsIG0tPmtmbGFncyk7DQo+DQo+IEkndmUgemFwcGVkIHRoYXQgaHVuay4gSSdkIGxpa2Ug
dG8gYXZvaWQgZXhwb3NpbmcgdGhvc2Uga2ZsYWdzIHRvDQo+IGx1c2Vyc3BhY2UgaW4gYW55IHNo
YXBlIG9yIGZvcm0gZm9yIG5vdy4NCg0KU3VyZS4gSXQgd2FzIHVzZWZ1bCB3aGlsZSBJIHdhcyBk
ZWJ1Z2dpbmcuIEJ1dCBJJ20gc3VyZSBhbGwgdGhlIGJ1Z3MgYXJlDQpnb25lIG5vdyA6LSkNCg0K
LVRvbnkNCg==
