Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AECC26869A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgINH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:56:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgINHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08E7VhQE069780;
        Mon, 14 Sep 2020 03:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=paEL0PaoPgSc9IEP40AlUAUmQ6zab0AuVqqu/4/YaCI=;
 b=jgGN0BrMLz5wPrdbx/zx8UHL5qqk9FN5pS2vevbhM0KSz8a5Uz1IpQjLhHKaIgel+xWq
 uokUpk/P8YnzZj+1bZ38f0mHNxJcZ607wfioLJiKLFE+hBMyvnlmNJ56lDSRjh3V+QZO
 rhC2wbgGMLgSO6jUNmRt75DeOcjHQAOJG7RMx/R7QLxD4nuFbhRlglcEGU0Jkf0378JO
 r4C2/wmec2qYxXI61gId4A4IB+wKXfRy05kOoD62wZhbJjUBDJubr/N8D3YK18+Ttd39
 MOSLTKY/VLTRsEtiajakR4bj2XyG6rQL90xUYd6lGmajDGPdtOXxz9kNRapTYcVFD1qC Xw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33j44qrpks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 03:55:52 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E7r0PO024889;
        Mon, 14 Sep 2020 07:55:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 33hjgdrcjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 07:55:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08E7sEDt21954918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 07:54:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F027742042;
        Mon, 14 Sep 2020 07:55:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABED54203F;
        Mon, 14 Sep 2020 07:55:47 +0000 (GMT)
Received: from osiris (unknown [9.171.3.188])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Sep 2020 07:55:47 +0000 (GMT)
Date:   Mon, 14 Sep 2020 09:55:46 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt device
 driver
Message-ID: <20200914075546.GA11573@osiris>
References: <20200910102838.28887-1-freude@linux.ibm.com>
 <20200911062134.GB21597@lst.de>
 <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_09:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=986 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=2
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:36:07AM +0200, Harald Freudenberger wrote:
> Otherwise how to we provide this fix then ? My recommendation would
> be to go the 'usual' way: Commit this s390 internal and then let
> this go out with the next kernel merge window when next time Linus
> is pulling patches from the s390 subsystem for the 5.10 kernel
> development cycle.

I will create a "set_fs" topic branch on kernel.org based on
vfs.git/base.set_fs and add your patch there and also the rest of
s390 set_fs related patches on top of that as soon as things are
ready.
