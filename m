Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D252C2823
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgKXNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:35:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKXNe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:34:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AODY6aW063754;
        Tue, 24 Nov 2020 08:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zlBpQ+27YRK6TGmwLtPomnVl9/dkYURlu4zjI6nLEqk=;
 b=mxICq8+PxSZ4244sV0/Ihr1YpNi422j5lYYcuxH75An/z4XTykDZYK1SzrbXMPaw3YGi
 t2/1bhcha/fHGPX9l1F44Nb1vlTWYquhgbQth6eWSwro6zjut3Cl7Mt7SmHocCzPz+kO
 L7vn7p5gTkdmv24MgX5K2ZDaJy8E6ISIUPwAUZEq4WINOBcT2QQ/qx73UEhHaDF3wVPM
 Q+i88bh3eQEft7wgFdhwlxz7+8RYfBTl/l1VHGKsOOEt58bRZfYhzWO/W72Rf+NDibeQ
 JYAazoHtFNRBEXXZ+7SQ2GTyBS1UOfHjXQYra3aQGpXOV9R2/vch+gyublXhUUlq4+27 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350y8jy6kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:34:35 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AODYQIe065928;
        Tue, 24 Nov 2020 08:34:34 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350y8jy6j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:34:34 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AODSAn0022335;
        Tue, 24 Nov 2020 13:34:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 34xth8kh4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 13:34:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AODYTFh54264072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 13:34:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0AC252052;
        Tue, 24 Nov 2020 13:34:29 +0000 (GMT)
Received: from localhost (unknown [9.171.12.143])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3C0D252051;
        Tue, 24 Nov 2020 13:34:29 +0000 (GMT)
Date:   Tue, 24 Nov 2020 14:34:27 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Fix ORC unwind table sorting on big
 endian
Message-ID: <your-ad-here.call-01606224867-ext-8315@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
 <patch.git-45d71f2e4f14.your-ad-here.call-01605357883-ext-1218@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch.git-45d71f2e4f14.your-ad-here.call-01605357883-ext-1218@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=2 clxscore=1015
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 01:53:10PM +0100, Vasily Gorbik wrote:
> Currently when x86_64 kernel is cross compiled on big endian hardware
> ORC unwind table is not sorted correctly. Due to missing byte swaps and
> treating size as 4-byte value ORC sections sizes end up as 0 and the
> problem is silently ignored.
> 
> Make ORC unwind table sorting endianness aware.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  This goes on top of the patch series:
>  http://lkml.kernel.org/r/cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours
> 
>  scripts/sorttable.h | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Friendly ping...
