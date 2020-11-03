Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F172A4548
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgKCMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:34:22 -0500
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:33763
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbgKCMeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLeZfzWD7Zzn3EnTigvoUGWEOWZe4h4kWlwYveS5XhQcGvBdoQkAdJOWLif+oPGikatvSXoAfZkDstiQ9NVmPB9fcEpQqSMDAp4zKN9/ZblGHFsMmRRPj+lHor1C3mBmygr2+Y9iKbUckCXWHVyS23OzrXHLQJCv2zRdc0ZIMTlHZa/hqrJ9o3bPBnWi2HDHuYsNMoFTiijlwr0lRy3UMazXaYlLgwMYg5Xs19LF0tZd4z9B18Q6a697ZkV3yw4Rgpeg/+2xKQMR0h/lWbAsLHcyUH3eW96p5nw0culubFdT83Eg9TBUqLJvrJMHEHJswwceM/UIaFr0NWhbJjYdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6IkiTBhOnFECJnIyOJISJG/UWD7BMed6y9MEOWkVAU=;
 b=a91gGccUKGzwlseZ5MO+GdGUHu+wbJsO9R1fk87vnQiHSSU1auHenGhGvvU3OVw85Qu1kDJIP7hdOb1N1gNyWySupSS6oAeIREz7zIx2wTyGB/nmsE57aqpb51GTU5/7eAQSiUy2hyuws5zoq/6PtF0NwYDws5d3Fb1PqAe7203JMqdhQuiWt5WjGTQ+LUiNNMJHfGEfjXg8JEdwNOt6/6YgtvBLD7HGiujuZ0pokc0g7eaplxqFjRaxscWhXWzCrT9NgTFh/ELQ9y+0LCK+QITQ9YNyUHQ3XJsJ4pUrRkhWm5qwqQigZMbLcNdWUzLsGWlegntsfXxRyu4Rs1JX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6IkiTBhOnFECJnIyOJISJG/UWD7BMed6y9MEOWkVAU=;
 b=gJULn07dYB/JYUHqbMBh8AGUeXtWblbZPkfx9rGvwx/kA3kGIXl10qv4ODeCdw9KsvgW2wf1o4BxpUH3q5vvpFB3cINr4Nroa5iZgWdl4lF74/3kLc8FhW4obyBInqJz3KmHBAcLNKj6ZsiMz7IE6izAhO+Bsjb9Wx45+azKsjk=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM6PR05MB4636.namprd05.prod.outlook.com (2603:10b6:5:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.13; Tue, 3 Nov 2020 12:34:17 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3541.016; Tue, 3 Nov 2020
 12:34:17 +0000
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
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBz6mQW+kAgAPEkzyAAWl/gIALAETTgAAhwwCAAAD7T4ACZ34AgADZzMiAEREnqIAADZOAgAFrvxs=
Date:   Tue, 3 Nov 2020 12:34:17 +0000
Message-ID: <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>,<20201102143035.GA3177@MiWiFi-R3L-srv>
In-Reply-To: <20201102143035.GA3177@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [103.224.33.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee166c2d-711b-42dc-4483-08d87ff4c7ef
x-ms-traffictypediagnostic: DM6PR05MB4636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB46362CCC0F77DA94942004ABA4110@DM6PR05MB4636.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: talEpydvkVdxawGpKhskZ5jow2FUkLARcjLtc1JAMvX55la/IVGcCaAs/Vb5uGxfP6JqlJfkrThYshpKNOjq7x6YY3kws++0EwVaR4ThGJLUJNz3ZDw7PLIuZdE+4VDBAqIhV65+aWLA2BH0vywpvGgOrA4FZJcdmsj4EjCCcU1+G95PwbMzjLLAHMIV+DcGJGsyxyOKQ6WbAVnuoz3nii795LoVxUKWE/3chxtgkK3Lv5uMMEe2lht6zN5+ngPCtw8VcH4ls2VZhD0m514pOCtxGgv3pvTH+3O3JX0367Vn/9Z/SUzBS+QdKU5fYoFAQePgEsgH1/c9Fz94tpbfug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66476007)(66446008)(107886003)(6916009)(76116006)(66556008)(64756008)(91956017)(66946007)(52536014)(5660300002)(9686003)(498600001)(83380400001)(55016002)(86362001)(53546011)(8936002)(54906003)(2906002)(33656002)(71200400001)(8676002)(7696005)(26005)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xJfmuwQ6eEITWple7YKHOkeMbbvwmyOGEThb58Lm3OA6Xd8RcZsj+e/5ZQNj61JPyWALzD+v0uqSSKGjWkFGcuTAZ46QxNorUEF8XA8x5pEQmvHK2gUNeSnvUOSX+QPtH0vrw+88pNuswwffFMOeGl8jctzZeFy4HW2OqwtOEG6zX7fNnnsrpwXg3zTAz+wWSANq8D4vldIFnAXl3EHcPzwfFTbKdEi9P+yKbI+AnYAxU3S+y1H1HdmEAGHjAYrSVjgpz2wwPw03q9Yka6G8qzyrOFRTWcg64e1Na9DmFAcD9egGlgw1fuTlfdr5q/PkTqpPHDNq4KZVsfyH0f+5aMV4ssKaIybFgZ8bioSdO19yPdUwiRKRwGW05xNNVOPVq7ZALgjGdnYMzeoQgh88xEjPw2pkp0Ya9GxaWHgyto2Hk2qOMpz3KNQTNXXmL8Q7/ZCgQOsL+fmohf7JjLM/yuNG18VyrgbZQt5q1QMnc7xkLdBe8aDbFBk5LRwXLr2WM2UyFPh9pwLER/Y/3mEPNODSCIALZSuWjFE7gdsmoCSCg9dfexwI8GTBdEhZjMo1fVGPCNWYgt3aJwjKAjbmvs1d9TSeAgxNgpqF/wxyOfe0XQ83E7M93LvrF6CymhD5c5xWgvraHt5OLX+glHlumg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee166c2d-711b-42dc-4483-08d87ff4c7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 12:34:17.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1+Hj5zgQEUsNdyBUVbzbCGAVFfAmEe/kF+phdXpEAfYSKfYTNjmvzHc9sdT9Ij4Su9ZfVXcZjQlMUHhbynqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4636
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> So, you mean with the draft patch applied, the initial performance
regression goes away, just many page corruption errors with call trace
are seen, right?

Yes, that's right.

>> And the performance regression is about 2sec delay in
your system?

The delay due to this new page corruption issue is about
3 secs.

Here is the summary

* Initial problem - 2 secs
* Draft patch - Fixes initial problem (recovers 2 secs) but
brings in new page corruption issue (3 secs)

>> Could you tell how you setup vmware VM so that I can ask our QA for
help to create a vmware VM for me to test?

* Use vSphere ESXi 6.7 or 7.0 GA.
* Create VM using vSphere Web Client and specify 1TB VM Memory.
* Install RHEL 8.1, that's the guest used in this test.

With draft patch, you should be able to reproduce the issue.
Let me know if you need more details.

________________________________________
From: bhe@redhat.com <bhe@redhat.com>
Sent: 02 November 2020 8:00 PM
To: Rahul Gopakumar
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation=
.org; natechancellor@gmail.com; ndesaulniers@google.com; clang-built-linux@=
googlegroups.com; rostedt@goodmis.org; Rajender M; Yiu Cho Lau; Peter Jonas=
son; Venkatesh Rajaram
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kern=
el

On 11/02/20 at 02:15pm, Rahul Gopakumar wrote:
> Hi Baoquan,
>
> There could still be some memory initialization problem with
> the draft patch. I see a lot of page corruption errors.
>
> BUG: Bad page state in process swapper  pfn:ab0803c
>
> Here is the call trace
>
> [    0.262826]  dump_stack+0x57/0x6a
> [    0.262827]  bad_page.cold.119+0x63/0x93
> [    0.262828]  __free_pages_ok+0x31f/0x330
> [    0.262829]  memblock_free_all+0x153/0x1bf
> [    0.262830]  mem_init+0x23/0x1f2
> [    0.262831]  start_kernel+0x299/0x57a
> [    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb
>
> I don't see this in dmesg log with vanilla kernel.
>
> It looks like the overhead due to this initialization problem
> is around 3 secs.
>
> [    0.262831]  start_kernel+0x299/0x57a
> [    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb
> [    3.758185] Memory: 3374072K/1073740756K available (12297K kernel code=
, 5778Krwdata, 4376K rodata, 2352K init, 6480K bss, 16999716K reserved, 0K =
cma-reserved)
>
> But the draft patch is fixing the initial problem
> reported around 2 secs (log snippet below) hence the total
> delay of 1 sec.
>
> [    0.024752]   Normal zone: 1445888 pages used for memmap
> [    0.024753]   Normal zone: 89391104 pages, LIFO batch:63
> [    0.027379] ACPI: PM-Timer IO Port: 0x448

So, you mean with the draft patch applied, the initial performance
regression goes away, just many page corruption errors with call trace
are seen, right? And the performance regression is about 2sec delay in
your system?

Could you tell how you setup vmware VM so that I can ask our QA for
help to create a vmware VM for me to test? I tested the draft patch on
bare metal system with more than 1T memory, didn't see the page
corruption call trace, need reproduce and have a look.

>
>
> ________________________________________
> From: Rahul Gopakumar <gopakumarr@vmware.com>
> Sent: 22 October 2020 10:51 PM
> To: bhe@redhat.com
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundati=
on.org; natechancellor@gmail.com; ndesaulniers@google.com; clang-built-linu=
x@googlegroups.com; rostedt@goodmis.org; Rajender M; Yiu Cho Lau; Peter Jon=
asson; Venkatesh Rajaram
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Ke=
rnel
>
> Hi Baoquan,
>
> >>=A0Can you tell how you measure the boot time?
>
> Our test is actually boothalt, time reported by this test
> includes both boot-up and shutdown time.
>
> >> At above, you said "Patch on latest commit - 20.161 secs",
> >> could you tell where this 20.161 secs comes from,
>
> So this time is boot-up time + shutdown time.
>
> From the dmesg.log it looks like during the memmap_init
> it's taking less time in the patch. Let me take a closer look to
> confirm this and also to find where the 1-sec delay in the patch
> run is coming from.
>
>
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: 22 October 2020 9:34 AM
> To: Rahul Gopakumar <gopakumarr@vmware.com>
> Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-foun=
dation.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulni=
ers@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.co=
m <clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmi=
s.org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; P=
eter Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.co=
m>
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Ke=
rnel
>
> Hi Rahul,
>
> On 10/20/20 at 03:26pm, Rahul Gopakumar wrote:
> > >> Here, do you mean it even cost more time with the patch applied?
> >
> > Yes, we ran it multiple times and it looks like there is a
> > very minor increase with the patch.
> >
> ......
> > On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:
> > > Hi Baoquan,
> > >
> > > We had some trouble applying the patch to problem commit and the late=
st upstream commit. Steven (CC'ed) helped us by providing the updated draft=
 patch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0c=
fb0fd24a3), and it doesn't look like improving the performance numbers.
> >
> > Thanks for your feedback. From the code, I am sure what the problem is,
> > but I didn't test it on system with huge memory. Forget mentioning my
> > draft patch is based on akpm/master branch since it's a mm issue, it
> > might be a little different with linus's mainline kernel, sorry for the
> > inconvenience.
> >
> > I will test and debug this on a server with 4T memory in our lab, and
> > update if any progress.
> >
> > >
> > > Patch on latest commit - 20.161 secs
> > > Vanilla latest commit - 19.50 secs
> >
>
> Can you tell how you measure the boot time? I checked the boot logs you
> attached, E.g in below two logs, I saw patch_dmesg.log even has less
> time during memmap init. Now I have got a machine with 1T memory for
> testing, but didn't see obvious time cost increase. At above, you said
> "Patch on latest commit - 20.161 secs", could you tell where this 20.161
> secs comes from, so that I can investigate and reproduce on my system?
>
> patch_dmesg.log:
> [=A0=A0=A0 0.023126] Initmem setup node 1 [mem 0x0000005600000000-0x00000=
0aaffffffff]
> [=A0=A0=A0 0.023128] On node 1 totalpages: 89128960
> [=A0=A0=A0 0.023129]=A0=A0 Normal zone: 1392640 pages used for memmap
> [=A0=A0=A0 0.023130]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63
> [=A0=A0=A0 0.023893] Initmem setup node 2 [mem 0x000000ab00000000-0x00000=
1033fffffff]
> [=A0=A0=A0 0.023895] On node 2 totalpages: 89391104
> [=A0=A0=A0 0.023896]=A0=A0 Normal zone: 1445888 pages used for memmap
> [=A0=A0=A0 0.023897]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63
> [=A0=A0=A0 0.026744] ACPI: PM-Timer IO Port: 0x448
> [=A0=A0=A0 0.026747] ACPI: Local APIC address 0xfee00000
>
> vanilla_dmesg.log:
> [=A0=A0=A0 0.024295] Initmem setup node 1 [mem 0x0000005600000000-0x00000=
0aaffffffff]
> [=A0=A0=A0 0.024298] On node 1 totalpages: 89128960
> [=A0=A0=A0 0.024299]=A0=A0 Normal zone: 1392640 pages used for memmap
> [=A0=A0=A0 0.024299]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63
> [=A0=A0=A0 0.025289] Initmem setup node 2 [mem 0x000000ab00000000-0x00000=
1033fffffff]
> [=A0=A0=A0 0.025291] On node 2 totalpages: 89391104
> [=A0=A0=A0 0.025292]=A0=A0 Normal zone: 1445888 pages used for memmap
> [=A0=A0=A0 0.025293]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63
> [=A0=A0=A0 2.096982] ACPI: PM-Timer IO Port: 0x448
> [=A0=A0=A0 2.096987] ACPI: Local APIC address 0xfee00000
>

