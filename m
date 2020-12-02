Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71912CC758
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgLBUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:01:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgLBUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:01:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2JreDh095338;
        Wed, 2 Dec 2020 20:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MWzc4cU1jncJjBh7/IzdYkh6gBTDQ3g4PKoAsnasayg=;
 b=HVu35OSuzDoWdQDV/WAQOgqEf9ioeX4rjXKdI8OLM9216bWgXxQ+55FFnX0WTJUu5VZg
 n51/TBQuS6SfmqQg8EAjNAav7jHEpOS5h6waUU17Yu3wOUImE4Aou2HSLKMnlMseXvW4
 sRmsGSoskJY+fdtXvk7lxhHHe2Kftp71uhXhoEwKgL/dKKxGAVEUZ812/ywCrUgTun1D
 iC3AKMYhxsPRVD+xAYWRhQEKHo+fi1f9NPUQ7/MJcY2FCme6+WXQnrWNczNxsxjUXmAO
 pTD6jqFhOwDaliclXFjg9jWdsr8G8JBlvWOFPyUNXhjJxPYjlwQqWF0ExnowaIkIxFoY jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 353dyqtfu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Dec 2020 20:00:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2JuSFb039346;
        Wed, 2 Dec 2020 20:00:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35404pt6vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Dec 2020 20:00:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B2K0TmU028031;
        Wed, 2 Dec 2020 20:00:29 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Dec 2020 12:00:28 -0800
Date:   Wed, 2 Dec 2020 23:00:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pstore: Tidy up an error check
Message-ID: <20201202200021.GJ2789@kadam>
References: <X8c4C2q6qaZ8qX6L@mwanda>
 <202012021124.ADBFCE999@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012021124.ADBFCE999@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:25:46AM -0800, Kees Cook wrote:
> On Wed, Dec 02, 2020 at 09:45:31AM +0300, Dan Carpenter wrote:
> > The crypto_alloc_comp() function never returns NULL, it returns error
> > pointers on error.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I replied to an identical patch yesterday, actually:
> https://lore.kernel.org/lkml/202012011215.B9BF24A6D@keescook/ 
> 
> Using IS_ERR_OR_NULL() is more robust, and this isn't fast path, so I'd
> prefer to keep it that way.
> 

The NULL return doesn't make any sense though because crypto_alloc_comp()
isn't optional...  When a function returns both error pointers and NULLs
then the NULL is special kind of success.

	p = get_feature();

If "p" is an error pointer that means an error happened.  If "p" is NULL
that means the feature is disabled in the .config or whatever.  We can't
return a valid pointer because the feature doesn't exist but it's also
not an error so it doesn't return an error pointer.  The code should
not print a warning, maybe an info level printk at most.  Then the
driver should continue operating with the feature turned off.

Two of the callers for crypto_alloc_comp() check for error pointers and
NULL and three only check for error pointers.  It's inconsistent.

regards,
dan carpenter

