Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26E2BFEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgKWDph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:45:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4101 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgKWDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:45:36 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CfY2Q2zlLzXfKd;
        Mon, 23 Nov 2020 11:45:18 +0800 (CST)
Received: from dggemi710-chm.china.huawei.com (10.3.20.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 23 Nov 2020 11:45:34 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemi710-chm.china.huawei.com (10.3.20.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 23 Nov 2020 11:45:33 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Mon, 23 Nov 2020 11:45:33 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYyXSBhcm02NDogbW06IGZyZWUgdW51c2Vk?=
 =?gb2312?B?IG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSBW?=
 =?gb2312?Q?MEMMAP?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1h?=
 =?gb2312?Q?p_for_sparse_memory_model_that_define_VMEMMAP?=
Thread-Index: AQHWcETlDVvjE2IvJkCQH2P2F6bPZqk7c02AgBr7NwCAdBE4gIAAh5EA//+diYCACw+1sA==
Date:   Mon, 23 Nov 2020 03:45:33 +0000
Message-ID: <c9d7b2cb6bc74ee5be3635d91e8f8d7c@huawei.com>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com> <20200903120558.GB31409@gaia>
 <eacfa2bb19df4126a476566512d93dab@hisilicon.com>
 <f34d3387368a406582bce36627cdc29c@huawei.com> <X7JYhyr2a4H6D+cQ@trantor>
In-Reply-To: <X7JYhyr2a4H6D+cQ@trantor>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.182.180.136]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENhdGFsaW4NCg0KU29ycnkgbGF0ZSBmb3IgeW91LCBJIHdpbGwgc3VibWl0IHRoZSBwYXRj
aCBhcyBzb29uIGFzIHBvc3NpYmxlLg0KDQpUaGFua3MhDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0K
t6K8/sjLOiBDYXRhbGluIE1hcmluYXMgW21haWx0bzpjYXRhbGluLm1hcmluYXNAYXJtLmNvbV0g
DQq3osvNyrG85DogMjAyMMTqMTHUwjE2yNUgMTg6NDcNCsrVvP7IyzogbGl3ZWkgKENNKSA8bGl3
ZWkyMTNAaHVhd2VpLmNvbT4NCrOty806IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPjsgTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29t
Pjsgd2lsbEBrZXJuZWwub3JnOyBYaWFxaW5nIChBKSA8c2FiZXJsaWx5LnhpYUBoaXNpbGljb24u
Y29tPjsgQ2hlbmZlbmcgKHB1Y2spIDxwdWNrLmNoZW5AaGlzaWxpY29uLmNvbT47IGJ1dGFvIDxi
dXRhb0BoaXNpbGljb24uY29tPjsgZmVuZ2Jhb3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNpbGljb24u
Y29tPjsgbnNhZW56anVsaWVubmVAc3VzZS5kZTsgc3RldmUuY2FwcGVyQGFybS5jb207IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgc3VqdW5mZWkgPHN1anVuZmVpMkBoaXNpbGljb24uY29tPjsgTGludXhhcm0gPGxpbnV4
YXJtQGh1YXdlaS5jb20+DQrW98ziOiBSZTogtPC4tDogW1BBVENIIHYyXSBhcm02NDogbW06IGZy
ZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSBWTUVN
TUFQDQoNCk9uIE1vbiwgTm92IDE2LCAyMDIwIGF0IDA4OjQyOjE3QU0gKzAwMDAsIGxpd2VpIChD
TSkgd3JvdGU6DQo+IEkgaGF2ZSBjaGFuZ2VkIFNFQ1RJT05fU0laRV9CSVRTIHRvIDI3IGluIG91
ciBwcm9kdWN0cywgYnV0IEkgZG9uJ3QgDQo+IGhhdmUgdG8gc3VibWl0IGl0Lg0KDQpXZWxsLCBp
ZiB5b3Ugc2VuZCBhIHBhdGNoLCBJJ20gaGFwcHkgdG8gbWVyZ2UgaXQuDQoNCi0tDQpDYXRhbGlu
DQo=
