Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED4F2EA85C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbhAEKN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:13:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728067AbhAEKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:13:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105A2llj131016;
        Tue, 5 Jan 2021 05:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=AMv2YmmLgL/CJeMtOpV2cTmp3+GOa/MTH4+kSDcnO64=;
 b=MhwccYJgqUk/Oq8UNrMVeWZsw4b5K0pzDFig1bjND6c7+1HGMkaHJ6H4FGXOb2yEqC1p
 Eano9okvWoy6gNc76wcuYurbKPNwQDuyA4+QqEK5u88DbQmXmQJx45X2kE+J6J6e3sY1
 e0omrc1t6soIL1XFnJTY74q6OndI/BnGU4gpdE0dGZxVY9V5SeIWDPq7XxBuOzRVaLh5
 QWT/QstniqkQgTQcHDxCqoWPPiIIVXrXtxEcn+VBwVMgkmVA0MTyqFoAdI7nWob+5Hy4
 OI9BoRaxh+oxqv1B+x/IC2jZCMy3CCwcpoJBw46XZUPM0zncdAJaF/wAN/escoBLFHbr Sg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vnvgrnjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 05:12:47 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105ACB4f006502;
        Tue, 5 Jan 2021 10:12:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 35tg3has82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:12:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105ACd0528377394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 10:12:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9354311C054;
        Tue,  5 Jan 2021 10:12:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04DE211C052;
        Tue,  5 Jan 2021 10:12:42 +0000 (GMT)
Received: from localhost (unknown [9.85.82.253])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 10:12:41 +0000 (GMT)
Date:   Tue, 05 Jan 2021 15:42:44 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Disable multiple_kprobes test on
 powerpc
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        shuah@kernel.org
References: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
In-Reply-To: <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1609841373.5sgt2b2ism.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=873 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue,  5 Jan 2021 12:27:30 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
>> test until that is sorted, so that rest of ftrace and kprobe selftests
>> can be run.
>=20
> This looks good to me, but could you try to find the functions
> which should be blocked from kprobes?
> (Usually, the function which are involved in the sw-breakpoint
>  handling, including locks etc.)

Yes, we did add several blacklists some time back, but there has been=20
quite a bit of churn in our entry code. I've been meaning to audit it=20
for a while now, but this has been blocking tests. It would be nice to=20
skip this test for now until I am able to spend some time on this.

Thanks,
Naveen

