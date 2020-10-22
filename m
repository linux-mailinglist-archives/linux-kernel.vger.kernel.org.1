Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA0295A57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507777AbgJVI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:29:30 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:5841
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2444569AbgJVI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGoYEOrT96rkCrmWrVdS3Ox3JODt/wXW3ZFE1h2fZ4=;
 b=2nJbxlWtiHwJE5Bb9CCLGWIM6EsN0IliRFSNMIppb3psoqi7dF1eQQ9eIhMnmHhSxOvh5cgKEA0v15ERaCWAld11L0mxwm9LqjKdq4/SWtHAdJfYox13UuPxG22sWU0zOGx3UEQjH6T5Xtw1OAirGVjFu3uCroVGV/E5Sqb5BPs=
Received: from DB6PR0202CA0040.eurprd02.prod.outlook.com (2603:10a6:4:a5::26)
 by AM5PR0801MB1779.eurprd08.prod.outlook.com (2603:10a6:203:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 08:29:25 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::4f) by DB6PR0202CA0040.outlook.office365.com
 (2603:10a6:4:a5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Thu, 22 Oct 2020 08:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 08:29:25 +0000
Received: ("Tessian outbound 7c188528bfe0:v64"); Thu, 22 Oct 2020 08:29:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cb270875d4d9ffb8
X-CR-MTA-TID: 64aa7808
Received: from ddf8c3127fda.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AE1344C3-D1BF-4D62-AE29-7C32083ED776.1;
        Thu, 22 Oct 2020 08:29:17 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ddf8c3127fda.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Oct 2020 08:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXOgQJJrWBS18vEAw0JaNQNbrXC0twpAyna/6ZsrsPAwicAEZsInYCnBbRy54NBEUEanlWCXXfjoxIsks9OT2Ap69XjS9PNGzgUYMzu9wXfSSPnsbHPzyRojXndjZJVlDi/f27Pf3vJjJKwmji9+ATK0/Hay50hbVNYFTYe1+IBWP51bWw/KTdhe/vGyMI07PWJHMfE5/RwMQLSH/HD7UHVjshX5kce0P90ZHITduDwlDeKf7HYTWJkew58SFLIQNQNr1z6/TiNQGwJbKvWJUWAMO4/M0zL9ipFxw6uiAm3amf8glbNvIoIRrkJlNFtAFPSFceoNPX1a3JnuGNnr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGoYEOrT96rkCrmWrVdS3Ox3JODt/wXW3ZFE1h2fZ4=;
 b=ObaJY2xMdenkMQB1XE6mkkOql2zVngRCnEqFQDShurEZpkYJMj+0IFrXM7EjZUu7hvt5g9/qieKuEmMbtneBaigw/mQAEYDK45iTfMcBo31eycK9hzXqibxtrjl5nWVHesnXCW0a5noH+6jBEbadTN+Bpj/v5LEGblchG1xb4p7MtJ32XU5Hrv11Vd+5GR+jrrQMfz4fWG5Qf4WIBZNK3Z4JnubFzdmaiEzuBBdKohsdevuRNHoK60XfYU8YVshSKorC+ITfLMVQ6CPExzOwAtc0wUjuGXTFV1xXDh3XTCoEQaTBPMCzge0wjVlprxNy3F4Sh5OY4QcgM6TjCTq0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGoYEOrT96rkCrmWrVdS3Ox3JODt/wXW3ZFE1h2fZ4=;
 b=2nJbxlWtiHwJE5Bb9CCLGWIM6EsN0IliRFSNMIppb3psoqi7dF1eQQ9eIhMnmHhSxOvh5cgKEA0v15ERaCWAld11L0mxwm9LqjKdq4/SWtHAdJfYox13UuPxG22sWU0zOGx3UEQjH6T5Xtw1OAirGVjFu3uCroVGV/E5Sqb5BPs=
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 22 Oct
 2020 08:29:15 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 08:29:15 +0000
Date:   Thu, 22 Oct 2020 09:29:12 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022082912.GQ3819@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 08:29:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd356d35-32da-43a2-c548-08d87664959a
X-MS-TrafficTypeDiagnostic: PA4PR08MB6141:|AM5PR0801MB1779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1779AEF90662D4228C740656ED1D0@AM5PR0801MB1779.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k/IN4WjNFdYnmj9Yh7XEXnnjmpJnhFv4xUxs0iI8roha6WGR3nibmK4aNGXJ7QO1eqFkmQNqDgUPq3QdV9kwzd4U03cbyxMManqOfE9XVujQlEM8zwpudIaanUIzBqWGSZ4zLkfbXP6LLT3ijhZG0uzlzIqBmxl63FsrSmXpPkL+YsMSeGDcrkmxMuDAEv5HkbvBgt+3f+p9IJdZ2oM3xP/BCbfV/zqY7tV/XeOTfP+kCqMSbf3xbh1At/bq85ht05gYsxE+bDKM9sw1+C5Kjysl2TKG2zTC9rSyxl6g0TyYhPTKtS16bPs/fly5V6yrdRq5ebdZOqidJzmsvm578lF81hnz0nicgaZvYRN505UA+QtKGhk3c6oDfTEpuPpB6nirDXjUzXJK8xymWfLuXw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(966005)(5660300002)(2906002)(8886007)(55016002)(26005)(478600001)(1076003)(186003)(7696005)(52116002)(8676002)(16526019)(44832011)(66946007)(66476007)(66556008)(316002)(36756003)(8936002)(6916009)(4326008)(2616005)(33656002)(54906003)(956004)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d3QTZM4x8ULLVxRHSmMIEofvqV6OeiFp/08wPg72yRYq5l9n03l1Phdoi1KLElbEonGTALNoJnKgsqxSgDOp+VVtwaah5PMWmV+TsMgF5ppApnGXRapdGDmPfvONrcVWE9ZcJ29iOtY76dkOs/LrLIA7bjAYCIrmZJLZFCJvHxT+jkd2ChDB+tHa1EkEA4W0RVFtPfwaeAsVw1usPRqUBH+5ybEutH2E6hwHbtpnqiL0emyc6tubB+XMkA1V/kaAtn2k53Mu9O7MdV8D2ZxmS9/mDzFX9YpCwIJ0241EuvzV6g9T7Y/bV1ahIZtbMFTY2esQDgFIpGEGpVhsSPwfeRsFXMv9TZZV9Yc6BH8FY13FJoLWNmJ9jgkTSB+fpl8vJGVit04Iw9xi8AT5W0JIm7OcPaiYh0yrDzwt03YXGmSCzUy6kHV3PTPFnFpcPv8R9PPSqrO7mcDh4eJd6qh8XiaA4M37jrWsPbb92JMJzY5XFPzm56qSa+R9117vDxMUAL/8mOD399njuXitGksXcXn4SDtbBJCySUhtbkdcKENqr6gZTeEpuIkw+KBiv23tylMhApWZl2w55gDJ4HxGo3K1hB/RSBwl5PqDM8gcZ9WklcXmhvYAFXdu8anEe8R/i4agcli4D6mQEhBqlAp71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a7b3ee6c-c4f5-45a4-4383-08d876648f6d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YytYYScXINyjpB4DOaeoeOXH6SfVjjYO6jeoXDB55RxEIwuavSSS7lVM/a+FCJmfujnllJz86HP42NiQrti1pBSGD1lgxVG1oqWXiK+ob8m+YaC9j3R0fKB1jTEJduXjmDV2RS2VaVBCZx/A5RAoNmVCwwlvVcKSL/WfRWn9QWwAWdLBDnw+eU+0PLH1PY7yKzQDu4Q6nwKWUuUX4OrBqf+I0yp/9SPx5Geb1upQTYdkzPCJWf7wWOyZmre363NJntOqFp2CTwbMo6c1eoP/XJTfpmHlwoO/MRTe9bUkGJLrkI1IXqunLIZpUPfzxqt7WN/pmVzhJBFJ8EIUMr8ER9qR9OeelMihqbQbVXy4HO0OauPqYIriXNUK5rIvHblxekqUshD3avXZIY/cgoJOexQPJUyd+MwiZ+qCQusfcZDwi+2YufDaDUeFXVqMiwz41t9ygst98EvOxWC9RpG4CTMwx9Rvg6yi4OyxMw8Ad98=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(966005)(336012)(316002)(47076004)(8676002)(86362001)(81166007)(2906002)(5660300002)(82740400003)(1076003)(107886003)(55016002)(6862004)(70206006)(26005)(33656002)(956004)(186003)(4326008)(44832011)(7696005)(2616005)(16526019)(54906003)(83380400001)(8886007)(36756003)(478600001)(8936002)(82310400003)(356005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 08:29:25.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd356d35-32da-43a2-c548-08d87664959a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1779
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/22/2020 11:17, Topi Miettinen via Libc-alpha wrote:
> On 22.10.2020 10.54, Florian Weimer wrote:
> > * Lennart Poettering:
> > > Did you see Topi's comments on the systemd issue?
> > > 
> > > https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
> > > 
> > > I think I agree with this: it's a bit weird to alter the bits after
> > > the fact. Can't glibc set up everything right from the begining? That
> > > would keep both concepts working.
> > 
> > The dynamic loader has to process the LOAD segments to get to the ELF
> > note that says to enable BTI.  Maybe we could do a first pass and load
> > only the segments that cover notes.  But that requires lots of changes
> > to generic code in the loader.
> 
> What if the loader always enabled BTI for PROT_EXEC pages, but then when
> discovering that this was a mistake, mprotect() the pages without BTI? Then
> both BTI and MDWX would work and the penalty of not getting MDWX would fall
> to non-BTI programs. What's the expected proportion of BTI enabled code vs.
> disabled in the future, is it perhaps expected that a distro would enable
> the flag globally so eventually only a few legacy programs might be
> unprotected?

i thought mprotect(PROT_EXEC) would get filtered
with or without bti, is that not the case?

then i guess we can do the protection that way
around, but then i don't see why the filter cannot
treat PROT_EXEC|PROT_BTI the same as PROT_EXEC.

