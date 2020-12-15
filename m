Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ECC2DB37F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgLOSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:16:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbgLOSQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:16:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFI0JIW047245;
        Tue, 15 Dec 2020 18:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kcWbcIUdFRkuvfo2PGfPoydZGFdPFg1SOj6XmBXLctw=;
 b=RecEQ7cFavY2GbMFbgThxDY8YFEKBSDyKZQnxQaPH87SEhLLDzTAFnj7tSFwj6uN1gyb
 Ep62jleeikeOWSyARYq6m6ZX3M+5nn8lrYRlf3ToTZIT8D3clpY2UU2G7hmJ+mg1EZbN
 p4+c3i9H/RAS8GQybcjXhg2WY84XV8zKJKRL2IdNH+M1R82tbskJPb2SrLAiWULJPtkk
 Z5igSeVZCNjKFWh9yvPS7za7eRsFhPDSLK7CGE6Z4jNUum7VT0hUJVC+Qi7VvRndW8oM
 GZeIio+L38dT59LU/y3TjHq/lv7MZZGl+2SXK8DQmAI4cv9UuGRz2qkbLF/5WIXEroCJ 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rc3c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 18:13:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFI12Qw107153;
        Tue, 15 Dec 2020 18:13:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35e6eqtd4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 18:13:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BFIDNYR023406;
        Tue, 15 Dec 2020 18:13:24 GMT
Received: from localhost.localdomain (/10.159.246.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 10:13:23 -0800
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
To:     Joel Fernandes <joel@joelfernandes.org>,
        chris hyser <chris.hyser@oracle.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
 <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <X9e9dcLMrMJThZs+@google.com>
 <16a390e4-b44d-b0eb-1df6-6e56d78d009f@oracle.com>
 <20201214232541.GF201514@google.com>
From:   Dhaval Giani <dhaval.giani@oracle.com>
Message-ID: <796ec1e5-15ef-34da-5716-0ec19432deba@oracle.com>
Date:   Tue, 15 Dec 2020 10:13:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214232541.GF201514@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 3:25 PM, Joel Fernandes wrote:

>> No problem. That was there primarily for debugging.
> Ok. I squashed Josh's changes into this patch and several of my fixups. So
> there'll be 3 patches:
> 1. CGroup + prctl  (single patch as it is hell to split it)

Please don't do that. I am not sure we have thought the cgroup interface through
(looking at all the discussions). IMHO, it would be better for us to get a simpler
interface (prctl) right and then once we learn the lessons using it, apply it for
the cgroup interface. I think we all agree we don't want to maintain a messy interface
forever.

Dhaval

