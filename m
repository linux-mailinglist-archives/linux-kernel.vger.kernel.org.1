Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44F28C3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbgJLVQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:16:02 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34258 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729454AbgJLVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:16:01 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CLDFUk009839;
        Mon, 12 Oct 2020 21:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=82gI87cN/PcYJfamurjkIo3GVLXjkWeQJtlIetXd9Og=;
 b=ffqA1RfuwKhOONpAFf/jG1g4bC/UQ20iWZaCGz76yjwwRCIJBs1X/f3e3U0H2DSKfG9W
 7VgKCmWU+52t+sQZhdNvpIQef0vk0QlIcZUDdRlz3sWkTmkU/eq3zI2PO3nne8pIpxbD
 pLOoI6KgVzLbCkgwV5QPVytFN/HsSAnkQww8nxikqAAEhwchjHTukRkOem0eS/Ix2qqX
 wf45kx3ZANn0ciZpibKtpLlb36X0JRlUgdpX9VMqFsbZTaQPitA4QDuHQZuWr01lOeDw
 8o0oVOwll/Sd4Qe6gg2XBNBDftCrw+bVnV992RTT//7Auh/RLC0MAfauEa/6GmCZG5Uc BA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 343fq07cme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 21:15:56 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 1D28EB0;
        Mon, 12 Oct 2020 21:15:56 +0000 (UTC)
Received: from [16.99.129.135] (unknown [16.99.129.135])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 818463D;
        Mon, 12 Oct 2020 21:15:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
Date:   Mon, 12 Oct 2020 14:15:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=966 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 2:10 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 3:10 AM Borislav Petkov <bp@suse.de> wrote:
>>
>> please pull the x86/platform queue.
> 
> Hmm. I didn't immediately notice this new warning, because it only
> happens with the clang build that I don't do in between every pull.
> 
> But this pull causes new warnings from clang:
> 
> arch/x86/platform/uv/uv_nmi.c:250:23: warning: implicit conversion
> from 'unsigned long' to 'int' changes value from 1152921504606846976
> to 0 [-Wconstant-conversion]
>                  uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
>                                    ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> and I think that warning is correct, and the code is wrong.
> 
> In particular, we have
> 
>       static int uvh_nmi_mmrx_mask;
> 
> so it's a signed 32-bit integer, and the code is treating it like it's
> a 64-bit mask.
> 
> Of course, it also looks like that 'uvh_nmi_mmrx_mask' thing is a
> write-only variable so it doesn't matter, but can we _please_ get this
> code fixed ASAP?

Yes, I'll look at it right now.  Thanks.
> 
>                       Linus
> 
