Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA920B53A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgFZPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 11:48:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54219 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593186536; x=1624722536;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9+17ZLyzuLsKL6v+SH1DWQIbcOVVHXT+miVYO7Gievk=;
  b=bE6Qv1iQ0Xbn/J6ejPn2pcFpzPy1oS7H7qWZrgJNefP50+vIvv42C+06
   Jh3hVbyCajfdV14LOmE7pGJgnmiocxmMT7qhTYJCSjr7lYfODznRPQRab
   GBh7W4GDlk/t8G/MjN+jV1uLrw79RxlLw85EEJ6ZYZhLwGAOORw0kLP1f
   N5ibYl8vaJxRO/S7hKNXeIoI3vAc7Tq82ha5NFxZ2JB09Wl6ApG7yjlZg
   vjelOhifirD1OdDAqVDWyUd2Mh8gWHiRTAvgM+VqslqPmGr3bRpYJcoR0
   K8Rcg58agTFtc0PnrGhTTzGwq9h5tqTN1jTAGs8ZqDb+bmphl8Ik8MWxD
   g==;
IronPort-SDR: EvHccpsGnm0iSZWcpDyqGm7T+ToWSra/R9Rn1oNaM0cOJVYbSFoQyzmbUk4MhhztDJrNjOweMP
 EC7FVhM+0oM+EOr4ecVl3hLIFpWYVUYAeO2u4BQRxrDjQ5SjOtTUoeX5syLhjkAaaj1738I74G
 Bs1yvz2IsNhMGR1yeyGWzCt2id0NsawWcSaCAaqXAZ3t87GthozSJZq+IbbzSUZ7WGwt+nJVgX
 DCRrw407NpPsQsqgja661CLgKjl2fhZz47kK9jlVEZaiOFmkEFUVT5NHAlwz7wmovdJbwHy71K
 2xM=
X-IronPort-AV: E=Sophos;i="5.75,284,1589212800"; 
   d="scan'208";a="145334232"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 23:48:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io2ovMN2/t6E5cusKtP2sXszUqutK5OhvXyOeArUMZroeRZHGLcUzuN61rZT0/xsAJAUS21D/Gs/AsrWlDQX14+lzYuyhErB0ULf6SLikBlGiq6+4SPnrlL/g1QbkvHfpMR54RFSngMk7LjV1f4vfqvz0SZAug57vs9CTEJ6xPf68JEl5cuNt328UDj0Qprq5LpJLpPrqUM6Jr+Ff9RXUdn1UGvdY/JLI19ajUP7kGq/Sh/VgyHUgqiEutS1maPIk8r4Fc9x9oHdwj9IjqwpFT6d1NM+RtcRePsnMHUnOFSN06pst4V6ca9SpSs3bjMBL4iwe/u8HdtEvnhsZG3juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vViMBGHAYVq4tTPmMrDdnxnkAIJMuceD/jhNrPOaDhg=;
 b=V6d+BV8xUKi9+oewgv+bHwq/JrCeD4fRQZwYkqGv5kqY6j3pfwbN9mychIBUiicC1umgcenYfNpmQp4V0SqGNMZBldPPMV/UKQ3A0f1jbfQn073gspb5BghkNwr53AKsLZfGjVsESZe6Mt4r09di0jbtWKmp4r0cEELukMGiiDNPqF984g8a06Lu2h3A4XvpFlrKTA+Z8XMJcEXk3e9GQX2nx2+46laW7oB0MSRAR3YjgiaLyo3Lk75bg6IfIu9anKHQ2K4uk/Z3Yi+YuRREXmvXPk5Cy+MpsSunrOp+3Jz9QOt8bmTfv2jCrBt+P/TlkO1FOBN11OK7tpxRmtNl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vViMBGHAYVq4tTPmMrDdnxnkAIJMuceD/jhNrPOaDhg=;
 b=WsRIRhiCjbdOMQEIYlBQjsgbKtgcfzVX5RAHTtB0HO88fOBw5i0uwW/8plA5QCF9AQT0um1WvQynYdlA73TkEoYjiAH2uGsDIiNKNNoisyK4kfjoaJbwgY8vP/iDKEAV/24QceWYLJNHwD3JNkXD+a+ze46cOeceTMrkNDC5kYI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 15:48:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 15:48:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] floppy: use block_size
Thread-Topic: [PATCH 1/7] floppy: use block_size
Thread-Index: AQHWS5A2R4KH51VBRUONtkChHUIXnw==
Date:   Fri, 26 Jun 2020 15:48:53 +0000
Message-ID: <SN4PR0401MB35982FE9416D43ABF2CDBBC79B930@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:a471:867c:4e70:8019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96fd7b0b-d803-45e7-f399-08d819e86dbe
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB396682B97005474D70ADBF989B930@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cB1J4tlcLPQ1Vl4kseI0qRrcwOq4eHZchG67Ah21xvVpFwPffEmhBJ7R0Y6zfrH6d+JOZTAckeKIvUR7xnyFYvk3f6KCztT+wBTFs+xOlWlU+asfP+E/5BpI4RGojmtJeUn9v8zIB4EFZ4s8EtRQ9SIuCMsa6jV3ob3kgIwEYW/EcS3eY+FiUtJpWLuokAxAtxvEJ1dTNXT33N4QCklfOjAP2oh4N2H/ImbNowNdaCYNfNnLeXp9c9yvbG/W0FYqMZN/WMrsojEc1X7ykowHXYA5d7Qh7GdB2gmZHIYRpXSzPwb0/eH9VuVsssM5qvZ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(52536014)(66946007)(7696005)(64756008)(86362001)(558084003)(66446008)(54906003)(110136005)(66556008)(8676002)(5660300002)(478600001)(83380400001)(9686003)(66476007)(6506007)(53546011)(316002)(8936002)(91956017)(55016002)(76116006)(33656002)(71200400001)(2906002)(186003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /J1D/ioIkK7dfriZ+I3pqMuf+DIsWtp+f+qvh3WIqAHrWofWE+vymrtokst6C+5h8RLJbIJHptyOSg05ah/VzBEtkQYBi9r5wtw5YFky+8pG1Ke88M4hOKNczi+FTsjSi7ADkmA2BGHrk36bBNNkMOfXfFVZagkbzfKVU5Gn7UVN+AGzWzzMpfLKIoeZ7owZnPzj23ezKsK6QJK8S9fitP46J8A0y4QHo9NGvN3epJ584hVTv8jpFjiRHseyF7DDm7gLq4sBM503O3uSLgWwklhRK9PIxn0ah2FNHETFAxTWpN64/jEq6zwbRBEbYzAp6lUTi2K5yOgJ3qnkpK54KoZyzjjGSy8EK4RjMDryA9mcUBXWcwN5F+oBaQz9Tq/kkFYaKKZWkXSxlXqhBwFvT7EQJBqKKGXpm8CXGX4RCWnjkVuZ2krWn1nxnWctPnLk50xbG/tgLv+GmBeokvO0f60gOZisD0s+6zuKcVEFcWluo/jGR3U9QEh1Thq0mydigqRPo4x3NMvrmygrtT+owAxLigTkcFz1Vhw+6Ct84WdoO+W6S+Ibquwby2S7K2VO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fd7b0b-d803-45e7-f399-08d819e86dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 15:48:53.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNwIiTGqpulIgPujURvSrHkucZH859oOtw59Q95e1QstoZKAhSrv7r4FQDvU4E0BMRjS9KDDODU+bSWRs8eJcTqa/io/FdU2n4XYYpUCjV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 10:03, Christoph Hellwig wrote:=0A=
> -	size =3D bdev->bd_block_size;=0A=
> -	if (!size)=0A=
> -		size =3D 1024;=0A=
> -=0A=
=0A=
Why is this correct? block_size() only returns 'bdev->bd_block_size' but I =
cannot =0A=
see where it's made sure bd_block_size is not 0. At least no calls to set_b=
locksize()=0A=
=0A=
