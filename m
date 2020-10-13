Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938F28CF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgJMNhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:37:52 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:3808 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727245AbgJMNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:37:51 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DDWHM1025543;
        Tue, 13 Oct 2020 13:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=1s2ZCSfK9nLLPox/9MaZsk5QI3ha13Ok9Fi8oYKbAWo=;
 b=k4LEiNKb/wzIXgG67pmPgQpE76luAR8j4JLcuG+mL5ap2OlrvTrO7eES7JYFfUAqwm5h
 ZdbBOmmebOkorupppeuxrXYR6P1VeZO86CRBGObYSbEpzOBvVTQoErC7H+kgEnbU12dn
 xQj8y3AtvUyZ0g6lCwH4QJ8EvOWbxQjtdAYHK57H73+Tqh4yCJ05ehZTFQvf7b8yX/kK
 Fs3+Kvy78wnCTjsohtZXO132Dxr1y19WYi97Z9MjeAJjs9uHlSX+JQp2pCBrB0l9GxL0
 HcmXQTc3aygOvzTiUnt9CXNDImDe3HAYCKHEtobsJPWB5qk/X5TkYaAdo5o9op7QZfgX Tg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 343pp5kndu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 13:37:42 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id D2A1889;
        Tue, 13 Oct 2020 13:37:41 +0000 (UTC)
Received: from [16.99.129.135] (unknown [16.99.129.135])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id F121139;
        Tue, 13 Oct 2020 13:37:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
 <20201013111158.GD32151@zn.tnic>
 <25632026-b498-022c-f37e-444672d57ecb@hpe.com>
 <20201013132940.GE28215@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <93b52b3e-8eda-eb46-0feb-1c02c92d3819@hpe.com>
Date:   Tue, 13 Oct 2020 06:37:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201013132940.GE28215@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_05:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 6:29 AM, Borislav Petkov wrote:
> On Tue, Oct 13, 2020 at 05:33:37AM -0700, Mike Travis wrote:
>> I'm working on the correct code now, and I have UV4 & UV4A machine time
>> starting at 7am (PDT) to test it.  The UV5 simulator does not yet emulate
>> console initiated NMI from the BMC.
> 
> Ok, let me put it another way: is this simple fix good enough for now so
> that it doesn't trigger the build error on Linus' tree or not? You can
> take your time and do all kinds of fixing later but we need a minimal
> fix *now*!
> 
> Pretty please?
> 

Yes, it does fix the compile error.
