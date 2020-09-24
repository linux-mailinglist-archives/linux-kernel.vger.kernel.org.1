Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9149C2777AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgIXRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:24:18 -0400
Received: from mail-eopbgr110117.outbound.protection.outlook.com ([40.107.11.117]:26496
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgIXRYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvRJANlRKrFXCDm/4T3fXojnDxalCOU7Gr6wQOAdjzq+AANzcJMpP/DeuuKJqETEOoCVSH9+z3EEgzrSReLp/1eMGO4+LUc/mlNmw8jAldAs4bfl6njyqCttsZEmfPUGHr+OjKVq4ZuP9VuNdO+jYJPJpvtnADiTiAgsLXdbWgP30jcPP6+nq/NsP88Uhf5mxK7J4irofAEAMZ8MeAoIQtrzR4qYIwbUR7EQQysjezRgzSIX41gvpDY4NAGW6XedydNHmhJps1EoRCRTSHx007fcwnqbQXaIfb5IK/n5qo7Dwye3xCMDFJnO3I8eYapEaWinXHzVdTV/HZ8Z5wpBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRwrF4V03wC5zS2pPypknwrZbc5bALPaNsIOvqWY3XM=;
 b=SH/lu/jp9onxylHhP7HWu3xJV2TNgkBgKnbwOxoemh/wfMlGeGtWlThKHeVmOIhOhBz6vXc8Ckchg5GHRRdTpu5JjAyWfHvPaVYYyAvmTJdp6HvVCTvB1A1t3gmhLt7a/z2hwTOlKe1ZX2CZhpVFVlp28Rn/LdZ7h+TskXsV2zHDZdYApdVY+fD1kdOm+epZnxVH/vxJf8bdVzMnwEs1aMc34BhAMBzcVwpmV7nSeQxKT2znGRGesXBYnjuHbUpAZGCBo9F2NisWAQ3gDkJLBSK4U9R3NT15knPYE5TPPPi7IeQIeAycP6dS+tZXFO68hMpukQmdH/ABHH40GD498Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purelifi.com; dmarc=pass action=none header.from=purelifi.com;
 dkim=pass header.d=purelifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purevlc.onmicrosoft.com; s=selector2-purevlc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRwrF4V03wC5zS2pPypknwrZbc5bALPaNsIOvqWY3XM=;
 b=oppRpFP2IGLlTNxaZe2/V7/tvMYHevZ1KwEzCeBw2V+1qTLEiRplCspE/P3tLRq84jyae23IlbejdEjf3FICuWXLJl3gSUhNwruDoceDjOW8Xblv2lgyQH4tJo4phR10IHucl0574uKOWTcsAp6KR9U/jbiLiMqz7HKQVUOMTFM=
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6f::14)
 by CWXP265MB2182.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 17:24:15 +0000
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f]) by CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f%8]) with mapi id 15.20.3412.021; Thu, 24 Sep 2020
 17:24:15 +0000
From:   Srinivasan Raju <srini.raju@purelifi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mostafa Afgani <mostafa.afgani@purelifi.com>,
        information <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Topic: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Index: AQHWkoZE6X9fo+Lqi0q3sBmm77AkSal36+wAgAAa6Io=
Date:   Thu, 24 Sep 2020 17:24:14 +0000
Message-ID: <CWLP265MB19727D19DE7D0498EEB2B1E4E0390@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
References: <20200924151910.21693-1-srini.raju@purelifi.com>,<20200924153636.GA1171035@kroah.com>
In-Reply-To: <20200924153636.GA1171035@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=purelifi.com;
x-originating-ip: [103.104.125.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3061f8d3-932a-4082-58d0-08d860aea914
x-ms-traffictypediagnostic: CWXP265MB2182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP265MB218240AC848D2B101E376A3EE0390@CWXP265MB2182.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkJot70wFpMiYOd+n9xM2g0II+M4/EAa+zmsJnYxcpqW7a7qkbYtVj4vVrv/BXZAImV6Uix5K4FPVx362ulPgov4VpCmlOhan4961YL/JIzpX0IiNQWF0YWCJ7L5Wo8I7wVcIL9KDrn6ye2n/6cYGCBbqGyysSyXJwgrijB6eiAzeHh5EA4rywNeQl4R0hJXJozCMQpHlrwnEBEAXYcbSoXUfT59CIxJVWKnfB3HSVDyQRuiZA1sG6T6D1O2YesT5VEq8r7tOVRdv1/bTVSKt0ZocZpxTrv3csXx6lCqUl6P9mqhaJxxDK6IZWdGkoxk/WZ4gl/TDJLJ50YkOBPyHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(396003)(376002)(366004)(39830400003)(346002)(136003)(54906003)(6506007)(186003)(7696005)(76116006)(26005)(8676002)(66476007)(2906002)(8936002)(66556008)(33656002)(55016002)(6916009)(4326008)(4744005)(64756008)(5660300002)(86362001)(478600001)(9686003)(316002)(83380400001)(91956017)(66946007)(71200400001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KP3yZpuwUaaWP3zZc24d3YE2Ig7MG1/Odiuk9sHhYRCF+Yl4naIqBojnJh59wyrWFQDr5xjvEeIhQsraSHlsKKHrWEh30lvN5qJ/F+VAtTTspm3NeEouj+eKCx9fxiziKNN2nKWH3eR81vjYXm7sTMVfJs7XZ04Y+oZuuSkbcqlx3eiI5FgGVeAgJ5VtLRW/VbBVDHbFCGorjxcrYSNRVk9ShsnyoCMo229tqyXd3Ry6drnixSpIR1A+arxyzH29iFKBEUz/IRxFa/mHOZP/NVkgXgLeENAe50zJf0PWGEnggKjdUS2Eq3rYpUG4lodWBUE+qSLnwHDaQeSPwHEVKtMvcVHYG1B+M7ekVmbyk1fuPRbKZqnrKua6BjEkvBUdo37nfAFy8SCkAme2xpclXIvLs/C0Ldmplvh6NAOEFELyHvZtI4LavQ1kSK2uqMiJxCWCcRn2ZGvEgQYjCGvmReHhQfrjpwaJQjNOjtXQ/3bDbbEV/DZoUvIV5naBA1U22+HIjhGHZdy5SQ/0c1Dfgn8I/V+moD1hYA8U99wEO35nkJd2JBSm8Jj/AI87W5tKa/9SLdm5Od3H0f/+gq6geRttp9N+5XyZXytWz21kvJSJwffjpJsDRn+F7IrGsi2PNIjv57oZbKJb78Q1JCFgPA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purelifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3061f8d3-932a-4082-58d0-08d860aea914
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 17:24:14.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5cf4eba2-7b8f-4236-bed4-a2ac41f1a6dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qzswQjx/QcBgguTEU+hITZmAV7bnVSFtA55oDcuegUZeqhT847MMQHrNiVZYw4cI4KpSxofGld4NSRuDfKCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2182
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/staging/purelifi/TODO=0A=
>> @@ -0,0 +1,5 @@=0A=
>> +TODO:=0A=
>> +     - checkpatch.pl cleanups=0A=
>> +=0A=
>> +Please send any patches or complaints about this driver to pureLiFi Ltd=
=0A=
>> +<info@purelifi.com>=0A=
=0A=
>Why not just do these fixups on your own right now and submit it to the=0A=
>"real" part of the kernel?  That should take what, a day or so max?=0A=
>Just sending stuff to staging because you don't want to do coding style=0A=
>cleanups feels very odd.  It takes much more work and energy to do it=0A=
>this way than to just do it right the first time and get it merged to=0A=
>the networking subsystem, right?=0A=
=0A=
>So why do you want to send it to staging?=0A=
=0A=
Thanks for the comments Greg, This is my first kernel patch, I was under  =
=0A=
the impression that the staging area is the place to start for any new "Dri=
ver" code=0A=
We will do the fixes and send an updated patch=0A=
=0A=
=0A=
Thanks=0A=
Srini=0A=
