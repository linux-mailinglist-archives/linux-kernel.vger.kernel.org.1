Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211A42B6D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgKQS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:29:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731055AbgKQS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:29:18 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI1ubr114709;
        Tue, 17 Nov 2020 13:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2CJgzSbOUQ6wibdW0bKgl/Zk2m8OEwb7Gzy5jLlOBwU=;
 b=isB/BO4K03WkAzjpGSHzVaCzOTcndAULD9y0Qi+zOk5C6OBRroLQiie6tJ4L5FfPg+/2
 5eSy+lwcgK2HvW2cK+ZFuOB2nVMM6uu90QAyZNBYAxOdxn+W3WDki30Y9wHaMYmyByX6
 NTNqt3a7d5hWMsHPXCYSDO5iSEej+pMpCFQ7x1+Xp7KYXjxh+/dSP4H/wlhIN0cKzsgS
 0lsh5VxBg+bFg7/7yBufLBFoHKkVi8sgilKy9T5BlQJ5dvHGcS6ZYsokur/ygHEfyybi
 98k3IvpnLlDPCtXcEvFe5E6yHOnqLIcwo1nuzMbuqd7+QnNy3tOh3/f/6LXfM/N2gFRp Iw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vexss2jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:28:53 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHISRmV000808;
        Tue, 17 Nov 2020 18:28:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 34t6gh3d68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:28:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHISlHj66715960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:28:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 588D6A405F;
        Tue, 17 Nov 2020 18:28:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5E4CA4054;
        Tue, 17 Nov 2020 18:28:46 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Nov 2020 18:28:46 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:28:45 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Message-ID: <20201117182845.GB4746@osiris>
References: <202011140757.5QyVghe2-lkp@intel.com>
 <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
 <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
 <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxlogscore=734 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:21:26AM +0100, Arnd Bergmann wrote:
> > Don't we need the dependencies on HAS_IOMEM for the CONFIG_UML=y
> > case, too?
> 
> I would have expected that as well, but I don't see the problem when building
> an arch/um kernel, all I get is
> 
> ERROR: modpost: "devm_platform_ioremap_resource"
> [drivers/iio/adc/adi-axi-adc.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource"
> [drivers/ptp/ptp_ines.ko] undefined!
> ERROR: modpost: "devm_ioremap_resource"
> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource_byname"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "devm_ioremap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "devm_of_iomap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "__open64_2" [fs/hostfs/hostfs.ko] undefined!
> 
> If I disable those five drivers, I can build and link a uml kernel without
> warnings. I could not find the difference compared to s390 here.
> 
> Looking a bit further, I now find that we ended up disabling CONFIG_COMPILE_TEST
> entirely for arch/um, which is clearly an option that would also work for s390.

I'll add a patch to the s390 tree which disables CONFIG_COMPILE_TEST
for s390. I wouldn't like to start again chasing/adding missing
'select' or 'depends on' statements in various config files.
