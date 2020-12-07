Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C862D1C69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgLGVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:54:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLGVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:54:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Lnw7P096433;
        Mon, 7 Dec 2020 21:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=piCzqQm0mVCxgJj+sqHb/JruJS99OLdhf2z56yFWCeg=;
 b=uSA+u//ggfO7i4LGAaf93J1AoylnkzIAC4LQ0OSldelB5IPBHq3VKCdqzUCEpZHZOqTE
 c3INRBq4HHEN7iHQaMjtkIyo9/gZSK4Y+T8nkTTTlfZaw/eMfTVVBRe+LvotIiCL3+GP
 f4lzsob+5FB8v5bRCTfabbfsbnFfZ4iIpRQvj9exBnIv46zFiQOKYCCJdOmuIsHOW3sD
 0FwXvFAP9OjBHXUfN/E0ddpMuYqiJhSokQd3ZD2w9+wsC4d/jpatORjjymCFlAssjVDH
 cEd+y0E3+mFNlfYqOkLSW0wJ47TVch+Vsodi2rswHqmDN3sJ0OSHKWLXLYMCWfCCdyPL rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3581mqqrv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 21:51:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7LejtD192480;
        Mon, 7 Dec 2020 21:49:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksmrh2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 21:49:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B7Lmueg020940;
        Mon, 7 Dec 2020 21:49:00 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 13:48:56 -0800
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
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
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <912e3ad8-5b18-566b-4321-537f3ff7e8be@oracle.com>
Date:   Mon, 7 Dec 2020 16:48:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201206173418.GC201514@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/20 12:34 PM, Joel Fernandes wrote:
> Looks ok to me except the missing else { } clause you found. Also, maybe
> dest/src can be renamed to from/to to make meaning of variables more clear?
> 

yes.

> Also looking forward to the docs/test updates.

on it.

Thanks.

-chrish

