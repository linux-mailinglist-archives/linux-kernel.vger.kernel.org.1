Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACE2C382B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKYEk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 23:40:27 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58340 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgKYEk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 23:40:26 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC4ACC00AF;
        Wed, 25 Nov 2020 04:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1606279225; bh=R/q6NwsNF21KOIgAEjdMfQsnTxKZKuDJxC5Rv2H8MYU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jAQW4PTYUb/breStGULS89zPR8JZpwzSOSBH8tKhyzMgz/xcoyraXG9lRTRmXWJ3d
         mHBNb5af0XvzBl04nIlTAzdgvnkduiSc0044n4oVUXwh+O1eO3uqnHAaUrdoaHxGUo
         6XmIir06rN4Lx8Fm1/uls3vNkgt1cOfYNAozquk6yruZ3Piz/5Yk4p79f5AIrj7Mrj
         hKHd9e+gJY56+Ydbl9Fdnx2MLC6FMDXxpUANJpVAB+IKxgXzk0y/hkTdA9OZlCgpjw
         WlnQy0pkZ0Cu7jrJfpBHo6IbB5lSkxwBlDUMbhLuVdaoggYJdNZnwhtzTz0rVksZJC
         BjyQK4x3u6/WA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 16321A0067;
        Wed, 25 Nov 2020 04:40:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B673A400BA;
        Wed, 25 Nov 2020 04:40:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="DiTvku4f";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFbLwfGPs6TQ9ZQvbcXyL9tGDq4vyEWu3fhPR0nFUZqlY0TbP4InGYzETB8GAQ8vXJV7p4mfefBADH7BIrQdfFi8Wv9BkcyoJr8WkbZA6VGjYdbKrs7u30uYDzYO+6c46o36Rqh6oT++dqBxRLh9o4OdV3mI1+OtUgt6s695qIbuiOauO6f7sPA9j9cGxeDkRKOySztLLaSQFL60C11S4W5cs3c3KdymgwFCdqVCavqmJ6qRpRtwrrkQATo2SdDkbAFrH6uj7OcZ+eGpCymq+KDBnMTJnCdJQOjnd62cyETsHQTNhHnGux54oz/rzjz67GkNQZq1EHnoPsKwMwDdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/q6NwsNF21KOIgAEjdMfQsnTxKZKuDJxC5Rv2H8MYU=;
 b=PjtD49LMM6vBdXLKAYG6ij6iYPYIar6R9CWZ/dLrl6AEWUyYEl+UnUOwNe6Evarpgf4h2C4C3XXgtngG/DgVLb1qP36YntalheMB/ggk/R6Z+8cdmaC3bs0fZrO+/fjnpedf2uLJu+TggEJmIc2llcSKvd9IceJBAGkj2UkkouIJic6HpncJfmXV4MvTnpauBPxNcLgjCTUw/xUV8tHKZqs/C4VyeQbK04Z7Fba8XbEzwW2dBR1Rtjk2sHNTI1a5CYwYBCotdpnaCZeRqITa5d5/q5no9sQO9PzY274YiOVCq/KXBK+GeQsqWfR1CpJnZq0S4lzb8AHHjH7q3lqEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/q6NwsNF21KOIgAEjdMfQsnTxKZKuDJxC5Rv2H8MYU=;
 b=DiTvku4fWANEvhZbjdZJVj6QjKhfx+aree8bX0AmAJTvg1ah5upVQmW1f7dlaDwUvsRUvZAPHUun+YjH1vGkdTo7Pmo5OUODl2wW65zpZ+81OubuYj5/WMeWIDiqJgt+8VG4YR1Vq6G06fot8D9DQFhe0SzZFyZ/NJn47qfw8Hc=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 25 Nov
 2020 04:40:17 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 04:40:17 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] ARC: build: fix various issues in arc boot Makefile
Thread-Topic: [PATCH 0/6] ARC: build: fix various issues in arc boot Makefile
Thread-Index: AQHWwD3VoBtjEs2mMEGciuOe7EANTqnYSagA
Date:   Wed, 25 Nov 2020 04:40:17 +0000
Message-ID: <01998029-6222-a2d1-9147-1a0dbc7b7e4b@synopsys.com>
References: <20201121193657.51441-1-masahiroy@kernel.org>
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f104c9-8792-4eb0-4948-08d890fc3576
x-ms-traffictypediagnostic: BYAPR12MB2806:
x-microsoft-antispam-prvs: <BYAPR12MB2806C14AB6FF71A8193B0D16B6FA0@BYAPR12MB2806.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Fw3vV0DCiCD8CDlCHsGPYyz9tLyEco0XZN3nIRKu2kwVoS9vJRz30IGU1d1lLegjYct22TmD6BGzIOhb0mJjtnpirdQ0CHFu4Jc7nVV6pZxJixWnnnSg3+jg7SjqCLxzwM9kbuTqKsP0Sduiff+TZ+VgGUgcxzJpVWG3peVSTRY7xqRrtBdd9znlJDxRvafgD4BnhSqsIEWo53B+rY1UBIirQfVrrpjhvo+IZojaW5uky9gyPEXuXryIA3Y3VQcXD1SJblDmrzXxko707Gv+9A3vHia+Kg7m/eIxcmC1yUhlb5Rboa+gdzzpb05aQf7GCuZXBWxOAubF7kVnkaIJSLuDkOoyG10c6lgWZo0tAgXcyqBeq5Lpu4ckZBMbSew
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39850400004)(376002)(366004)(4744005)(186003)(36756003)(8676002)(110136005)(4326008)(6512007)(6506007)(478600001)(83380400001)(31696002)(5660300002)(53546011)(26005)(2616005)(66476007)(8936002)(71200400001)(2906002)(86362001)(316002)(66556008)(6486002)(64756008)(31686004)(76116006)(66946007)(66446008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0Q/hFN3JbMfQK//8zPvgNMeAWt8+jWatokQIKQ16O8EVRykxVP2/UEX1R5oMGm+bf8BSrcEYWJztPVnu4gojF71izl2pklsCL7c5cS9gHheVSZQO5jKDnYjphT50Chzix7bmkND2IFINJnDAVVOetqvjaNN/aIuWjS5npMA/Z29EIycdz0VN2SbUJag5FdLYH5viQehg32toL79LSXYTwNAJ00pyZQn7VUJxowkgE/OfOXunqCl/F2S3Lyvo0wjpSOG/V5h4A7/vJj6UX7WAbrHjszzZKlyqulhoePkMZO1Hh6ZljBrqzQYUuNh94M50wdw5jhQPranQ+HeFZNYQX1qtxFCFeQOQN32i0Xmvat0CtTzf8cJT2jVPEPEodwJIjardXGxC5gkMezlWDQSRIBsnpGqTPU42HN/RCwp2WR95be0oy3AUiGpKgfdfQ4v914QccgPEnB5dIrXWhxSky9quTyhSTjjsfTxF+hVbr7g/ZbDYFUzz1r+CIUMC2njWRE3As3jE60+SMElmh7UENC536btDKoKzi3aSrbBZFOh/XT8mAS4FTguCLGbEmJQY/yygambqjbCzZrYfqmbXBZQ52zbr/Yp3b7GPochv5UK8PFy73maLnFbxd4PcyVmjbVN1/LNmaR/gf1Go94FTyJ0x9vBxqH39Bj3FZPldTztg1sEoRKuDHOlrugjmYfpoS0EpGbePYacpN/jdbH2qHDOU7JWZKH1wfjI01LjHRbnKac7y60FuiHpHdXzuLgr6Zh4a0TJAqjJqsaRM0Oqk10vFvbGynFc8JE8MI1lLle4fgTyxKLElDhEEA8V/Q7XD98FTeMsm+V9UqEinrcwATUTwHmYAA/tXXiRKb7CDxuXmwmZPiO+dsZ4RI9oUbhaXcP9VG+T0KdF8QgozLOW0CQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA0A3BACB6DC4D4C87D706C6E7C57A6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f104c9-8792-4eb0-4948-08d890fc3576
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 04:40:17.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3sd6lqPCJ4Lw5eWPGHER/xEqoecQHuOzSncMOaKsI2y2YnJvr+9fYoidD9FRpl6xWJV+F6uHQ98jxVYQwzqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFzYWhpcm8gU2FuLA0KDQpPbiAxMS8yMS8yMCAxMTozNiBBTSwgTWFzYWhpcm8gWWFtYWRh
IHdyb3RlOg0KPg0KPg0KPiBNYXNhaGlybyBZYW1hZGEgKDYpOg0KPiAgICBBUkM6IGJ1aWxkOiBy
ZW1vdmUgbm9uLWV4aXN0aW5nIGJvb3RwSW1hZ2UgZnJvbSBLQlVJTERfSU1BR0UNCj4gICAgQVJD
OiBidWlsZDogYWRkIHVJbWFnZS5sem1hIHRvIHRoZSB0b3AtbGV2ZWwgdGFyZ2V0DQo+ICAgIEFS
QzogYnVpbGQ6IGFkZCBib290X3RhcmdldHMgdG8gUEhPTlkNCj4gICAgQVJDOiBidWlsZDogbW92
ZSBzeW1saW5rIGNyZWF0aW9uIHRvIGFyY2gvYXJjL01ha2VmaWxlIHRvIGF2b2lkIHJhY2UNCj4g
ICAgQVJDOiBidWlsZDogcmVtb3ZlIHVubmVlZGVkIGV4dHJhLXkNCj4gICAgQVJDOiBidWlsZDog
dXNlICQoUkVBREVMRikgaW5zdGVhZCBvZiBoYXJkLWNvZGVkIHJlYWRlbGYNCj4NCj4gICBhcmNo
L2FyYy9NYWtlZmlsZSAgICAgIHwgMjAgKysrKysrKysrKysrKy0tLS0tLS0NCj4gICBhcmNoL2Fy
Yy9ib290L01ha2VmaWxlIHwgMTggKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCg0KVGhpcyBMR1RNLiBEbyB5
b3Ugd2FudCBtZSB0byBwaWNrIHVwIHRoZXNlIHZpYSBBUkMgdHJlZSA/DQoNClRoeCwNCi1WaW5l
ZXQNCg==
