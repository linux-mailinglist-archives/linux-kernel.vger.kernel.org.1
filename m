Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0219927395D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgIVDlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:41:46 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:11647
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgIVDlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9J9AI/31cY75iRfa9jnzcy19ww2zPXlG8BO6s7qOrwpt44402mVDokR2vLrzqUWGu/rFnEV2TSfegyksNtxhdNfqwps8FHzDTSD0LHwCRXEBIl1Cz/wfGuxylj7C8lIkdOLHeKDyw2AveAW9W/VPL4KJaNI6vY2d3ozBucujbSCZGKCLsnqPcj0aJosEjBSJ0R6Pm1bUd9vB5fSGz6g7gDylvuvLWU0MXQAiGnORVGW1bW1Magh8nPFRHLcGvtJIYYkmhUCSRkfHW2rcDcyZ5MsYGbQi3DRlDwJHfM1+q3OaQZ4Bv1uwuNEINDpR4hR1OutkPPP754fsT+r7bqBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pemaZaSpd2MPT6cGLSrzAustFddbhwFnFQkaD0Kr/g=;
 b=ThevHxBd3uNCI1zaSIOv4ynUeN4mL5CAvNIjHrngQDBt9v8R2tsrXDhUdJLtdbdvNSrcXauWpIZFYl1SCdCZ6XmUrbRk6OnQInnhOpac4khUqo/sa7YaAGo+OoR10wYLQhwBJb32S9+/br2lKNt4DFZzQFhcf5A/HXYIDJcQ2bAk/TvuKFam0I+e2enDcQcGEoeM0wvNHxJM/Eqgqsts04d/ULHlLPIHQqLB//4zXTuELl8I7qFCFN9MJFqNM2zdRKjPE302ajaCWX0NLeLENMfOjzEhVUCECNZHoZa2mxM3sEm+pU4G9NNlwcVJZZbqXQZI8HGD2rQYVaiGQebrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pemaZaSpd2MPT6cGLSrzAustFddbhwFnFQkaD0Kr/g=;
 b=b0zfrmuww5sTjAxCyCzVHOfmSTj+lzSXuMivRZQMGmXbQJ+6dk0IayHgO6V47JUDJAbMiISeY6Y3oKG7ZxC4cG+Eh8dn/cRHaWwQfX+gxyPykq9aqaUWDlVgU+BbI+bfyaCDR8uFi0HohetfximrLwIFfjaTV/z0wNrQD3NCIMI=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR04MB3261.eurprd04.prod.outlook.com (2603:10a6:802:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Tue, 22 Sep
 2020 03:41:42 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35%6]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 03:41:42 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: layerscape: correct watchdog clocks for
 LS1088A
Thread-Topic: [PATCH] arm64: dts: layerscape: correct watchdog clocks for
 LS1088A
Thread-Index: AQHWim0XVbGZOO3IH0SIkcW9XlwHB6lz+FuAgAAW5yA=
Date:   Tue, 22 Sep 2020 03:41:42 +0000
Message-ID: <VE1PR04MB67682EEC17A93D2DEBCDD58C913B0@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200914075202.43341-1-qiang.zhao@nxp.com>
 <20200922021801.GU25109@dragon>
In-Reply-To: <20200922021801.GU25109@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 134e7820-6ba1-4de6-b1b5-08d85ea96c0f
x-ms-traffictypediagnostic: VI1PR04MB3261:
x-microsoft-antispam-prvs: <VI1PR04MB3261DA05C7201F5E15E8D6CB913B0@VI1PR04MB3261.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H97uMH9HyLoBOAxObwW/BGw95dHt3Z9sVv71a5mshFFWZx/q2MDwmWmdpGJ95nHWNseSin5zzXpX2u1WsG77FEgLfkpZUFVwJV07uzYqCyXobBxSLy7kgaA7Xcsgl9o0li2vc+nQoo8b+9Eqjohy+reDEfPABs6y/pgtayL3pn+HZ0SaQDtukJ9iPzeh+YaEsFtViaCWv1qoIfq/oazUHEmAFnBOMkkGpPVrxYnbMS5R8DmvzWERClU/n7HEC9zQr9SytYdna06rM7dKz8m79hEbMgGaPH6ra/VzhmSc/eIGAHctuPTekXlF/PhA7mw9E3iKWO830qGEsggeXBVviw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66556008)(54906003)(66476007)(64756008)(44832011)(2906002)(8676002)(52536014)(186003)(9686003)(6916009)(76116006)(66946007)(5660300002)(316002)(55016002)(53546011)(4744005)(71200400001)(33656002)(8936002)(26005)(66446008)(4326008)(478600001)(83380400001)(7696005)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xk3AZAeYlUX0O5cC1VAohMzRSpq/RLauDWQfcl8YU0M2960aMeZd408CRPELlbhGN6aJocR/tXcfILUvtSHBdAr1b79XKQ1rGv2bbS3zDoQBcXw5M68g5WRthkbbJDd2IeAKAGdY4Xdh5Rh+f/pDjBRJPqDI40Yuj6Br5Eu+4SxWislXm0081ejt7L69f4owLnQCBs/CPIlhekwknsb7a1P1CTsX5zJVnMgZbLkN7QfCYEz7B/vK7TvI2Q/3pY3fbCm0snTk0x+oDqhx37fh4yF/b8yDndhi49hjsuj3pJbrKCL+4G+JGXy2Iq1J8qcIlKj7kxa8zj2624rCybGxk8Ze0wqEjdvYOOjWMzSqdro5IOPQ8htCkPhW3W5ijY1SkCOvLF1Oct3U2FLzYooZbO3gsVa6mL4+BuK+XcYTyl1uXUgz2JO7dpXue45nrKYEoSa7wRt4xoh3gnRC+C8y961JuUX38zDCkdysvbjs5c3oo+tdO681+i0Zk6ERz1n5cAFu39N3ESWsm5+D81wNCI5L6trs1vvwSGUXy25fYFJXaHk3exrNKlZPwQPyf+BC3ADp8RgDlbo31846qWySKTpV/C1+8FMGngK011/vWX4Nzu0O5n7HWxcXCCiErs6Ozsje9H/D/wNd9N1tu33EIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e7820-6ba1-4de6-b1b5-08d85ea96c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 03:41:42.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KD/zn+Sj50DT33kyIMnObK+B3he/Bm4sHL3WwAB19kELZjouzNVp5R22qv7+gf7n7yIlNVWJvOQ/GoNiE1SMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMDM6NTI6MDJQTSArMDgwMCwgUWlhbmcgWmhhbyB3cm90
ZToNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jnUwjIyyNUgMTA6MTgNCj4gVG86IFFp
YW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogbGF5ZXJzY2FwZTogY29ycmVj
dCB3YXRjaGRvZyBjbG9ja3MgZm9yDQo+IExTMTA4OEENCj4gDQo+IE9uIE1vbiwgU2VwIDE0LCAy
MDIwIGF0IDAzOjUyOjAyUE0gKzA4MDAsIFFpYW5nIFpoYW8gd3JvdGU6DQo+ID4gRnJvbTogWmhh
byBRaWFuZyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+DQo+ID4gT24gTFMxMDg4QSwgd2F0Y2hk
b2cgY2xrIGFyZSBkaXZpZGVkIGJ5IDE2LCBjb3JyZWN0IGl0IGluIGR0cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFpoYW8gUWlhbmcgPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gDQo+IEl0IGRv
ZXNuJ3QgYXBwbHkgdG8gbXkgaW14L2R0NjQgYnJhbmNoLg0KPiANCj4gU2hhd24NCj4gDQoNCkhh
dmUgcHVzaGVkIHZlcnNpb24gMiB0byByZWJhc2UuIA0KDQpCZXN0IFJlZ2FyZHMNClFpYW5nIFpo
YW8NCg==
