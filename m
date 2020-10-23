Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23271296993
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372228AbgJWGNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:13:34 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5983
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2898399AbgJWGNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGI5v4C3s67hzaAPFM5NOxhUyVogZl2FQvTGIRk6tTY=;
 b=ck8qNqvMRkobToEP2jmrEbjfVKYNSBa8ykwOYBai1MfmvTx1HLyDSYIISHwYeYLKBBk4QVDm82nbQS78EWfi1tVDJlFJ/zn5L5lKNKNOTnJN73tCnHYSCzpKlBlxoScT/mSt3ki1u6sShm7xu/PCLTjs/LlMQPXbSfYXD6iK2cQ=
Received: from AM7PR03CA0013.eurprd03.prod.outlook.com (2603:10a6:20b:130::23)
 by DB6PR08MB2805.eurprd08.prod.outlook.com (2603:10a6:6:20::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 23 Oct
 2020 06:13:27 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::67) by AM7PR03CA0013.outlook.office365.com
 (2603:10a6:20b:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 23 Oct 2020 06:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 06:13:27 +0000
Received: ("Tessian outbound 68da730eaaba:v64"); Fri, 23 Oct 2020 06:13:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0326b32da17b340d
X-CR-MTA-TID: 64aa7808
Received: from e9aeef0569f2.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 91E9E363-1CA9-4422-BE53-30A67A1C9035.1;
        Fri, 23 Oct 2020 06:13:19 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9aeef0569f2.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 23 Oct 2020 06:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPtiyWOTWk92VfVXUpHM+EafXF6GV0PhPlLQjDXyhwge/TdzN98QGAq6LhlwksFFNNHyhJt8j7DdV7/57mKAd/XwKzimE6yxclTkGvlXjKVNAANZujScuHNzg31UBerHXHrcMwAcMj2wzmNJXIpz+SoZW2mFfzokKtkL9+A9qWA3y4FABwQFiYCjjBh2QK+D2kt0RlB0xZHh0yhEWfCBDq2hjmy2yy+3K762a06yy/wyjsafWjvhxAqEVJHepuHru6zw+3OgwwX9DcA3J9PDNJ+a6sUL12Z3bf/T8E0SqRcfGYnxXPPO+oPcshzI4t1SJaV/1/K+lISSqIflkM0VYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGI5v4C3s67hzaAPFM5NOxhUyVogZl2FQvTGIRk6tTY=;
 b=VEOQdiGf5jui0q8qFMu7K1hSGWpTYW/9Yefwui2mWNFG48O4msG+dSdv+EbtVD+xzTSLphqB7dATVCzHmyx+uV/px48aJE6M2hmrzDgiMF0u0A05YkTwo6771zeJyWnpbLsfhSkAb4D9eHznjW1AnHkaxeXYzULDThPw0lVxidqn+E7m0mDhr9D8Djx3FOiyYmXIa/IK+YHE4glyOBXGtbECQ/iSY5NXyDmvY4/mSa40oExaI63FR5w2/F2M/3NTiTe6m7lCaXc01/QfLfRcgHLgE9zXb34Xx6xFCwDtxgrzwTzk+CkcWATxvonPipMJn0fIzxzDd11d43T6eVfmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGI5v4C3s67hzaAPFM5NOxhUyVogZl2FQvTGIRk6tTY=;
 b=ck8qNqvMRkobToEP2jmrEbjfVKYNSBa8ykwOYBai1MfmvTx1HLyDSYIISHwYeYLKBBk4QVDm82nbQS78EWfi1tVDJlFJ/zn5L5lKNKNOTnJN73tCnHYSCzpKlBlxoScT/mSt3ki1u6sShm7xu/PCLTjs/LlMQPXbSfYXD6iK2cQ=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 06:13:19 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 06:13:19 +0000
Date:   Fri, 23 Oct 2020 07:13:17 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201023061316.GR3819@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com>
 <20201022083823.GA324825@gardel-login>
 <20201022093104.GB1229@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022093104.GB1229@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO3P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::23) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO3P123CA0018.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 06:13:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 434cd07d-934a-493f-baa7-08d8771ac18a
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|DB6PR08MB2805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2805F2C3C007AA959BE6E0A2ED1A0@DB6PR08MB2805.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Mo1L8Dce+xHQb76VA3E0qpZwU5xLDi+qxZWiuvxgHGd2/JANbQQNKA+oeXVx2FcHAMYNAq/Xxbm6nzpD9FVGxgsG8GtA3S/OUywqCGO9FD1zrWGbw50Guh4HKVrh+aAqg6XvN1nkn4qUQSOxsk7Sl4XbLwzn1SAGdJzm3kU8T5o4p8V4CQYGHxSmxKj/VQwS5JMSwgzBnM3KhymXQOMjlbNeF8IAUla5fq1F6EvL3ChPRRYIcne4aqEzKDCzZzsM9pK0ldp8uHQojN/a7XXIeg+6zN0TucscDGAWJ8Yb+XQza03coWESNe8OV4bl2onwqMyjmrjpH4I+xgi3cRUkmQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(956004)(316002)(52116002)(54906003)(44832011)(5660300002)(4326008)(7696005)(33656002)(186003)(26005)(16526019)(8676002)(478600001)(66476007)(37006003)(66556008)(6862004)(8936002)(2616005)(66946007)(83380400001)(86362001)(1076003)(6636002)(36756003)(8886007)(2906002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kD3pCqYs44WU7S7mDA8+JmSW/4jy6Ok1+ZP9Ga2+bQuO/1BJyeEcotKPwl714pldjz0RNSM//Lk0fS8NLGw8TnDfeGgZ2cI3751hEO3U6wyuWGLxj6gtVRjuX2DY/jpsoMm80/+RPftfdm/rXOhiHdRKs5TIro+HNFXqPyxsmYfAS+Lc5IAlM93/EDmyNVkZ8WubV4hwL9jsa9AoScZxQRObT7Xxjj9hDlEsNopAUgM9MNZFWGccvdpqTY34RF92z7fKl/kc+h7gzVjO/+tNFlFKuYro/vUyIzyNSczkwtLUBwAqJIqfDtwj7oICR4VcePEvghshCvQf9drY4BFezPzwkPMLY3VX/beggSBh0+w0S+CV2Jgf0hFw5bUcy5cwyvcfmfxZb60OKYtDieh6Xdl7B9N9sSYgTGpJGzjy5C2TZJkGGv3hcB97VN95FOZbkgEGrzbGuMbVtrJOtC0Hew0ZD9XUi4RNFoI3gtnHQOGc72MEFxRpwtpzo5H2ECer5+cEBtnRgaYx+lojv2ZARn2hPrGHjMYJEeNFQMhTHSuYdagEwNk/gR0M6ghgqZJxWwMRTtnx6bTNWqKp0zI3FDu8Gq+LJNtVMzNlyk125YH+IGvD+BShXcUkbenafOG/lH98brEQTwda2+XCuiUNBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2f59cc67-e0ad-4d78-c899-08d8771abc77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAIQOopmgfpgPC3nWTPZ64uqhGDKVtC9HFzc067Eht+EZ2ChjwYqbLoL24putWZnodZbO+LqNkqEwUh0rxkt/wZkM7PjoNXl9rKblZLlv3iBaRXWCffSrKsY5dAyWNKjyupxIaMMDPBA81WorFhG+cxgrvrWMIKKBVlZ4SuVNSO4M/6XokN5f+GM+Ocw8lTbO2mw8zj1pFhvNMvdaiY1nAqvSMGBiF8RkiSpHziIs6Z3nEo0hhf4QvY0U5J1rdyqk8mL2tcEDzonipzrcEGr5YY8ZTuNExCj9SFtPhr2E8QrHYCXUHTZV1myZPlwMkXfi9kCtdZQwC9eHF+dfRhMPnbVUYs+JWRa24GLuBC/RHsLlSNtLTZfQ7zEgHbDBwsiSkHhZMHG8hrJlkAlycV7bg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(5660300002)(186003)(36906005)(33656002)(8886007)(26005)(4326008)(44832011)(478600001)(47076004)(82310400003)(82740400003)(70206006)(70586007)(81166007)(16526019)(336012)(1076003)(956004)(316002)(356005)(36756003)(86362001)(7696005)(6862004)(2616005)(55016002)(6636002)(8676002)(54906003)(8936002)(2906002)(107886003)(83380400001)(37006003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 06:13:27.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434cd07d-934a-493f-baa7-08d8771ac18a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2805
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/22/2020 10:31, Catalin Marinas wrote:
> IIUC, the problem is with the main executable which is mapped by the
> kernel without PROT_BTI. The dynamic loader wants to set PROT_BTI but
> does not have the original file descriptor to be able to remap. Its only
> choice is mprotect() and this fails because of the MDWX policy.
> 
> Not sure whether the kernel has the right information but could it map
> the main executable with PROT_BTI if the corresponding PT_GNU_PROPERTY
> is found? The current ABI states it only sets PROT_BTI for the
> interpreter who'd be responsible for setting the PROT_BTI on the main
> executable. I can't tell whether it would break anything but it's worth
> a try:

i think it would work, but now i can't easily
tell from the libc if i have to do the mprotect
on the main exe or not.

i guess i can just always mprotect and ignore
the failure?

> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4784011cecac..0a08fb9133e8 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -730,14 +730,6 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
>  			 bool has_interp, bool is_interp)
>  {
> -	/*
> -	 * For dynamically linked executables the interpreter is
> -	 * responsible for setting PROT_BTI on everything except
> -	 * itself.
> -	 */
> -	if (is_interp != has_interp)
> -		return prot;
> -
>  	if (!(state->flags & ARM64_ELF_BTI))
>  		return prot;
>  
> 
> -- 
> Catalin

-- 
