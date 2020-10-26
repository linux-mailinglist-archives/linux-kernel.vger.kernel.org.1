Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF14C299201
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785186AbgJZQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:50 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:63713
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2444361AbgJZQLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:11:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZmc570ish1sGadi4VfRTZfCaxzca6q/sgx1qBpN3qtC3JIL9wTZ75xG9dkwyuaqXKkEeaWIZhewoFQaJ0oOjQDKQ1/Ht3x7vtjNpCeCunu10soSE2G8iWRCIhtP/BAHTMMs7T7tGi40VYQU3kejy1cCsjOtTj/fkCdI6/LQEH1L3hpz6mkHruMCa0H5OOf7VZly0ml/TKBpxKF0CjwQFJIW1QZSQRhWmAujOOFLbuDcj7k+l5ulgl/KU17cpIhQfcYbxmhSEvLkO/FYK77RBuDnbml9+SUkEV/nMOcWMlP5wt7cliHenuKkXUn5SLoTm3kRYvFpVkY4VZ8dFzjoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTEyxSMBlHqU0f4P8pI82i5nPb3rh9TdkxZIHFw0aZo=;
 b=RpVma31GmIN5pe4QDGG7Vz2E+EkbbDwnxunLa5toOx9WAi6IwVptwtorTNNCaFgpwbTOba8q0CYQiiBSB+uU2Io1JpZiuK9JXWokv1EdrBYlGvpBtAfXszZFTSEpZgJrm8R5TzqR27VeZ5ehXuJkfezHZ5FAOlYjzjByxQ+zveCgiGGuaYrjzlpeSOoKmk8a0QEEQHppdVH15YH/wuUCSiXNfn7CI0PTPOe0pYhWjB9wBDpsia5K+3Ku448hrhE1MPWcEhTySszPTVcw0u2SP/0e7Mq2D74AURaLjydIdRSNW2L0Kz2d52iFBVsHxXwcu8ohaTDDK4Y12CSSH7JeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTEyxSMBlHqU0f4P8pI82i5nPb3rh9TdkxZIHFw0aZo=;
 b=iextC2/5nMycOS+FgnSuZtTGRLJnQuQfUEWpussyIhM1BVpMyLWyKzfrU+DONVyqVmuymzNvqaElZAOazQRIGBk+bzccjtHt4NawhkvFAgmZ9Kju2AFO4hKpMdHH5swc1aUEQCnVx/jNl0x06Oss8ArhQaSsHvpBVml4UZ5wEYw=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2863.namprd11.prod.outlook.com (2603:10b6:805:5c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 16:11:18 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 16:11:18 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] staging: wfx: avoid uninitialized variable use
Date:   Mon, 26 Oct 2020 17:11:11 +0100
Message-ID: <1716365.mxtkSTacob@pc-42>
Organization: Silicon Labs
In-Reply-To: <20201026160243.3705030-1-arnd@kernel.org>
References: <20201026160243.3705030-1-arnd@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [37.71.187.125]
X-ClientProxiedBy: PR3P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::24) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (37.71.187.125) by PR3P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 16:11:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9804015-68df-4536-3db5-08d879c9c59e
X-MS-TrafficTypeDiagnostic: SN6PR11MB2863:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2863C55FB28DD4AB48DF098493190@SN6PR11MB2863.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuSg3m9JVQKSEamt93M94sTObrbukM6uf2z7Rgkj0nLnEMsJ2KH1Pe3v+r7Y73F6ZhJC/MW7tYMsDUOUlcnCtDEiiAHm0Zz95vaUvgZ4euJtwW5H88QM4aHsZtOKysdMwCvAXtIW2UfTw7co8j0JRNx/2VViTgYoHUJ7GPPGUQYfvt4Mpn5zOMXc3nisX483kaWobLxyILx6I4giTx4eSVYTntp8hU8YTL5YqUhtgMcOjgPSVnps72AZeclf0skFWKSHZryv/C4dfUHBnC3hFEAFiQaBt4D9BMb/+1HBPCx7DaxEO0Gv9TZYYS1KrKs5LvWWru8GibEUBvQULP7jdWQyazjOIZe/+ihFuwSMbijbRzI7kV28qzfPAlJX4GjieKw7QjgtMz8ctEbgwAr0xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39850400004)(396003)(6506007)(9686003)(478600001)(54906003)(6486002)(186003)(8936002)(2906002)(26005)(966005)(4744005)(8676002)(86362001)(4326008)(316002)(110136005)(52116002)(956004)(16526019)(33716001)(36916002)(66476007)(66556008)(5660300002)(6666004)(6512007)(66946007)(83380400001)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FpyRD3HbuN0CPiWczUqbuDkrCY8Pl2rt9tsC9ehjJa5W0722vQBNFG4QRVq7YUbG6RW+DWrk7OFQYguHqlOSZ3prO8kk4uKUNuLVetHDkfBSlsNr3SvGMt+7YcReGfQMxCIr5PL9YeT3gQYIJ9dDB4O4bed3gCPULVkGU8YKZxfdOj5FbSudTQCNq4oydAoKVQg53gDl7Vdu3y5R7rwx34xCTecqSNhL6/o9OTQUhv8i74DL2JoYvTLJc8Gg57bVdqPNb5CFurQCoxd3qY/w8uXn3Ot/Y5eCkxr/j7apzPK5wLspUS6uuHsqt7ZERqI0ItFOYyMiWYY9HZCma7Yw2Nhrr132EV7FCHLsSYAAqZSx4RODu4cxnXnhjJWPc/5j4RBdC+obBBqebZiqmx1XyEh2PLlyi+SXft1DnKAJIkjgGMTz1alkIADFGebG5J0MjcwF6tuhJrtytXAzGEKqv8jvA4G7LrLVqZaGqYvfZ85VZ2hwM4G2A2YmMMrCg23hE2YnwVkKX2TDPO2wVv2PNe4NHsqZjZHwRLF+d2C92pHezKDK09BzsLdO+uBnGsAqfM5myhcK6ZfWwTP9jg+fPU32+QPMUq4xsDpMpXe+vsRuHnoRqHCgFQ1zNzDfAngVElonPouSt7TS5YDyPZUwnw==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9804015-68df-4536-3db5-08d879c9c59e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 16:11:18.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va37iIE1OXTh6D5JArV0M8TvEmmX8zK9bDpgPugMK5TZUbcsRJilRXjzdf3yfmAzpwy3v/pzz75CTRQpIIX5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2863
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 October 2020 17:02:22 CET Arnd Bergmann wrote:
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Move the added check of the 'band' variable after the
> initialization. Pointed out by clang with
>=20
> drivers/staging/wfx/data_tx.c:34:19: warning: variable 'band' is uninitia=
lized when used here [-Wuninitialized]
>         if (rate->idx >=3D band->n_bitrates) {

Hello Arnd,

This patch has already been submitted[1]. I think it is going to be
applied to staging very soon.

Sorry for the disturbing.

[1] https://lore.kernel.org/driverdev-devel/20201019160604.1609180-1-Jerome=
.Pouiller@silabs.com/

--=20
J=E9r=F4me Pouiller


