Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37E0303AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbhAZKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:47:47 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:17665
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbhAZCNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:13:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEzcUlOKO7mt862Jk8TQykjp20Fpd8XQ8lSVtl0b02zd+bGfDCvUZ9jPHxFqWybhpu1e22Ldax42mdQIapHmSUXEGfnvmeyIrxMwwL7TIuLh2LFUNIcfu3wDAClI3lA2CNmLiz42MEKJ+TPEfHJJEzgSkV3vbFmqkMcOo1Wd4CbR/KKZ3bQ1RWOjudzxCWfx91APHW0pc+yw7t7TTEeIBHnkGDetdxsKli3wmPlADtXYgxaIF/lUiN+XtUOLPzW6lTQQyDNGU+8V5sUsm345u3hfziWAs1BcSb4rhW0hrao67lLrMaVGX4hggTP83JaErjmndqKUdI3MiR5PMxI2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASsmje/S+obvmANpMtbDjoL70MJ7ZvUNcZLdFGnF18g=;
 b=IuGvIJGGwyBUxGGlkT0aPfSXKfgC+kLeePcdcPnvgfkxTH8pFTt5vsqvGnrufDNs44sfKPkN5fo4aj51r4UbFHnA2pkiLpBLDElGdcuHTbV32MVXyO6NWMoTpamRJHa0gx4tCSXdrvDFdmatyW3/KHXXBBYv5AMAZYP9luubkb1004+DXEnkdHz6UnrDWkiaRDJoz4hhl+fMWjGZQQgvlcF1G7pc+6n3gdVPvlkwwZtW+YwViFvyim+3Bn6+NYUN39IKHMZ3QepX/Oh8bmbQFDkXxHmVXSlKgr2HJwLsrVn8yDSNCnDijvF8QiqUMqHTUljYgLi9VLlS+uoJu3SmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASsmje/S+obvmANpMtbDjoL70MJ7ZvUNcZLdFGnF18g=;
 b=a6SpRRklLDio5GFynOWS4Ja6yNp3fEIZ9UiagvtptOkYn9KOI7eVtijYHNx4XaQeGCemt95wGkG0crwQdrXPJ28ron+TXUwTiahYzph9ctbr7inbNYEeLN/Ko8z6Hpp6IRDgiepJQ4Kzq+Jol3FUbZJARji3e/klYogNVRv21No=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4225.namprd11.prod.outlook.com (2603:10b6:a03:1ba::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Tue, 26 Jan
 2021 02:12:45 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 02:12:45 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question on migrate_disabe/enable()
Thread-Topic: Question on migrate_disabe/enable()
Thread-Index: AQHW84bOF+3rqGjcZUW04nBm71/AnQ==
Date:   Tue, 26 Jan 2021 02:12:45 +0000
Message-ID: <BYAPR11MB2632E0BCC9CE86D7DB6E7CFEFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94d84ba1-d768-418d-2dc9-08d8c19fded1
x-ms-traffictypediagnostic: BY5PR11MB4225:
x-microsoft-antispam-prvs: <BY5PR11MB4225ADAB6AD1B84A72A72959FFBC9@BY5PR11MB4225.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DYf26DxEhtkIKNO3GKdImNaUfQFe2mA98K5dtwYpUsrwWFTQ2YEM+LE3FRrzjMIUC5Ze+B4ojgPLz8xwHI8XPvX3kLbrZIzFVF9q2l34sMRj7a7o9ygTkBD4QJSYQiB8kfCxMJvgHP17jxXZSQndPsenLrbzacl5x+3gFR7Osqn0ia0wncjKXvtVWH4rzAdN6gb2TboeLlymjkRg7f8HJ5cnW4dzhKmku+bdNtpe3r/5ZPLBWMQrPZclx+DioXo2s3pPXpW9EI9EAs0NTZbu8vweNUi0ok7WcGeOyqb2B+IA0pgNokqVwmjtkI/eqzJBf99Nrb5q+bcO33yjKYR7DGpGBXf0feb+FKVM/j1Kh8bhaqT5sSr+RPJhw+zOcv/XwkOgnEr3tTJtQKU+lZEAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39850400004)(366004)(376002)(71200400001)(8676002)(6506007)(316002)(110136005)(8936002)(76116006)(91956017)(64756008)(66556008)(66476007)(66946007)(66446008)(478600001)(7696005)(4744005)(5660300002)(86362001)(33656002)(52536014)(83380400001)(2906002)(55016002)(186003)(4326008)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SldGYkFkUnFIbk54aVlyWXRYM05WUUN4bVlGYmRIREFRbmhuVXEwZHRtRGN6?=
 =?gb2312?B?ck5BWWw5dnNBdTA2ZlFhSlk0M1VzNnNDbmtJZmtNRUcwMUkrekJNTjBndm9R?=
 =?gb2312?B?T05iNElZaXJMcjJjc3ZEd21SMzBpVVFPT3ZYNHA0blJvbWhDQU9qNTVMOG5v?=
 =?gb2312?B?YkJlZjV1WlZoZ3lucTEvUkY2azZUa0QwMllzVzlZcVFZdWQ2TTlsNkprNmJF?=
 =?gb2312?B?VVZyN3BCUnpSTnJBVHBNMytMU1pBRjRsaHhaVGg4Wk1YQ0JUcFdWUFRqZnBy?=
 =?gb2312?B?T2RjRHRsWW5sRW5DSWxLc2xTOTE2WGthM0s1MWhKU3NSaFhGT3dxRTdkcVNv?=
 =?gb2312?B?OWVBS2tqVEM5VGp2cnRxbHBQemVqdnRuV0RlZ3FRQm9DOHpwUklLeGsxQXJ2?=
 =?gb2312?B?VUEybFUySUh4S2JQZ1p3YW1QeG5kYy9rZ3JFbFdRZ1NNeUE5ckJCbEpWRmdr?=
 =?gb2312?B?MDBsVjY3ZHBmTXpPRGRveUJabXI4VWxkZjMrQ3lpZEk4KzdWNHhWK25GNEpn?=
 =?gb2312?B?THBuQmdMS3JjTTlmM2orQXJ4akdJbkVTRVk5STM2S3ZOT0NhdFhhWEtvakFY?=
 =?gb2312?B?bERpZUNkTGhtejdTaEpQWjk3ZUlZM3kwdzl1bzdRSk9SUW1jN01MaDgva2lv?=
 =?gb2312?B?MXJHbE5ONkNoWnVDY2FHMDI1SUhjbGlvSzQzV1pCbVNuWHNJanVrRnY3bVo1?=
 =?gb2312?B?MSs0TTVJaXRlYVZSem1NZlNKMUE1TG9nRUxxRUFyd0lxVGxQQlB5YkdyUlhJ?=
 =?gb2312?B?UTZFRHFPdVYrbzdobTNxRGZ6QUJKZ2xHZklyMENxYkpiektPZW5YTXJFMkFE?=
 =?gb2312?B?ejJGZ0dmMTgzQVVxM3FlcmYzS081WE5NKy8wRUxvWDJrOEMrNDI5dFJQNHdD?=
 =?gb2312?B?TUltTGtQdkEwVlphaEk0YWxmQmczeXkzRDgzdzlFbzl6RmxFRy9FcUx3Tisr?=
 =?gb2312?B?aGR6YTlObUsyS0NuWVFqL1JCMzljTEkxRVhVNUpoV29tQ2NrRWY4d0VYbGJi?=
 =?gb2312?B?bFpZYmtINThZazlKVmZ1ZTZHM2dKekxrR3JzL3ZRcEluanVrUVo3RVdvQ2lR?=
 =?gb2312?B?R1RSKzM5VjF3ODBuU29rZGVrY2pFS0ZMZ2JYajhhNC9MdmQydXErOFU5OHoy?=
 =?gb2312?B?T1VIRnNpVkFvb2h5MGxRWStyM3BpdGd4MXRNcmVzbWdFQ25IcHN0WHdBTk9Z?=
 =?gb2312?B?S3cwb1JlUTRQcnIzTmxQZG1nTmZLOVlkQXZLdzlYZVlDLy9sRDlZT25Cd2Y4?=
 =?gb2312?B?ZWNMYnZtTGNrRmlGY1pudGQwYzBkUGJySDNvRlovMlJyaXlWNGp0TDJ6UmpM?=
 =?gb2312?B?YVpZZ24xTTV5dWM4dVN6aUZrd2o3Ym9WL3VUY01IamNtekFjc0k4cmtQWmlO?=
 =?gb2312?Q?zXbPQkkWu+gPG9MxkkWJ8WbuTREHnJMM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d84ba1-d768-418d-2dc9-08d8c19fded1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 02:12:45.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ozOaUSavnsGsDH1aHMwpPTP2sGA7zxA7ZGOG/bQysMQPq/eb2vhYC7qLRXUVueoSAO14ySy1YghGOLHMHHT+SMvdXaXHW2MXQvZ2WtRfSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4225
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGV0ZXJ6LCB0Z2x4CgpJIGhhdmUgc29tZSBxdWVzdGlvbnMgYWJvdXQgbWlncmF0ZV9k
aXNhYmUvZW5hYmxlKCksICBpbiB0aGUgcGFzdCBtaWdyYXRlX2Rpc2FiZS9lbmFibGUoKSBpcyBy
ZXBsYWNlZCBieSBwcmVlbXB0X2Rpc2FibGUvZW5hYmxlKCkgaW4gbm8gUlQgc3lzdGVtLgoKQW5k
IG5vdyBtaWdyYXRlX2Rpc2FiZS9lbmFibGUoKSBoYXMgaXRzIG93biBpbXBsZW1lbnRhdGlvbiwg
SSB3YW50IHRvIGtub3cgaW4gbWlncmF0ZV9kaXNhYmUvZW5hYmxlKCkgY3JpdGljYWwgYXJlYSBp
cyBibG9ja2luZyBhbGxvd2VkPyAgCgpJZiBhbGxvd2VkLCBUaGVyZSdzIGEgYmxvY2thZ2UgaW4g
bWlncmF0ZV9kaXNhYmUvZW5hYmxlKCkgY3JpdGljYWwgYXJlYSwgYW5kIHRoaXMgdGltZSBpZiBD
UFUgZ29pbmcgb2ZmbGluZaOsb2ZmbGluZSB0aW1lIHdpbGwgYmUgbG9uZ2VyLiBJcyB0aGlzIG5v
cm1hbCBwaGVub21lbm9uo78KClRoYW5rcwpRaWFuZwoKCgoKCgoKCgoKCgoKCgo=
