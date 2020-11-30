Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42EE2C8B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgK3Rje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:39:34 -0500
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:25568
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728451AbgK3Rje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:39:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEXEiI57b70QPiIAZhOdUuwI5krqLB9A+AzalADcpiSR5ajX5e0cXoFHPc8Srgs9XNJQ4zXGiCFFLsTsBzW0Nvtjuvos9XuU9bXKFbNHCehpi8RQWzfKTQervhEIlVlyJ0FVfg3v96Kg3qA1VNJPNgs0o8QGKn6pABRhQhr+eFEUYITYOiYdAQFIbHVOG8xxjgCTD2lhZAivqaIyuVmUUCEmgA0Bqu4TzAs2huFiO15pbWWLxmeWUbtN/Mc7ftOVjEsjUel/mvMRFumaIXH/mGPZNk/2zr7j6zpu0bZ4MVZghar4I/EEf6OLwOgLGy9uzMyYFqfzePzhP7LqbcqxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhQAGtxa++ICLKo7HZNmlkOcSBcyuTfC8SEXWXAlGoo=;
 b=LwJkp1f+59QvE30qwEzUhV44cuwvbHamp7IVTgQC5JQrgX838R5YPZghlpiGAMA5ob0WnPcZFWtCGxaOOgYQQH0pfRYXQeXxMhgz3tEuH5Xpb83maR/np0QXGyoR8u+G4NYCLNe0fqw1BLdwaL1i7vrsWtf1FzVyLf2EalgC6GvJWP+KfPnynGtKQwq4fx3Skp/WYGfJHnMtPeTUp/oz+w2COqPydNMcxcsiknFiTWgxk2SscyjntNRsVNKU+90HE6PZ4d578iYKw1xbd0cca1+A6S63V0uUNfKX18kDoml31E9RWyDq4qpgyHkqwqC3UnO3GDYO+CnacEDFB8Bgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhQAGtxa++ICLKo7HZNmlkOcSBcyuTfC8SEXWXAlGoo=;
 b=ld9jMDXwpn9CS24ehCS6cw6F/bxmE5Vz0/w1EIEaQkcclBYQ5IO+4eyZW6KQu6RhujMboME+P8NzkovQKhNWACfUL4+7dqeJM3Q4et2fA4EONgME7Yt6Dh5a+Cy03cJqMM583mzaK/9hEupBwsJu6N6MGLQSWgdLetRODx6e15g=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 17:38:46 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 17:38:46 +0000
Date:   Mon, 30 Nov 2020 12:38:43 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201130173842.GB26693@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <20201130030828.GA1363814@tassilo.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130030828.GA1363814@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 17:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2555109f-9502-470c-e82e-08d89556c9dc
X-MS-TrafficTypeDiagnostic: DM6PR11MB4514:
X-Microsoft-Antispam-PRVS: <DM6PR11MB45144ECB75E52F66716101BF83F50@DM6PR11MB4514.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sk0XrfWDZH/MWPzi6gbun29fHbpe611Eb/PDJJyqtIOkuwdhxJ6S1oigJPKXF/HlXv7Jlx8hrBpdn1iT2UoRUNKVoE2FI0wAAvKrOe+oim67lsTeSLX+E5Xcr4piqvuFr/1VkBRyz/StfTf7+LIIJuH/RyNuZBYDSS1aVpJkZIpnyNglk+2Jts7nI6Fov5Si+xTMrEcBC4Ubiv3R9DaNwevczrs411SX0YwPcPuuyhQCQJnQwaRkAqQddsvHeU9vPe5PBxDuwiGAFP0fneOT5j8NXq0cDyMrBWRSDkxmpthNZdNwfnCI1WTFAXJrPT2CRWbVqNWu8HnmehhOFjzASg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(6916009)(8676002)(316002)(16526019)(8936002)(26005)(54906003)(33656002)(186003)(7696005)(2906002)(55016002)(86362001)(1076003)(66556008)(5660300002)(66476007)(2616005)(52116002)(956004)(44832011)(66946007)(8886007)(478600001)(83380400001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qUWGwC/u7FfwVuY92sdEwtSpf0ZY1Z2qL3uFY4dVm2kfrDhSa08sRHbDmcwI?=
 =?us-ascii?Q?LLgs10CdhwI33YDGgCauYd9AUONdV/M9FufzWWl8/bX6B8ztArrjXH6I/O8o?=
 =?us-ascii?Q?0q3tUGmrf8FodA/VVFnfp+17ui1U+1tp5+W3QfFZRNDUi5rykFtcKR11N0W0?=
 =?us-ascii?Q?TbW7kGN7IF7Dfsl4kuq0wjFwGQPt4IWRIpF2gPIOvjg3wJapiXejV5yqGwDH?=
 =?us-ascii?Q?iviUCQPrLKxz4I0u18j7U5d/q0C+BhwY8C+fxcGArUoMv1Y/WE1lO5rUr++A?=
 =?us-ascii?Q?O7YpMcvqyPIhvDFEpKU2IcuJipzAnfvuSdeZVq93OdaqJdiOfXA/HXfze90V?=
 =?us-ascii?Q?7/p5+huq5mg9dMSO/m65YrG6PK3RxsmJAM0Rhwxc96XuL75fU/Xxbo2JYxYx?=
 =?us-ascii?Q?iE2h45QoXItuzU0KZdcR3rNyro3MlTlMbmtjh7GORrblyFJm0UDfBjXMBPe8?=
 =?us-ascii?Q?lkBE+B/YVwJazEWIIWfDENlfRfxxABMljT3bUdZl+oLjXRdfZZPD9AqhCqho?=
 =?us-ascii?Q?UfgPwzY+M2V0zdW594GXXjLbQP3qlrlJFdPPH2jRagG3ui+bAUx68HRXolgO?=
 =?us-ascii?Q?X9ZjYJGPzn8zPfLA410mnCyPzgw1SMRsjPaoOrN7WTQcN68WO0ZB4GHgAgi5?=
 =?us-ascii?Q?OjwBKDyciMIEFd2YBSRJ/4d00j1QV3ezOr8eEMX3X+t0O2bEE4pNrFT37pf8?=
 =?us-ascii?Q?h+6vMnsgLAnh3wrVQdLv+bx7vJv9ULsP1XmpqLIuFxSqh0ebzvB7m/SoV6wp?=
 =?us-ascii?Q?u4Qa3hsUPscElnz5urWa838gOKF1nYXGKslURH80A1Bo18XXw5NoBcbQaJlw?=
 =?us-ascii?Q?aCtvF9efgedBufL3mqa/QE9nIntUC4otGYepDMMki5NIYxfcBJEmuPgR59zD?=
 =?us-ascii?Q?UALr4QbGzMk1RzCkqP+3xP22GMLXrnKFIkAvG3WqrlqVx5lsJ1ZDryNdyDYv?=
 =?us-ascii?Q?7JMGKMIl9kVJrKMSonQgw3o0YO5KHJv1pVC6t86dmoxWJA+SYkwmlur/UeyE?=
 =?us-ascii?Q?sHp8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2555109f-9502-470c-e82e-08d89556c9dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:38:46.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkQOWlx3EXoXYZ1RxROg0LLjDCv6DGN7fX0LG1gXB09oxdSoiBeSl1wJk55or/QwxVTHlKnEIw6HjheTx1e5xJPHT2sHp/y1qZmtdP0+MpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/3] clear_warn_once: add timed interval resetting] On 29/11/2020 (Sun 19:08) Andi Kleen wrote:

> On Thu, Nov 26, 2020 at 01:30:26AM -0500, Paul Gortmaker wrote:
> > But you currently can't make use of clear_warn_once unless you've got
> > debugfs enabled and mounted - which may not be desired by some people
> > in some deployment situations.
> 
> Seems awfully special purpose. The problem with debugfs is security,
> or is it no convenient process that could do cron like functionality? 

My understanding is that it is a bit of both.  As users of rt tasks,
they won't be running anything like cron that could add to OS jitter on
the (presumably minimal) rootfs - so they were looking for a clean
engineered solution with near zero overhead, that they could easily
deploy on all nodes after the rt tuning was 99% completed and node
images had been bundled.  Just to be sure everything was operating as
they'd aimed to achieve.

I thought a boot arg (and the internal timer) seemed like a good fit to
that requirement.  No kernel or rootfs rebuilding required.  And I
figured others might be in the same boat and could use it too.

Paul.
--

> 
> If it's the first, perhaps what they really need is a way to get
> a partial debugfs? 
> 
> -Andi
