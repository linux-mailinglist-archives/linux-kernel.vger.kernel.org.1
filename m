Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC32276A21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIXHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:11:26 -0400
Received: from mail-vi1eur05on2093.outbound.protection.outlook.com ([40.107.21.93]:5664
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbgIXHLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iml0V4p+KoReXaMai5WYbfVYI2MNAx9YYsrnqWSAUEHOMdgjbEaeCNVwYEX87wX3x4dxrD9MWxCLr/Q+SCYhIMh+mD5kuSalAFRv0HNdjLKZJK0s2eWGKT0bUoH9Qs4Q0BFwwzC5oKObWtaHRrloDTSPVxjDWfaVD4BxYCb4KpQfFF7F1hj553lVqjKOLvbIKySxCZm+0SGhfiJ/bpooYel1C/lqHHrfyi5ZrKeUnhoHDYNYNt082m+/kOts/X5vKO0R/KK2nKoGhsnp3VZWogVLHklJL+kgt2L3lgFLDUvO6Dfl7uJyU2dnYA6klfItNVbqhRMHEpOPXjGMlsO9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf6VnarkOA/qjhh9/C82lh/NbJkqqpKEeE96+IvSAvE=;
 b=iWixY9uFevjFgCReIkBIyFW9u8MrtuWDiOupZ0k9nv5vVgp5tRxOQFGt0jX1oCIJu0397BOLeibGSuJ2d5GiSrfhOUQ6VaTM1kC8T2++wFWcqoHnhohYoO/57MurDhHglfKbBX3PR/XuCOlfjjjW1+Ad6fHFSGK528FJwjlHLmzZKbBxBL7R7+Eh3dtMGaavRAFO6QM7E4OPcYSXYyzixKjh4ijzp64E6j1YGkxM3KxQtitNFXVNCfjYbbrBxBU1rHRJTapTcmaKUgO1s1c+86RVZjBnovUx32DG8amczXfEq0n5lji2VYd6hBn1sDuLLa67YCELfWHeHCYJXvLF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf6VnarkOA/qjhh9/C82lh/NbJkqqpKEeE96+IvSAvE=;
 b=FlcIxbx7JXzm9eRRy9vJuYMsE7a7NQ2RTD4qsmp5Q6EMiYHAgQF41XnVBChUtRpnmGvcTgSqyk9jqDDlA1a2suiIy+huPgByidxoCy/+vKNvRvKgyv18G3lUzMnj9aoZt+C2JUZqsdjLx4XR/5f+ap+DX3E5BlJEOKzdMVu6W40=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB7PR02MB4774.eurprd02.prod.outlook.com (2603:10a6:10:29::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 07:11:20 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::64b0:7fee:4c:c4b]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::64b0:7fee:4c:c4b%6]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 07:11:20 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 4/4] habanalabs: add notice of device not idle
Thread-Topic: [PATCH 4/4] habanalabs: add notice of device not idle
Thread-Index: AQHWkkDCsiSDxIZC2kWIDjFZc32+uKl3Xw7Q
Date:   Thu, 24 Sep 2020 07:11:20 +0000
Message-ID: <DB8PR02MB54688F6E7D1140C1F0483C3ED2390@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200924070259.19833-1-oded.gabbay@gmail.com>
 <20200924070259.19833-4-oded.gabbay@gmail.com>
In-Reply-To: <20200924070259.19833-4-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [89.138.176.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de4d5271-8d3e-4fc4-5dae-08d8605909bf
x-ms-traffictypediagnostic: DB7PR02MB4774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB477436199C8EBB84D1964BDBD2390@DB7PR02MB4774.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lCqwbogDHyeBfq/A1Au9U2oMUbiAafuhRT92QowSZUk7ncuTeZjpI/i+N/9Wv9yJxjfT/xlDfnXzkJTElBxHPGixN9zcjBWwd9+tYiOyXg2s5f8pqnRIo6yxojNQS21J1qei8jPY3fOPhnwADMUuowqGrn1jZR1dRsrR2W4HAaZU55pXEc7rqlCmmRrqdkddINFenKXLV7XlVtbDxJTwJMZv9M+Gh1aaoqXhf0a0Clfa+udZODfxp4jJHk12hkhTP4hgsrDlAZy0cs6sXjypjsqtkS2fAIFjdINN8WV03grYlz4Ep9yksLvcH5KXdJHi0pG4FlbQeTCQ2yJQvjLuI6qSBAItVh8JCc6FypOROMpeQCZlaI0p0CNzPQbjB9AJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(136003)(396003)(366004)(346002)(110136005)(26005)(15650500001)(316002)(33656002)(558084003)(83380400001)(8936002)(8676002)(186003)(478600001)(53546011)(7696005)(6506007)(4326008)(9686003)(66946007)(66446008)(66476007)(76116006)(66556008)(2906002)(64756008)(52536014)(71200400001)(5660300002)(55016002)(107886003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qKhQUiZ0Tj2m8NcNkFxx1dZ1zxX3dqfUuh3V6DJ0op8lv3kEiY2l+UvdE4/iQbZ8e9zpFDWVpKTGh+3CXcwaxtYgV7qkgXsoOOcQ3+0LuZDu65QcZZ4cpFADafQW86cSXYGkZ8MVvLFriSBLr5BjmcNq2mdoR2mbhx5R7ZW4Gozc/zRs79u7PVE6HezZvOc5m01lkfG/gs42N3RdnxLm5XB/6gexF7tgj1TtA5DEqOiNwA3FQ13PiXgORwECqoK/hJ42gLGZX5lCyASwlRKh3pVCOtBxqinzFyIqPcHWLkEvU4kJ5Le9jwW7PBeFpqPUCGfd1tK03DeRtozMSIfwkq8KPpoAyQPLTHsrDzg/9Tp2nWZR2RBnTwZbxs8TA9ifTmadFVqtnfz2rLPgG8G8tMSH0d09WKTHlEGoX3buW+fYOpgLP81VflBMecOXsPp+/GiPKdN/fh4SyN+PERrTOEwkyB3WVgEVZZDlKi7z4JWOZZdIEcqUmLnQHH0hTgXAHDKTCxlqlMX9s0BvOUR+p1UfNc5qIDGjNB8djMztLbzF8QYx9jcrPVMD/wJ9QUOWL8sN3AL60EqDmSmYswctkK/6j4iN6rI+pQYCwji7uhwWmCYkUymoOSQ/aVkJSj+gJevmjAGv6zj19VLMp4OWtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4d5271-8d3e-4fc4-5dae-08d8605909bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 07:11:20.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RDaaDr6sFCmcKcZppi3pPVNGKaYU9yuajPgsLgJqYY+MX7UT0F0+AHwoFJqhXGbTMP6o2tk4UvVT285dk9fNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:03 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The device should be idle after a context is closed. If not, print a
> notice.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

This patch-set is:
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
