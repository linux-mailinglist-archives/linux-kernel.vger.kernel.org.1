Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC182AC2C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgKIRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:45:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgKIRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:45:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9HjBh7075939;
        Mon, 9 Nov 2020 17:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=urACPZF0y4V2NTCkwdnrAwDce8Jt91fSO2D1RzJVgWk=;
 b=QeXv23SAZlt/pB7kDBoZoBQD3N8/rw0YUNOgc85bayWYhpR2xoDUmkEHmNfiAITzEbzu
 kRKcLdE0pBgGOs9p9/g+m5GsHiuXuB9Fi+vpIm1H38CMLUu43JHtqijr4M/DV/5s7iq1
 CMrN1IcFG3fa+Hb0hIEOZSxj08v45GhZYxMyj0p1v9uJXfsiQMrSsSubKZ+2aPYynJKo
 05AVl/ilYIZOy1WneclLazwr9GwXQbeiE8dt4eBIhe5E0TaVIwvGtgvCiGrbTeEGRNR/
 vvq10UOf3smRaxcSngG7o/SscOUhLzv3YRnJCV0roy2kwgRCBbx+CYwOd/QdMQ+UFBmc pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72edfy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 17:45:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Henp0042773;
        Mon, 9 Nov 2020 17:43:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5fy05nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 17:43:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9HhZOT032026;
        Mon, 9 Nov 2020 17:43:35 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 09:43:34 -0800
Subject: Re: [RFC][PATCH 01/24] x86/syscall: Add wrapper for invoking syscall
 function
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
 <20201109112319.264511-2-alexandre.chartre@oracle.com>
 <CALCETrWOK-ZjcUKarbTokRxLOd3RmjYjnDhc1mgUeXRVFdGgow@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <c6959c99-a494-3b31-a3d3-f0aa2335e13e@oracle.com>
Date:   Mon, 9 Nov 2020 18:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWOK-ZjcUKarbTokRxLOd3RmjYjnDhc1mgUeXRVFdGgow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/20 6:25 PM, Andy Lutomirski wrote:
> Hi Alexander-
> 
> You appear to be infected by corporate malware that has inserted the
> string "@aserv0122.oracle.com" to the end of all the email addresses
> in your to: list.  "luto@kernel.org"@aserv0122.oracle.com, for
> example, is not me.  Can you fix this?
>

I known, I messed up :-(
I have already resent the entire RFC with correct addresses.
Sorry about that.

alex.

> 
> On Mon, Nov 9, 2020 at 3:21 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> Add a wrapper function for invoking a syscall function.
> 
> This needs some explanation of why.
> 
