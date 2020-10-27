Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8094B29C4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823999AbgJ0SB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:01:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823088AbgJ0R5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:57:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHt2j7190304;
        Tue, 27 Oct 2020 17:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hvl3eqwvU0FU1DRhXO6+KBI9X/WA5aR0wcPHYoqQpnM=;
 b=Uu70zH77yr+j3cQ2pXDmOqjQhqE4ITyLCqgMn6Ws6F2PZatvrTAU4RjCSHgiiu2bvq1J
 D2uxSMjxfJmWPgsjogyheINxXiCnbRp5AwS11+dAnFYrgcV2+DDs4zmkI2/Q2KPchyPH
 o2iHSSzrtg50xWmVxytu11L8Aa5Sdr3pKDQS5lG1Op8xASMWMatj7K5QAhb3u2CC6hcW
 dyutIJpS68IwjhJt75jdn866u/Rd46t4x4OYPwn9nNltbhdRhh947SF8bDeqdLu8bUj+
 3XptD3A3MCR6/ViyaC022H67Nek+DrfiI9s9VGjpNsgMnNDzuW6ImRrmY8r5bWGDxRTX Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7kuhsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 17:57:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHoS3Q077215;
        Tue, 27 Oct 2020 17:57:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwumpqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 17:57:27 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RHvRlX011589;
        Tue, 27 Oct 2020 17:57:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 10:57:26 -0700
Date:   Tue, 27 Oct 2020 20:57:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kent Russell <kent.russell@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [kbuild] drivers/gpu/drm/amd/amdkfd/kfd_crat.c:801:9: warning:
 Either the condition '!pcrat_image' is redundant or there is possible null
 pointer dereference: pcrat_image.
Message-ID: <20201027175720.GO18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: TCCQ3WF4OCNME6XM5TMIXOUMYWHBCWYH
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   4525c8781ec0701ce824e8bd379ae1b129e26568
commit: d0e63b343e575e8b74c185565b0d79a93494bcaa drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT
compiler: powerpc64le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:
>> drivers/gpu/drm/amd/amdkfd/kfd_crat.c:801:9: warning: Either the condition '!pcrat_image' is redundant or there is possible null pointer dereference: pcrat_image. [nullPointerRedundantCheck]
    memcpy(pcrat_image, crat_table, crat_table->length);
           ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:802:6: note: Assuming that condition '!pcrat_image' is not redundant
    if (!pcrat_image)
        ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:801:9: note: Null pointer dereference
    memcpy(pcrat_image, crat_table, crat_table->length);
           ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:405:32: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
                                  ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:1112:26: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
                            ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:1146:11: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
             CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
             ^
   drivers/gpu/drm/amd/amdkfd/kfd_crat.c:941:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
     sub_type_hdr++;
     ^

vim +801 drivers/gpu/drm/amd/amdkfd/kfd_crat.c

8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  772  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
174de876d6d02f7 Felix Kuehling         2017-12-08  773  {
174de876d6d02f7 Felix Kuehling         2017-12-08  774  	struct acpi_table_header *crat_table;
174de876d6d02f7 Felix Kuehling         2017-12-08  775  	acpi_status status;
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  776  	void *pcrat_image;
174de876d6d02f7 Felix Kuehling         2017-12-08  777  
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  778  	if (!crat_image)
174de876d6d02f7 Felix Kuehling         2017-12-08  779  		return -EINVAL;
174de876d6d02f7 Felix Kuehling         2017-12-08  780  
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  781  	*crat_image = NULL;
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  782  
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  783  	/* Fetch the CRAT table from ACPI */
174de876d6d02f7 Felix Kuehling         2017-12-08  784  	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
174de876d6d02f7 Felix Kuehling         2017-12-08  785  	if (status == AE_NOT_FOUND) {
174de876d6d02f7 Felix Kuehling         2017-12-08  786  		pr_warn("CRAT table not found\n");
174de876d6d02f7 Felix Kuehling         2017-12-08  787  		return -ENODATA;
174de876d6d02f7 Felix Kuehling         2017-12-08  788  	} else if (ACPI_FAILURE(status)) {
174de876d6d02f7 Felix Kuehling         2017-12-08  789  		const char *err = acpi_format_exception(status);
174de876d6d02f7 Felix Kuehling         2017-12-08  790  
174de876d6d02f7 Felix Kuehling         2017-12-08  791  		pr_err("CRAT table error: %s\n", err);
174de876d6d02f7 Felix Kuehling         2017-12-08  792  		return -EINVAL;
174de876d6d02f7 Felix Kuehling         2017-12-08  793  	}
174de876d6d02f7 Felix Kuehling         2017-12-08  794  
6127896f4a27257 Huang Rui              2020-08-18  795  	if (kfd_ignore_crat()) {
ebcfd1e276207e4 Felix Kuehling         2017-12-08  796  		pr_info("CRAT table disabled by module option\n");
ebcfd1e276207e4 Felix Kuehling         2017-12-08  797  		return -ENODATA;
ebcfd1e276207e4 Felix Kuehling         2017-12-08  798  	}
ebcfd1e276207e4 Felix Kuehling         2017-12-08  799  
d0e63b343e575e8 Kent Russell           2020-09-18  800  	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
d0e63b343e575e8 Kent Russell           2020-09-18 @801  	memcpy(pcrat_image, crat_table, crat_table->length);
                                                                       ^^^^^^^^^^^
Dereferenced before the check for NULL

8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  802  	if (!pcrat_image)
                                                                    ^^^^^^^^^^^^
Check.

8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  803  		return -ENOMEM;
174de876d6d02f7 Felix Kuehling         2017-12-08  804  
8e05247d4c23ff1 Harish Kasiviswanathan 2017-12-08  805  	*crat_image = pcrat_image;
174de876d6d02f7 Felix Kuehling         2017-12-08  806  	*size = crat_table->length;
174de876d6d02f7 Felix Kuehling         2017-12-08  807  
174de876d6d02f7 Felix Kuehling         2017-12-08  808  	return 0;
174de876d6d02f7 Felix Kuehling         2017-12-08  809  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
