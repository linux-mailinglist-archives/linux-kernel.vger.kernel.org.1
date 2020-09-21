Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0C271EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:34:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47824 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:34:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L9PoqL070039;
        Mon, 21 Sep 2020 09:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rsEph3MymUHzIrmsyBBbDiw6YIHpk9+WhKEi98Qh7OQ=;
 b=ONX0FjYdTVsgJXCVASE1SlHrtZgg2zRmwID2RWSuB+ArbALrVyzl66ZTzmo/CgfUIADL
 PRC2mjSnBiMPCRUALnR9+pg94+WA/mbukgMtizlxjEoksYN6AU4y279y18pvvrc+0yTj
 Zwh3Zvv3PPQHdVT0zUSAKHxITRJmO1TyBrWHVlmu8Rj+hVjzy1JvHWlu9LazzY3OEeC8
 85NheQgJLipBFNV65Guht5m5k3uoFSUlRd4ZDWq3RVZIBX+dt5zPXTHou8UnBgq639MH
 QAob87poenEGBZkJn8ZMlXKPksFKo5tDfyRLj3fcREgVf2Ga4zObOoMgmEX9DNoHdWKc qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33ndnu4a2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 09:34:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L9PKMW009073;
        Mon, 21 Sep 2020 09:34:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33nuwvsv9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:34:16 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08L9YDDv024348;
        Mon, 21 Sep 2020 09:34:13 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 02:34:12 -0700
Date:   Mon, 21 Sep 2020 12:34:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, alex.bou9@gmail.com,
        gustavoars@kernel.org, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org, madhuparnabhowmik10@gmail.com,
        mporter@kernel.crashing.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/gup: protect unpin_user_pages() against npages==-ERRNO
Message-ID: <20200921093405.GV18329@kadam>
References: <20200916100232.GF18329@kadam>
 <20200917065706.409079-1-jhubbard@nvidia.com>
 <20200917074054.GO18329@kadam>
 <CAFqt6zYFjGTJ=KUjHd5jf-ri5tCmo4HOLP1j3nsELFgcoEoLHQ@mail.gmail.com>
 <7812dfc5-698d-e765-ad62-abf23d19d3cf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7812dfc5-698d-e765-ad62-abf23d19d3cf@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 09:13:17PM -0700, John Hubbard wrote:
> On 9/19/20 8:03 PM, Souptick Joarder wrote:
> > On Thu, Sep 17, 2020 at 1:11 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > On Wed, Sep 16, 2020 at 11:57:06PM -0700, John Hubbard wrote:
> > > > As suggested by Dan Carpenter, fortify unpin_user_pages() just a bit,
> > > > against a typical caller mistake: check if the npages arg is really a
> > > > -ERRNO value, which would blow up the unpinning loop: WARN and return.
> > > > 
> > > > If this new WARN_ON() fires, then the system *might* be leaking pages
> > > > (by leaving them pinned), but probably not. More likely, gup/pup
> > > > returned a hard -ERRNO error to the caller, who erroneously passed it
> > > > here.
> ...
> > 
> > Do we need a similar check inside unpin_user_pages_dirty_lock(),
> > when make_dirty set to false ?
> 
> 
> Maybe not. This call is rarely if ever used for error handling, but
> rather, for finishing up a successful use of the pages.
> 
> There is a balance between protecting against buggy callers and just
> fixing any buggy callers. There is also a limit to how much code one can
> write in hopes of avoiding bugs in...code that one writes. :)  Which is
> why static analysis, unit and regression tests, code reviews are
> important too.
> 
> Here, I submit that that we're about to cross the line and go too far.
> But if you have any examples of buggy callers for
> unpin_user_pages_dirty_lock(), that might shift the line.

I checked for buggy uses of unpin_user_pages_dirty_lock() using Smatch
and didn't find anything.  (Which doesn't mean that there aren't any).

regards,
dan carpenter

