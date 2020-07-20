Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF52255AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGTB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 21:58:29 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:44209
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTB63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9BFC4xJuAlX4Waxqb7o7wc46kurHXUjxeTr7UmEChc=;
 b=nHA6WeLTPvRpw5wlTz1GnC3Ha/TBbjTwOH2DH4BS3lvxRw3bulvuyRFovo8zOd/DsmGKiKM9+GVd8cE4Tqi3UfwaWc3ntHKeq4ax5B+Auyb2UbJDY0xG9KPubLotySohKy+ubRI7X+CSUz85k7zMmurNdXo+JsPzqd50CphGvjc=
Received: from MR2P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::28)
 by HE1PR0802MB2410.eurprd08.prod.outlook.com (2603:10a6:3:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 01:58:24 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:33:cafe::78) by MR2P264CA0112.outlook.office365.com
 (2603:10a6:500:33::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 01:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 01:58:23 +0000
Received: ("Tessian outbound 73b502bf693a:v62"); Mon, 20 Jul 2020 01:58:23 +0000
X-CR-MTA-TID: 64aa7808
Received: from 05b5a9fcac0b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7ACBDA53-51AC-4CDF-8185-F88725E0F3E6.1;
        Mon, 20 Jul 2020 01:58:18 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 05b5a9fcac0b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 20 Jul 2020 01:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIl3TqdvVi1WMqyNjjOBf3EgurIKPR4x+GYDO9V9k7Y6UbDqNSywe/oJvPMu/8BxxWofRANe7gnoTpuz4M0/5DUGoDcJdcyAzkeE8BUpNkr423MXVk1Z3pKF5R2btkCupXb0IwRUQ2gDPxtOWrB9k2BC2MIrV5mUstP2COsEbRKpSt32HVe14fqE+MfQC9MZ6WPVIy3Dmv7x70j4mghJ40EbknoDZsfpEHRz+CdCgU4279esvM9j/rRgCr/9HuyfGEuX9G8tSJvChZUFAmDVSbadqZktu0ERxP03mFAMGoXWjX3qT2wIpgEthz/eOA4e4MovM6ODquH/5cBVoup5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9BFC4xJuAlX4Waxqb7o7wc46kurHXUjxeTr7UmEChc=;
 b=kK63gwRNVTkUMfd4sjbRiZE7lgDwzRgUiO5/M20z7s+HYTmIpUOh2tk1wzp63i+1yD7+OnwnGdby5p2fxczK1I896qgAJMrHB5T1lrg+4L4FhpabgB4p6+sAqakkB+7pUXDEH/Y5pqcE9CNSGbI5wuvQPHd6fIcraqzdUBCO/BvEsp7haPBOCpOlN9PsMkx8cprR+43XY8Ha0ZAZ2V7pK5Klz3jhIjXzNj0kgJa9jr0JOWeP1/cZ5mcIzFcDdL9WxZ5ozDTlCQlCS5yceTyFeora2AX1Iv/kbzKUSsNGJH2t2pWyuqRqGhmz/0SkYEhaBv3XlekevPutYxBIVHk/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9BFC4xJuAlX4Waxqb7o7wc46kurHXUjxeTr7UmEChc=;
 b=nHA6WeLTPvRpw5wlTz1GnC3Ha/TBbjTwOH2DH4BS3lvxRw3bulvuyRFovo8zOd/DsmGKiKM9+GVd8cE4Tqi3UfwaWc3ntHKeq4ax5B+Auyb2UbJDY0xG9KPubLotySohKy+ubRI7X+CSUz85k7zMmurNdXo+JsPzqd50CphGvjc=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2444.eurprd08.prod.outlook.com (2603:10a6:3:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 01:58:16 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 01:58:16 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>, "hch@lst.de" <hch@lst.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        Wei Chen <Wei.Chen@arm.com>
Subject: RE: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
Thread-Topic: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
Thread-Index: AQHWXjefI/dFRQ8uiE2cxP7P59J4UakPtFYAgAABSbA=
Date:   Mon, 20 Jul 2020 01:58:15 +0000
Message-ID: <HE1PR0802MB2555B33805E71BB78BBDACB3F47B0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
 <20200720015212.GN2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200720015212.GN2786714@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3ecd2357-a1a4-4fca-acdd-4c802624a37e.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1af07866-29aa-4111-2ba5-08d82c5062b7
x-ms-traffictypediagnostic: HE1PR0802MB2444:|HE1PR0802MB2410:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2410878697F075D88E687D2DF47B0@HE1PR0802MB2410.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /nGjWYa36Yty4WRE4ChlMLMChJASNrs/Pa0MSISt8sxJAtNE4QWT3sf2m3C4uPsZGoK0BgXwBRkArEfGAKZcnoLghBd3PAkIyqTygmxIkKEg0r8KFwMJHLII8GECR8MCuclWfqLofWjENq9alN2zO+56xT3ZObEvM/t9EGHvE5VianyZfQmgcpvf8mcfzGvDQtMYv8fclQ/FhBPSuFEdnRuXjNGqVyvidPEyu449tkkOp2TXhgjshGGZneaPs+d4V2+q/1OqIOuPxessfLDANWz7NzcdJSEdu3xQbFUWtQdCnRR7NtqSA9+yfJxhy5jUpoQkonLN7p+j0rlqIXmQvA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39850400004)(86362001)(2906002)(5660300002)(316002)(76116006)(66446008)(66556008)(66476007)(64756008)(52536014)(33656002)(26005)(54906003)(478600001)(6916009)(186003)(8676002)(53546011)(6506007)(8936002)(7696005)(66946007)(71200400001)(83380400001)(9686003)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jVdMuD9Xdo+vfpZwl1Ti2BLUcjEBZnu/qAmrfxubjpN+y+Gs+4f8sQLQNnXw11jwC2TolPGz8PPL3o6O/CFYQJsArnfboFhTVlhm+2fzl5E4jyNhw/pwdy80vdSbiuXJIqmlbNxEzdDaNuWkxcUDwXUDM7eHSQZrKWimb7J8S8kAFgi7lU68agbmM9xZaxRFjV9fY2pIT0cv/RXlq9UhA3LHZzsBxDldgJB3iISgEPdjN3lHNZPngHrgQ43YglskvMi+gOx22hwUXnOa5UrC4BkoavZoZM3OA3f8OCe3PapMHtERBoapjziybrf1N6u/5V0I3dqpi6/8Yq8T/KHUllMl+6bLS8NHmZ+sswS6Ti9MwFrrysMhIKYsEiZRGyDmu/QRrVMoRBlhOZ7C/0hzWu7oQKPQscpM1nHVR79EtLc03eo5LkjYsly3E2UCGp8uzP2ymQVhYzXIoAHwCTd1PrLktANkJL8xdf5RHIM8SaY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2444
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966005)(7696005)(186003)(86362001)(6862004)(55016002)(4326008)(26005)(33656002)(52536014)(478600001)(8676002)(70586007)(70206006)(9686003)(5660300002)(316002)(54906003)(8936002)(47076004)(2906002)(83380400001)(82740400003)(6506007)(53546011)(81166007)(82310400002)(356005)(336012)(36906005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f906d934-436f-424c-a748-08d82c505e3f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5N16Kb5K90eTcEn22C58VTAv7h2cU3QZ0mYF1ne6blVuSBrFj1xGWYkYzMr1aPmRysvLf+vTjOjoxuNBNKfqL8h2sDHFAZ4a+5/l7ri+Q/NRhWNIo/r5bxLReQwsRlf+nnwobsOez4LavJRDRVIokrWRkQTc5n4LJYQ6rwhGbmQnnstSqYi1nG7QbG+CwjgdYPlgxR23HDN4p8p7gH1VwWQiPdGtC37i1GHOXuKLTLqiWl47F6ezUvMr2LX837R/dHarTNxACpQ4DMjGPVAvFFyPikdiOvVW4sLEvpjMYu32SEbycR3TuzhbVA59BBgI3wX+cjK1JrbDtmDugQFH+c5g03B4hJ0ZqRhW5085xbLUCA4kj0MH26Nakx9HKscG2Xdg8RLmlsi17AzQCTYWsg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 01:58:23.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af07866-29aa-4111-2ba5-08d82c5062b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2410
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Monday, July 20, 2020 9:52 AM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: ericvh@gmail.com; hch@lst.de; dhowells@redhat.com;
> lucho@ionkov.net; asmadeus@codewreck.org; v9fs-
> developer@lists.sourceforge.net; linux-kernel@vger.kernel.org; Kaly Xin
> <Kaly.Xin@arm.com>; Justin He <Justin.He@arm.com>; Wei Chen
> <Wei.Chen@arm.com>
> Subject: Re: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
>
> On Mon, Jul 20, 2020 at 09:46:20AM +0800, Jianyong Wu wrote:
> > how to reproduce:
> > in 9p guest:
> >
> > struct stat *statbuf;
> > int fd;
> >
> > fd =3D open("tmp", O_RDWR);
> > unlink("tmp");
> > fstat(fd, statbuf);
> >
> > fstat will fail as "tmp" in 9p server side has been removed. 9p server
> > can't retrieve the file context as the guest has not passed it down.
> > so we should pass the file info down in 9p guest in getattr op.
> > it need add a new file member in "struct kstat" as "struct istat" does.
>
> Er... what struct istat?
Oh, sorry, I make mistake here. it's "struct iattr" Not "istat".

Thanks
Jianyong
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
