Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4B2963A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894639AbgJVRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:21:54 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:20403
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507470AbgJVRVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEnhkwDHvTCOO0gssbNOl2RdsJmQbiP9UhxnqACHQXWqnp+nihAWM1ZTRd6BwAlEVG08UgqybKa9GgLTAr0I1TElIt45VSmdSPYLwDpingPTTocCVw2LPNjWPEdchVHP/aZRN6FlZyDQjxuPfOveyzRTnUfGLhA0ZjndnQhDQrEnQH5kacXxTepXb9NwMghCCMlbceiejuP3TEHaKsJ3MB1NyLNScG1ScvAhoiacPuxyfhsPJ/oBLiLu5/o5NRwJZXuVr5fuv2LSJe2wmL+ca05Uv/rlqFul3yEQFBxsjkBp3TFnIx9N182+K1bxsNpNJdTnYVVi4lB9WnfY2YV2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVUqTGaf82w6wEcBBqM23GXlsujvR6sjurFENlWZVoQ=;
 b=dN0RM2kOxL/y2A6suOThxKF+0Fk4NTBV2s+g4Io8SWUbEeqZ3RDi/5OPYMtG9mYhZZf1P/He6TmfGx6XHkw2AeRjQbCiAAEm2e2EJE6R9S46qwyGEKCK9R6PpqUQuu4iAm7D+uamAagSSXYL/uNEC1tTz41JPDm2of2iVwp3EPcubfSucMhWADz6vd2k+86I6IqxR+1STGXV625pCJ0Uw2q6HpMefPK13Z0UONwpulcJNeKLiV7EObytsJTU53Ot80GuuqdPAseM4Zy+QbrpZBcSDrQ7xk0OdMh6Wk7Yi0nmJEuqcQkPyTGRsGCQskr6e6lDYscdEt6gRTZeif8I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVUqTGaf82w6wEcBBqM23GXlsujvR6sjurFENlWZVoQ=;
 b=PV+t4PUxzSTiQp8Q7c8yG08mdzNYW335E8TB78yGg+b47gNnNLCBOIsEc69KDU5rEFw8Z/eaitbVR/0SnZYu2uMYjZea8zMpN+nziIrSxw/OmbhtqCO4X4cM262kHGElhiWxqpCqnmlJUViTwLqJjXRjIOoC9pD8JFd6rSG9WfA=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM6PR05MB3993.namprd05.prod.outlook.com (2603:10b6:5:82::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4; Thu, 22 Oct 2020 17:21:50 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 17:21:50 +0000
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
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBz6mQW+kAgAPEkzyAAWl/gIALAETTgAAhwwCAAAD7T4ACZ34AgADZzMg=
Date:   Thu, 22 Oct 2020 17:21:50 +0000
Message-ID: <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>,<20201022040440.GX25604@MiWiFi-R3L-srv>
In-Reply-To: <20201022040440.GX25604@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [103.224.33.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e2cabee-c592-43ec-038a-08d876aef697
x-ms-traffictypediagnostic: DM6PR05MB3993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB39934650E316FC2549BE393AA41D0@DM6PR05MB3993.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWy9hAPrgWe4Kfl0K5yRqsWPY/qWSxlu1k3UNTTWTwM6XDjM7iulsfrPDc7Hp6HxgoFzDwvrdMhYwK84TSatfZo+TUMVm1pyMiGPv4b9uBjmeZZKyg+MAYRy8e2stOz5dmchCRy94U5OiYWevYabeh/RN2W3t62/H63e295d+BJDy1BmAi2LF/zrTC68nVcxJpcglcpX5WWMnleKWr7gRY9UaoXtCSnBMZaizJHvljha6w/15X1PdvZCfwdPqjktHPt8QqHorzHx3PDA+P7ZNEOPPY82UrLg5sej5nuEsaUuWQYTUF6gRgBkWSOArSxFExTbzg1iDId5IZu+OGgi/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(186003)(76116006)(53546011)(55016002)(2906002)(6506007)(54906003)(26005)(478600001)(33656002)(8676002)(66476007)(66556008)(71200400001)(9686003)(64756008)(66946007)(91956017)(66446008)(316002)(4326008)(83380400001)(86362001)(7696005)(8936002)(5660300002)(6916009)(107886003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YmioyMP07Jm/YoBFn4vf4wcUZT2m5ywzCzOXuAepkowZ/oF35q6s85ArtWXe0DW/uNQVTr1uABVLcxM2zaHN9y9JfT/m2LqcErv1atN3j1z0r9h5Ypf+RoKe2MVvpB/Wc23Wva+r5oxyitFFEuVmKCK1W6fEXSZ8iElU7EYdbaZSnjyC4edOdk66qoPdepaOeTKMHHPGetNhh60VR63p6O9v/fc7bk2iaRGKgnd4OtpEaQ3a8dIcfI51+LwCH+7s2JI/QJwxRVIb+fjm6szMsFPdf9ZS2SRQXtP6FBoAPipK+mv0clLiw96h4Zk4IQTQcu3w2kTZ6Zgwnb8lCeKQ03rt/Se7BxkzFtFsg4pwW/o3udJ/0Vwzf8XaDz6muPDM1/mXYl4OsqZ1MEABplYVkHhXN1Uf+IWXv/zZHXTlzI6HotvkaCV++hqjvtp10mGev7ChDiJvIk5oHzeGoyyP9yb5U+ZHEY7VDBDbk6ovGlR1Z7rmwXJkrbj+9NRR/WCn0o02iIuQEwhuWTE1PGHJ0DncMlhgYcZwqyCsAw8WRuMz7cob25K7VctMYJWFKQKfHnnSGNtsPRD8sKt4N5m2FYISZZVvP3CZ2rEX/5kv1+QoLEgONBYEmrfWLskXoztQJojzzsm62bVo7w9mwQP8+g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2cabee-c592-43ec-038a-08d876aef697
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 17:21:50.3905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c98Jas/cy4TxSlPYLhEC7qjMs4VC93q6/XgipSoQ/atEvqNp/WHB/YEBkjQysmIETEgA65QPISTHGO8Poc0yFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB3993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=A0Baoquan,=0A=
=0A=
>>=A0Can you tell how you measure the boot time?=A0=0A=
=0A=
Our test is actually boothalt, time reported by this test=0A=
includes both boot-up and shutdown time.=0A=
=0A=
>> At above, you said "Patch on latest commit - 20.161 secs",=0A=
>> could you tell where this 20.161 secs comes from,=0A=
=0A=
So this time is boot-up time + shutdown time.=0A=
=0A=
From the dmesg.log it looks like during the memmap_init=0A=
it's taking less time in the patch. Let me take a closer look to=0A=
confirm this and also to find where the 1-sec delay in the patch=0A=
run is coming from.=0A=
=0A=
=0A=
From: bhe@redhat.com <bhe@redhat.com>=0A=
Sent: 22 October 2020 9:34 AM=0A=
To: Rahul Gopakumar <gopakumarr@vmware.com>=0A=
Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-founda=
tion.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulnier=
s@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com =
<clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.=
org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Pet=
er Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>=
=0A=
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kern=
el =0A=
=A0=0A=
Hi Rahul,=0A=
=0A=
On 10/20/20 at 03:26pm, Rahul Gopakumar wrote:=0A=
> >> Here, do you mean it even cost more time with the patch applied?=0A=
> =0A=
> Yes, we ran it multiple times and it looks like there is a =0A=
> very minor increase with the patch.=0A=
> =0A=
......=A0=0A=
> On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:=0A=
> > Hi Baoquan,=0A=
> > =0A=
> > We had some trouble applying the patch to problem commit and the latest=
 upstream commit. Steven (CC'ed) helped us by providing the updated draft p=
atch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb=
0fd24a3), and it doesn't look like improving the performance numbers.=0A=
> =0A=
> Thanks for your feedback. From the code, I am sure what the problem is,=
=0A=
> but I didn't test it on system with huge memory. Forget mentioning my=0A=
> draft patch is based on akpm/master branch since it's a mm issue, it=0A=
> might be a little different with linus's mainline kernel, sorry for the=
=0A=
> inconvenience.=0A=
> =0A=
> I will test and debug this on a server with 4T memory in our lab, and=0A=
> update if any progress.=0A=
> =0A=
> > =0A=
> > Patch on latest commit - 20.161 secs=0A=
> > Vanilla latest commit - 19.50 secs=0A=
> =0A=
=0A=
Can you tell how you measure the boot time? I checked the boot logs you=0A=
attached, E.g in below two logs, I saw patch_dmesg.log even has less=0A=
time during memmap init. Now I have got a machine with 1T memory for=0A=
testing, but didn't see obvious time cost increase. At above, you said=0A=
"Patch on latest commit - 20.161 secs", could you tell where this 20.161=0A=
secs comes from, so that I can investigate and reproduce on my system?=0A=
=0A=
patch_dmesg.log:=0A=
[=A0=A0=A0 0.023126] Initmem setup node 1 [mem 0x0000005600000000-0x000000a=
affffffff]=0A=
[=A0=A0=A0 0.023128] On node 1 totalpages: 89128960=0A=
[=A0=A0=A0 0.023129]=A0=A0 Normal zone: 1392640 pages used for memmap=0A=
[=A0=A0=A0 0.023130]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63=0A=
[=A0=A0=A0 0.023893] Initmem setup node 2 [mem 0x000000ab00000000-0x0000010=
33fffffff]=0A=
[=A0=A0=A0 0.023895] On node 2 totalpages: 89391104=0A=
[=A0=A0=A0 0.023896]=A0=A0 Normal zone: 1445888 pages used for memmap=0A=
[=A0=A0=A0 0.023897]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63=0A=
[=A0=A0=A0 0.026744] ACPI: PM-Timer IO Port: 0x448=0A=
[=A0=A0=A0 0.026747] ACPI: Local APIC address 0xfee00000=0A=
=0A=
vanilla_dmesg.log:=0A=
[=A0=A0=A0 0.024295] Initmem setup node 1 [mem 0x0000005600000000-0x000000a=
affffffff]=0A=
[=A0=A0=A0 0.024298] On node 1 totalpages: 89128960=0A=
[=A0=A0=A0 0.024299]=A0=A0 Normal zone: 1392640 pages used for memmap=0A=
[=A0=A0=A0 0.024299]=A0=A0 Normal zone: 89128960 pages, LIFO batch:63=0A=
[=A0=A0=A0 0.025289] Initmem setup node 2 [mem 0x000000ab00000000-0x0000010=
33fffffff]=0A=
[=A0=A0=A0 0.025291] On node 2 totalpages: 89391104=0A=
[=A0=A0=A0 0.025292]=A0=A0 Normal zone: 1445888 pages used for memmap=0A=
[=A0=A0=A0 0.025293]=A0=A0 Normal zone: 89391104 pages, LIFO batch:63=0A=
[=A0=A0=A0 2.096982] ACPI: PM-Timer IO Port: 0x448=0A=
[=A0=A0=A0 2.096987] ACPI: Local APIC address 0xfee00000=0A=
