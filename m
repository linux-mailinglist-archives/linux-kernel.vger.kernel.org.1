Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DE28CE69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgJMMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:33:44 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42552 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbgJMMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:33:43 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DCSeQL013062;
        Tue, 13 Oct 2020 12:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=qNMdHBqXqwaf90OVuzZBNx3mK1NeTl6sFfUOFag2YLI=;
 b=gFmEEBph2G03onC6a38/t1L03B/BsK9NEQNPzLfCI9bVZLj0MXHTTPVgZsPHpdJy2VKy
 M1iOOLtBUPl8yQRLEK3xnOXHPgPWceu80qYpZEzbcIxIcnXgoLJlfpBtGo1ItBuTVNDs
 9HeoZhgItVctSKsc69iupb1nnU5NvtjEtMvxdxmovrs2LexT8P8z4qxaT78FWZ3ihHOK
 u6XRWmlYCxl0uG+lTa/8FOI967yqatBx/nnq0hvEx0MGE826RLcQTCBVBsqRBBxksAQI
 doRtXu9QniUiIZObd7PndC/jgx7CcFHEi3dQSJgyYVZGqLMZqdy7Gm/GBRzlsgS+8p2y dQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 343pfkka31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 12:33:39 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 60E9E91;
        Tue, 13 Oct 2020 12:33:38 +0000 (UTC)
Received: from [16.99.129.135] (unknown [16.99.129.135])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C1BF737;
        Tue, 13 Oct 2020 12:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
 <20201013111158.GD32151@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <25632026-b498-022c-f37e-444672d57ecb@hpe.com>
Date:   Tue, 13 Oct 2020 05:33:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201013111158.GD32151@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_03:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=931
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 4:11 AM, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 02:58:07PM -0700, Mike Travis wrote:
>> I was in the process of tracing it through and perhaps it does need a bit
>> more analysis to be correct.  What does it mean to send a patch to fix the
>> compile error, just remove it?
> 
> Yes, to remove it for now as it is unused currently. But making it an
> unsigned long is ok too AFAICT. So should I queue it and send it to
> Linus later?
> 

I'm working on the correct code now, and I have UV4 & UV4A machine time 
starting at 7am (PDT) to test it.  The UV5 simulator does not yet 
emulate console initiated NMI from the BMC.
