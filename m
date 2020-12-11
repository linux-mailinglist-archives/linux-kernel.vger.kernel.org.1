Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBD2D72E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437430AbgLKJe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:34:56 -0500
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:17742
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405618AbgLKJeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0NGlFtaX9S6HQB1ttjEbafzd+6rL5R7qxOmL92n3Uc=;
 b=fbhUDn2YCRFwiLJCSfwD74zcmx3LsbOah2lM0E6erSk74mNLEntA5FePyiFQGLoRwk9fIHJR5L8Qlcw44gn0HJNPOLxCh5vW7FXnlClRTzurQmJuYUAkKnt/ixvkIJjRstY9QhReM7E/9GPuoVcQ6TP5enM+QBLcpN6jICYAfLI=
Received: from AM6P194CA0043.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::20)
 by VI1PR0801MB1760.eurprd08.prod.outlook.com (2603:10a6:800:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 11 Dec
 2020 09:33:23 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::f2) by AM6P194CA0043.outlook.office365.com
 (2603:10a6:209:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 09:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 09:33:23 +0000
Received: ("Tessian outbound 6ec21dac9dd3:v71"); Fri, 11 Dec 2020 09:33:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4666d5f4ef21b8db
X-CR-MTA-TID: 64aa7808
Received: from 6e6afcd7e5ce.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B7A61146-A6F6-462D-A27C-16BF00E4AE1D.1;
        Fri, 11 Dec 2020 09:33:07 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6e6afcd7e5ce.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Dec 2020 09:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLs95G+KjJxrAMh5WpzNdDHLjBsUHy2+SqF+clw8PbOZQr+u/YXBtkDfkBr8fa021xmNscSwJ1yEo01zJ9Hebupexmw0PDjENXJ81u4O7yNx/jU6oT3zKwN+rK7WDF8ipHRvbZdmRv8rPJCWFsIUefNThfuBqRoQD11d4H502GLXeoEetKGVp4JEOsOAwm8Kfm56sQu8RCBEkTIsVQEytwpK634EdiYRFIe4mNaxTZpGcfXIjbA6GnBwhp7icle/XPs4mNxIZL1yD1cvxACTXI9nKx7lQ6fzG1J/Ps5QeD5/53GHwRCR3uouwQzUcsHTyQgnaBlSS5F7a8Fb8NJ9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0NGlFtaX9S6HQB1ttjEbafzd+6rL5R7qxOmL92n3Uc=;
 b=A4T/s0trw9rJagmRxHeOh56VvT4miv1wwTezQH5OcZYS+hKQsqPvMU/zXyV54wqKNhuHbfCvMkjf6bn5pKTE0LzdSwLyVNdqkWsP60uGakAiu+6u/TGM/DXDI19ALEuiWsNTjGr1USc1Fe2dCH7Pz22jap1IS1XPxKyE0vVz21tlkCstNVvDmxqFv4mzsjdMN+2GoAqmDQVbYUG49juEShZFM3r9NGmEXwGDaesmSXqIkZrICEYxljc27ErhB1BcC8hLN2Zkk2+s15lZ7im4UIUt3hWcHW2Xfl3oaClLLJgZZUb91BjscR7vxaL2Q1vaf+SxjEhUo+Qdk7/jTXwtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0NGlFtaX9S6HQB1ttjEbafzd+6rL5R7qxOmL92n3Uc=;
 b=fbhUDn2YCRFwiLJCSfwD74zcmx3LsbOah2lM0E6erSk74mNLEntA5FePyiFQGLoRwk9fIHJR5L8Qlcw44gn0HJNPOLxCh5vW7FXnlClRTzurQmJuYUAkKnt/ixvkIJjRstY9QhReM7E/9GPuoVcQ6TP5enM+QBLcpN6jICYAfLI=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR3PR08MB5851.eurprd08.prod.outlook.com (2603:10a6:102:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 11 Dec
 2020 09:33:06 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3654.013; Fri, 11 Dec 2020
 09:33:06 +0000
Date:   Fri, 11 Dec 2020 09:32:56 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] elf: Fix failure handling in
 _dl_map_object_from_fd
Message-ID: <20201211093255.GD24625@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
 <8ebf571196dd499c61983dbf53c94c68ebd458cc.1606319495.git.szabolcs.nagy@arm.com>
 <1525639f-560f-2677-b1cb-f904b3552c71@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525639f-560f-2677-b1cb-f904b3552c71@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: DM6PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:5:190::26) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by DM6PR11CA0013.namprd11.prod.outlook.com (2603:10b6:5:190::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 09:33:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf0b2c1c-6a85-41c3-5395-08d89db7cdf0
X-MS-TrafficTypeDiagnostic: PR3PR08MB5851:|VI1PR0801MB1760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB176061D2C835038D5BEC841CEDCA0@VI1PR0801MB1760.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SJELLdooa0Sa6urSNkHQ6cEYJuYQ9FmWUm8q8lq/BIRFWmqjP5BgNwRMbRMEbF57RNTH7tdc8Qg7kDKmvLyv782SdEhyEnVoCWgAuW5BrCxTfvIDkWmo+uFzKmx6uBoxNxLcOAAfqmU85qfyePKPq5wjw0T1ZjHalYMIlIuhMidt27yqQkpTmxKrFSql4WsWNk4DqCrNo1H/KP2SILczDPPnTmkhbqDEIrmCBDSk3U9FpkaAMmbRA39Bkedz3IDiHqfG86hFHsS6iZ3fM+DVUm7GMU7Yi3KB3AHlxixQ/BSH1KGJJyu3WoRlR042NQrG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(366004)(2906002)(186003)(4326008)(36756003)(33656002)(7696005)(956004)(8676002)(26005)(52116002)(66946007)(53546011)(66476007)(86362001)(8886007)(66556008)(8936002)(55016002)(2616005)(6916009)(16526019)(478600001)(6666004)(316002)(1076003)(44832011)(5660300002)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmJCU1FqUUthVlhGWjBJZ29rRzcwNlluRm5oemtXVjRpYko1NWRESTFnenV6?=
 =?utf-8?B?V0lnNi94eENrdzZjN2xza0l1RVNwZ3I4NmYySkpYNnlCWGltbWNVYnBGeWtC?=
 =?utf-8?B?Mld0ZlJpNjBESVJVR3RScGFLaTVWVkNQb0lTWFhNR0NDMm9McjdFZ0tzaXg0?=
 =?utf-8?B?dmpEOHp4WnNQV2o2L2RmMkRUMnM5RFp1ZGlUUHlmOU1UYkdTSUwxNXR4a1Y1?=
 =?utf-8?B?TS9LKzVrbkl0WWEzMm9YUTVPNHZYV0pZa1AxbVdsOFphL1NKZnhDc0FtUWNl?=
 =?utf-8?B?U21nMUd5YzFRTGJVNHJlb3lFMkZ4SXN0RWl3VlpkUzdZdWQ0UElvaWNTRitH?=
 =?utf-8?B?YnR0TlowQ1U0UXhZOU9pM2JWRy9ubDhNYjk5elRYQ3VOeGUzWTBnODltWDZO?=
 =?utf-8?B?SG5peG5iSWhZTDlpK1AwWjJEUEkyYUFJQnZWYjd1UFJhaTJXbWNoc2Z2RFZn?=
 =?utf-8?B?QTNpM2syTHhyQ0ZyU0NFQU4xZFF2VkQrdlJjZ1FzUXlBR1NpS0txMklZL1pG?=
 =?utf-8?B?eTIwQWZWbVJVY1VwdTJTSDZpckxLNW5LY25SeG9LRWtyMjVES2krdnZZTmhI?=
 =?utf-8?B?b1BiZmJxejU0NVNzdnpNTlFNdk0xL2FxVk9jNEExdEQ1dkZ4NWhtOC8yRWtM?=
 =?utf-8?B?V1FNcGhMMnR1RGdKZDhUUnlxM2NPT2taRkMzZGp5ajQ0bDdUL3JiWDBVbVla?=
 =?utf-8?B?MmtsWk9MNTFmNlJ6aDJVUHJiZ2VpZ2tta3lWQ3crVFlvQVNvTnR6MEEzNGpF?=
 =?utf-8?B?N21oWUpibDdPbS90RzNFZnpRWU5oM2tGOXMza1oxL0dTWlIycHdEUEIxaUdp?=
 =?utf-8?B?MHhGVHJzWlQrbXhnZGZLTkFDWnBhekFpQ0xMSld2T28wc2xSbUFvS1pKUzRE?=
 =?utf-8?B?N3VKbEh5a250UTRZOGJWVnpzOEZCZ1F3dXdqVHB4dzJJeWViUlI0emY2ZXFT?=
 =?utf-8?B?RU5ybDcvOHBJOEFObzB3cXdobG9rMDRmZ0g0Ni9taGtyT3I5L3RmM3Y2U0RZ?=
 =?utf-8?B?eGdjdXc3VEZlV1Z3S3VQdnVjejNhMnhXcGpERFJDSzZFZC9QYjBtaW1JYitT?=
 =?utf-8?B?ZnFMbXduUWdrazBGd25qcG8zb0dwaXBtQ2ZGbmRHNXRkcFh1MmVFREhLMDhJ?=
 =?utf-8?B?Zjh5d0NFU2l2ZVNCMTd5aWowNGdYbW94bUVxQmFFaXlqYWVkcVBvaldQdk92?=
 =?utf-8?B?d2tGZGx1QjA0Q2xBYmVKZjFtT2ZiNEFZdzhWeGRRR01WVjJnL2FxWStxVk5U?=
 =?utf-8?B?VnVmS0xNN0hONVV5VlBEek5ic3VwMG0yRitPU0ZKMFNxTU81cmtsTlpSTVo0?=
 =?utf-8?Q?AeI91gr6Brg18YwqAH+IPZi7krKzlgmL/a?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5851
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f637007-6c6a-4eb5-6bc6-08d89db7c3b4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lORTPsAfrwFFR1jCNodQCuAiM+0KGrBl6+2U2Wk/kwHOAMusoUEBBU3BUeqvnRwD4TN7n7T62+3LK2e6qVm1qo7U0Gy2l883EYZgucHRFPm8sARxYZcXL1v7/BfRACXMkf1StB65iTmA2HprIM7w3JIdyNHQ31HHJ2A7OCmFeXw/5mw4+fe55q6FlfYdCYnWsdm1yy4KjvNAdRhCXJ4+gsJhuZw/8uN0RPnA96RBfRzrafceXSjQnKO71wKBKxLlhZET4W0mcmsQAjMMHMsHCdFs3xF6qunUjFTOP/uwpLTbZC1X4V/E6LsJGYlEVxUFGgcphEaljSkxOLtRKITwAJSpiY6ipFDPsobDRIrUeuwLVsiTg3cvRmUCSYlLOYlgqB4RMkBh/MsX/aE1FCj9Yg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(396003)(346002)(46966005)(33656002)(8936002)(16526019)(6862004)(956004)(8676002)(86362001)(36756003)(4326008)(6666004)(2616005)(5660300002)(8886007)(55016002)(478600001)(47076004)(53546011)(82740400003)(70586007)(82310400003)(336012)(186003)(26005)(356005)(107886003)(54906003)(2906002)(1076003)(7696005)(70206006)(44832011)(316002)(83380400001)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 09:33:23.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0b2c1c-6a85-41c3-5395-08d89db7cdf0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 12/10/2020 15:25, Adhemerval Zanella wrote:
> On 27/11/2020 10:20, Szabolcs Nagy via Libc-alpha wrote:
> > There are many failure paths that call lose to do local cleanups
> > in _dl_map_object_from_fd, but it did not clean everything.
> > 
> > Handle l_phdr, l_libname and mapped segments in the common failure
> > handling code.
> > 
> > There are various bits that may not be cleaned properly on failure
> > (e.g. executable stack, tlsid, incomplete dl_map_segments).
> > ---
> >  elf/dl-load.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/elf/dl-load.c b/elf/dl-load.c
> > index 21e55deb19..9c71b7562c 100644
> > --- a/elf/dl-load.c
> > +++ b/elf/dl-load.c
> > @@ -914,8 +914,15 @@ lose (int code, int fd, const char *name, char *realname, struct link_map *l,
> >    /* The file might already be closed.  */
> >    if (fd != -1)
> >      (void) __close_nocancel (fd);
> > +  if (l != NULL && l->l_map_start != 0)
> > +    _dl_unmap_segments (l);
> >    if (l != NULL && l->l_origin != (char *) -1l)
> >      free ((char *) l->l_origin);
> > +  if (l != NULL && !l->l_libname->dont_free)
> > +    free (l->l_libname);
> > +  if (l != NULL && l->l_phdr_allocated)
> > +    free ((void *) l->l_phdr);
> > +
> >    free (l);
> >    free (realname);
> >  
> > @@ -1256,7 +1263,11 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
> >      errstring = _dl_map_segments (l, fd, header, type, loadcmds, nloadcmds,
> >  				  maplength, has_holes, loader);
> >      if (__glibc_unlikely (errstring != NULL))
> > -      goto call_lose;
> > +      {
> > +	/* Mappings can be in an inconsistent state: avoid unmap.  */
> > +	l->l_map_start = l->l_map_end = 0;
> > +	goto call_lose;
> > +      }
> >  
> >      /* Process program headers again after load segments are mapped in
> >         case processing requires accessing those segments.  Scan program
> 
> In this case I am failing to see who would be responsible to unmap 
> l_map_start int the type == ET_DYN where first mmap succeeds but
> with a later mmap failure in any load command.

failures are either cleaned up locally in this function
via lose or after a clean return via dlclose.

failures that are not cleaned up will leak resources.

_dl_map_segments failure is not cleaned up (the mappings
are in an unknown state). however after a successful
_dl_map_segments later failures can clean the mappings
and that's what i fixed here.

i did not try to fix transitive design bugs (such as
leaks in _dl_map_segments) that would require interface
change or local cleanups in those other functions.

> > @@ -1294,14 +1305,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
> >        || (__glibc_unlikely (l->l_flags_1 & DF_1_PIE)
> >  	  && __glibc_unlikely ((mode & __RTLD_OPENEXEC) == 0)))
> >      {
> > -      /* We are not supposed to load this object.  Free all resources.  */
> > -      _dl_unmap_segments (l);
> > -
> > -      if (!l->l_libname->dont_free)
> > -	free (l->l_libname);
> > -
> > -      if (l->l_phdr_allocated)
> > -	free ((void *) l->l_phdr);
> >  
> >        if (l->l_flags_1 & DF_1_PIE)
> >  	errstring
> > @@ -1392,6 +1395,9 @@ cannot enable executable stack as shared object requires");
> >    /* Signal that we closed the file.  */
> >    fd = -1;
> >  
> > +  /* Failures before this point are handled locally via lose.
> > +     No more failures are allowed in this function until return.  */
> > +
> >    /* If this is ET_EXEC, we should have loaded it as lt_executable.  */
> >    assert (type != ET_EXEC || l->l_type == lt_executable);
> >  
> > 
> 
> Ok.
