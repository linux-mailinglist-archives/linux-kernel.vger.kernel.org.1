Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC72748E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVTPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:15:44 -0400
Received: from mail-eopbgr700139.outbound.protection.outlook.com ([40.107.70.139]:16574
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgIVTPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/fRfSNLMAGqcm09mvd/XYDntogNvHAmRKNkyGKMnbFo8V6VmrKCeaU2fw0ehNPgGwzsD3Y23HAqKsETjT8TBkRlvwh0H+Z7ry7NKKj/kLgNodi9zp0KgB7eWePPkjZEQIHa4tGfYGfZenBXgx7I5De5NY9e+1juWqbJMhbcK1OCi2+exxVdx/7CGhX/p7qrej1wr1HvGA70RV24VUZGZjll/YD8qdepGNx+AEe234aU84CMQJ2nieRIcY4pvuOvN6p/0NAz5Ms3cRwQApY/d2nJQC1brf1htigaLQdlxd4dXk7HM6Gk+ycnVQZkgvLx4TrMAhq3CKWhAG3UxGNXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S88//JNMSMH01EpdjxgKxDgix2RleLHqO3M0JFZH5Oc=;
 b=LaqQ7NnhtYU4bax4CQH6Dsw2o+Wp1+LKfZfB2EHwWgbWtyOk0aLJIqHcYKjz+iz9Bjy4Le0V46uqiXyv4xZb8zHfdBcWFcmrv1ZZjTb442eYJZkhGO435eT6AQHvNyeU5utLpcCwlFoK+A7So7UMeRT8T01OvXUbKad8CcfjXAOzZ+7FEXwYJhvI6ds2mgcCjjhipn6easoDgRQ2dAdyf9aamukFdXA17ZM5uXJlhw0BnkYo8sJi8JhUR0v15hiIVTsl6tFnnI8e4LTBa1FeKY5D84ir63SsY/gR5YjLgqakOZAynYINcVC+oyZ9HvgXn6mepE8UsaLuhwr4EMpQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S88//JNMSMH01EpdjxgKxDgix2RleLHqO3M0JFZH5Oc=;
 b=ZXyK4DO0nHnyRpcgSXekelz9j5JwMZsYDnJ0+xyIKfDk6r+3KwMfZWBL2CtQOG5XGDNvRfF6+o6OdT/iqRBlhBFRx5eNujmEM7ps4PXTCN9hYz7wZAQCOOSVSZQoUUj63H+XAiuf/NHPSPOHAg+QRx3BmJKExoYoeYK9F51z76o=
Received: from MWHPR11MB1965.namprd11.prod.outlook.com (2603:10b6:300:110::15)
 by MWHPR11MB1504.namprd11.prod.outlook.com (2603:10b6:301:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 19:15:38 +0000
Received: from MWHPR11MB1965.namprd11.prod.outlook.com
 ([fe80::e4c9:1dd4:14f6:8761]) by MWHPR11MB1965.namprd11.prod.outlook.com
 ([fe80::e4c9:1dd4:14f6:8761%11]) with mapi id 15.20.3391.026; Tue, 22 Sep
 2020 19:15:38 +0000
From:   Ugur Usug <Ugur.Usug@maximintegrated.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] hwmon (pmbus/max20730): add device monitoring via debugfs
Thread-Topic: [PATCH v4] hwmon (pmbus/max20730): add device monitoring via
 debugfs
Thread-Index: AdaREcTj+PEGIESfRUCcigwWqijDdA==
Date:   Tue, 22 Sep 2020 19:15:38 +0000
Message-ID: <MWHPR11MB1965C01083AD013C630646B2FD3B0@MWHPR11MB1965.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [176.236.34.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8de294fb-9bf8-40e9-e6dc-08d85f2be40c
x-ms-traffictypediagnostic: MWHPR11MB1504:
x-microsoft-antispam-prvs: <MWHPR11MB1504D99DE28707FE95515AD3FD3B0@MWHPR11MB1504.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2v9OszeQ0fvYD9bqiXfldokphX5bC6nk9Aj+VfWQ5CrfbzDoIDnufuWjkBkysNa6USoxUYH8rkgGTNzfEAjTB/27BAia1NHqHA9zOJ89GKgAajSho8rsy7roiI6bMOZTcJRfRVXxrEJ1fPv5sHHvKS6sI5Vg+mPvNlSNL3oruxhCktLa7Dc1rdn9Jxu8iXDbNH7Y5mjbN62pUberootM2/r0nZpWfh2okHp6eKILKhCRTL3xEwfKj1XVfgHVxY8oK7Eb59/p59M/+/5rzicay7OKKEZr0Eeer53YkLjxJIQ6CPB1Bqq+S2Ba/iFD49hWtHDRNzMppaS9Bp3l8Ud8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(346002)(136003)(376002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(6916009)(54906003)(71200400001)(7696005)(8676002)(478600001)(33656002)(4326008)(9686003)(55016002)(83380400001)(26005)(30864003)(2906002)(52536014)(86362001)(6506007)(5660300002)(186003)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UX6YtOcbfl3AsUR0CkUC9l1JLX9exE8JoPyqSDVJ39g1TiKQfyLLI6hvcaGT45euh7uQCAv2hsOlBk11Q0wgD4YlNFL2T3tN5Pol11CZZs6h4shHHRR2sIpfqZtFHTSfjQHvVykfLpGfdPksBcJvyz9q7CKqvTw7BAiAWbeJoNfOxczdIzrKqqUYn6Bxkc8PYNUk/GcVnSJjUA0yszQf+hYPfgA8ND9f0NkZ0uZ0is9/cgOuuPRvnc7eTNIJDEVkKrcNIPchDeKXfTWH3U23uPwWWZ6Zd2Q7PUAl2kc4PXR24NPnj2b1DUhDxxLLSTcKk/S2StHUDJODdOG+/TI/O3co2q42sapFO8bgO4DKZw0BrFViPHD7dO9Ol2bFuohTVwOR+Q+4Lj3fz1Os1eweRRlqXOH90HjA5gQD3k4/voro+MplvP8fIAwdAmWvCVWOrMdxBs4S7ui21W991rvG1S2mT8y1OH8fzPTr6PNAUsmvBzYS1+Og60KZ/PCg5nE6kTYbe7X0dpEvO923MIVjABROmSWJq3hvyw68yhDTDGZTl6EK7qL0dhGtZciHIgCu/EnC9UXCBu2yIKgdjO008KAOAibgdLxO7KpipZoqNoFllsNxnQyEVmsKO3DVdIt52HNTBHcAj/aZluOz/1sLCQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de294fb-9bf8-40e9-e6dc-08d85f2be40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 19:15:38.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWrKIPsnsSDHp8UXBnhkRbGKcx5peYQOyO9tpC1G2drPhUlvHt/Ik/FNcm+rsfxuMvb3wEJ2PKbb6Rel4/NTX0m99JSeQuS8OOz3Vd/Ye6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs interface support for accessing device specific registers (MFR_=
VOUT_MIN,=20
MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_OFF_CONFIG,=
=20
SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.

This patch changes following items in max20730_debugfs_read():=20
- the EINVAL returns to "Invalid" or "Not supported"=20
- strcpy() and strnlen() calls to strlcpy() calls
- VOUT_MODE, VOUT_COMMAND and VOUT_MAX raw outputs to unit volts
- terminating '\0' characters to the simple_read_from_buffer() return

Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
---
 drivers/hwmon/pmbus/max20730.c | 363 +++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 362 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.=
c
index a151a2b..3175c9b 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -26,16 +27,367 @@ enum chips {
 	max20743
 };
=20
+enum {
+	MAX20730_DEBUGFS_VOUT_MIN =3D 0,
+	MAX20730_DEBUGFS_FREQUENCY,
+	MAX20730_DEBUGFS_PG_DELAY,
+	MAX20730_DEBUGFS_INTERNAL_GAIN,
+	MAX20730_DEBUGFS_BOOT_VOLTAGE,
+	MAX20730_DEBUGFS_OUT_V_RAMP_RATE,
+	MAX20730_DEBUGFS_OC_PROTECT_MODE,
+	MAX20730_DEBUGFS_SS_TIMING,
+	MAX20730_DEBUGFS_IMAX,
+	MAX20730_DEBUGFS_OPERATION,
+	MAX20730_DEBUGFS_ON_OFF_CONFIG,
+	MAX20730_DEBUGFS_SMBALERT_MASK,
+	MAX20730_DEBUGFS_VOUT_MODE,
+	MAX20730_DEBUGFS_VOUT_COMMAND,
+	MAX20730_DEBUGFS_VOUT_MAX,
+	MAX20730_DEBUGFS_NUM_ENTRIES
+};
+
 struct max20730_data {
 	enum chips id;
 	struct pmbus_driver_info info;
 	struct mutex lock;	/* Used to protect against parallel writes */
 	u16 mfr_devset1;
+	u16 mfr_devset2;
+	u16 mfr_voutmin;
 };
=20
 #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
=20
+#define VOLT_FROM_REG(val)	DIV_ROUND_CLOSEST((val), 1 << 9)
+
+#define PMBUS_SMB_ALERT_MASK	0x1B
+
+#define MAX20730_MFR_VOUT_MIN	0xd1
 #define MAX20730_MFR_DEVSET1	0xd2
+#define MAX20730_MFR_DEVSET2	0xd3
+
+#define MAX20730_MFR_VOUT_MIN_MASK		GENMASK(9, 0)
+#define MAX20730_MFR_VOUT_MIN_BIT_POS		0
+
+#define MAX20730_MFR_DEVSET1_RGAIN_MASK		(BIT(13) | BIT(14))
+#define MAX20730_MFR_DEVSET1_OTP_MASK		(BIT(11) | BIT(12))
+#define MAX20730_MFR_DEVSET1_VBOOT_MASK		(BIT(8) | BIT(9))
+#define MAX20730_MFR_DEVSET1_OCP_MASK		(BIT(5) | BIT(6))
+#define MAX20730_MFR_DEVSET1_FSW_MASK		GENMASK(4, 2)
+#define MAX20730_MFR_DEVSET1_TSTAT_MASK		(BIT(0) | BIT(1))
+
+#define MAX20730_MFR_DEVSET1_RGAIN_BIT_POS	13
+#define MAX20730_MFR_DEVSET1_OTP_BIT_POS	11
+#define MAX20730_MFR_DEVSET1_VBOOT_BIT_POS	8
+#define MAX20730_MFR_DEVSET1_OCP_BIT_POS	5
+#define MAX20730_MFR_DEVSET1_FSW_BIT_POS	2
+#define MAX20730_MFR_DEVSET1_TSTAT_BIT_POS	0
+
+#define MAX20730_MFR_DEVSET2_IMAX_MASK		GENMASK(10, 8)
+#define MAX20730_MFR_DEVSET2_VRATE		(BIT(6) | BIT(7))
+#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
+#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
+
+#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
+#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
+#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
+#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
+
+#define DEBUG_FS_DATA_MAX			16
+
+struct max20730_debugfs_data {
+	struct i2c_client *client;
+	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of((x), \
+			struct max20730_debugfs_data, debugfs_entries[(y)])
+
+#ifdef CONFIG_DEBUG_FS
+static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	int ret, len;
+	int *idxp =3D file->private_data;
+	int idx =3D *idxp;
+	struct max20730_debugfs_data *psu =3D to_psu(idxp, idx);
+	const struct pmbus_driver_info *info;
+	const struct max20730_data *data;
+	char tbuf[DEBUG_FS_DATA_MAX] =3D { 0 };
+	u16 val;
+
+	info =3D pmbus_get_driver_info(psu->client);
+	data =3D to_max20730_data(info);
+
+	switch (idx) {
+	case MAX20730_DEBUGFS_VOUT_MIN:
+		ret =3D VOLT_FROM_REG(data->mfr_voutmin * 10000);
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d.%d\n",
+			       ret / 10000, ret % 10000);
+		break;
+	case MAX20730_DEBUGFS_FREQUENCY:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_FSW_MASK)
+			>> MAX20730_MFR_DEVSET1_FSW_BIT_POS;
+
+		if (val =3D=3D 0)
+			ret =3D 400;
+		else if (val =3D=3D 1)
+			ret =3D 500;
+		else if (val =3D=3D 2 || val =3D=3D 3)
+			ret =3D 600;
+		else if (val =3D=3D 4)
+			ret =3D 700;
+		else if (val =3D=3D 5)
+			ret =3D 800;
+		else
+			ret =3D 900;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_PG_DELAY:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_TSTAT_MASK)
+			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
+
+		if (val =3D=3D 0)
+			len =3D strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 1)
+			len =3D strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 2)
+			len =3D strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
+		else
+			len =3D strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_INTERNAL_GAIN:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
+			>> MAX20730_MFR_DEVSET1_RGAIN_BIT_POS;
+
+		if (data->id =3D=3D max20734) {
+			/* AN6209 */
+			if (val =3D=3D 0)
+				len =3D strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 1)
+				len =3D strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 2)
+				len =3D strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
+			else
+				len =3D strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
+		} else if (data->id =3D=3D max20730 || data->id =3D=3D max20710) {
+			/* AN6042 or AN6140 */
+			if (val =3D=3D 0)
+				len =3D strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 1)
+				len =3D strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 2)
+				len =3D strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+			else
+				len =3D strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
+		} else if (data->id =3D=3D max20743) {
+			/* AN6042 */
+			if (val =3D=3D 0)
+				len =3D strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 1)
+				len =3D strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+			else if (val =3D=3D 2)
+				len =3D strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+			else
+				len =3D strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+		} else {
+			len =3D strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
+		}
+		break;
+	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_VBOOT_MASK)
+			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
+
+		if (val =3D=3D 0)
+			len =3D strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 1)
+			len =3D strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 2)
+			len =3D strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
+		else
+			len =3D strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
+		val =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
+			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
+
+		if (val =3D=3D 0)
+			len =3D strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 1)
+			len =3D strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 2)
+			len =3D strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
+		else
+			len =3D strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
+		ret =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
+			>> MAX20730_MFR_DEVSET2_OCPM_BIT_POS;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_SS_TIMING:
+		val =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_SS_MASK)
+			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
+
+		if (val =3D=3D 0)
+			len =3D strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 1)
+			len =3D strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
+		else if (val =3D=3D 2)
+			len =3D strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
+		else
+			len =3D strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_IMAX:
+		ret =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
+			>> MAX20730_MFR_DEVSET2_IMAX_BIT_POS;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_OPERATION:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_SMBALERT_MASK:
+		ret =3D i2c_smbus_read_word_data(psu->client,
+					       PMBUS_SMB_ALERT_MASK);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MODE:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_COMMAND:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
+		if (ret < 0)
+			return ret;
+
+		ret =3D VOLT_FROM_REG(ret * 10000);
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX,
+			       "%d.%d\n", ret / 10000, ret % 10000);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MAX:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
+		if (ret < 0)
+			return ret;
+
+		ret =3D VOLT_FROM_REG(ret * 10000);
+		len =3D snprintf(tbuf, DEBUG_FS_DATA_MAX,
+			       "%d.%d\n", ret / 10000, ret % 10000);
+		break;
+	default:
+		len =3D strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
+}
+
+static const struct file_operations max20730_fops =3D {
+	.llseek =3D noop_llseek,
+	.read =3D max20730_debugfs_read,
+	.write =3D NULL,
+	.open =3D simple_open,
+};
+
+static int max20730_init_debugfs(struct i2c_client *client,
+				 struct max20730_data *data)
+{
+	int ret, i;
+	struct dentry *debugfs;
+	struct dentry *max20730_dir;
+	struct max20730_debugfs_data *psu;
+
+	ret =3D i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET2);
+	if (ret < 0)
+		return ret;
+	data->mfr_devset2 =3D ret;
+
+	ret =3D i2c_smbus_read_word_data(client, MAX20730_MFR_VOUT_MIN);
+	if (ret < 0)
+		return ret;
+	data->mfr_voutmin =3D ret;
+
+	psu =3D devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return -ENOMEM;
+	psu->client =3D client;
+
+	debugfs =3D pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return -ENOENT;
+
+	max20730_dir =3D debugfs_create_dir(client->name, debugfs);
+	if (!max20730_dir)
+		return -ENOENT;
+
+	for (i =3D 0; i < MAX20730_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] =3D i;
+
+	debugfs_create_file("vout_min", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MIN],
+			    &max20730_fops);
+	debugfs_create_file("frequency", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_FREQUENCY],
+			    &max20730_fops);
+	debugfs_create_file("power_good_delay", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_PG_DELAY],
+			    &max20730_fops);
+	debugfs_create_file("internal_gain", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_INTERNAL_GAIN],
+			    &max20730_fops);
+	debugfs_create_file("boot_voltage", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_BOOT_VOLTAGE],
+			    &max20730_fops);
+	debugfs_create_file("out_voltage_ramp_rate", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OUT_V_RAMP_RATE],
+			    &max20730_fops);
+	debugfs_create_file("oc_protection_mode", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OC_PROTECT_MODE],
+			    &max20730_fops);
+	debugfs_create_file("soft_start_timing", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_SS_TIMING],
+			    &max20730_fops);
+	debugfs_create_file("imax", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_IMAX],
+			    &max20730_fops);
+	debugfs_create_file("operation", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OPERATION],
+			    &max20730_fops);
+	debugfs_create_file("on_off_config", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_ON_OFF_CONFIG],
+			    &max20730_fops);
+	debugfs_create_file("smbalert_mask", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_SMBALERT_MASK],
+			    &max20730_fops);
+	debugfs_create_file("vout_mode", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MODE],
+			    &max20730_fops);
+	debugfs_create_file("vout_command", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_COMMAND],
+			    &max20730_fops);
+	debugfs_create_file("vout_max", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MAX],
+			    &max20730_fops);
+
+	return 0;
+}
+#else
+static int max20730_init_debugfs(struct i2c_client *client,
+				 struct max20730_data *data)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
=20
 /*
  * Convert discreet value to direct data format. Strictly speaking, all pa=
ssed
@@ -370,7 +722,16 @@ static int max20730_probe(struct i2c_client *client,
 		return ret;
 	data->mfr_devset1 =3D ret;
=20
-	return pmbus_do_probe(client, id, &data->info);
+	ret =3D pmbus_do_probe(client, id, &data->info);
+	if (ret < 0)
+		return ret;
+
+	ret =3D max20730_init_debugfs(client, data);
+	if (ret)
+		dev_warn(dev, "Failed to register debugfs: %d\n",
+			 ret);
+
+	return 0;
 }
=20
 static const struct i2c_device_id max20730_id[] =3D {
--=20
2.7.4
