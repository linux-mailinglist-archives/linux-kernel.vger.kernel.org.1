Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F030189B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbhAWVm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 16:42:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbhAWVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 16:42:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10NLWMKR176482;
        Sat, 23 Jan 2021 16:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=lE60vpXqpKtW3AkS89mfSNdJOESBN1hLw2h+uxilxmY=;
 b=nk4FF9WUwBXBm8Vzg4UJlIMIY4VgA38j2M6QlgvzABtkp5CHtvjso5uTkCKTkXVtioMq
 zE2wljsAwmzv/i89JsebhcDMwWyM9y+AOlOfAPXy0OBGrdUwRpfS44pTxBJBJExndiq0
 UZEWw735uzw8y5JnxiZSFSR+fL8Hyc8g4zIjv/Hfd3G280BTMQhnTKaughPcovHQwgTa
 mo7bqRQPgcQAm4jANNVGGiNYXOigFA613BLtlD6XPBeJYf5LfbxxCD1PT3cpzhvaRwWg
 pR5CExgucFr+BlOwXloVeOMyQXEDnPMeQBZ6VJ9uRypm2A6HSoS/UVkAkQOgEHTnNvun /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 368uh1rcbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 16:41:29 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10NLYYM8183328;
        Sat, 23 Jan 2021 16:41:29 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 368uh1rcb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 16:41:29 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10NLXA2t020959;
        Sat, 23 Jan 2021 21:41:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 368be888u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 21:41:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10NLfOgl44630354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 21:41:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60D6A5204E;
        Sat, 23 Jan 2021 21:41:24 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1C2BE52050;
        Sat, 23 Jan 2021 21:41:24 +0000 (GMT)
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
        <yt9deeibe4ia.fsf@linux.ibm.com>
Date:   Sat, 23 Jan 2021 22:41:23 +0100
In-Reply-To: <yt9deeibe4ia.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Sat, 23 Jan 2021 22:18:37 +0100")
Message-ID: <yt9d8s8je3gc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_12:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=992 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101230123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> John Ogness <john.ogness@linutronix.de> writes:
>
>> On 2021-01-22, Sven Schnelle <svens@linux.ibm.com> wrote:

> I was able to reproduce it in a virtual machine where i have a few more
> ways to debug. What i got was:
>
> 01:  -> 00000000001B8814"  MVI     92001000 >> 000000000163F1CD     CC 2
>
> That's a watchpoint telling me that the code at 0x1b8814 wants to store
> one byte to 0x163f1cd, which is the second byte of console_drivers.
>
> gdb tells me about 0x1b8814:
>
> (gdb) list *(0x1b8814)
> 0x1b8814 is in record_print_text (/home/svens/ibmgit/linux/kernel/printk/printk.c:1402).
> 1397		 * If a buffer was provided, it will be terminated. Space for the
> 1398		 * string terminator is guaranteed to be available. The terminator is
> 1399		 * not counted in the return value.
> 1400		 */
> 1401		if (buf_size > 0)
> 1402			text[len] = 0;

I don't think i have really understood how all the printk magic works,
but using r->text_buf[len] seems to be the correct place to put the zero byte
in that case?

> 1403	
> 1404		return len;
> 1405	}
> 1406
>

