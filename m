Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65D82AC584
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgKITyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:54:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgKITyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:54:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9JnDG6116290;
        Mon, 9 Nov 2020 19:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fHZHT9mmQPOv7fLKB17nK0Npmx0uWBB4ffF75knnty8=;
 b=S7yNqoutHZPtkAfJ8m2GfR28gVUAflR5lZ+W6BMAn7kSbdjSlmNFqdONGizQm/rsNXt/
 Hv2Lc/ijLvhDyamdqV2WCWKXcGPAiIxITcTlXIhSF2+EhkMMycO+kEPl1QthJaU8sTi+
 dbaUcHG6kNBfz3sjbfPb31Ytw8q18fhR/EEe/lREq32Rh8YaA/nn3p/LonwsPc2oKd/l
 hJMH7vuAfvMx4yWvWCQWfAYRdcaw2p1EiPDtkLrsJbvnkUxhK9HWU2o9FjgNSCj/RE/S
 Z//XERPH2mCICI+1xE6nP7JpM8W1GLXlcNJX+mP+X12/i/H5CJE7LSe/gozWGCWBGoJy dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34p72ee3mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 19:53:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Jp1sA053375;
        Mon, 9 Nov 2020 19:53:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34p5bqy8b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 19:53:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Jrpso018160;
        Mon, 9 Nov 2020 19:53:51 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 11:53:51 -0800
Subject: Re: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
 <20201109144425.270789-14-alexandre.chartre@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <bb5b370b-5091-f3ca-9967-5a5d91287788@oracle.com>
Date:   Mon, 9 Nov 2020 20:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109144425.270789-14-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Copying the reply to Andy in the thread with the right email addresses]

On 11/9/20 6:28 PM, Andy Lutomirski wrote:
> On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> Extend PTI user mappings so that more kernel entry code can be executed
>> with the user page-table. To do so, we need to map syscall and interrupt
>> entry code,
>
> Probably fine.
>
>> per cpu offsets (__per_cpu_offset, which is used some in
>> entry code),
>
> This likely already leaks due to vulnerable CPUs leaking address space
> layout info.

I forgot to update the comment, I am not mapping __per_cpu_offset anymore.

However, if we do map __per_cpu_offset then we don't need to enforce the
ordering in paranoid_entry to switch CR3 before GS.

>
>> the stack canary,
>
> That's going to be a very tough sell.
>

I can get rid of this, but this will require to disable stack-protector for
any function that we can call while using the user page-table, like already
done in patch 21 (x86/entry: Disable stack-protector for IST entry C handlers).

alex.
