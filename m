Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5D2A3768
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKCABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:01:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17324 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgKCABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:01:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2NXESV171339;
        Mon, 2 Nov 2020 19:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y9Nos3ahvz3IxqudanRH2iJeOKQpNN+5l54NhP5KCzo=;
 b=GpLg8o8hjViBDzluxNHyklEF+vhU8vjmP2xyfuH6d4Rv/kMexNEGOhTqc1hIh63yib6y
 m/TFDF9sIeN1Z1mOr8+KLU9z5LWH+PCFLF8sX+H19/mLvJNf7WnGQrkuuwmk+ShUgX/6
 y6LPzyZ9FjC1R+R0hVawrrpjilykMY2wfzrNIIwa1705dE3dnjFVOm5N9+CxpmlBH9hZ
 W2e8dqWPuxRv/u4s4OVGS8/XSlxYzaFqDR103DecE8Dc3JH8okN9EblgddwA3IKPysGp
 w9/F/7hDCyU33jOq77tfBaMSur/dVYJSCvbwKAphBFXXwnX8YRc54XJMmWuYMUaOQVlk gw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jm70eska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 19:01:30 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2NvnaX013803;
        Tue, 3 Nov 2020 00:01:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 34h01khb87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 00:01:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A301PBZ55050680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 00:01:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA332AE04D;
        Tue,  3 Nov 2020 00:01:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 762FCAE045;
        Tue,  3 Nov 2020 00:01:25 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 00:01:25 +0000 (GMT)
Received: from [9.81.211.185] (unknown [9.81.211.185])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A72E8A00BD;
        Tue,  3 Nov 2020 11:01:23 +1100 (AEDT)
Subject: Re: [PATCH v2 2/2] misc: ocxl: config: Rename function attribute
 description
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20201102142001.560490-1-lee.jones@linaro.org>
 <20201102142001.560490-2-lee.jones@linaro.org>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <82b78262-14a5-d384-0c78-d4876d85f713@linux.ibm.com>
Date:   Tue, 3 Nov 2020 11:01:22 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102142001.560490-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_16:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 1:20 am, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/misc/ocxl/config.c:81: warning: Function parameter or member 'dev' not described in 'get_function_0'
>   drivers/misc/ocxl/config.c:81: warning: Excess function parameter 'device' description in 'get_function_0'
> 
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks!

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
