Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804F22D8C62
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404790AbgLMIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 03:25:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404695AbgLMIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 03:25:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BD81suB139154;
        Sun, 13 Dec 2020 03:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5gdvRqHOIcFF9778mDFI20rVvUg6ROjVA5xHEBRcM78=;
 b=iqPwdpFPF5nshS2GvkRdUMBaUUDr5p/2sqwz6V7mFI/+L24ngzZgXeSH6TN9aIAww7SD
 TCM186jU2c7Fvtr5Au5OMFxujvpwEmBDeJzOyA8QC6rXb1f/3wwAHODkF2EGafdRL9/d
 UKt5gUcymu+4NJ6mnuXFTurjcPH4BBccz9RLBIa3LT5xXVEqmI8SPFlw5Iykd8zYNoIj
 4RX0tfh+qvDAcUD+FDUx7hnQszSHh585uUouC+DC4ui57IfgR1BmUfM/6EkQVBoLgF3O
 wgLdgXHH+r+QrkyXQtOKO88nV1T9rhb0g1eQdd0mFZvCpuB77uk7FFQ4eG/58Id9qskt 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35ddkrssvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Dec 2020 03:24:36 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BD820h0139615;
        Sun, 13 Dec 2020 03:24:35 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35ddkrssv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Dec 2020 03:24:35 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BD8Mtp5012328;
        Sun, 13 Dec 2020 08:24:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 35cng89gd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Dec 2020 08:24:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BD8NHv257147844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Dec 2020 08:23:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A52A405C;
        Sun, 13 Dec 2020 08:23:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16868A4054;
        Sun, 13 Dec 2020 08:23:16 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.58.102])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 13 Dec 2020 08:23:15 +0000 (GMT)
Date:   Sun, 13 Dec 2020 10:23:14 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
Message-ID: <20201213082314.GA198221@linux.ibm.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-13_03:2020-12-11,2020-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012130058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Fri, Dec 11, 2020 at 09:53:46PM +0000, Guillaume Tucker wrote:
> Hi Mike,
> 
> Please see the bisection report below about a boot failure on
> rk3288 with next-20201210.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> There's nothing in the serial console log, probably because it's
> crashing too early during boot.  This was confirmed on two rk3288
> platforms on kernelci.org: rk3288-veyron-jaq and
> rk3288-rock2-square.  There's no clear sign about other platforms
> being impacted.
> 
> If this looks like something you want to investigate but you
> don't have a platform at hand to reproduce it, please let us know
> if you would like the test to be re-run on kernelci.org with some
> debug config turned on, or if you have a fix to try.

I'd apprciate if you can build a working kernel with
CONFIG_DEBUG_MEMORY_INIT=y and run it with 

	memblock=debug mminit_loglevel=4

in the command line.

If I understand correctly, DEBUG_LL is not an option for these platforms
so if earlyprintk didn't display the log there is not much to do about
it.

> Thanks,
> Guillaume

-- 
Sincerely yours,
Mike.
