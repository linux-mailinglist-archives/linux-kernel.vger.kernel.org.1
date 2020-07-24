Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97AA22BAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 02:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgGXA3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 20:29:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728008AbgGXA3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:29:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O03fUV149644;
        Thu, 23 Jul 2020 20:29:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32facss112-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 20:29:07 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O04HcY152265;
        Thu, 23 Jul 2020 20:29:06 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32facss10w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 20:29:06 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O0JemK015067;
        Fri, 24 Jul 2020 00:29:06 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 32brq9ge7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 00:29:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O0T5wW52494840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 00:29:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70272AC05E;
        Fri, 24 Jul 2020 00:29:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E837AC059;
        Fri, 24 Jul 2020 00:29:00 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.53.35])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jul 2020 00:28:59 +0000 (GMT)
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524964786.20855.15850644504721928289.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 09/12] ppc64/kexec_file: setup backup region for kdump kernel
In-reply-to: <159524964786.20855.15850644504721928289.stgit@hbathini.in.ibm.com>
Date:   Thu, 23 Jul 2020 21:28:55 -0300
Message-ID: <874kpx69iw.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> Though kdump kernel boots from loaded address, the first 64K bytes
> of it is copied down to real 0. So, setup a backup region to copy
> the first 64K bytes of crashed kernel, in purgatory, before booting
> into kdump kernel. Also, update reserve map with backup region and
> crashed kernel's memory to avoid kdump kernel from accidentially
> using that memory.
>
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, purgatory() declaration was missing]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just one minor comment below:

> @@ -1047,13 +1120,26 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  			goto out;
>  		}
>
> -		/* Ensure we don't touch crashed kernel's memory */
> -		ret = fdt_add_mem_rsv(fdt, 0, crashk_res.start);
> +		/*
> +		 * Ensure we don't touch crashed kernel's memory except the
> +		 * first 64K of RAM, which will be backed up.
> +		 */
> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_SIZE,

I know BACKUP_SRC_START is 0, but please forgive my pedantry when I say
that I think it's clearer if the start address above is changed to
BACKUP_SRC_START + BACKUP_SRC_SIZE...

> +				      crashk_res.start - BACKUP_SRC_SIZE);
>  		if (ret) {
>  			pr_err("Error reserving crash memory: %s\n",
>  			       fdt_strerror(ret));
>  			goto out;
>  		}
> +
> +		/* Ensure backup region is not used by kdump/capture kernel */
> +		ret = fdt_add_mem_rsv(fdt, image->arch.backup_start,
> +				      BACKUP_SRC_SIZE);
> +		if (ret) {
> +			pr_err("Error reserving memory for backup: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
>  	}
>
>  out:

--
Thiago Jung Bauermann
IBM Linux Technology Center
