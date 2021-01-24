Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3369301AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 10:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAXJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 04:00:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbhAXJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 04:00:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10O8iAVY107321;
        Sun, 24 Jan 2021 03:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=SNe1zLUkHXj8kWpkclhOdG1Gzk31KCtk7YBH5dFvtqs=;
 b=eNR1ep01KhBQwDtpa62r9w8ScGoGj1jL1LWHF6AlMclKBT8KTFpfffBedseBDXkhC/nX
 36lr1uv5H+T1DT/bZNXPqJmf10GsqghbjGzmc+KtwVNSsKhlP46jMXQVzKYFHiYs0ygG
 LLS4nGthNaDVS04RwdVcTSNrA6mVJUpELdo1iTXW+E3Ivz0pV1XM6KZZDElVsYGwp0rj
 PD0Ak3GX2Lh2PycxzhnTGHc84lyPwogZOcrlFUGCrOngmXOk0M8MV/S0qhe9DIVyMSJY
 K+HWN+tfrDYcJg8CgER5khUxzHySHKHriUsj6Mm/9iErDBms3CUfailUMZtMPSzEXtxc 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3695n086ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 03:59:32 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10O8iO8u107455;
        Sun, 24 Jan 2021 03:59:32 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3695n086n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 03:59:31 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10O8wAFg021584;
        Sun, 24 Jan 2021 08:59:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 368b2h8f3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 08:59:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10O8xKh731850898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Jan 2021 08:59:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE80A405C;
        Sun, 24 Jan 2021 08:59:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF7DBA4054;
        Sun, 24 Jan 2021 08:59:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 24 Jan 2021 08:59:26 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
References: <20210114170412.4819-1-john.ogness@linutronix.de>
        <yt9dk0s48y70.fsf@linux.ibm.com>
        <87v9bomtd0.fsf@jogness.linutronix.de>
        <yt9deeibe4ia.fsf@linux.ibm.com> <yt9d8s8je3gc.fsf@linux.ibm.com>
        <87k0s2n45n.fsf@jogness.linutronix.de>
Date:   Sun, 24 Jan 2021 09:59:21 +0100
In-Reply-To: <87k0s2n45n.fsf@jogness.linutronix.de> (John Ogness's message of
        "Sun, 24 Jan 2021 09:19:40 +0106")
Message-ID: <yt9d1reayal2.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_02:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=961 phishscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> writes:

> Hi Sven,
>
> Thanks for the outstanding analysis!
>
> On 2021-01-23, Sven Schnelle <svens@linux.ibm.com> wrote:
>>> 1401		if (buf_size > 0)
>>> 1402			text[len] = 0;
>>
>> I don't think i have really understood how all the printk magic works,
>> but using r->text_buf[len] seems to be the correct place to put the
>> zero byte in that case?
>
> Yes, you are correct! @text is pointing to the beginning of the
> currently processed line, not the beginning of the buffer.
>
> I will submit a patch to fix our recent fix (unless you would like to do
> that).

Please go ahead, thank you!
