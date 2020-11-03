Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349522A4C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKCRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:18:37 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:55937
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbgKCRSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:18:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiZD7L9imABak4jUzf/lg0fh/Hh6Ijy6okDA0EEnBDHuBlh7J5b7VgvuYva0ofXfbh8k+bpqcmq0dU4GeGboJHOCHLXW2g55PO45lO2NYuZRr5Ag60RK+uFcWGtd7Dlf7Y/TaP9+M9ibHyJD0WomqEksEDvdMlc3ybPaLCwXdhypbByfR/f2RuDLLjd1GmxEVUswYthPUfG6NELuHZrzOwSU5BhvIqrlZHHrXWxJyKUIsnLe9AlDxbDLavvRdSwg2V480/KmpesIzUUFflnPleIybLSJWn2MdOhnCLm030dnPLwCrPfDUexd4Fpq/xbLqf8gfSIhEDfPyz4FeqMorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgspc/+c+wX9GBRT4K1WpkZh3v0MLYlP0wPTb4/jlqU=;
 b=hM2WxLvocFYL6WEr6tuV4G7i30eLircoEa4qltv2krKxy9sSDHtWqa9fyaiF92sw20zoJrnxuo3ZGv83cXeiTY+ia4QI54u+RMB1F8nFahPqvZZi4eIMpexNvLZnN35YfGLoQVyRWzxx/wIP9pORcwLUU+X5Spz3Pg5+Ojif5dfhUqzAh2Ku4ydraiDwTA9Yv+hb4l+tX/6zrG9qg4jehMGywyXvlGiq3hrXTh8JZoO9mYX21fDhEhSa+/goFoYYBhMcU4xVjvX5l+r4xlcCDVCUz5fBTkXyeMuQ8dUl+dPBAkJbWej+EgaKQJmO9m+/HUQy5AT5oISv7VsuMjSWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgspc/+c+wX9GBRT4K1WpkZh3v0MLYlP0wPTb4/jlqU=;
 b=iSuuNxOW42/zGYteaSJ2Q5LJUXL73zOWW1J5uA9UCYO5UMXInNE36WWEDHuIkNiIcP/XIZxrpwd7tKQt9h2V5Jwvk1J0E0YMgxA+ZcB3bShvY6X9qBtzrCfk7MawxtEDMrrOPtTygQxyKoA9JlwCzWWbvNOBpsahjNrEAgmvffY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 17:18:31 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::6cf3:a10a:8242:602f]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::6cf3:a10a:8242:602f%11]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 17:18:31 +0000
Subject: Re: drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c:16:5: warning: no previous
 prototype for function 'vfio_fsl_mc_irqs_allocate'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Eric Auger <eric.auger@redhat.com>
References: <202011031516.4gcgoMmU-lkp@intel.com>
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <404c152f-f0c8-a5d5-d62f-7b43a47d8614@oss.nxp.com>
Date:   Tue, 3 Nov 2020 19:18:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
In-Reply-To: <202011031516.4gcgoMmU-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.121.79.46]
X-ClientProxiedBy: AM3PR07CA0072.eurprd07.prod.outlook.com
 (2603:10a6:207:4::30) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.122] (86.121.79.46) by AM3PR07CA0072.eurprd07.prod.outlook.com (2603:10a6:207:4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 17:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c92072f8-37d3-4220-74c6-08d8801c7c95
X-MS-TrafficTypeDiagnostic: VI1PR04MB5040:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5040678EEAA60944167120FABE110@VI1PR04MB5040.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:76;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkuMZuds3a9TpYB00kB9IYt7qY65iGQz9uTSGevxAx41eMuLmYjVrOORqB7qBDbEoW3eMWrjZgTtbcWAOCtNO0ZCNNE+hd38oR8tw/VshkANyuKf4zgoP3dMh+762SCjb/2unGeDdHuz/JcyRXOhV2n1NBTdpKL1xOoJJUKj0A6JOE4GnCNJnwSMrTOhCg90Z6qDJqDRZzlpLrG8JH6Cmv+m12YDKBOpu0T2gYS25ud6eP86pwpIFpveGGCNsb1A6DXeBI/aFVZ9evxZUrzmgfQoYhX6qalh8MBQZrYxme6i41m9KsO08JbPcZmqfIlEWAMOIkV9Ovl6OXKkphA6NJeJar8Io9EMiBmrnumLTlkmFO9eq6oEv2QVyYfy/HeLjsPjMnlVsLJmCtsAeHrPWKJtjefECYPjKIJmh9u+ZFk285xTZxGbsnIwkD06xA7mckzFX8oJldPLTzTpF0MEIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(956004)(6916009)(16576012)(316002)(52116002)(54906003)(26005)(186003)(53546011)(16526019)(83380400001)(2616005)(4326008)(966005)(6486002)(66476007)(66946007)(5660300002)(86362001)(31686004)(31696002)(8676002)(6666004)(66556008)(8936002)(478600001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7EfG+ORFV1hKHaVr9vpAKYCbykQj+Xk8l+O4VfybR3ctdCLdquZfDtsQdT4gE3RshGoIdkNcM0pxLifo8Udoi+nKfso1CEHOFzm9EJ9c0BYU3kJ0h+qYAEb/h15Nk1GntNmbwEnX7cbna8Q3QWH5uUp0lkcpLDeMbOE3R6ax1KJyEYJBgpbP5qzn2rddS8agebHKSbsLwdLAp3TV6Q16zT9KuZG5NqD0yjUnT1U+kn3CKIs0eseRyZH8rBUdzeXOHpDsJkP0TCx435xjPvpvbMxlUWIYhpQCMjju9a8A07l7FW7ufTXvetkEuEalC0YWScyLUDJCKYN1wvzjWmPvTjF/JsiZTy1FqLL3x6oLx56yZuw+h6ydXqUqVRC18TV+1MB+uvyIOPNQVSQ7DoNtDWjlPxImiLd9QPIMQF+iDBeeuA8oLA3M36/vyBFEq6rB+DnhqtLBS0u4PLB7Hn3Sg0bWymb1TNoOU1Yblsx8Td7ZI1j5EHkx2ri1ZyZIs56bGPMy+o9XXyFnaxp3Yd68h7U5kTHpyjH9/eEidT9LsLv2CGFUxsUAVIErvHHXJl59aNpLUGOtHxsgIHtaZe+tBUbs7LOSqo/ess4rbhtaXpxONqvDmXPl53i2zHEvX+H9DR7otWO3E/W2SGnsYKEIhg==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92072f8-37d3-4220-74c6-08d8801c7c95
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2815.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 17:18:31.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23p50fyVmwQ/Nd117kwuSpOOK02qInxMpwugMpRAKJnLYkOqVTDtbSr+OlRh9Y9hwd8MTbw3RDufToMUnJkqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The warning is fixed by this patch: 
https://www.spinics.net/lists/kvm/msg227575.html

The errors are caused by the fact that the vfio fsl-mc patches have a 
dependency on the fsl-mc bus series. For this particular error the 
missing patch is: bus/fsl-mc: Export IRQ pool handling functions to be 
used by VFIO. But the entire series should be merged before the 
vfio-fsl-mc patches.

I have verified compilation with clang on the master branch and there 
are no errors.

Diana


On 11/3/2020 9:54 AM, kernel test robot wrote:
> Hi Diana,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b7cbaf59f62f8ab8f157698f9e31642bff525bd0
> commit: cc0ee20bd96971c10eba9a83ecf1c0733078a083 vfio/fsl-mc: trigger an interrupt via eventfd
> date:   3 weeks ago
> config: arm64-randconfig-r026-20201101 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 235dfcf70abca65dba5d80f1a42d1485bab8980c)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm64 cross compiling tool for clang build
>          # apt-get install binutils-aarch64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc0ee20bd96971c10eba9a83ecf1c0733078a083
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout cc0ee20bd96971c10eba9a83ecf1c0733078a083
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c:16:5: warning: no previous prototype for function 'vfio_fsl_mc_irqs_allocate' [-Wmissing-prototypes]
>     int vfio_fsl_mc_irqs_allocate(struct vfio_fsl_mc_device *vdev)
>         ^
>     drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     int vfio_fsl_mc_irqs_allocate(struct vfio_fsl_mc_device *vdev)
>     ^
>     static
>     drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c:121:8: error: implicit declaration of function 'fsl_mc_populate_irq_pool' [-Werror,-Wimplicit-function-declaration]
>             ret = fsl_mc_populate_irq_pool(mc_cont,
>                   ^
>     drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c:122:4: error: use of undeclared identifier 'FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS'
>                             FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
>                             ^
>     1 warning and 2 errors generated.
> 
> vim +/vfio_fsl_mc_irqs_allocate +16 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> 
>      15	
>    > 16	int vfio_fsl_mc_irqs_allocate(struct vfio_fsl_mc_device *vdev)
>      17	{
>      18		struct fsl_mc_device *mc_dev = vdev->mc_dev;
>      19		struct vfio_fsl_mc_irq *mc_irq;
>      20		int irq_count;
>      21		int ret, i;
>      22	
>      23		/* Device does not support any interrupt */
>      24		if (mc_dev->obj_desc.irq_count == 0)
>      25			return 0;
>      26	
>      27		/* interrupts were already allocated for this device */
>      28		if (vdev->mc_irqs)
>      29			return 0;
>      30	
>      31		irq_count = mc_dev->obj_desc.irq_count;
>      32	
>      33		mc_irq = kcalloc(irq_count, sizeof(*mc_irq), GFP_KERNEL);
>      34		if (!mc_irq)
>      35			return -ENOMEM;
>      36	
>      37		/* Allocate IRQs */
>      38		ret = fsl_mc_allocate_irqs(mc_dev);
>      39		if (ret) {
>      40			kfree(mc_irq);
>      41			return ret;
>      42		}
>      43	
>      44		for (i = 0; i < irq_count; i++) {
>      45			mc_irq[i].count = 1;
>      46			mc_irq[i].flags = VFIO_IRQ_INFO_EVENTFD;
>      47		}
>      48	
>      49		vdev->mc_irqs = mc_irq;
>      50	
>      51		return 0;
>      52	}
>      53	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

