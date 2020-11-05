Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946C42A7A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgKEJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:07:15 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:28998
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbgKEJHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SStCvVpeOLX31hkGNet0k6CfzfpTbzrSDArdlFPE6kk=;
 b=k0fpHTZmGtWqr+ja8EjXh5p3BNN1+03jeUl6x0tLsz09GJXRse8eIEmEULTcwvCu869gMpd0UVGTXJupKTNg7ZC4Uyimsf1eWQPFlSgEqcMQGMnqvmqkH6IuTb8/safHz/K6S6j+q0zuA+SI1ELh2+3+VmbQWwfehZZ/NAQiX88=
Received: from AM6P193CA0057.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::34)
 by AM6PR0402MB3527.eurprd04.prod.outlook.com (2603:10a6:209:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 09:07:08 +0000
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::53) by AM6P193CA0057.outlook.office365.com
 (2603:10a6:209:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Thu, 5 Nov 2020 09:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Thu, 5 Nov 2020 09:07:07 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.57) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 05 Nov 2020 09:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmm4BqkgZIxQmQJmWGbIZOBy0/oPZsLiJv36xUHPlWcyOrJ+NP4WfBq0eAGLkFt9+pAjIABlJ1dNzOpi/xWavVPs1TTJqQWKe9+ph0612u7/wyrkTeFUWzC99vtcJEtbYiemJYCY1O6dIZKkIsUpELITlkw/TzW/+E4TMTDf3zGOfJN+WFfWm+su6jdyYdqhHaSrJqBONmu4o13VgQrDDv9VEKvlK1LpXUXEDRUZzj60NQI7g8K2l1I3/fGI1cDSIGTS01Cyn3UJYfv6Ku+vec3gPUNc4pgJz+/FwgkczdeC3zWLyeSWlETt3v9earUqYVTCyx85aq2/9IlcxDNRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoY2oJDVBjEg5xWy+BBykCA7WsCRcHnGvUqEgXXBqXk=;
 b=H/WXivNJfq1ya+ceTuNZApEwlapYV148o77mOC0NR1U8NPALubw8oea6qMYj3MwU7lT0zqVEqyQiNWQvaaXuYgujcOaNyCTRWq+nVr1jdBSBAH0CJy/wm5eBuQSXyzaOHQmsOwi+5inY7BEwT3LYsG30aSK6Na2xiBInOW7mf27qM1YfqG3iusdsze28FBRp5f9uvw0dLCfWBnoiw05zsA/QL9LLpUv2V+v+RrdORGWX/tyY8qT+XRp1z7IiqQT0XoUGCXmrOyR51HsbfYSCV1hASOXHMKjTI4/6N7gg5BT3HEMoOVqbU5LgmpstJ5Wp8aqw0T2JuyRzDZUX6E7Yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 09:06:57 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::35e9:2f0b:112b:28c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::35e9:2f0b:112b:28c3%6]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 09:06:57 +0000
Subject: Re: [PATCH] clk-si5341: Support NVM programming through sysfs
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
CC:     mturquette@baylibre.com, linux-kernel@vger.kernel.org
References: <20201103141741.2511-1-mike.looijmans@topic.nl>
 <160454088987.3965362.6147280271557523496@swboyd.mtv.corp.google.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e888d4ad-6d00-4e78-a0c7-083be5e86c8e@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.9c2cb1f3-6c6b-4005-b459-f71a0d72128e@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <b18625cf-7dd0-db96-9460-bb0ff920b5db@topic.nl>
Date:   Thu, 5 Nov 2020 10:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <160454088987.3965362.6147280271557523496@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [81.173.50.109]
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.121] (81.173.50.109) by AM0PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:208:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 5 Nov 2020 09:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0faec12-2c01-45c8-9355-08d8816a2bff
X-MS-TrafficTypeDiagnostic: DB8PR04MB6923:|AM6PR0402MB3527:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3527726617656F01B0F43E5C96EE0@AM6PR0402MB3527.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y2aaIvo103zExfsmU8g2BjOda9XAEq1S3V2/9nZbvDkWxM1DOOaJ/lwFgHmVesdWkzVtY9z2ttJgsgOhVIYDNbJaLdhigL9J6qBtcge6bnV3v4NueQ+tE/ImVbLt9My0HMO48hfgZqJK1xFRjHmWMJebu3SoTBJylPbLx31uT9iZjTZQllGYWizTGSjbLIhRY2aMqPFYeFleJHBlpmHZg8kUdOjV2QQx1II8lzI+kfzj2k/JUOuyO34lX67ADczl7p2pQbPk1IxoN94dnFSTwrWsqDlDVIVjlIMHaio5nO//AVhWECO/OFP2ynzxy1RdmHIev37/JhPguNLvDoI0uHBsNot3B+ZNZBTb5gebeazSuU7Nxc49Kp3NVSua4XUY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39830400003)(346002)(376002)(53546011)(83170400001)(8676002)(83380400001)(16526019)(52116002)(31686004)(8936002)(6486002)(5660300002)(36916002)(36756003)(478600001)(2906002)(956004)(66476007)(66946007)(44832011)(4326008)(2616005)(31696002)(316002)(186003)(16576012)(26005)(42882007)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZUEGG2cgJjKPILBnySOTZSqK1Hy/JJVqlunaYRbbVOpTr3x4KGzAXHgXLHlSfDzV4B7xmkrFiCZlh6u1L0UITT1tfhBp5t40XPq5aaeV+OGsxWcUG9yHBobeGnRvXpVxRJO2tt9cxhA2cDHxc0cP6szhmfivKwEMg5PdtTDgp8JkzOlnnRCCb00ajAu0nwrBZJ2iGRWkhOHEzIPv0XSe8Nwq7EJOqdQGRD7xZIFzUdgXpjd0u/voMvgWadBneOJb1OkvaxxOKrHJnX8u+YW5Wn/aDks9LGwZaMQUXFg1UG804TM6iimCLl+e5rjohqmup8JGn26B/Bd/LHBtztbCGX29K5kWVftPI6a6LYeXf/z1pydktNuO1Bt7nnZHrVq5MbN79otEkIpYHU8tm8Srj73bjpbX7IjqBkDcgLo0muKQCud/AHaoTFI7C53H/j0CIdDHGz7VFcLnpk15vPrx+wOqXKses87cyg1mczhcp4XqOGA+4Fjg6XuFLpEfIdz1ypVYhZVMOFjC0hFl77rfjScekekSbY64ZaK9lt24xnRk4p1DyuEZYNaqJR31lktC7+/DWRG2Te2dtLmaSvHcZ1Ib1U9z1KD8fr++SGOS69zPwPlJCpfQhSIKNk1NZXM1qbNj/roAIyRh6Wi5vft9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
X-CodeTwo-MessageID: c51befac-4741-4c27-978b-6cc16f28e4b7.20201105090701@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 492f61a4-b5d8-456d-31d6-08d8816a250c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EymWZuabB/meqcOSfyMVJ2fS/iUNziwdgs2snP06wLW00DFh7RupKIZ5IbXqO8CsDOu7/hTeapvajwJTTKbXvseylfXjoEAcY6z3sUv5ZcO43g/cRN0yNljpCNjJBnkhH53NFvO9uA42VjYzoi+HlfvAzjMJdmTTKeeHaNtFyzhDTbm2765KXvMWLdSw002/iyiWFHJUvKZD8mZ8Zzvqjq6/4aOB1CtgBnIcoWmlX1zwZ9pourGD1XTbxzUpJGh40IT1BQkuNMP8n5HTE2dU4XfLxKTsy06tLUsoB/LIKifAAHEEnz+thC3mifobfjt216v5PWCRfGYnjtq0HVns9XrztVUvBFCYkjhJrcI4X6QjdsOiOdTQUPW7+BcN8Z9CKEnIWWx+e+jyS8JKGxCiPtrxrnkheE8Avh59xS2gNzEr4C5emka/FPAGu9vk3llAzE1M+hw1itMisTu8OOLb4+EcxnDAXleQQbUCZrXX9n/9KO0/PRBuz/8kC7yNz9me
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(39830400003)(136003)(346002)(376002)(396003)(46966005)(70206006)(83380400001)(44832011)(16526019)(70586007)(31696002)(186003)(8676002)(47076004)(26005)(6486002)(2906002)(8936002)(82310400003)(478600001)(31686004)(4326008)(956004)(356005)(2616005)(36756003)(336012)(7596003)(53546011)(83170400001)(36916002)(316002)(15974865002)(16576012)(7636003)(42882007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 09:07:07.6378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0faec12-2c01-45c8-9355-08d8816a2bff
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 05-11-2020 02:48, Stephen Boyd wrote:
> Quoting Mike Looijmans (2020-11-03 06:17:41)
>> Export an attribute program_nvm_bank that when read reports the current
>> bank value. To program the chip's current state into NVM, write the
>> magic value 0xC7 into this attribute.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>=20
> Any chance this can be done through the nvmem framework?

This part doesn't fit. The purpose is to store the current state of the clo=
ck=20
chip into its non-volatile storage so it boots up with that configuration t=
he=20
next POR. Main use case is that some vendors initialize PLLs only in a=20
bootloader and thus need the clock running at boot. Or it might just be to=
=20
save on that 300ms initialization time.

Having said that, the clock chip does have some "scratch" areas that'd be=20
useful as NVMEM storage. That'd be for a separate patch.

For this device to be NVMEM compatible, nvmem would need to have a sort of=
=20
transaction model, where you write several values and then "commit" them al=
l=20
to NVM in one call. The nvmem framework wasn't intended for that I think.

>=20
>>   drivers/clk/clk-si5341.c | 73 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
>> index e0446e66fa64..4e025a5ea2b7 100644
>> --- a/drivers/clk/clk-si5341.c
>> +++ b/drivers/clk/clk-si5341.c
>> @@ -1199,6 +1205,69 @@ static const struct regmap_config si5341_regmap_c=
onfig =3D {
>>          .volatile_table =3D &si5341_regmap_volatile,
>>   };
>>  =20
>> +static ssize_t program_nvm_bank_show(struct device *dev,
>> +                               struct device_attribute *attr, char *buf=
)
>> +{
>> +       struct i2c_client *client =3D to_i2c_client(dev);
>> +       struct clk_si5341 *data =3D i2c_get_clientdata(client);
>> +       unsigned int regval;
>> +       int ret;
>> +
>> +       ret =3D regmap_read(data->regmap, SI5341_ACTIVE_NVM_BANK, &regva=
l);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return sprintf(buf, "%#x\n", regval);
>> +}
>> +
>> +static ssize_t program_nvm_bank_store(struct device *dev,
>> +       struct device_attribute *attr,
>> +       const char *buf,
>> +       size_t count)
>> +{
>> +       struct clk_si5341 *data =3D i2c_get_clientdata(to_i2c_client(dev=
));
>> +       int ret;
>> +       unsigned int value;
>> +       unsigned int timeout;
>> +
>> +       ret =3D kstrtouint(buf, 0, &value);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Write the magic value to this attribute to program the NVM */
>> +       if (value !=3D SI5341_SI5341_NVM_WRITE_COOKIE)
>> +               return -EINVAL;
>> +
>> +       ret =3D regmap_write(data->regmap, SI5341_NVM_WRITE,
>> +                       SI5341_SI5341_NVM_WRITE_COOKIE);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Wait for SI5341_DEVICE_READY register to become 0x0f */
>> +       for (timeout =3D 10000; timeout; --timeout) {
>> +               ret =3D regmap_read(data->regmap, SI5341_DEVICE_READY, &=
value);
>=20
> This is regmap_read_poll_timeout()?

Yes, indeed.

>=20
>> +               if (ret)
>> +                       return ret;
>> +
>> +               if (value =3D=3D 0x0f)
>> +                       break;
>> +       }
>> +
>> +       return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(program_nvm_bank);
>> +
>> +static struct attribute *si5341_sysfs_entries[] =3D {
>> +       &dev_attr_program_nvm_bank.attr,
>> +       NULL,
>> +};
>> +
>> +static struct attribute_group si5341_attr_group =3D {
>> +       .name   =3D NULL, /* put in device directory */
>> +       .attrs  =3D si5341_sysfs_entries,
>> +};
>=20
> If not nvmem framework, then this needs to be documented in
> Documentation/ABI/

Okay, will do.


>=20
>> +
>>   static int si5341_dt_parse_dt(struct i2c_client *client,
>>          struct clk_si5341_output_config *config)
>>   {
>> @@ -1544,6 +1613,10 @@ static int si5341_probe(struct i2c_client *client=
,
>>          for (i =3D 0; i < data->num_synth; ++i)
>>                   devm_kfree(&client->dev, (void *)synth_clock_names[i])=
;
>>  =20
>> +       err =3D sysfs_create_group(&client->dev.kobj, &si5341_attr_group=
);
>> +       if (err)
>> +               dev_err(&client->dev, "failed to create sysfs entries\n"=
);
>> +
>=20
> Cool, I as a user would do what in this situation? The error message
> seems sort of worthless.
>=20

It's not critical for the driver to be able to register this. So I could ju=
st=20
silently ignore the error.

M.
