Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2432DE50A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgLROly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:41:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgLROlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:41:53 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BIEWCFL031958;
        Fri, 18 Dec 2020 09:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=/nS1ZT32K5g6u05vb/ouY0Xy92r7TYZJv3aBQ6ccv4Q=;
 b=fo2goudPnH013gRk19Qv05a08gAugF9CkvwR/Wuq7DOJE4E3lI7T+dm4PK55CY9uY5+y
 sUq5YN6swwlXAhG2rG035GkOXpBfVpSCFDoi5qiDcQV2dWCe1DuSchQldLF1PkZJSr3a
 2sLKuu50DqIUqSXQ3O06SF/xrFB/GRWsHEuRg2Mt4nSEKoOkrOPPS+oLqfCbX6ZdnDQL
 +VXu4aHxdTKEoayRpyafMyKME/cA3ral6KDMuKHZSfnzCzQdKSWR0wbdRsiGzLMc5gyr
 k1na1ehFik9jOv4Zr+WCHINnzsPXshL4SxVzwc9oSDuJeJT5nV/c5SQJJS8AxrKm+jsF sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35gv0fbufm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 09:39:36 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BIEWrKs033799;
        Fri, 18 Dec 2020 09:39:17 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35gv0fbu9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 09:39:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BIEccA8005718;
        Fri, 18 Dec 2020 14:39:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng8eedw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 14:39:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BIEd0G76357252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 14:39:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433F011C050;
        Fri, 18 Dec 2020 14:39:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FB6111C04A;
        Fri, 18 Dec 2020 14:38:59 +0000 (GMT)
Received: from localhost (unknown [9.85.94.234])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Dec 2020 14:38:59 +0000 (GMT)
Date:   Fri, 18 Dec 2020 20:08:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
        <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
        <20201218112659.GB325926@kernel.org> <20201218113209.GD325926@kernel.org>
In-Reply-To: <20201218113209.GD325926@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1608301824.eljlhiafee.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_09:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 18, 2020 at 08:26:59AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Fri, Dec 18, 2020 at 03:59:23PM +0800, Tiezhu Yang escreveu:
>> > This silences the following tools/perf/ build warning:
>> > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/=
syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/s=
yscall.tbl'
>>=20
>> Hi Ravi, Naveen,
>>=20
>> 	Can I get your Reviewed-by or Acked-by for this change and the
>> other that adds s390's syscall.tbl to check_headers.sh so that we get
>=20
> oops s/s390/powerpc/g :-)
>=20
>> notified when the copy drifts, so that we can see if it still continues
>> working and we can get new syscalls to be supported in things like 'perf
>> trace'?

Yes, this looks good to me:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

FWIW, I had posted a similar patch back in April, but glad to have this=20
go in ;)
http://lkml.kernel.org/r/20200220063740.785913-1-naveen.n.rao@linux.vnet.ib=
m.com


Thanks,
Naveen

