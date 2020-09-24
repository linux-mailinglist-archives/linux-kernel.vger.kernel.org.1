Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4124227778B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgIXRQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:16:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgIXRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:16:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHDepu002825;
        Thu, 24 Sep 2020 17:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=amW70FmbGDogjo5Q8xTnEpZcxgKAVRej5X76hhQrk08=;
 b=dboR68KZ/BcroeEjfAzp60eEl74y5h6X+nzkEQot63USMXv27x3ox9I2t5JS6S2UsrDE
 k7uTPCk87Y1Zj3xLaFzzZnGH7Cn8F6BAKRjG0gOcNqKm5F9JrXEjAI5znWyZRVWqM1fQ
 RvkxJyg3yYY0WqUOzcSchCR9/Ekkd/b8M1nK+Y1GAaYgBwAo1S53EoHdA8lNfSDOgJLD
 VjfZBBRSyOcWHcAT6dyN0tStnEwucsuMJHp11C031ae9GX1WNJcQWyBepJj6LAR0Fi70
 2SwxK5xjWFRAW68OPW0ubuucsqLN1AtsQdg75E37mpkLyLJLDX9zaRUrmJKByLfCiD18 HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcpu6gbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 17:16:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHBUvr019516;
        Thu, 24 Sep 2020 17:16:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nux34c7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 17:16:20 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OHG8rn012734;
        Thu, 24 Sep 2020 17:16:08 GMT
Received: from [10.74.108.139] (/10.74.108.139)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 10:16:08 -0700
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
To:     Michael Kelley <mikelley@microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
 <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
Date:   Thu, 24 Sep 2020 13:16:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/20 12:43 PM, Michael Kelley wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM
>> Michael Kelley <mikelley@microsoft.com> writes:
>>
>>>>> Added Hyper-V people and people who created the param, it is below
>>>>> commit, I also want to remove it if possible, let's see how people
>>>>> think, but the least way should be to disable the auto setting in both systemd
>>>>> and kernel:
>>> Hyper-V uses a notifier to inform the host system that a Linux VM has
>>> panic'ed.  Informing the host is particularly important in a public cloud
>>> such as Azure so that the cloud software can alert the customer, and can
>>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
>>> entirely by the customer and how he configures the VM, and we want
>>> the host to be informed either way.
>> Why?
>>
>> Why does the host care?
>> Especially if the VM continues executing into a kdump kernel?
> The host itself doesn't care.  But the host is a convenient out-of-band
> channel for recording that a panic has occurred and to collect basic data
> about the panic.  This out-of-band channel is then used to notify the end
> customer that his VM has panic'ed.  Sure, the customer should be running
> his own monitoring software, but customers don't always do what they
> should.  Equally important, the out-of-band channel allows the cloud
> infrastructure software to notice trends, such as that the rate of Linux
> panics has increased, and that perhaps there is a cloud problem that
> should be investigated.


In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.


>
>> Further like I have mentioned everytime something like this has come up
>> a call on the kexec on panic code path should be a direct call (That can
>> be audited) not something hidden in a notifier call chain (which can not).
>>

We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.


-boris


> The use case I describe has no particular requirement that it be
> implemented via the notifier call chain.  If there's a better way to run
> some out-of-band notification code on all Linux panics regardless of
> whether a kdump is taken, we're open to such an alternative.
