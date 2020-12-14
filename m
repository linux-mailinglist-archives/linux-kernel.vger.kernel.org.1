Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083C2D984E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406739AbgLNMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:52:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732174AbgLNMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:52:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BECWHCj193558;
        Mon, 14 Dec 2020 07:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to : sender; s=pp1;
 bh=XZj1J5RML+8dGiI1mOBhArxN8Q5zCMpEepZPxYM0BQo=;
 b=YHcfKe2bDsjvnpJDMg0JHb9z6vhO5G6L5H28Arv/F3dTl99z86Q79KOxTaLn9rjFnA9l
 1QeGfQJvbcepJIqQMJjXXsaTZsBHyJ19DEef4Ye03ESJdQPhROOUfSp+BYPP6wn6yhzE
 9ylJibi8TPj6jtmbgJcHi5qsrvw2429Y8k8rhN7AMKyuKEeZM9RsHEpeVBVQf4nBPH1A
 iosu3/Zd5kHA+6FFKf17Y2dVZ40fdmnEY24BXLiI+iLqCfM1IK9hEMwPamWEmFpmTzgL
 RQjPAmS2MV6ftofWSuGDRrEPrVcvgimCSkq+Dg46rVb7HIJJ0QrD2M7vwnt56kcD0nP7 lw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35e2s59xvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 07:51:14 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BECXfYv032010;
        Mon, 14 Dec 2020 12:51:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8b74y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 12:51:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BECnrdm54198612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 12:49:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5471A4057;
        Mon, 14 Dec 2020 12:49:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2981A4040;
        Mon, 14 Dec 2020 12:49:53 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.92.204])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Dec 2020 12:49:53 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.94)
        (envelope-from <bblock@linux.ibm.com>)
        id 1konIW-000bQw-Sh; Mon, 14 Dec 2020 13:49:52 +0100
Date:   Mon, 14 Dec 2020 13:49:52 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: zfcp: move the position of put_device
Message-ID: <X9dfcBC/qqUc4bmh@t480-pf1aa2c2.linux.ibm.com>
References: <20201201024716.42926-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201024716.42926-1-miaoqinglang@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_05:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:47:16AM +0800, Qinglang Miao wrote:
> Have the `put_device()` call after `device_unregister()` in both
> `zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` to make
> it more natural, for put_device() ought to be the last time we
> touch the object in both functions.
> 
> And add comments after put_device to make codes clearer.
> 
> Suggested-by: Steffen Maier <maier@linux.ibm.com>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  v2: add comments after put_device as Steffen suggested.
> 
>  drivers/s390/scsi/zfcp_sysfs.c | 4 ++--
>  drivers/s390/scsi/zfcp_unit.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Got a bit delayed.
Looks good, I queue it, and we send it with the changes for 5.12 once
the merge window for 5.11 is over.

Thanks.

-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /        Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
