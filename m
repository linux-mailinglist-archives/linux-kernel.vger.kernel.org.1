Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5287A26CE95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIPWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:20:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPWUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:20:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEOqtG139734;
        Wed, 16 Sep 2020 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sMO9dOSd55gfD34Ih+uz0eloTznXsxzz/6Aq4hBRFtY=;
 b=q01ze8IUV9+Ff75U0rhUgyS9AkvY11qvQVHdh4SsZhMtHpJeq9cgsv5b3ZlwXe1Bd6We
 8i241nhInwOKktCYajcNEZTMB3/M9GZvjDlkgx07yFHc66s9/2ZDemYEM/NkAeyxkH9m
 OWt+5TUffQP3fq7hNIABApDWEdCh0wQve7pCsz/V6UFOjiIiA/n4FXqCIETxO/bzDynR
 BJKl73IEtosbiEI5w6TOssNIHRFRAdHbmlx9iBpdwIS9vbOJdaZAbAA4r2tb0zuQaXBf
 UrCvyxot+xB7bgamJPbWK6HuU6d5UUIWdoFFGqbvhWkDvv8liEQAl8mcGjchUfnJNHrR bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33gp9mbdcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 14:27:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEK153094857;
        Wed, 16 Sep 2020 14:25:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33khpkgm49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:25:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GEOwVw011991;
        Wed, 16 Sep 2020 14:24:59 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 14:24:57 +0000
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <f20f4d5b-574a-7c3d-8c08-3e6b7893fc58@oracle.com>
 <81b208ad-b9e6-bfbf-631e-02e9f75d73a2@linux.intel.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <51424491-b7e0-b245-1062-319021eb1845@oracle.com>
Date:   Wed, 16 Sep 2020 10:24:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <81b208ad-b9e6-bfbf-631e-02e9f75d73a2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 8:57 AM, Li, Aubrey wrote:
>> Here are the uperf results of the various patchsets. Note, that disabling smt is better for these tests and that that presumably reflects the overall overhead of core scheduling which went from bad to really bad. The primary focus in this email is to start to understand what happened within core sched itself.
>>
>> patchset          smt=on/cs=off  smt=off    smt=on/cs=on
>> --------------------------------------------------------
>> v5-v5.6.y      :    1.78Gb/s     1.57Gb/s     1.07Gb/s
>> pre-v6-v5.6.y  :    1.75Gb/s     1.55Gb/s    822.16Mb/s
>> v6-5.7         :    1.87Gs/s     1.56Gb/s    561.6Mb/s
>> v6-5.7-hotplug :    1.75Gb/s     1.58Gb/s    438.21Mb/s
>> v7             :    1.80Gb/s     1.61Gb/s    440.44Mb/s
> 
> I haven't had a chance to play with v7, but I got something different.
> 
>    branch		smt=on/cs=on
> coresched/v5-v5.6.y	1.09Gb/s
> coresched/v6-v5.7.y	1.05Gb/s
> 
> I attached my kernel config in case you want to make a comparison, or you
> can send yours, I'll try to see I can replicate your result.

I will give this config a try. One of the reports forwarded to me about the drop in uperf perf was an email from you I 
believe mentioning a 50% perf drop between v5 and v6?? I was actually setting out to duplicate your results. :-)

-chrish


