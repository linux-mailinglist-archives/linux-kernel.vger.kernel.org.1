Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F702C321B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgKXUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:44:21 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:61358 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731289AbgKXUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:44:20 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AOKhqpH001474;
        Tue, 24 Nov 2020 14:43:52 -0600
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00010702.pphosted.com with ESMTP id 34xyt4f7ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 14:43:52 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqhWLFas28eimHaUkR4VrFTn/gnmywP9fxrFCtSPWXWKUYb611vGn2Ok+2ZPX92FivTyZKMZi6/RpgGrXXzkmkFPCtlB6j0Ds1Vod4OhQ3sxZ2dL0oJmk4sFGwGppE8M2HTlOz0Mwx8eLeqv+oWw/dAX7jH7Gl+qDgGVyGUbrVRoktAc7utmLccrmYE5Ndp8wK3p6k+Hh/Nqn+avkdwucP3ogEtx8qw6rCRXImqNYXeQbIPyNEwTtk8S+tbmj0LU+bq/54eRByv5QtytO1IOdapzG844Kh9qV11pBPbDfzMwohrA0C2pO9QUyvbR8AdoMGhjwLumHZuysSe4Z9cf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKWA8Ee+i8s0hl+7HLE1dzPIcd3sFDEffq+NJ3HlXEw=;
 b=RgeVVEcQRViuYsxGdJMMMp169wbvqZFB7W+5izqhVOnUAr0mU0dwb22IcQP2Fi9fqwMQxKYcygq4bPRGmWPb9TQwfVw5TzRm4XD0d0vqeQeio6pkhcNYgTpmmv/NPYwAbEtqDfi4vc2p8q9ZKkSihoSyy3tV5mIUoCx12fOgCuGONlWKQRW50Tax4wD6xUGO1HyZiXidrGaPjItpjL69X+nvBBSHH+q664soLkGb6cesbSjDOAFl/oBwcEUUKQOHNKPbCrWMxI4Sl/H3vqqbdYt//CE8TZj+DoKJbnxo2CXHjw7iknf3dPQ3k8000KEeqYyDWGj3akfQMIWVnxqgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKWA8Ee+i8s0hl+7HLE1dzPIcd3sFDEffq+NJ3HlXEw=;
 b=jtTgk/Mcvs2R2fWMxbzMSedybMwv+B97bd2TfvLCyqD3FAY33QvNIrkO9u4P7udfm84piawrBqiJ/IFY6Ap34YD7/9UEGSuINwwxRreAKC3k/+toK+WX0th+AthE+XHlHdjqbE857BHztGS2Faj88elCTxgKNtam3NPq9DeK3lA=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4125.namprd04.prod.outlook.com
 (2603:10b6:805:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Tue, 24 Nov
 2020 20:43:50 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::9060:4872:8d22:a3b1]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::9060:4872:8d22:a3b1%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 20:43:50 +0000
Date:   Tue, 24 Nov 2020 14:35:00 -0600
From:   Michael Auchter <michael.auchter@ni.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        sergei.shtylyov@cogentembedded.com, boris.brezillon@collabora.com,
        michael@walle.cc, j.neuschaefer@gmx.net,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, joerg.hofrichter@ni.com
Message-ID: <20201124203500.GA487864@xaphan>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911144703.25409-1-m.felsch@pengutronix.de>
X-Originating-IP: [130.164.62.8]
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (130.164.62.8) by SN6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:805:66::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 20:43:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b199e490-ef69-4ac2-aa96-08d890b9a605
X-MS-TrafficTypeDiagnostic: SN6PR04MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB41255ABE10E10C66D15598BB87FB0@SN6PR04MB4125.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qw6V+VAqQK5O7TPlGY++/XjMhxeCLYrzyhU4MdtyKl2cGWDWRN0CIUkl+OIaIX334BJRoVJfP+ahtlRnVKkBCXCX0zfpD3x0UoEX4V1gWADgClpXE3mqQljNacjk7dPNfetsH2qLNs+H8BIOUmT78vzByMLj2zEyj0Ce1hlJxMz6fprg3ahk31/+D8QLJyDDJACVrQJTmPZsmO7As/EDx54H/CUHFNF7rrbng7snqzq9AXVifqXDVXU4FAkSelXsTZvQqB/AXMgDRpW0Tnj2qeaZIFXpYl+Twjlr5LkMJT/2tuwmzUnJoINIYqFqTP8n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(5660300002)(6916009)(956004)(2906002)(1076003)(33716001)(52116002)(7416002)(6496006)(316002)(66556008)(66476007)(4326008)(6666004)(44832011)(186003)(8676002)(16526019)(86362001)(26005)(6486002)(83380400001)(9686003)(33656002)(66946007)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8SWIm/sqlStANG4K9ubdfreGTocjKyB4A+RqLpo0Yg35ZOVCH9Vi/Z9TILi7?=
 =?us-ascii?Q?ijril+Uv/pgZHa3tLCyYi9I0ZDL49dkIenXUYHAzEX6jFq8wEmg9jx33ALec?=
 =?us-ascii?Q?PARfwZCW4SZg9xk137ohvu4dB7kS+xjjLBbenxSVK183EseIMFAjc4f2JrwP?=
 =?us-ascii?Q?F8voIlRhM0M6HbnXvmZ+uf8ufe6yneXlvHZz8T4YPlO5JZjwdZIOV8gjAShx?=
 =?us-ascii?Q?L3Ogifk/kF5/IUO6LevI6rbM9ckpOL+WSreWANQZuHTj+ppvIVZ7NmXMflgd?=
 =?us-ascii?Q?VMdtBwUGs8XbKKK15PABOB4ZglIkg2BXXLart4DnVjlOF4Iu/cCOsDeHwlam?=
 =?us-ascii?Q?X3SbvZBz0lpTtGA4msEd5IcPziU5rWl5ckpakr4j/ejDACekJdidd6Yhkx2y?=
 =?us-ascii?Q?NjGEd5vajbqO7I1oZVWbes7/P1FT2L8lteYGVADobKTYCOp7n0lBf7087lZl?=
 =?us-ascii?Q?RP/3ZqA8NBd/fmHUf6v+mbwxwNJNY0c2dodlC0yEUpdrVqacHcZ95jlBusok?=
 =?us-ascii?Q?Vq94GWP+6PcccF/eeKOUK3kZLpv+bh2DYW/D2qsuRY3l9VGMdulG+XJOXBLv?=
 =?us-ascii?Q?akiXJrQe9pXF5TeTYJW7D3Fchu6D8ovI2UlaHZM/md5KEK+yeLzkSBwMWAfK?=
 =?us-ascii?Q?SJFXbTfO8f35AQTZ4wh29uiJIghQsmKkx3cQahtMwLieheoCykhcmrs62Aez?=
 =?us-ascii?Q?DGL9MAxcgq/IEbY/xVgGB0arkMeDajFRL0vYPPxod/bFsC5YasJMJZR3wlNm?=
 =?us-ascii?Q?qU5TfdEC5+3zmphRW1oMdByU1C/wuLkLsCqwwjmxmyl4SbFwCYVRTfZG2wRm?=
 =?us-ascii?Q?ikuXcDfmL145pN27OXbUs9TKxHZoO/iaxf6I6f4PzWdNg76Pmm6Ks8j5bAZt?=
 =?us-ascii?Q?OC5C2caRsnFxGWPJlOvISI98MgbHM1oz+sAXo9UBPq47NQuaWIdx50MnT3dx?=
 =?us-ascii?Q?aY6qu+63dCu+4cBEh8RCa7pj1jsEKf/ANru5NJmvw/A=3D?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b199e490-ef69-4ac2-aa96-08d890b9a605
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 20:43:50.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7zVHRTopgSWs184TzlG/kqoTWD5US6mmlYODnkPTVhoFNwyd1QL60nDMRo8EufHlbBAnwGIZCayyhVywYnOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4125
Subject: Re: [PATCH 0/3] MTD: SST SPI-NOR fixes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_07:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco,

On Fri, Sep 11, 2020 at 04:47:00PM +0200, Marco Felsch wrote:
> Hi,
> 
> Patch 1-2: write path fixes
> The sst write path is completely broken since v5.7-rc1 and in rare cases
> since the support of the sst_write() function (49aac4aec53c).
> 
> Patch 3: cleanup
> 
> I've tested my patches with a small test app to ensure writes starting
> on an odd address and with dd to test even start addresses. My dut was
> an public available imx6q-sabrelite (rev.D).
> Other testers are welcome :)
> 
> Regards,
>   Marco
> 
> Marco Felsch (3):
>   mtd: spi-nor: sst: fix write support for SST_WRITE marked devices
>   mtd: spi-nor: sst: add missing write_enable
>   mtd: spi-nor: sst: move sst_write_second to local driver
> 
>  drivers/mtd/spi-nor/core.c  | 15 +++++++++------
>  drivers/mtd/spi-nor/sst.c   | 15 +++++++++++----
>  include/linux/mtd/spi-nor.h |  2 --
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> -- 
> 2.20.1

My colleague, Joerg, has validated that these patches fix an issue we
saw where performing multi-byte writes to a SST25VF016B would fail.

Tested-by: Joerg Hofrichter <joerg.hofrichter@ni.com>

Thanks,
 Michael
