Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98B23D05D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgHETro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:47:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbgHERAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:00:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075C3m1P124605;
        Wed, 5 Aug 2020 08:24:02 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qqt1gv3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 08:24:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075CFrNY010087;
        Wed, 5 Aug 2020 12:24:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 32n017tmb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 12:23:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075CMULl54460840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 12:22:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0406411C04C;
        Wed,  5 Aug 2020 12:23:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 149FC11C052;
        Wed,  5 Aug 2020 12:23:56 +0000 (GMT)
Received: from pomme.local (unknown [9.145.52.198])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 12:23:55 +0000 (GMT)
Subject: Re: [PATCH] powerpc/drmem: Don't compute the NUMA node for each LMB
To:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mpe@ellerman.id.au, nathanl@linux.ibm.com,
        cheloha@linux.ibm.com, benh@kernel.crashing.org
References: <20200805092858.64143-1-ldufour@linux.ibm.com>
 <202008051807.Vi8NDJtX%lkp@intel.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <ee7f5b73-81ee-ecc1-d7a1-9cdb3eceaf0b@linux.ibm.com>
Date:   Wed, 5 Aug 2020 14:23:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202008051807.Vi8NDJtX%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_09:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008050101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/08/2020 � 12:43, kernel test robot a �crit�:
> Hi Laurent,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on linux/master linus/master v5.8 next-20200804]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Laurent-Dufour/powerpc-drmem-Don-t-compute-the-NUMA-node-for-each-LMB/20200805-173213
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-mpc885_ads_defconfig (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arch/powerpc/mm/drmem.c: In function 'init_drmem_v2_lmbs':
>>> arch/powerpc/mm/drmem.c:457:8: error: 'struct drmem_lmb' has no member named 'nid'
>       457 |     lmb->nid = first->nid;
>           |        ^~
>     arch/powerpc/mm/drmem.c:457:21: error: 'struct drmem_lmb' has no member named 'nid'
>       457 |     lmb->nid = first->nid;
>           |                     ^~

My mistake, the nid member is only present when CONFIG_MEMORY_HOTPLUG is set.

I'll send a new version fixing this.


> vim +457 arch/powerpc/mm/drmem.c
> 
>     397	
>     398	static void __init init_drmem_v2_lmbs(const __be32 *prop)
>     399	{
>     400		struct drmem_lmb *lmb, *first;
>     401		struct of_drconf_cell_v2 dr_cell;
>     402		const __be32 *p;
>     403		u32 i, j, lmb_sets;
>     404		int lmb_index;
>     405	
>     406		lmb_sets = of_read_number(prop++, 1);
>     407		if (lmb_sets == 0)
>     408			return;
>     409	
>     410		/* first pass, calculate the number of LMBs */
>     411		p = prop;
>     412		for (i = 0; i < lmb_sets; i++) {
>     413			read_drconf_v2_cell(&dr_cell, &p);
>     414			drmem_info->n_lmbs += dr_cell.seq_lmbs;
>     415		}
>     416	
>     417		drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
>     418					   GFP_KERNEL);
>     419		if (!drmem_info->lmbs)
>     420			return;
>     421	
>     422		/* second pass, read in the LMB information */
>     423		lmb_index = 0;
>     424		p = prop;
>     425		first = NULL;
>     426	
>     427		for (i = 0; i < lmb_sets; i++) {
>     428			read_drconf_v2_cell(&dr_cell, &p);
>     429	
>     430			/*
>     431			 * Fetch the NUMA node id for the fist set or if the
>     432			 * associativity index is different from the previous set.
>     433			 */
>     434			if (first && dr_cell.aa_index != first->aa_index)
>     435				first = NULL;
>     436	
>     437			for (j = 0; j < dr_cell.seq_lmbs; j++) {
>     438				lmb = &drmem_info->lmbs[lmb_index++];
>     439	
>     440				lmb->base_addr = dr_cell.base_addr;
>     441				dr_cell.base_addr += drmem_info->lmb_size;
>     442	
>     443				lmb->drc_index = dr_cell.drc_index;
>     444				dr_cell.drc_index++;
>     445	
>     446				lmb->aa_index = dr_cell.aa_index;
>     447				lmb->flags = dr_cell.flags;
>     448	
>     449				/*
>     450				 * All the LMB in the set share the same NUMA
>     451				 * associativity property. So read that node only once.
>     452				 */
>     453				if (!first) {
>     454					lmb_set_nid(lmb);
>     455					first = lmb;
>     456				} else {
>   > 457					lmb->nid = first->nid;
>     458				}
>     459			}
>     460		}
>     461	}
>     462	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

