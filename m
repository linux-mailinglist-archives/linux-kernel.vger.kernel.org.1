Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06072CD4EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgLCLvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:51:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgLCLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:51:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Bf0Ou131813;
        Thu, 3 Dec 2020 06:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NB0+Qh1bkZLQI3ZOcH++d50o1IticgktyjhpCKbjgb8=;
 b=pDTeRuiSKbNvdWW3Ea85Cm/g9lAzHFcvyYYaoS9SDP4egMOzxe+kM3qsvepftgInRhQC
 qot6qYoObIWkTM9wkADryOh4b5UURZ93y9osGop4ZK6q3IOMjjF4fyEl5l3XedSItOSa
 0r51Q16baTsO6Cn+81y8UhIkbQ2FFSOb4mhLm8unYliak3l3afwez6/CDkAobaH8oHtv
 dZYE9ApPjqJxudXHr6XbpntSZkvL+Qr2WnmcPWSXRHDCgG12mQbXiLr/Qmigt4ntHwzW
 IxsG+6FFr/PFz8ujCCBri3Qh4MGiozyTYCcDB3iS/mZ+4/z7PhswifRAbCBOFsGGsCE2 /w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356wbemn0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 06:50:51 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BhJTL030799;
        Thu, 3 Dec 2020 11:50:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 353e687nvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 11:50:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3BmG6V7799342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 11:48:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74CACAE05F;
        Thu,  3 Dec 2020 11:48:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 245ADAE057;
        Thu,  3 Dec 2020 11:48:16 +0000 (GMT)
Received: from [9.145.44.252] (unknown [9.145.44.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Dec 2020 11:48:16 +0000 (GMT)
Subject: Re: arch/s390/pci/pci_event.c:101 __zpci_event_availability() error:
 we previously assumed 'zdev->zbus' could be null (see line 83)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <20201203102759.GQ2767@kadam>
 <52b96642-f78c-478e-913d-b294c385c5ab@linux.ibm.com>
 <20201203111954.GK2789@kadam>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <92d88da8-b5ab-4c50-25c8-d8bf045551e4@linux.ibm.com>
Date:   Thu, 3 Dec 2020 12:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201203111954.GK2789@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 12:19 PM, Dan Carpenter wrote:
> On Thu, Dec 03, 2020 at 11:52:48AM +0100, Niklas Schnelle wrote:
>>
>>
>> On 12/3/20 11:27 AM, Dan Carpenter wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
>>> head:   3bb61aa61828499a7d0f5e560051625fd02ae7e4
>>> commit: 3047766bc6ec9c6bc9ece85b45a41ff401e8d988 s390/pci: fix enabling a reserved PCI function
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> smatch warnings:
>>> arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we previously assumed 'zdev->zbus' could be null (see line 83)
>>>
>>> vim +101 arch/s390/pci/pci_event.c
>>>
>>> aa3b7c296732b43 Sebastian Ott   2013-12-12   76  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>>> cbc0dd1f856b52b Jan Glauber     2012-11-29   77  {
>>> cbc0dd1f856b52b Jan Glauber     2012-11-29   78  	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
>>> 9a99649f2a89fdf Sebastian Ott   2016-01-29   79  	struct pci_dev *pdev = NULL;
>>> 623bd44d3f277b7 Sebastian Ott   2017-05-09   80  	enum zpci_state state;
>>> d795ddad36cbc82 Sebastian Ott   2013-11-15   81  	int ret;
>>> cbc0dd1f856b52b Jan Glauber     2012-11-29   82  
>>> 05bc1be6db4b268 Pierre Morel    2020-03-23  @83  	if (zdev && zdev->zbus && zdev->zbus->bus)
>>>                                                                      ^^^^^^^^^
>>> Check for NULL
>>>
>>> 44510d6fa0c00aa Pierre Morel    2020-04-22   84  		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
>>> 9a99649f2a89fdf Sebastian Ott   2016-01-29   85  
>>> 1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   86  	zpci_err("avail CCDF:\n");
>>> 1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   87  	zpci_err_hex(ccdf, sizeof(*ccdf));
>>> cbc0dd1f856b52b Jan Glauber     2012-11-29   88  
>>> cbc0dd1f856b52b Jan Glauber     2012-11-29   89  	switch (ccdf->pec) {
>>> 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   90  	case 0x0301: /* Reserved|Standby -> Configured */
>>> 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   91  		if (!zdev) {
>>> f606b3ef47c9f87 Pierre Morel    2020-03-25   92  			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 1);
>>> 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   93  			break;
>>> 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   94  		}
>>> fcf2f402937a669 Sebastian Ott   2013-12-18   95  		zdev->fh = ccdf->fh;
>>> f606b3ef47c9f87 Pierre Morel    2020-03-25   96  		zdev->state = ZPCI_FN_STATE_CONFIGURED;
>>> 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   97  		ret = zpci_enable_device(zdev);
>>> 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   98  		if (ret)
>>> 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   99  			break;
>>> 3047766bc6ec9c6 Niklas Schnelle 2020-06-18  100  
>>> 3047766bc6ec9c6 Niklas Schnelle 2020-06-18 @101  		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
>>>                                                                                               ^^^^^^^^^^^^^^^^
>>> Unchecked dereference
>>
>> First, thanks for reporting this is definitely appreciated!
>> We have also seen the same smatch report internally 
>> and I determined that this is a false positive.
>>
>> This is because the existing zdev->zbus NULL check could already never
>> trigger.
> 
> I don't consider it a "false positive" exactly because the NULL checking
> is inconsisent.  I would instead say that it is "correct but harmless".

Good point, I think your wording captures the situation better and I agree
the checks as is definitely inconsistent.

> 
> That said, if Smatch can determined that "zdev->zbus" is not NULL then
> it doesn't print a warning in these situations.  As it stands now Smatch
> doesn't understand lists very well, but I plan to fix this in upcoming
> months.  Once that gets fixed, Smatch will still assume that
> zpci_create_device() is racy...  :/  And then finally it will only
> silence the warning when the cross function database has been built and
> I don't think the the zero bot builds the DB for s390.

Sounds like some exciting developments are ahead that will
make smatch even more powerful. That said, it's already pretty amazing
to me what it does.

> 
> Anyway, these don't affect runtime so it's not time sensitive.  Thanks
> for taking the time to look at these!

Thank you for working on smatch. The report it gave for this definitely
made it easy to understand why it was complaining and when I saw it on our
internal smatch I too wasn't immediately sure it was harmless so the report was
definitely useful.

> 
> regards,
> dan carpenter
> 
