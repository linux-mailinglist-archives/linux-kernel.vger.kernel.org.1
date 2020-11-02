Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495AF2A2C62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKBOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:15:47 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:6497
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbgKBOPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:15:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caCWii0s4uTiOCpNn80oaaHkDfRvEdXF2GwX0+IhWnDO7qfylgkn4UffyiKNj7SNm+OJn+pAcY3K7Mwg80ooJznW7u/BXWNlqT4AX3tZiwIkI2G2Zc7+lT9VAkzCyJyQ7PKNDUoeDU1e36Ea1Spu2yonx8fRw7Kg27I3xEXIuk6RvduigQe585UibNTlUDGaOAnH/ixpi1ffws2vy7Wobx6Srvh563r+0mmSDRAoHkVrJR3KZ1OgdhKqSZUV7FeDnE5AiUS1gIXk64H28Vnkh1d7/eWo7KpYckuIdqNfsscHZpCdhV4hluy4IuOV34cusrdSUMBwgdt01b21UqKgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nTE+rUHVgj2jf3pH0KS0bvRRau+/3rw4cgO+tAy9EY=;
 b=Y/M15tWl3MrEbmuYJBQUGevMq0pn7Owzq3ymy0smdMLeupUlXBYO2kbQIokigyjad1xq90dlB/iMxoRBORhYqc0iHJdfH6Upzzx2NBlJym7lllEwLxFPaDRbC9UbkIcvkSxQ025aocnWW+k8MXgcTIXOqWOuNbsweUJe0EkCl1Xp+M/DAWAP29RPXiuChrfclfiX2Jr5+ov5smCdpYn+IIfM+y9TJ7i7iR2qPa3ZqRqgmoaeRuxdj43+EPLvnyNWRLHd1P1PSw/iomaCNq+NhAVP0wjqo6mVb4p/O6i9qQoTn04HVHKGcy1WXEzCJ0TKuUaPXoRAXBhYVnT6DSEPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nTE+rUHVgj2jf3pH0KS0bvRRau+/3rw4cgO+tAy9EY=;
 b=HwaknSRY8elr0IP5XKsWmZHO1yeXgSjQnpAMnIfcKYP+mhNu4QLcwEgjQkLuvGeR2hEl3s6T4ZCCmvjJRYpiYUz7zN87d/iIF47uNskUtcktVxl8/ML32yFIcNWKhihgc6y0qBCE5knQ3xeKUaEHhdemcltLkXz/865Plbfhwwc=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM5PR05MB3321.namprd05.prod.outlook.com (2603:10b6:4:45::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10; Mon, 2 Nov 2020 14:15:32 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3541.010; Mon, 2 Nov 2020
 14:15:32 +0000
From:   Rahul Gopakumar <gopakumarr@vmware.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Topic: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBz6mQW+kAgAPEkzyAAWl/gIALAETTgAAhwwCAAAD7T4ACZ34AgADZzMiAEREnqA==
Date:   Mon, 2 Nov 2020 14:15:32 +0000
Message-ID: <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>,<20201022040440.GX25604@MiWiFi-R3L-srv>,<DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [103.224.33.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1235515-e134-4ca5-88ef-08d87f39c292
x-ms-traffictypediagnostic: DM5PR05MB3321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR05MB33214E77903D8E7A9D14B070A4100@DM5PR05MB3321.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Up9I7Q+1RDL+qjj98IXKG++ZvMgTAimzLZtwwf08fPdlcX7YhvmylUrYc91wn7bama7RylFPKsu+gBiQl4iBlgOhcLpMdYBgc8Q1J6U70cNIVMsoIIW3QEivUWNHIlW1EDlb3qGtagYH1KTiVZr5sdWOjWjzeknksOmDRm2Df1ktqHPqdEhg+Cm9FHj6ah/rTTLrlO7/Ybv//HhZFAYnFGGCmz8NfILK6Ojq5VsGkxQnHnvWtmXVQkBJR7WKG57xwfgHZQyI1grcWOR6LdJ4NYqL5IBQ9RdrHTDo5NthHtWoStmXnxyq7rbH94cQVaLEpZ971//aGXT9PxkmhagFkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(71200400001)(4326008)(7696005)(107886003)(8936002)(83380400001)(6506007)(53546011)(186003)(26005)(8676002)(33656002)(86362001)(52536014)(6916009)(316002)(66446008)(55016002)(66946007)(66556008)(66476007)(54906003)(5660300002)(76116006)(9686003)(2906002)(91956017)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 98C5mP83CvdOkrDDtqAXTJUH4Fo8lJ/sS1r4vqBKv+obpYaTlXrPsa1y+HHDIknl3x4IAjJzld3BLK4YchxyZK4GSFz28DLTultUacAIDY1lJ7ynL1n+XrmlYmcHNfHdeo6J0s6hrlMN7H7aAya4nKzlPZXektEeQNZY5s09EOT0t1E9TDSQq0BDAxXriZY1ip5BnUju4/ZM1M11qc5M6dH7OgkQq0PTPiiwaBquxEKBfNvbMGJs7tc8t+GbAAz5eX1ci6WvFD7A+ynbA1FcELgFi0nYEBvkeTQ4d3QzqbXCISaD+ZbtNnllh4rGpq4nVXADSP6F5YjU0llnRZQjdg/aoUpMp0gwqSVzb6YBU7OlbnAFkPDljxKmifWIS7NlapKs+OdU8CDNIhyn4yOIo42xDeWmCbalDLmFlC0ZlsHGWThO+15wIzgboHPWQ9liIYO4wrGeZIRrmF60i127DSOfDT4Q4xpTiGedEnctNZTiser1sBc1pygcOPhrrfkU7Ad91Q4QstnfSIMrH9jFBTalhjbeVNY+AeYPtAZHG6ISGwqVkaGQnpnrnJzarIWRSlLV2ZK+QfLjtxUbhRyuxjSnsYvhOrOhwxNtdMq75lJW5buvGwILbRSebJlYOqkRaZeEeIo+Ht9JOlwjx3BJIw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1235515-e134-4ca5-88ef-08d87f39c292
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 14:15:32.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HS9ekwF3jxuT0mExPUAekIIsk2s4DzVg/1gtglcBD7GvyvjWU/rwyLh6iwv2sq7fLKKADc2uKVt1frDkfiv40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3321
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

There could still be some memory initialization problem with
the draft patch. I see a lot of page corruption errors.

BUG: Bad page state in process swapper  pfn:ab0803c

Here is the call trace

[    0.262826]  dump_stack+0x57/0x6a
[    0.262827]  bad_page.cold.119+0x63/0x93
[    0.262828]  __free_pages_ok+0x31f/0x330
[    0.262829]  memblock_free_all+0x153/0x1bf
[    0.262830]  mem_init+0x23/0x1f2
[    0.262831]  start_kernel+0x299/0x57a
[    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb

I don't see this in dmesg log with vanilla kernel.

It looks like the overhead due to this initialization problem
is around 3 secs.

[    0.262831]  start_kernel+0x299/0x57a
[    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb
[    3.758185] Memory: 3374072K/1073740756K available (12297K kernel code, =
5778Krwdata, 4376K rodata, 2352K init, 6480K bss, 16999716K reserved, 0K cm=
a-reserved)

But the draft patch is fixing the initial problem
reported around 2 secs (log snippet below) hence the total
delay of 1 sec.

[    0.024752]   Normal zone: 1445888 pages used for memmap
[    0.024753]   Normal zone: 89391104 pages, LIFO batch:63
[    0.027379] ACPI: PM-Timer IO Port: 0x448


________________________________________
From: Rahul Gopakumar <gopakumarr@vmware.com>
Sent: 22 October 2020 10:51 PM
To: bhe@redhat.com
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation=
.org; natechancellor@gmail.com; ndesaulniers@google.com; clang-built-linux@=
googlegroups.com; rostedt@goodmis.org; Rajender M; Yiu Cho Lau; Peter Jonas=
son; Venkatesh Rajaram
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kern=
el

Hi Baoquan,

>>=A0Can you tell how you measure the boot time?

Our test is actually boothalt, time reported by this test
includes both boot-up and shutdown time.

>> At above, you said "Patch on latest commit - 20.161 secs",
>> could you tell where this 20.161 secs comes from,

So this time is boot-up time + shutdown time.

From the dmesg.log it looks like during the memmap_init
it's taking less time in the patch. Let me take a closer look to
confirm this and also to find where the 1-sec delay in the patch
run is coming from.


From: bhe@redhat.com <bhe@redhat.com>
Sent: 22 October 2020 9:34 AM
To: Rahul Gopakumar <gopakumarr@vmware.com>
Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-founda=
tion.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulnier=
s@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com =
<clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.=
org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Pet=
er Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kern=
el

Hi Rahul,

On 10/20/20 at 03:26pm, Rahul Gopakumar wrote:
> >> Here, do you mean it even cost more time with the patch applied?
>
> Yes, we ran it multiple times and it looks like there is a
> very minor increase with the patch.
>
......
> On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:
> > Hi Baoquan,
> >
> > We had some trouble applying the patch to problem commit and the latest=
 upstream commit. Steven (CC'ed) helped us by providing the updated draft p=
atch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb=
0fd24a3), and it doesn't look like improving the performance numbers.
>
> Thanks for your feedback. From the code, I am sure what the problem is,
> but I didn't test it on system with huge memory. Forget mentioning my
> draft patch is based on akpm/master branch since it's a mm issue, it
> might be a little different with linus's mainline kernel, sorry for the
> inconvenience.
>
> I will test and debug this on a server with 4T memory in our lab, and
> update if any progress.
>
> >
> > Patch on latest commit - 20.161 secs
> > Vanilla latest commit - 19.50 secs
>

Can you tell how you measure the boot time? I checked the boot logs you
attached, E.g in below two logs, I saw patch_dmesg.log even has less
time during memmap init. Now I have got a machine with 1T memory for
testing, but didn't see obvious time cost increase. At above, you said
"Patch on latest commit - 20.161 secs", could you tell where this 20.161
secs comes from, so that I can investigate and reproduce on my system?

patch_dmesg.log:
[=A0=A0=A0 0.023126] Initmem setup node 1 [mem 0x0000005600000000-0x000000a=
affffffff]
[=A0=A0=A0 0.023128] On node 1 totalpages: 89128960
[=A0=A0=A0 0.023129]=A0=A0 Normal zone: 1392640 pages used for memmap
[=A0=A0=A0 0.023130]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63
[=A0=A0=A0 0.023893] Initmem setup node 2 [mem 0x000000ab00000000-0x0000010=
33fffffff]
[=A0=A0=A0 0.023895] On node 2 totalpages: 89391104
[=A0=A0=A0 0.023896]=A0=A0 Normal zone: 1445888 pages used for memmap
[=A0=A0=A0 0.023897]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63
[=A0=A0=A0 0.026744] ACPI: PM-Timer IO Port: 0x448
[=A0=A0=A0 0.026747] ACPI: Local APIC address 0xfee00000

vanilla_dmesg.log:
[=A0=A0=A0 0.024295] Initmem setup node 1 [mem 0x0000005600000000-0x000000a=
affffffff]
[=A0=A0=A0 0.024298] On node 1 totalpages: 89128960
[=A0=A0=A0 0.024299]=A0=A0 Normal zone: 1392640 pages used for memmap
[=A0=A0=A0 0.024299]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63
[=A0=A0=A0 0.025289] Initmem setup node 2 [mem 0x000000ab00000000-0x0000010=
33fffffff]
[=A0=A0=A0 0.025291] On node 2 totalpages: 89391104
[=A0=A0=A0 0.025292]=A0=A0 Normal zone: 1445888 pages used for memmap
[=A0=A0=A0 0.025293]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63
[=A0=A0=A0 2.096982] ACPI: PM-Timer IO Port: 0x448
[=A0=A0=A0 2.096987] ACPI: Local APIC address 0xfee00000
