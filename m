Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283B22BA0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKTDLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:11:16 -0500
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:20321
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbgKTDLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyVxaCmO8chVbNtPWlNkMmNtV49FtsMbMQs7fmmRpXFHxkCOjxMw8tuflSpl+Isu33JRVyvXRDdeoUVx5ME8Xq5TRPSttqBRzLD/KGtIOtixfZu9fWcyDVR51d761BDiGC9yCDiRBz8Hc8yE3EAHGVl7IJzYbD+2gigTqvIn9tL0LcC2ikB1r0gmU76lOdWuf1kqVtpmW4jJwfRDdmgYA8oZU2YODxBfAfzKpUxGIC+z7iYXNYCKXZM5BW79KlifJT5ag3ZHmZlW5pa3uFQWSDkoZoL0EAp+IFUEfwEtauWKdksk7NTABp5hgG78Obyzu04oN42jacgh5+6A+hdrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI87c9l7JM346FRT8pYFB/mB8eCRs2m1FWXDwPwhoYI=;
 b=EsmxDceZdoyKoxtIZF8DQXIztA8Y2lxWHkyfEmdoKPm5JPxU0+RoIy3bIOQiwjvFjLKcMIBiJEeug9Mvd/ef3njbiDITQkqxDDqPbpWQcFH7G398uo9OIJtWPSeZFCNgoh/UlEHx52tRt4NDWgYPM912ihuTGIi2JdHsa86kRRDKsm0Q+y/H+gb0k8HuRexxZVwcEVWOd/qlBM0rz/siakTXcNoiN87InZ+2dvSmqsk8TwPtg8HwJiHVQ7isZh3xW5Y5UVlTcMcpORVOHLw2JKA3MxIIFKppy01+Bdqj8mY/84uU+hlMMN89YcnRHjoD1iEknSyL7wRKPy+Xf+KP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI87c9l7JM346FRT8pYFB/mB8eCRs2m1FWXDwPwhoYI=;
 b=kxtz9UlSQ+R8uzSDk2wF560rtl2qs4uCtHLsuM9nagkHEfaO25qSSTNPt/Amay1EpIKYn9EcFWcRVCETxhWYEAEVAdOSf0uEUhqMRkC93X/Ul8dVxp6vHX8Q9XMeag/OPK5JvNKIKGRLBSzckDLNrGXP/tNQYedhj11V0/f62Uo=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM5PR0501MB3719.namprd05.prod.outlook.com (2603:10b6:4:77::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.15; Fri, 20 Nov 2020 03:11:12 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3589.016; Fri, 20 Nov 2020
 03:11:12 +0000
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
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBz6mQW+kAgAPEkzyAAWl/gIALAETTgAAhwwCAAAD7T4ACZ34AgADZzMiAEREnqIAADZOAgAFrvxuADlGAgIALzC/8
Date:   Fri, 20 Nov 2020 03:11:11 +0000
Message-ID: <DM6PR05MB52920B2D4267AD7D073D3C36A4FF0@DM6PR05MB5292.namprd05.prod.outlook.com>
References: <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201102143035.GA3177@MiWiFi-R3L-srv>
 <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>,<20201112145149.GN8486@MiWiFi-R3L-srv>
In-Reply-To: <20201112145149.GN8486@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [103.224.32.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c97b079-e3cf-4b54-4346-08d88d01ef41
x-ms-traffictypediagnostic: DM5PR0501MB3719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0501MB3719BDDA16C4F5BB7E1ACAEBA4FF0@DM5PR0501MB3719.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLDStVZ3wUHn5HwmP5YqnAzffHiFQQxiYEC25LPhD1nnsPdunfaXdzPfPDbDY6/KzuTRpAmseoxmjuSOE65Yz/IK6CufvzpKAv1t5fNEfrVD59rFSTnGT3nyi4j6MBH1iK25Ssm1IhKxPwU7CGoPWYZH62QrDz8nfBlKRNOl02L5jRYvtcEqWb19VSL1S5iajHrs9tQzKuYrQ9ok1Z2VUKAcWpZDkOhQMBzdE5nsBtTk3K3joEsFNPflSJ22ny0ILe4QUDJgvUlxQvxYNgHnydUzifE4n/oNl+ulwcH0dgrRAyNNtYA1+MyYBKX43wbYADhf9OL5lKLh9kYeqdpCtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(316002)(8676002)(55016002)(26005)(186003)(66476007)(9686003)(2906002)(4326008)(71200400001)(66446008)(76116006)(86362001)(478600001)(64756008)(66556008)(107886003)(53546011)(54906003)(52536014)(8936002)(6916009)(91956017)(6506007)(66946007)(7696005)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bRM8Et18YwVNMgQvEX3bNS6dOjM5mnROR69E+zZLDG9keucwmGVGLuLB8+R7ve5trKfeB2I4XnqFIDjIxNptSsTYyk+oKRbKGNTrp9iZ2GpO6uVQXvumubBgf7iXXEWL9FUnb8blSYtasDL52tBPQ9ex0upq426Tm7bIvFoif8YfsVOKU47ibXmHHCWIXUu+u0NGilE4Gm/gsNjNh5TWvQxuh95blprz+oWC2jEZBATkPqW3Tam7OJxZ6pZmZLpy04IneuIoCCO3+FCgdnDgLkZg7tMo5a943btbFHBnVjygmouYj7w6wnDB3gyf/EDD88bgmesW6fZfxnIZ0TsBriXnvup0aQd9Sr8I3SSgBGC65jiWO7WTT6rIxG012ySilkut3G8c0cVC3L7oNqekVSnVhz7NomHgosfbXOYEaWQxUps57a6QPaVpr+FkBo65HCZAYZ9Phx/TXs/HWuFjcaNU8vVjM6HkfdY1ZhEch6M7dlOszi0Gda+5qzFgmcdscnDhsv1/E6BsdgyK8FWGVLguygqPWxRQ0SnV9u3LdaY0TaQk0lTfw5W/iZaMu9fS6MQP+oNHL2xwXKpu2+SUUT19NCogvwJhzoXGdt0N2XntCzYrqRkC+wUkxz3KsY1B713f2MK8pznbHZCNOrQh1A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c97b079-e3cf-4b54-4346-08d88d01ef41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 03:11:12.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dL3vSEbpmZKiZV7CdtO3dd72ejHkwc4OZjyapq6+AJHQvtSMFDaCojAw9OnvhPT6HbweYp2d52YKPsBMTTDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3719
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,=0A=
=0A=
To which commit should we apply the draft patch. We tried applying=0A=
the patch to the commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3=0A=
(the one we used for applying the previous patch) but it fails.=0A=
=0A=
=0A=
From: bhe@redhat.com <bhe@redhat.com>=0A=
Sent: 12 November 2020 8:21 PM=0A=
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
On 11/03/20 at 12:34pm, Rahul Gopakumar wrote:=0A=
> >> So, you mean with the draft patch applied, the initial performance=0A=
> regression goes away, just many page corruption errors with call trace=0A=
> are seen, right?=0A=
> =0A=
> Yes, that's right.=0A=
> =0A=
> >> And the performance regression is about 2sec delay in=0A=
> your system?=0A=
> =0A=
> The delay due to this new page corruption issue is about=0A=
> 3 secs.=0A=
> =0A=
> Here is the summary=0A=
> =0A=
> * Initial problem - 2 secs=0A=
> * Draft patch - Fixes initial problem (recovers 2 secs) but=0A=
> brings in new page corruption issue (3 secs)=0A=
> =0A=
> >> Could you tell how you setup vmware VM so that I can ask our QA for=0A=
> help to create a vmware VM for me to test?=0A=
> =0A=
> * Use vSphere ESXi 6.7 or 7.0 GA.=0A=
> * Create VM using vSphere Web Client and specify 1TB VM Memory.=0A=
> * Install RHEL 8.1, that's the guest used in this test.=0A=
=0A=
Can you try the attached draft patch?=0A=
=0A=
> =0A=
> With draft patch, you should be able to reproduce the issue.=0A=
> Let me know if you need more details.=0A=
