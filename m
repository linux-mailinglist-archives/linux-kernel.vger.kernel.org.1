Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9357B2B8502
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgKRTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:38:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgKRTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:38:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIJYQWM036110;
        Wed, 18 Nov 2020 19:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mq0W7IL8hYcqperURNj/+dp02eZOijQxp8cDcuFHHbo=;
 b=jLbFlVxB9zjMZKP58VRxWdMqlYQEf9biO4+o9XzBtUm3g7VUMxNIgmAcIM3Dlr0v6sOn
 2dTy+Pm+R3bJS0Q2eObpLgh4l+Sx1+dsFshTba9lywhBOrZlDrp+QcVg8sjuu5/2d08V
 fFJYy0KpHG1mxXc86/m8C31cLNX+1TCvD0fZfCqhoDXKNz1+FnSxAeg4SmiUJFH05S+O
 w13LGvSt93sisLOukABqHZj8q5XDP//IYkt/DvfGVu3ZrPQkQveuLsNePDbuAOTjgthY
 65e9IaEJsrvI3H95rvDROuzn7+4hVPDQBuwNbuZOzCoSyjzW+URge/JUUvKpi0VGYuJA ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34t76m1uwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 19:35:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIJZk9b020150;
        Wed, 18 Nov 2020 19:35:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0sqqwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 19:35:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AIJZbql027868;
        Wed, 18 Nov 2020 19:35:37 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 11:35:37 -0800
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com, Mel Gorman <mgorman@techsingularity.net>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
 <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
 <20201118112952.GB7472@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <408004fa-b143-7e12-150a-0dfab12d34ee@oracle.com>
Date:   Wed, 18 Nov 2020 20:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118112952.GB7472@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/20 12:29 PM, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 08:41:42AM +0100, Alexandre Chartre wrote:
>> Well, it looks like I wrongfully assume that KPTI was a well known performance
>> overhead since it was introduced (because it adds extra page-table switches),
>> but you are right I should be presenting my own numbers.
> 
> Here's one recipe, courtesy of Mel:
> 
> https://github.com/gormanm/mmtests
> 

Thanks for the detailed information, I have run the test and I see the same difference
as with the tools/perf and libMICRO I already sent: there's a 150% difference for
getpid() with and without pti.

alex.

-----

# ../../compare-kernels.sh --baseline test-nopti --compare test-pti

poundsyscall
                                test                   test
                               nopti                    pti
Min       2         1.99 (   0.00%)        5.08 (-155.28%)
Min       4         1.02 (   0.00%)        2.60 (-154.90%)
Min       6         0.94 (   0.00%)        2.07 (-120.21%)
Min       8         0.81 (   0.00%)        1.60 ( -97.53%)
Min       12        0.85 (   0.00%)        1.65 ( -94.12%)
Min       18        0.82 (   0.00%)        1.61 ( -96.34%)
Min       24        0.81 (   0.00%)        1.60 ( -97.53%)
Min       30        0.81 (   0.00%)        1.60 ( -97.53%)
Min       32        0.81 (   0.00%)        1.60 ( -97.53%)
Amean     2         2.02 (   0.00%)        5.10 *-151.83%*
Amean     4         1.03 (   0.00%)        2.61 *-151.98%*
Amean     6         0.96 (   0.00%)        2.07 *-116.74%*
Amean     8         0.82 (   0.00%)        1.60 * -96.56%*
Amean     12        0.87 (   0.00%)        1.67 * -91.73%*
Amean     18        0.82 (   0.00%)        1.63 * -97.94%*
Amean     24        0.81 (   0.00%)        1.60 * -97.41%*
Amean     30        0.82 (   0.00%)        1.60 * -96.93%*
Amean     32        0.82 (   0.00%)        1.60 * -96.56%*
Stddev    2         0.02 (   0.00%)        0.02 (  33.78%)
Stddev    4         0.01 (   0.00%)        0.01 (   7.18%)
Stddev    6         0.01 (   0.00%)        0.00 (  68.77%)
Stddev    8         0.01 (   0.00%)        0.01 (  10.56%)
Stddev    12        0.01 (   0.00%)        0.02 ( -12.69%)
Stddev    18        0.01 (   0.00%)        0.01 (-107.25%)
Stddev    24        0.00 (   0.00%)        0.00 ( -14.56%)
Stddev    30        0.01 (   0.00%)        0.01 (   0.00%)
Stddev    32        0.01 (   0.00%)        0.00 (  20.00%)
CoeffVar  2         1.17 (   0.00%)        0.31 (  73.70%)
CoeffVar  4         0.82 (   0.00%)        0.30 (  63.16%)
CoeffVar  6         1.41 (   0.00%)        0.20 (  85.59%)
CoeffVar  8         0.87 (   0.00%)        0.39 (  54.50%)
CoeffVar  12        1.66 (   0.00%)        0.98 (  41.23%)
CoeffVar  18        0.85 (   0.00%)        0.89 (  -4.71%)
CoeffVar  24        0.52 (   0.00%)        0.30 (  41.97%)
CoeffVar  30        0.65 (   0.00%)        0.33 (  49.22%)
CoeffVar  32        0.65 (   0.00%)        0.26 (  59.30%)
Max       2         2.04 (   0.00%)        5.13 (-151.47%)
Max       4         1.04 (   0.00%)        2.62 (-151.92%)
Max       6         0.98 (   0.00%)        2.08 (-112.24%)
Max       8         0.83 (   0.00%)        1.62 ( -95.18%)
Max       12        0.89 (   0.00%)        1.70 ( -91.01%)
Max       18        0.84 (   0.00%)        1.66 ( -97.62%)
Max       24        0.82 (   0.00%)        1.61 ( -96.34%)
Max       30        0.82 (   0.00%)        1.61 ( -96.34%)
Max       32        0.82 (   0.00%)        1.61 ( -96.34%)
BAmean-50 2         2.01 (   0.00%)        5.09 (-153.39%)
BAmean-50 4         1.03 (   0.00%)        2.60 (-152.62%)
BAmean-50 6         0.95 (   0.00%)        2.07 (-118.82%)
BAmean-50 8         0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-50 12        0.86 (   0.00%)        1.66 ( -92.79%)
BAmean-50 18        0.82 (   0.00%)        1.62 ( -97.56%)
BAmean-50 24        0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-50 30        0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-50 32        0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-95 2         2.02 (   0.00%)        5.09 (-151.87%)
BAmean-95 4         1.03 (   0.00%)        2.61 (-151.99%)
BAmean-95 6         0.95 (   0.00%)        2.07 (-117.25%)
BAmean-95 8         0.81 (   0.00%)        1.60 ( -96.72%)
BAmean-95 12        0.87 (   0.00%)        1.67 ( -91.82%)
BAmean-95 18        0.82 (   0.00%)        1.63 ( -97.97%)
BAmean-95 24        0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-95 30        0.81 (   0.00%)        1.60 ( -97.00%)
BAmean-95 32        0.81 (   0.00%)        1.60 ( -96.59%)
BAmean-99 2         2.02 (   0.00%)        5.09 (-151.87%)
BAmean-99 4         1.03 (   0.00%)        2.61 (-151.99%)
BAmean-99 6         0.95 (   0.00%)        2.07 (-117.25%)
BAmean-99 8         0.81 (   0.00%)        1.60 ( -96.72%)
BAmean-99 12        0.87 (   0.00%)        1.67 ( -91.82%)
BAmean-99 18        0.82 (   0.00%)        1.63 ( -97.97%)
BAmean-99 24        0.81 (   0.00%)        1.60 ( -97.53%)
BAmean-99 30        0.81 (   0.00%)        1.60 ( -97.00%)
BAmean-99 32        0.81 (   0.00%)        1.60 ( -96.59%)

                         test        test
                        nopti         pti
Duration User         150.13      432.03
Duration System       372.10      657.69
Duration Elapsed       94.17      199.27

