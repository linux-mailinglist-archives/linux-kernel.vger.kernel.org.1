Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23262AE9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgKKHVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:33 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:49320 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKKHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:21:19 -0500
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB7BtxQ007093;
        Wed, 11 Nov 2020 02:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mz3Xzk5N/GnwlIyyfPrwAC6OC+9XL8aPoPFOpnqHmBQ=;
 b=e11VtKVoXuKLMgTqp4mR0jKN0cpOopQ5gyJbia/QvdCPveRV7Yihlvf6+gU1ypQwGW1p
 7PUGNfUtjMvwOGDDfhunaQKSZ24aXAPn+26niLTVyeLl1wd+TXtuBSSFPxzdMvBePQLl
 Qi/44FAu/NiHDKSx/fLn48gGylAtzxLz8XIBrOIzxbhEMgsBoIec8STt8ZV4xV9XB4zB
 FL91300jG3xBBKB0SyNT2Aye6HmnO2Cy0GXY/behUVlGmrxu3dCZ1eupgnUvfSEax00t
 vevy+UWOEmz55gpKrhfIKMPL1Y/NH8t3LlKOKqx8xcNtxmluP86mHz4TYAmcjBdrYyqw 5g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 34nnhx2yvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 02:21:10 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB7Cqv9013278;
        Wed, 11 Nov 2020 02:21:09 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00154901.pphosted.com with ESMTP id 34qturgm0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 02:21:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo59601+PDoMMGo7ufQa5ue3xNipH7I4CptwF+2VeXbbcBuVQtbaH5k5GqaXsRJhbYq7D7d8QiodPEKPFP7bdPnHkQAvcTMEdsGktRTXTNWJ2LCChfyFKPXfh2DyzTcXrZdx/MjkLOYgoHfbQ8F4ZryCP/J/c0ZQLsNOxEZ/HEFnUa4d2WlsnJ0D3l8ivx2s7FiJSc1ZzJC6PcnAsBHJwthHJIl9AH2rLHoRLpPLCaEg2J3XWwQMF2+1Ry43C13t7mpZ2Y7kkST40tRILB+HsIBwAMaLsAhblty79tDCNqtmdx31DmCredISUGG3UKawLOBkid8JiSrfcB5Rvn9Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz3Xzk5N/GnwlIyyfPrwAC6OC+9XL8aPoPFOpnqHmBQ=;
 b=hqGi9NJY2pdSQhXdtRGMxtfesFXs8B0IeqoAkwfzSv8vWwikL7saeYSKJuRaICkwCemriZDdXnNh3WMd8POG7DEGaI9CjCdg72sZRX+0LV09S0rR1XYy24ySqHJ7eEe/b4E0Tqi9V7avMQTYsZ5k1TspHhnM/tx5+4iL0dqB+RxwRgviyN42olgWTNHlJUGl98X4qzuFPw0UiDkyKQwyfCr+qikcEIuKabN0BZ143EM/7Qv4wcLoImXUW8QAkj4GFeLBTNW7l2Xc+eOJpzl8SNuKKAgPqGHWVOS9qrKHLydg2c2sgmjyneyMYRtLUqA5jFfo6dOhyWz5xFbmwM13nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz3Xzk5N/GnwlIyyfPrwAC6OC+9XL8aPoPFOpnqHmBQ=;
 b=VPxOJEqgH69NSqqlP8Rdoc6v6K3/ZOoJm81HDm8dsF3Cv9i+oKReTnrAiZ4BR4sjRRAhlUXArSZkdfqCGKdjClVbpF8VQx9nAIxT4UdBi2kF8N//oc/L2Bom5HXnl6MP6f3Om5RlC5shYyYg3OlTQtFsuD7tCzlTTi1grg8PDao=
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (2603:10b6:a03:28a::6)
 by BYAPR19MB2727.namprd19.prod.outlook.com (2603:10b6:a03:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 07:21:07 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::cdf9:1409:7f4a:b17c]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::cdf9:1409:7f4a:b17c%8]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 07:21:07 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Subject: RE: [PATCH]  platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Topic: [PATCH]  platform/x86: dell-privacy: Add support for new privacy
 driver
Thread-Index: AQHWseC6+2HFzxrm30edUEfX3Yxeu6m3NaWAgAtS2yA=
Date:   Wed, 11 Nov 2020 07:21:07 +0000
Message-ID: <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
In-Reply-To: <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: srcf.ucam.org; dkim=none (message not signed)
 header.d=none;srcf.ucam.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [163.244.246.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f2b6c72-55f8-4b9a-9396-08d886125b9f
x-ms-traffictypediagnostic: BYAPR19MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB27279733E6D60CFB2312901084E80@BYAPR19MB2727.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSjzsq5Dcm2bwwyCXhK3iIR1ril/xmOZLLR/6KIlnJKb2MlATLO72Ic/JRfwzHzNkAWhsEwaBRu/87uDjcU1ey14PUTRH/U+cFu5s5f2iKxDOBUEP1mFzjoUEW+9WwMPe3JBRFKux7h9Mkl/RIck2dJ9gQWyYcUlecpoptpnZoFAJpfIJ9sezph+Y+BOa0IHdoki0e5plvgaGubpeg9oNoMuKLUPrgw00/jZg+L/ebBw4Fhefj6ZEmANvFfWVT/Qd/ZILvPhTCaM70ALjATXLvNG2okElAkxlovEIMj6AJQHUOzMUUrNXFMUemJLaEVee3P9mIs9DEUwuwa1fAi3pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(66556008)(9686003)(26005)(66446008)(64756008)(66476007)(6916009)(478600001)(86362001)(53546011)(7696005)(186003)(6506007)(5660300002)(8676002)(55016002)(76116006)(8936002)(66946007)(2906002)(71200400001)(52536014)(786003)(33656002)(4326008)(54906003)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o/NCEmcFgQj9nQycAY0f/sCtJ3ALqlgrR76X4Z5yxMd7FbB3lpjVwyLaT2uh5sY5oN6uStpvxz6Mp8SS9ypfLlsmTsVAfgILv9R4IBw4hBOhnM1QvyVwPvztOpzAYnRo+Z+QTfO7QlUE2rKbNDAjUuShbZA2a10kr9f6nU+XCvXvKBdiONw0TO3YduBH3hX+nkAuOr/FUekjK9C9YJw9s3nvBTkvUdkIoNVETyytCrsnfaGcwIT/iUe+aj+Du/i2O6M0p1ytxkIG+sQ/Xi8a+4yegS9zsXgy91tJqL9jG7E+dYunUdy4rwzXUTdI+S0DoWiwinfflvyWWogPa/8eahpZMaTLoC7H8RHBGl0oHXKvJPOo2Yqf8haCgleOsg+sTzL3gvyzEtiKwO+kHsmdie5GROKodHJ6XE/K6sHakW2+tOuNJPvpceu/4qRoWXZ3uL0DtOOfUCm1rWTInitoGE+0DWNN0iD5cYGWcikQe1rD0gm/1vVqWxGx5UtoufDbylod9IXUXyveibLxBD9VE558ltpvOzJsAuw3vHF92UxgEE7a8UvR5Nl1r+6QoMCUnpztJC1j5+CcdySAaYpk8HEvWIB9Lepz2P2Nyy8QF0q/5G1a+PD5p0SyB0Cf4WqBurUnqthpuZJxa9onfKC8JaImthkucsuj087Pp2PmWQuAyxFYL+h368gtnsodwVVnLnnh9+13/dyXeor0I7bxlhx8kC9KZvtJY1ecUXRMTgAcSoIrSGLFAuyXrRgJLnTHgO1B/RNG5nRLBcztkLMdz/7OdWGwA+N1U1h8dCAyZfkXxWHIOXNSOCm7iA5BR9BGqwf8ETq618hEpaqzfwvouUW/DBydQSZgtmUqxuw8eThAVBaSFWgA6JjLpWWEFjYGmyjZG5BHFEtfJLNYaRd0Xg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2b6c72-55f8-4b9a-9396-08d886125b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 07:21:07.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGG5+k5kxIG9rxATxP6m0TVNXEy3x4ASPt4ZniPwkNjouUEXEa9AagwHi9WiqyHr4wulDEN/m+ilG/2NkHA5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110037
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> Sent: Wednesday, November 4, 2020 9:49 AM
> To: Yuan, Perry
> Cc: hdegoede@redhat.com; mgross@linux.intel.com; pali@kernel.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Limonciello,
> Mario
> Subject: Re: [PATCH] platform/x86: dell-privacy: Add support for new priv=
acy
> driver
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Nov 03, 2020 at 04:55:42AM -0800, Perry Yuan wrote:
>=20
> > +#define PRIVACY_PlATFORM_NAME  "dell-privacy-acpi"
> > +#define ACPI_PRIVACY_DEVICE	"\\_SB.PC00.LPCB.ECDV"
>=20
> This looks like the EC rather than a privacy device? If so, you probably =
want
> to collaborate with the EC driver to obtain the handle rather than depend=
ing
> on the path, unless it's guaranteed that this path will never change.

Thanks Matthew
I will change the path to handle as you suggested.


>=20
> > +static int micmute_led_set(struct led_classdev *led_cdev,
> > +               enum led_brightness brightness) {
> > +    acpi_status status;
> > +
> > +    status =3D acpi_evaluate_object(NULL, ACPI_PRIVACY_EC_ACK, NULL,
> NULL);
> > +    if (ACPI_FAILURE(status)) {
> > +        dev_err(led_cdev->dev, "Error setting privacy audio EC ack
> value: %d\n",status);
> > +        return -EIO;
> > +    }
> > +    return 0;
> > +}
>=20
> What's actually being set here? You don't seem to be passing any argument=
s.

Yes,  it is a EC ack notification without any arguments needed.=20
=20

>=20
> > +static const struct acpi_device_id privacy_acpi_device_ids[] =3D {
> > +    {"PNP0C09", 0},
>=20
> Oooh no please don't do this - you'll trigger autoloading on everything t=
hat
> exposes a PNP0C09 device.

Got it , I need to adjust the driver register logic.=20
In drivers/platform/x86/dell-privacy-wmi.c .
The privacy acpi driver will be loaded by privacy wmi driver.
The privacy wmi driver need to  check if the privacy device is present.
It can avoid loading driver on non-dell-privacy system.=20


+static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] =3D {
+    { .guid_string =3D DELL_PRIVACY_GUID },
+    { },

=20

=20
>=20
> --
> Matthew Garrett | mjg59@srcf.ucam.org
