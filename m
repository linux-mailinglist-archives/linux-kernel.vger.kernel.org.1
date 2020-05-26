Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACBE1A4A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDJT2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:28:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbgDJT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:28:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AJ47Ud077233;
        Fri, 10 Apr 2020 15:28:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3091yca62u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 15:28:23 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03AJ4jpQ078842;
        Fri, 10 Apr 2020 15:28:23 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3091yca62e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 15:28:23 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03AJKlD3015826;
        Fri, 10 Apr 2020 19:28:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3091meeqt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 19:28:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03AJSLwg52887994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Apr 2020 19:28:21 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C3E17805E;
        Fri, 10 Apr 2020 19:28:21 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D69D578060;
        Fri, 10 Apr 2020 19:28:20 +0000 (GMT)
Received: from localhost (unknown [9.85.153.52])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Apr 2020 19:28:20 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 1/1] powerpc/rtas: Implement reentrant rtas call
In-Reply-To: <20200408223901.760733-1-leonardo@linux.ibm.com>
References: <20200408223901.760733-1-leonardo@linux.ibm.com>
Date:   Fri, 10 Apr 2020 14:28:20 -0500
Message-ID: <87ftdb87jf.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_07:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 mlxlogscore=999 suspectscore=1 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Bras <leonardo@linux.ibm.com> writes:
> Implement rtas_call_reentrant() for reentrant rtas-calls:
> "ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive".
>
> On LoPAPR Version 1.1 (March 24, 2016), from 7.3.10.1 to 7.3.10.4,
> items 2 and 3 say:
>
> 2 - For the PowerPC External Interrupt option: The * call must be
> reentrant to the number of processors on the platform.
> 3 - For the PowerPC External Interrupt option: The * argument call
> buffer for each simultaneous call must be physically unique.
>
> So, these rtas-calls can be called in a lockless way, if using
> a different buffer for each call.

From the language in the spec it's clear that these calls are intended
to be reentrant with respect to themselves, but it's less clear to me
that they are safe to call simultaneously with respect to each other or
arbitrary other RTAS methods.


> This can be useful to avoid deadlocks in crashing, where rtas-calls are
> needed, but some other thread crashed holding the rtas.lock.

Are these calls commonly used in the crash-handling path? Is this
addressing a real issue you've seen?


> +/*
> + * Used for reentrant rtas calls.
> + * According to LoPAR documentation, only "ibm,int-on", "ibm,int-off",
> + * "ibm,get-xive" and "ibm,set-xive" are currently reentrant.
> + * Reentrant calls need their own rtas_args buffer, so not using rtas.args.
> + */

Please use kernel-doc format in new code.


> +int rtas_call_reentrant(int token, int nargs, int nret, int *outputs, ...)
> +{
> +	va_list list;
> +	struct rtas_args rtas_args;
> +
> +	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
> +		return -1;
> +
> +	va_start(list, outputs);
> +	va_rtas_call_unlocked(&rtas_args, token, nargs, nret, list);
> +	va_end(list);

No, I don't think you can place the RTAS argument buffer on the stack:

  7.2.7, Software Implementation Note:
  | The OS must be aware that the effective address range for RTAS is 4
  | GB when instantiated in 32-bit mode and the OS should not pass RTAS
  | addresses or blocks of data which might fall outside of this range.

