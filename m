Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5F2889A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbgJINPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:15:48 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:13281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730726AbgJINPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8B+5JOsdQQ+9U1fZ+dLu21qs6g8eyqOhcT2+xPWg40dH6OayeKOi3e27wx42WVfoAJva4m2tzsyECzpW0RGy8iGK0omi8yeBQhp+aPERg2FUdivTYp7P8SZYsq1RsGtVysXIPUgyXAFoxwC3HJdaA9jAi5Ma950LkTgemAQNhrSkT6YSLL1hLMmNDBBDevMO4weOinx1XIx12cbYD7T+rRrrA0kS5Gq3g/ahPWLPkX+kHPJjOouB1kGISiPsY3JAMRB7lD2M0rtndoj60Ijf2kX/TKzYollrmWB47LxqEEVcHfSe8kJMQ3OeAwA2smHSDkb5eXeKHMl+XevbFpCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Impx6rpK4bJ1x+iTFzrAFzAfltNXcNBfAKD0GDgQsGY=;
 b=XI0NAAjheuNYc+ZK+4XkmBYq/S6U25sJogJFhOrOwShRXYFNhYz8ltASkLX9lRVHL7bNtuzUwcwu55/heDpbm/PgJCc5P5lYgRink/krPl9a/OrFT1F9JbAaEI1D6YbgSjH+GxOYe+D4iRoW88ewTMHGje7JSDY6aPwOqXKCniy7RwhoGRE+kMxyDAiiuVajRHJcuDdakp9rPjYC5KetZe4N+0NeiEEXpYvwwVoQZvgFESlIcaorEj4+WbWsSFIcTu+TYdL8tA9kGel16sdCSvv2WQOeeoJLP5ucruB2PLIOZM329J/EYTIpkQC0f6XKIEx/2wHcNGzuAo4pVQ9o2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Impx6rpK4bJ1x+iTFzrAFzAfltNXcNBfAKD0GDgQsGY=;
 b=uG0L7vzDl3qvJzrGfZsem3EWuup6rVcCNk0xpGNgSmFm2hsD21YW+/qGrki1jeP5bWd5bQCEJzHccvSsflcHMB1KCDu2HPETEpG78AayrTZo0Ib2wKBB4d4xKOhTB0CIZe+MBEpP7OVGIvkS8wi6LSiaWUhunTalcS3e9FeuLZ0=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM6PR05MB6441.namprd05.prod.outlook.com (2603:10b6:5:130::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Fri, 9 Oct 2020 13:15:43 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3477.011; Fri, 9 Oct 2020
 13:15:43 +0000
From:   Rahul Gopakumar <gopakumarr@vmware.com>
To:     "bhe@redhat.com" <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Topic: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBzw==
Date:   Fri, 9 Oct 2020 13:15:42 +0000
Message-ID: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [43.225.165.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96a3a9e8-bebd-4920-b50b-08d86c556d0b
x-ms-traffictypediagnostic: DM6PR05MB6441:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB64416F39E10C2AD30A5474CDA4080@DM6PR05MB6441.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JYVEV8gvPpF576kjkw0eEzdrMAbwJCEi/nga5vmdXIjSoNuXb5NhBTdJZTuK0oTUoooGg8D0CJb+/oXKgeVZLfD3s23IojS1gI6psAvMsd/LVVHLiy07v//UfA/5v38wJpZ6r2CT04S+w9txtCbOCki0Gi5GjKcucOXnwtCMTY5xnMI4MnTooMJ4QWX6c5BU6kyPOBcuIyiGwDxj5T57GOg3aJZBmIS4MDSCtqaqPM53xFTFo7jcJQqBlLXE7Mq1GVZc08JjjQoe1+4RgYHsDbD6RW/G0FAmCwv6ZvdBerqh7tVL5+V2cId3VEEkRUryALJXBQm2PmfONDLIzkofQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(33656002)(9686003)(478600001)(2906002)(64756008)(76116006)(8936002)(66446008)(66556008)(91956017)(83380400001)(66946007)(55016002)(66476007)(26005)(316002)(110136005)(5660300002)(54906003)(4326008)(86362001)(6506007)(107886003)(8676002)(186003)(71200400001)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4EPfNVK2JOoDygrL+qU1n+96qQfNteVp4yI+7J0BIuY0KePClTDxV/WuyoN4nTdRDIIxPmqHZopMyfdw5YQ3VrmGszXObqXiutnKF1FghFB5QCwWDIX31yK9UHO8sT5E6/oBulyax4pWb3Ke3z9VI4o8ascTluqXez5XSgslA3yJ9w7BWteYqbOqR7QQj5PNnHkuWoh8TfYtaPTDxagNPjOu8TmmIKe185XD26SDjRSrLxqwDxIP8CGH976JyE2QRSUw6KnjopBxcIN/PYdPfWc6Crm3IpOOTdVhWS5HXLNZu4rH87GPqELym30xjogPPBPaUCf2sVnFELGX05koxlLK860FfOKM+EofNo+JI+fNhcdXQXSGpM080IAzKN76qY63L8wLXKT5+jiVV/r5KrGXo5dWR26sU1ehf1etFl7ch6hGarF+1aWRf+XNA7QpMYyrc1zvmoP1Z2GprIAloBMBJ7VuSXaPRYXKpzHyZ5dy0ajk3YO+91mX6ZzxGPPV9jMQ3SUYd7kdTlumFxY2nH5WICMElD1m+bOZ2JLcWLY29vpanCHlL/wshxiIRbp7fKzvc1pAog+fwDvAl2GcO0F8eyn6tolDZfxN6ouit1oZ+9J+qgR7oIFwKviHzR+T5m8gM7vLBoniMXoT+uBpxw==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3a9e8-bebd-4920-b50b-08d86c556d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 13:15:42.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnTnbvA9rAsXh01hKh6EnqW+eMOdkr0bTdDy4Ox+0qyJx9R3dCYqtvlpiYk86xSPgQUPKNJfLGveH4G4GkuGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6441
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of VMware's performance regression testing for Linux Kernel=0A=
upstream releases,=A0we identified boot time increase when comparing=0A=
Linux 5.8 kernel against Linux 5.7 kernel.=A0Increase in boot time is=0A=
noticeable on VM with a **large amount of memory**.=0A=
=A0=0A=
In our test cases, it's noticeable with memory 1TB and more, whereas=0A=
there was no major=A0difference noticed in testcases with <1TB.=0A=
=A0=0A=
On bisecting between 5.7 and 5.8, we found the following commit from=A0=0A=
=93Baoquan He=94 to be=A0the cause of boot time increase in big VM test cas=
es.=0A=
=A0=0A=
-------------------------------------=0A=
=A0=0A=
commit 73a6e474cb376921a311786652782155eac2fdf0=0A=
Author: Baoquan He <bhe@redhat.com>=0A=
Date: Wed Jun 3 15:57:55 2020 -0700=0A=
=A0=0A=
mm: memmap_init: iterate over memblock regions rather that check each PFN=
=0A=
=A0=0A=
When called during boot the memmap_init_zone() function checks if each PFN=
=0A=
is valid and actually belongs to the node being initialized using=0A=
early_pfn_valid() and early_pfn_in_nid().=0A=
=A0=0A=
Each such check may cost up to O(log(n)) where n is the number of memory=0A=
banks, so for large amount of memory overall time spent in early_pfn*()=0A=
becomes substantial.=0A=
=A0=0A=
-------------------------------------=0A=
=A0=0A=
For boot time test, we used RHEL 8.1 as the guest OS.=0A=
VM config is 84 vcpu and 1TB vRAM.=0A=
=A0=0A=
Here are the actual performance numbers.=0A=
=A0=0A=
5.7 GA - 18.17 secs=0A=
Baoquan's commit - 21.6 secs (-16% increase in time)=0A=
=A0=0A=
From dmesg logs, we can see significant time delay around memmap.=0A=
=A0=0A=
Refer below logs.=0A=
=A0=0A=
Good commit=0A=
=A0=0A=
[0.033176] Normal zone: 1445888 pages used for memmap=0A=
[0.033176] Normal zone: 89391104 pages, LIFO batch:63=0A=
[0.035851] ACPI: PM-Timer IO Port: 0x448=0A=
=A0=0A=
Problem commit=0A=
=A0=0A=
[0.026874] Normal zone: 1445888 pages used for memmap=0A=
[0.026875] Normal zone: 89391104 pages, LIFO batch:63=0A=
[2.028450] ACPI: PM-Timer IO Port: 0x448=0A=
=A0=0A=
We did some analysis, and it looks like with the problem commit it's=0A=
not deferring the memory initialization to a later stage and it's =0A=
initializing the huge chunk of memory in serial - during the boot-up=0A=
time. =A0Whereas with the good commit, it was able to defer the=0A=
initialization of the memory when it could be done in parallel.=0A=
=0A=
=0A=
Rahul Gopakumar=0A=
Performance=A0Engineering=0A=
VMware, Inc.=
