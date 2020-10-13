Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4928C63D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgJMAde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:33:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbgJMAb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:31:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09D0TphY006207;
        Mon, 12 Oct 2020 17:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=HlLwr13CySWBSIs+P+W/dByqhlWChoUVV/NMqKtk9pk=;
 b=NGjqnfJNyCdWDyMp6RUDRMmEYaS/uPXPCuAA4TP2qk1H8GOn6Xxh42EurfAKVZXy0P1X
 RfZ1oY+PIYJ3FfUPL2a+k8hPLIjTLYxexMe+vnvGTtB1eBd221++tbLXc2C82Z6D/qpQ
 uHQo21eMxGy+6pE9qVM2nZWkU5es1mawlCY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3438f0382c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Oct 2020 17:31:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 17:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8HJJEYA4uerOvhkr91cNRgZTq/cToHvOzev4Q5cJJXT3eCS9ZvWE5nDOmmOymQ0HZnRUwiLivxfUDYW5m9e+V9PM+jgHwO6NW6Q62la2Q7pSKNdwvCeQ8t3MgtlLEqGR1mo8oI/wVTwD0EbKZM/mE14+jiw1mG+uBHOh2cf9ezHAfJB+UWJcxYVwz+BxBdwCj2uSlkL0DexTjyJtmh26BgNK6dzjMAywQqaoLUbZojnF5CCxEyfPgYqFHr05q5ZlBzeMsG6oyRCNimp1mIw3vUl7KlX1294FuJApn2aW0vRuVfcjuCSpLWxrw8Cg1sHK2NRT2V4sYs2PJQlIuAmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlLwr13CySWBSIs+P+W/dByqhlWChoUVV/NMqKtk9pk=;
 b=cbnqDwWrA0ovePHI3iIChQgU2bO1MCIx+EsAx44ibEsIj5dbl2DAvxvnDdwpFasojYYWorwbAe+zVJhf5br4ytbU9t3+is9KTSvTnlTvZDwI8JAgd3G3AUqNUV/Z31icCktqINMupbt33YFN5xHI3NHek85r/FFr7tDficDwIMHoU8eky9Wk9If1QSj9i8Yj6dXlkRVLmlQlja1CCoxD3SusWjQgaSvciipnuwByV/kC9lo5ArmxE7aHXcNdr4NXVFi2k1Ks6jJBIfN6Vl5S8/qd0uNImXA6pmTKmsUK4YJJROUL0Kjf9pwpHSvN6b05ueupC0yk/lkBBh0ddCvGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlLwr13CySWBSIs+P+W/dByqhlWChoUVV/NMqKtk9pk=;
 b=IasfqhCPcrV9bG2z1qwQ7DOwYPeepNOYBJ6D5/LV4HGQwoRFbY5B9a36DevzI75+2PtsGwBVUbXZoCxenDpYZQ3cw5JFbUFNRvm3J0+s7DE9v23WLUS8xaHST53ZqxRzuHi4xvIUDfaksc67YYDo2As15o34J0NLYjnXfMOKu0o=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3839.namprd15.prod.outlook.com
 (2603:10b6:806:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Tue, 13 Oct
 2020 00:31:14 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 00:31:14 +0000
Date:   Mon, 12 Oct 2020 17:31:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Philip Li <philip.li@intel.com>
CC:     kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <kbuild-all@lists.01.org>, LKML <linux-kernel@vger.kernel.org>,
        Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [kbuild-all] Re: [PATCH] mm: memcg/slab: fix slab statistics in
 !SMP configuration
Message-ID: <20201013003108.GA3687509@carbon.dhcp.thefacebook.com>
References: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <202010020814.M5nb692Y-lkp@intel.com>
 <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
 <20201002053405.GA30771@intel.com>
 <20201002175506.GB2954069@carbon.dhcp.thefacebook.com>
 <20201012230550.GB19671@intel.com>
In-Reply-To: <20201012230550.GB19671@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:2319]
X-ClientProxiedBy: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2319) by MWHPR21CA0056.namprd21.prod.outlook.com (2603:10b6:300:db::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.10 via Frontend Transport; Tue, 13 Oct 2020 00:31:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b002727-0704-43e0-d852-08d86f0f4aab
X-MS-TrafficTypeDiagnostic: SA0PR15MB3839:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3839EE57B3DC2F8B193EB96BBE040@SA0PR15MB3839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTMEENbqyqm3RPJRLCkMmxW51wFKmXdOL5rffZq7XXM+jVxlp+wAy76z9gMySNh2mBsR0c4QmxerPSVCQaAXwNHW3WxJi//g/NHy3NLHeC9Yexbo5oiAolvGDWpiBWgI+hQCbL03TxTwvdAWKYRWP8oL8mLr3b5hBoCp1VFk01KndMir2+MYxBINWPwhxv3OTPT+bGTTy6kE+Q3v1ERWvgSxfoCGa49Pln267v/mhqff8eoQKImV1wGyLsD1cprz8Cvl7p4l9HLhUjaIZKGlon9+tDKVa0EYIkisTmTij6shUo3RgK0Kp2OqLJj8haE4DRXu36WVZxeCmjEYOOHE3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(6666004)(316002)(55016002)(2906002)(7416002)(478600001)(1076003)(5660300002)(54906003)(6916009)(16526019)(4326008)(6506007)(33656002)(83380400001)(86362001)(66556008)(52116002)(7696005)(66476007)(9686003)(66946007)(186003)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: exz42gdHeTSBJERVoKDNXxrOvIeRm3zpZmtThi3wqGlcNqLbZ/LSka7vBw55E7ElB7/vACcL/bK3XOReGqiDNrd+vpDc9X2RtUVwCSSu4KVDRKKkaJ9z3hmbOOoqvorOQO8yt6yAcRgYvgKNuKeUuB9hJSkNiHraVvWGASUmt7iiYyZPQf791hY2X85eqfeCbCWU6Q5xI15U+HxDeDQsyNxfbFDXv1DvzHW/oA+77vUAy9rtGf9ZS5lauFVGPoHaXU+m7t2/lD012nsx9CGBm86FEt/TPjOcG8qROC/hUbHsx+Qf4e/QSxj3DErXmgZ44d4C3TaMA07LHw66jvkc91+vYnAmLfr4k1USc242TNDLLuFD541iFKhC+8+hFxEInIC5jtW3MsDXvQ9xHkbqUKUX1k+KIvvGqN2joXL/l5jSZFJHh7l1KfPKr5M5a7UWHagPwO0hlEpHPJo0xEyvB6GvDfIavd9H+Cy0hKjcETFxdxdwHA/fP2DOc+rCk/I7hxaHnoaEDT2Kp7sJiaG2/ASDZIiXRwUyotpPhpuwtQBZ2QQF66cPaNodYOmSoyHkEZ6l36+lMqy44Cmct3jdwMPDB2/PBEZ4x2fcRMXx6zSk6V97Y1x83P8+nyKWSVvLzozdRvi7jPX2QmjZSigcHKX6m23M98mL/GSAzBUde2o=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b002727-0704-43e0-d852-08d86f0f4aab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 00:31:14.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIalc38XYXZyNiv07nPFMO/dDPF9Q5JACzYaOnl+jByaMvZwPI6wcHYsUS6BEyQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3839
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 07:05:50AM +0800, Philip Li wrote:
> On Fri, Oct 02, 2020 at 10:55:06AM -0700, Roman Gushchin wrote:
> > On Fri, Oct 02, 2020 at 01:34:06PM +0800, Philip Li wrote:
> > > On Thu, Oct 01, 2020 at 05:55:59PM -0700, Roman Gushchin wrote:
> > > > On Fri, Oct 02, 2020 at 08:08:40AM +0800, kbuild test robot wrote:
> > > > > Hi Roman,
> > > > > 
> > > > > Thank you for the patch! Yet something to improve:
> > > > > 
> > > > > [auto build test ERROR on mmotm/master]
> > > > 
> > > > It's a bogus error, the patch was applied onto mmotm/master, which doesn't
> > > > contain necessary slab controller patches.
> > > sorry for the wrong report, and thanks for the input, we will check
> > > this to see whether we can find an appropriate base for this case.
> > 
> > I wonder if you can look at the "Fixes" tag if the patch contains one?
> Thanks for the advice. Yes, we have Fixes tag as part of hint for us
> to analzye the possible base. For this case, "Fixes: ea426c2", the commit sha
> is a little short than we expected, thus ignored. We have updated matching
> rule now to handle such situation.

Hm, but the patch contains the full 12 chars long sha?

Anyway, thank you for looking into it! It's really great to have
the kernel test robot working.

Thanks!
