Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36B928C434
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgJLVmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:42:32 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:60490 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgJLVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:42:32 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CLXq9j009461;
        Mon, 12 Oct 2020 21:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=MbnACpP2TNsn7jLQ14CWNvdcd+7jO+2XrggHp3sfGrM=;
 b=TD97hNqyRWbvA0C2PL0hMz8V8yeZSGqBkTZ0I8WeSjuC0Qu8UMHqjSNa+FTDvZSMv/eq
 BFjwU3Se+nU03ZJ+uOJtVR/e9wjcGaiKWc4YpQI40tjzXeIGv1349wqto3Xri21FzerL
 6W9aaB2R1AK6vQuWG7JfcWRyQubOxD+eoDbiO5EE/4iRJ1jj+HUwPAIa0/Qm77HsIpSq
 gXo0CKAKJJcO/1dkDcS3BQUvj1tfBOvo9P61pHFwq5/P5tdmm/+neSpDElDVP1ZBZS3V
 mr0jZQKbbDAmoYBc1aUgOvnTPFD+D8DAqICN3Wo0y6fRJYO6cq7fFRP2aAUQn+QF0BLp 0Q== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 343fq07hws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 21:42:28 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id B461BA3;
        Mon, 12 Oct 2020 21:42:27 +0000 (UTC)
Received: from [16.99.129.135] (unknown [16.99.129.135])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 3A16637;
        Mon, 12 Oct 2020 21:42:27 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
Date:   Mon, 12 Oct 2020 14:42:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201012212709.GM25311@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=892 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 2:27 PM, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 02:15:55PM -0700, Mike Travis wrote:
>>> Of course, it also looks like that 'uvh_nmi_mmrx_mask' thing is a
>>> write-only variable so it doesn't matter, but can we _please_ get this
>>> code fixed ASAP?
>>
>> Yes, I'll look at it right now.  Thanks.
> 
> As this variable is write-only you could simply zap it now with a patch
> ontop to fix the build and then introduce it properly later, when you
> really need it?
> 

It should have been an unsigned long instead of an int as Linus 
suggested.  I'm not sure it's a write only variable as I think the mask 
is used to check if the interrupt occurred (I'll have to look closer). 
I'm trying now to send the fixed patch.  It only has this change:

dog 74> diff -u patches/uv5_update_nmi{.v1,}
--- patches/uv5_update_nmi.v1   2020-10-12 16:30:06.083941459 -0500
+++ patches/uv5_update_nmi      2020-10-12 16:30:46.663903731 -0500
@@ -55,7 +55,7 @@
  +static unsigned long uvh_nmi_mmrx;            /* UVH_EVENT_OCCURRED0/1 */
  +static unsigned long uvh_nmi_mmrx_clear;      /* 
UVH_EVENT_OCCURRED0/1_ALIAS */
  +static int uvh_nmi_mmrx_shift;                        /* 
UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
-+static int uvh_nmi_mmrx_mask;                 /* 
UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
++static unsigned long uvh_nmi_mmrx_mask;               /* 
UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
  +static char *uvh_nmi_mmrx_type;                       /* "EXTIO_INT0" */
  +
  +/* Non-zero indicates newer SMM NMI handler present */

(or quoted)

> dog 74> diff -u patches/uv5_update_nmi{.v1,}
> --- patches/uv5_update_nmi.v1   2020-10-12 16:30:06.083941459 -0500
> +++ patches/uv5_update_nmi      2020-10-12 16:30:46.663903731 -0500
> @@ -55,7 +55,7 @@
>  +static unsigned long uvh_nmi_mmrx;            /* UVH_EVENT_OCCURRED0/1 */
>  +static unsigned long uvh_nmi_mmrx_clear;      /* UVH_EVENT_OCCURRED0/1_ALIAS */
>  +static int uvh_nmi_mmrx_shift;                        /* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
> -+static int uvh_nmi_mmrx_mask;                 /* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
> ++static unsigned long uvh_nmi_mmrx_mask;               /* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
>  +static char *uvh_nmi_mmrx_type;                       /* "EXTIO_INT0" */
>  +
>  +/* Non-zero indicates newer SMM NMI handler present */
