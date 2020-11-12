Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E912AFE63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgKLFhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:45 -0500
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:52799 "EHLO
        us-smtp-delivery-162.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbgKLEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:38:04 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 23:38:03 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1605155882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfsRPu/lkOvjPCzyUlaqY/eoVOMCy4ihP1t1IgVZZ+o=;
        b=fpvYYT3xPQ6N2iZ1R7eQqsV9UqRaaM4Ju7v0gGvuLif+evEFcsrNijiUwHMjhx9EsEyQ9h
        od64xT9TofuKzCV2kmP/lS4C/kEmxFmNSWm5U/9mlKgdT0BukwJ21nEwHTQmFUHyPjI8Pf
        Aei/cKHRqDRH7T777mlGw7Ef8ft37uo=
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-jikaAjUtOtqwRgZnVzWtnQ-1; Wed, 11 Nov 2020 23:31:20 -0500
X-MC-Unique: jikaAjUtOtqwRgZnVzWtnQ-1
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::13) by TU4PR8401MB0525.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:770b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 04:31:18 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c03a:bba9:ff3a:ae3c]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c03a:bba9:ff3a:ae3c%8]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 04:31:18 +0000
From:   "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question of ESP failure when device receives Packet Too Big ICMPv6
 message
Thread-Topic: Question of ESP failure when device receives Packet Too Big
 ICMPv6 message
Thread-Index: Ada4SmAp9DMGJIC2RlyDCLYetrfJqwAYhxsQ
Date:   Thu, 12 Nov 2020 04:31:18 +0000
Message-ID: <TU4PR8401MB12166610FCD3DB77C5F2CDF2F6E70@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB12164E982A4DF41593AAF1A9F6E80@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <TU4PR8401MB12164E982A4DF41593AAF1A9F6E80@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [49.207.215.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15ea0889-b261-4573-24bc-08d886c3ccf8
x-ms-traffictypediagnostic: TU4PR8401MB0525:
x-microsoft-antispam-prvs: <TU4PR8401MB052500FC28ACCF185A322F00F6E70@TU4PR8401MB0525.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: vt0XBwjcL7eY/kg28f3guXDRkAm9qBVEvkqqlUIFvBXKLhnNbBztpb+CQmmWkKdgGCphe7G9/RMi+miSOswC+slYn75IMdhSiz5U4Gbbsr40T3jdR80ysKaDsoCn6691TXFqT/tAoBFuMMZAnmP3O38CLRCuk5kBzvcBHyPgsyw5nrEKr5v/SWMDZH8I7G/UfTwmyiFhNm6tckpnLGKzgA+jakvf4hZi94fU+B/VJk3wXWI0LpRFE3TWCdYpJyPBBRK2VaS7/8pVMbKrrQOEysEpCsjg0Ty2Gi3xXTIwfrgPKkmf6LCN1E9MQ3bGBllJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(9686003)(66476007)(66574015)(478600001)(8676002)(66556008)(26005)(6916009)(55016002)(5660300002)(7696005)(6506007)(66446008)(316002)(66946007)(76116006)(64756008)(33656002)(52536014)(8936002)(55236004)(71200400001)(2906002)(83380400001)(86362001)(15650500001)(186003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: FAwzVcFvtZ5crStVX/hJXu2v/zB/tsM58nBf0pSnBFFK7Y0mdEFq49Ug8tYCEVTQD8YVPwCjnhSuINtn5rpPX6LSa3hb3K5bZfgYg/tgU9/AUAtID34C+8JHoq5vit9jdeSwH+FKMlEPzMIoM/hP4t1AdsEDAQkf4+AZQK2gqs45RCuwiD7YWkcaHZrsSDLXdqz/LA77zravqqUIYcsAPqtWOyUbCi5vLswH8934PyLbOdvgE4YYIRxorI6tK6W0kP03BtoV4wBDnDQhD2LHF9BERH0+efTRO1C+yPDRXWCQQk/QMcPaKYSjsO5w7t8y/fkWSWxuTStcIer4cxtvWsqwHsJTpExnDWXsxL1rzIg2luw1C3XHQAmq3M1EDVec4OysxIaPMU1mvSQfMx3wrlZR8Yi8/LpPPPcR6c3LxQGD7VYO5QSoZKtr3wesbaDV+muLfFMPhlAg2n2SfQmlLVvYJ3afwK/nR9DTkSPVlIb73WZzQXBp7gDy6tOzjK/q8hDXlO4/GEv0X8QD6J76S+j0ga9VD+JTWBtpdL2difqbsK1udyiTkqh7/gDyyex1O/F7nBuuTe5w140sVj788EhHTdOzdauhwELrsy3zr0XLRx+95XMVOaZWOQUwfKQ8uZ09ZO9WMNAdvyww/SwcbUFRru3DefO3j0lgQKA4IEJTB9uC/K9TYIaJLebZIY0J7uGTABM6/QSKPMVJEjyJQlq+l7aAYkR4mg6ErVBARzrBO9ZZ9Kfx6ZnIjaL+c/fy/I+DEqNth20ZjqKKqtJWBlP7htVsyBzZp+LBKxQgRox1Stge1s0f2ZHmSQZWrue1O0G+n05V3pyxoGBznYzprII1byM5iBvHn+L3jKY4xC9pyX3+9cOfbLhnlFqUZtKUgnlrOyI+cUnCGXWtxpcf6g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ea0889-b261-4573-24bc-08d886c3ccf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 04:31:18.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqjxTX1vhyE1qLacTV7oH40P50mxSHy37xh2VKAQmKBRcg+kd2vXgZbv5dUtq7yj3iIyoj7VlSg06T0LJg/bcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0525
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jayalakshmi.bhat@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have the below scenario. Devices are IPsec tunnel mode configured.   Ref=
 device  sends fragmented ping requests. Our device responds with unfragmen=
ted ping response. Router send packet too big with proposed MTU as 1280 and=
 payload
as ESP packet number 3.  As soon as our device receives the Packet Too Big =
ICMPv6 packet, device becomes unresponsive for the next ping request from r=
ef device. However our device is responding for ISAKMP informational messag=
es from the ref device. Has anyone experience such issues.  Our device conf=
iguration are  Linux 4.9.180 #1 SMP PREEMPT Fri Oct 23 23:29:20 America 202=
0 aarch64 GNU/Linux. Any inputs are welcomed.


Our device =09=09Router=09=09Ref device=09=09=09PKt Num
<------------------------------=09|----------------=09Fragmented Ping Reque=
st=091  (ESP)
<------------------------------=09|----------------=09Fragmented Ping Reque=
st=092  (ESP)
--------------------------------=09|--------------->=09Unfragmented ping re=
sponse=093  (ESP
<------------------------------=09|=09=09=09=09=09=094  (non ESP)
  (Packet too big)
<------------------------------=09|----------------=09Fragmented Ping Reque=
st=095  (ESP)
<------------------------------=09|----------------=09Fragmented Ping Reque=
st=096  (ESP)


Regards,
Jayalakshmi

