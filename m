Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26743268629
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgINHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:36:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64210 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgINHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:36:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08E7WXKN165771;
        Mon, 14 Sep 2020 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yNe57v5tEM2OGM2g/Zi7f23YnshelszlVWqCz72cyv0=;
 b=aFXYhS6eUGGFSO8lf6hcQBAu+T/xwF1YAIyvk45r2o9skToZINNIJ1BSC87zyysOeBD2
 +90tuTnBl1TwZtEjUW3mX/jdEj76p43PzI8K+4cVkllazhGQJZqJLE/8CD/LI+zNr/d2
 jqO0OfhZS7B6jTJwwPdFtu0pE4ySJ5xl07hS/3bf2t/T0EOf7EOwQA7G6uTLg4YL7neI
 aUb4uDc3aKLQzIuH5Joeso1MkauOChSGlV1QgWFApu/+FeIwwff7Ai71LuZTuSGcQlbF
 pHAiBVkY2XLI3ZxEVbgTlQLIgiuWuCigY32gj8IJAgHihlWwpDOP74XPo303jlbwesuf mA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33j3c71puh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 03:36:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E7XAgd018708;
        Mon, 14 Sep 2020 07:36:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 33gny8116s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 07:36:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08E7a3C019136950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 07:36:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D50724203F;
        Mon, 14 Sep 2020 07:36:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F75E42045;
        Mon, 14 Sep 2020 07:36:03 +0000 (GMT)
Received: from funtu.home (unknown [9.171.37.48])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 07:36:03 +0000 (GMT)
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt device
 driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200910102838.28887-1-freude@linux.ibm.com>
 <20200911062134.GB21597@lst.de>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
Date:   Mon, 14 Sep 2020 09:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911062134.GB21597@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_09:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.20 08:21, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 12:28:38PM +0200, Harald Freudenberger wrote:
>> +static inline unsigned long z_copy_from_user(bool userspace,
>> +					     void *to, const void __user *from, unsigned long n)
> Can you avoid the pointless long lines in the function declaration?
Yes, will do.
>
>> +{
>> +	if (likely(userspace))
>> +		return copy_from_user(to, from, n);
>> +	memcpy(to, (void __force *) from, n);
>> +	return 0;
>> +}
>> +
>> +static inline unsigned long z_copy_to_user(bool userspace,
>> +					   void __user *to, const void *from, unsigned long n)
>> +{
>> +	if (likely(userspace))
>> +		return copy_to_user(to, from, n);
>> +	memcpy((void __force *) to, from, n);
>> +	return 0;
> Otherwise this doesn't look great, but also not horrible and gets rid
> of the set_fs while reducing the lines of code, so:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Christoph, maybe you have a greater idea on how to solve this. So don't hesitate and tell me.
Otherwise how to we provide this fix then ? My recommendation would be to go the 'usual' way:
Commit this s390 internal and then let this go out with the next kernel merge window when
next time Linus is pulling patches from the s390 subsystem for the 5.10 kernel development cycle.

