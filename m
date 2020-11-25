Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331492C3640
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKYBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:31:55 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2443 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgKYBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:31:55 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cgjz6372yz4yHg;
        Wed, 25 Nov 2020 09:31:30 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 25 Nov 2020 09:31:50 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 25 Nov 2020 09:31:50 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.1913.007;
 Wed, 25 Nov 2020 09:31:50 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Quentin Perret <qperret@google.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBzY2hlZC90b3BvbG9neTogTWFyayBzb21l?=
 =?gb2312?Q?_symbols_with_static_keyword?=
Thread-Topic: [PATCH -next] sched/topology: Mark some symbols with static
 keyword
Thread-Index: AQHWwlafLk185zewZ0qM6qsjO6pYHKnWv3sAgAFRBLA=
Date:   Wed, 25 Nov 2020 01:31:50 +0000
Message-ID: <fb49182853774d13b5dadb3d8ac8cce7@huawei.com>
References: <1606218731-3999-1-git-send-email-zou_wei@huawei.com>
 <20201124132428.GA1067355@google.com>
In-Reply-To: <20201124132428.GA1067355@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.100]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UXVlbnRpbiwgDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgd2lsbCBzZW5kIHRoZSB2MiBzb29u
Lg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogUXVlbnRpbiBQZXJyZXQgW21haWx0bzpx
cGVycmV0QGdvb2dsZS5jb21dIA0Kt6LLzcqxvOQ6IDIwMjDE6jEx1MIyNMjVIDIxOjI0DQrK1bz+
yMs6IFpvdXdlaSAoU2FtdWVsKSA8em91X3dlaUBodWF3ZWkuY29tPg0Ks63LzTogbWluZ29AcmVk
aGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGp1cmkubGVsbGlAcmVkaGF0LmNvbTsgdmlu
Y2VudC5ndWl0dG90QGxpbmFyby5vcmc7IGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbTsgcm9zdGVk
dEBnb29kbWlzLm9yZzsgYnNlZ2FsbEBnb29nbGUuY29tOyBtZ29ybWFuQHN1c2UuZGU7IGJyaXN0
b3RAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQ
QVRDSCAtbmV4dF0gc2NoZWQvdG9wb2xvZ3k6IE1hcmsgc29tZSBzeW1ib2xzIHdpdGggc3RhdGlj
IGtleXdvcmQNCg0KT24gVHVlc2RheSAyNCBOb3YgMjAyMCBhdCAxOTo1MjoxMSAoKzA4MDApLCBa
b3UgV2VpIHdyb3RlOg0KPiBGaXggdGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZ3M6DQo+IA0K
PiBrZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYzoyMTE6MTogd2FybmluZzogc3ltYm9sICdzY2hlZF9l
bmVyZ3lfbXV0ZXgnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IGtl
cm5lbC9zY2hlZC90b3BvbG9neS5jOjIxMjo2OiB3YXJuaW5nOiBzeW1ib2wgJ3NjaGVkX2VuZXJn
eV91cGRhdGUnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQoNCkkgdGhpbmsgdGhp
cyB3YW50czoNCg0KRml4ZXM6IDMxZjZhOGMwYTQ3MSAoInNjaGVkL3RvcG9sb2d5LHNjaGVkdXRp
bDogV3JhcCBzY2hlZCBkb21haW5zIHJlYnVpbGQiKQ0KDQpCdXQsIHdpdGggdGhhdDoNCg0KUmV2
aWV3ZWQtYnk6IFF1ZW50aW4gUGVycmV0IDxxcGVycmV0QGdvb2dsZS5jb20+DQoNClRoYW5rcywN
ClF1ZW50aW4NCg==
