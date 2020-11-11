Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72F2AEE50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKKJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:58:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:58:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB9rM1a026154;
        Wed, 11 Nov 2020 09:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oA61zxEVlmMNqsCkjllOctTkDy6MHEZz/u0CS0f0GR4=;
 b=EQ8585thJHiooh6+1JOWtvq0C3AVYE3QmSIqvUKrsXCKk1jWJbWXvTMWy7zl2LOx++72
 08NZQ9P7fWkAcWVE64rNpSs9iiZOrBDkLo6KFUbH6M2hpKf68PsNajR+F/LbYkA5NMy4
 QPQ2kaVm45VRbpFLGQfWi+0JxbL9qLk1C/WBmuws9owZJ/0IriOGLGHd23/VTGOtHQtw
 aPHm89YLeIvSVUXWmBZFiVX9kOP0neTChUC2qW9p4ejmMyDYZpyb2tnNncsl2afn+hwS
 f3C3bP6tonLgknMS2su1C+EQYimJGBhOpmw2mQ5wqX9diAcREKhCHLlgajSc48U4YJfT cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72epbfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 09:58:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB9uANX188256;
        Wed, 11 Nov 2020 09:56:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gy5h87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 09:56:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AB9uSol008867;
        Wed, 11 Nov 2020 09:56:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 01:56:28 -0800
Date:   Wed, 11 Nov 2020 12:56:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     kbuild@lists.01.org, lkp@intel.com,
        Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c:412
 sun8i_ce_hash_run() warn: possible memory leak of 'result'
Message-ID: <20201111095621.GJ29398@kadam>
References: <20201110104737.GF29398@kadam>
 <20201111080134.GA4359@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111080134.GA4359@Red>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:01:34AM +0100, LABBE Corentin wrote:
> On Tue, Nov 10, 2020 at 01:47:37PM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   407ab579637ced6dc32cfb2295afb7259cca4b22
> > commit: 56f6d5aee88d129b2424902cd630f10794550763 crypto: sun8i-ce - support hash algorithms
> > config: x86_64-randconfig-m001-20201109 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> 
> Hello
> 
> Thanks for the report, I will send a patch soon.
> Note that you should send this report to the maintainer also (but this time it is me with another address, so its fine).
> 

These are automated emails from the kbuild bot.  I just look over the
Smatch warnings and forward them.  It don't know how the CC list is
chosen.  I guess just from who signed off on the patch...  My guess is
that people would be annoyed if we CC'd more people.

Generally, we have a really good success rate with people fixing these
warnings.  I recently had a case where the zero day bot email wasn't
clear, but I caught that because I'm looking at new Smatch warnings on
my own system.  There was another case, where the bug was fixed and then
re-introduced via a bad merge and we almost missed that because it was
marked as old.  Fortunately, I discoverd it while looking at a different
bug.

regards,
dan carpenter
