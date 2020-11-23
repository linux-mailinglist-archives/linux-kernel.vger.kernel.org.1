Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3E2C0E61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbgKWPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:03:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389294AbgKWPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:03:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANF1GcZ025969;
        Mon, 23 Nov 2020 10:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ajLgjdq3F09Sm6PRnktY1ShkPTmRih/QYqAHfywLmXg=;
 b=oPVTJ8n+2ywP1f/B9KJ+wkW2f6Uofujdza1BXx+VDVzANChzJEcLydsN6xOK3Wajl99t
 AzWD2mbnlctq8PMize84qoKeR9fXYkjMU+Ma+AbUvv1uqUO3DEapJGtdLdKb739M1xna
 CV8fjprrG2Gc6Q1mxPEh48T60qyJhbMEbypVNyaPv4sMnLZYZ8UXC3O/94DZRWoRW1MO
 EmO4LZzuuErktDm5rZIfOC6PC2RBRX6K7VCZ3xeGcZ8ZuXrDnAHj5rXe7jdvvOm5PVzH
 k5JmPKd67qnj761QXF/hDfwbsbjZG2P1eZL66hnaJTQZ4602u2SFnMTt/PdEBww/TcLF qw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34yucmku95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 10:03:18 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANEwIGN021236;
        Mon, 23 Nov 2020 15:03:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 34y6k4s42s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 15:03:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANF3EXB64094466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 15:03:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B81611C069;
        Mon, 23 Nov 2020 15:03:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA0911C052;
        Mon, 23 Nov 2020 15:03:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 23 Nov 2020 15:03:13 +0000 (GMT)
Date:   Mon, 23 Nov 2020 20:33:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: powerpc64-linux-ld: arch/powerpc/mm/numa.o:undefined reference
 to `coregroup_enabled'
Message-ID: <20201123150312.GC528281@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <202011200207.3PUoc4Gf-lkp@intel.com>
 <e9a3cd97-5a26-7b43-0077-22f909986141@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e9a3cd97-5a26-7b43-0077-22f909986141@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_11:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [2020-11-19 15:51:29]:

> On 11/19/20 10:26 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   c2e7554e1b85935d962127efa3c2a76483b0b3b6
> > commit: f9f130ff2ec93c5949576bbfb168cc9530c23649 powerpc/numa: Detect support for coregroup
> > date:   9 weeks ago
> > config: powerpc64-randconfig-c003-20201104 (attached as .config)
> > compiler: powerpc64-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9f130ff2ec93c5949576bbfb168cc9530c23649
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout f9f130ff2ec93c5949576bbfb168cc9530c23649
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > powerpc64-linux-ld: arch/powerpc/mm/numa.o:(.toc+0x0): undefined reference to `coregroup_enabled'
> >     powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x0): undefined reference to `node_reclaim_distance'
> >     powerpc64-linux-ld: mm/khugepaged.o:(.toc+0x0): undefined reference to `node_reclaim_distance'
> 
> Hm, OK.
> CONFIG_NUMA=y
> # CONFIG_SMP is not set
> 
> Michael, Gautham, does anyone care about this config combination?
> 

I can add #ifdef CONFIG_SMP where coregroup_enabled is being accessed
but I do feel CONFIG_NUMA but !CONFIG_SMP may not be a valid combination.

> 
> Thanks.

-- 
Thanks and Regards
Srikar Dronamraju
