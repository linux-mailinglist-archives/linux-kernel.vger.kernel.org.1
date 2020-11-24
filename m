Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB142C28A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbgKXNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:48:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15452 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388627AbgKXNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:47:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AODWxbJ033452;
        Tue, 24 Nov 2020 08:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=OjF6bqqG0pJRYJr2z1eRX4IAQ9frRRFFEKx1Ea61Tvg=;
 b=pXye4oCXP/M16Oj70boLGij8UFF93V+5GXxmfjUEBUGwBXHdAN1BOqjYgBeyNln5baev
 wn0wnXTWiTXBjeukkeKrVg3x8k+YINhLVfh7HSn9gN0iijiRqN/Wzc8wFAQEWq13Se6v
 N4xYCFlgb+uqRrk35YNRBAn/3yaGvt4YbYGIxvEFutdV81Qe7Xm7NLQ/YBH5pXUALi2t
 7+HpAtx/DLcmi2dGQqAge02ZOgEJ1ErCeIv4YOTdxlN1FhEBKxlyJK7nLMfz/k/A1lMn
 UNABi3sO6I0tX/wJrn/fIW5tdMP+LK2kEC83DtsfiDgKT8qc7FumYqGU0Nb/I892nWkT iQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350nsds43k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:47:35 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AODc9l3003735;
        Tue, 24 Nov 2020 13:47:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 34xth8khek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 13:47:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AODlVXp6423080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 13:47:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26EAC52052;
        Tue, 24 Nov 2020 13:47:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CDED252054;
        Tue, 24 Nov 2020 13:47:30 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org,
        x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] More RCU vs idle fixes
References: <20201120114145.197714127@infradead.org>
Date:   Tue, 24 Nov 2020 14:47:27 +0100
In-Reply-To: <20201120114145.197714127@infradead.org> (Peter Zijlstra's
        message of "Fri, 20 Nov 2020 12:41:45 +0100")
Message-ID: <yt9dv9du7tow.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=702 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Both arm64 and s390 are tripping over arch_cpu_idle() RCU,tracing,lockdep
> interaction. While looking at that I also found fail in inte_idle.
>
> Please consider for this cycle.

Is anyone taking this patchset? For s390, we also need to change the
local_irq_safe/restore to the raw variants in enabled_wait() in
arch/s390/kernel/idle.c. I can make a patch and carry that via the
s390 tree, but i want to make sure the s390 change in this patchset
also reaches linus' tree.

Thanks
Sven
