Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34842AD0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgKJIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:06:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgKJIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:06:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA85PfF032636;
        Tue, 10 Nov 2020 08:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8Yc+JuCBcxw5njKSI0AKPzOTkerHm9T7cEaGIy0DBvU=;
 b=omBLIIFpLmMdKJNUyk8r4/REAbd6LhGG4zz1ijRbQtloSS081SRIj1R4iQDFpQ8mqsXy
 kEVkyi2R5p69dSGnmYRIuhX05lsFs5mFQF7YNLY/o57DbK30hEm9glMD2cGrIWZBfB5o
 POIiXz0hTGvWmL5ObCrqEbiwJO3OaIiUEHv50J/SL/gBBkYmI2P0dK+2sn8i4oXZSw8b
 2aKGvT6hRP9wsyjTWHu+cJSUlv36EOEjezGl0u+/zm9uQEs1BeLxqermMFSZj+1C8x9F
 GRg8R56rnfWHteYeAoRKKAeklQg3fG0qMbzVli0kLBo7i9lQsP8hzCpaBGAgy2v4o+1Z 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72eg8n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 08:06:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA80qTo181652;
        Tue, 10 Nov 2020 08:06:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5fyvhk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 08:06:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AA86HU7010913;
        Tue, 10 Nov 2020 08:06:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 00:06:16 -0800
Date:   Tue, 10 Nov 2020 11:06:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] taskstats: remove unneeded dead assignment
Message-ID: <20201110080609.GD29398@kadam>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
 <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk>
 <alpine.DEB.2.21.2011061126130.20338@felia>
 <aea9d12d-88ee-f262-4328-03993521668f@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aea9d12d-88ee-f262-4328-03993521668f@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:04:53PM +0000, Sudip Mukherjee wrote:
> Hi Lukas,
> 
> On 06/11/2020 10:31, Lukas Bulwahn wrote:
> > 
> > 
> > On Fri, 6 Nov 2020, Sudip Mukherjee wrote:
> > 
> >> Hi Lukas,
> >>
> 
> <snip>
> 
> > 
> > I did not try but I bet (a beverage of your choice) that the object code
> > remains the same also for your suggested patch. Try to disprove my claim 
> > and possibly earn yourself a beverage when we meet...
> 
> Lets decide which beverage.. ;-)
> 
> Using gcc-7.2.0 for MIPS:
> 
> original:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
> After your change:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
> After my change:- 0acae2c8d72abd3e15bf805fccdca711  kernel/taskstats.o

I'm surprised the line numbers from the printks aren't affecting it...

I personally prefer Lukas's patch.  "rc" should be function scope...

regards,
dan carpenter

