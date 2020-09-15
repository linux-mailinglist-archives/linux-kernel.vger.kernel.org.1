Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE926AA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIORVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:21:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbgIOQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:32:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FBDchR157733;
        Tue, 15 Sep 2020 11:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=px/1ifPcXj0Nyj9Jrg+NgLvEiUj7lU6yuDbJ59OtomY=;
 b=rquBhoXy/wLL/Igxx6Z8Kvtd0UnyP0PCKtbxJrSh2xTDO96UqtJ+sR0A0+CEjsp9ot9Q
 aWD+jCMS4sHlbEvEcbjK9QZ5TBfPea6KNdtD+Z9ZqxaVE1/A5xj1AMTusLkrwAfO8wTz
 zOK++ObN33IaZV6Qd1jaMlFrHSJ3Fc/+pGLBvprg5g7o04hvM0KwcD0kzH4p6yffGdng
 yR4LpLVF9WOf0hsRNki1Y6OBVizKZzYDx1YrUGm5dv/arLWQ+F64KT36cTBCpVICeKAa
 funxmNbmvWN16yV/pGejnihX1uf+OM80kAzvYM37Arzo6uqWyPzJAIkkGrrKPDyGt59H dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqva65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 11:20:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FBFQoR095327;
        Tue, 15 Sep 2020 11:20:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h884jnhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 11:20:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FBKZ4Y029716;
        Tue, 15 Sep 2020 11:20:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 11:20:35 +0000
Date:   Tue, 15 Sep 2020 14:20:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>,
        Sebastian Arriola <sebdeveloper6952@gmail.com>
Cc:     Sohom Datta <sohom.datta@learner.manipal.edu>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
 (checkpatch)
Message-ID: <20200915112028.GG4282@kadam>
References: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
 <20200914145755.GD4282@kadam>
 <8c95d3d02dbdd36a048280cb8d9e8f171c3b4959.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c95d3d02dbdd36a048280cb8d9e8f171c3b4959.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:42:49AM -0700, Joe Perches wrote:
> On Mon, 2020-09-14 at 17:57 +0300, Dan Carpenter wrote:
> > On Sun, Sep 13, 2020 at 12:19:50PM +0530, Sohom Datta wrote:
> > > > From 4c8c8f3ff7f4d711daea4ac3bb987fcecc7ef1ed Mon Sep 17 00:00:00 2001
> > > From: Sohom <sohom.datta@learner.manipal.edu>
> > > Date: Sat, 12 Sep 2020 18:04:56 +0530
> > > Subject: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
> > >  (checkpatch)
> > > 
> > > Fixed:
> > > WARNING: else is not generally useful after a break or return
> > > 1636: FILE: ./rtw_recv.c:1636:
> > > +           return false;
> > > +       else
> > > 
> > > Separated the return statement into a separate block since
> > > it doesn't seem to depend on the SN_LESS explicity being false.
> > > 
> > > Signed-off-by: Sohom <sohom.datta@learner.manipal.edu>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_recv.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> > > index 5fe7a0458dd2..5e81134ffb6d 100644
> > > --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> > > +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> > > @@ -1629,10 +1629,11 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
> > >  		hdr = list_entry(plist, struct recv_frame, list);
> > >  		pnextattrib = &hdr->attrib;
> > >  
> > > +		if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
> > > +			return false;
> > > +
> > >  		if (SN_LESS(pnextattrib->seq_num, pattrib->seq_num))
> > >  			plist = plist->next;
> > > -		else if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
> > > -			return false;
> > >  		else
> > >  			break;
> > >  	}
> > 
> > Checkpatch is just wrong here.  Ignore it when it's wrong.
> 
> It's not "wrong" here.  It's making a suggestion.
> 
> Perhaps read the SN_EQUAL and SN_LESS macros.
> 
> a and b are both u16's here.
> 
> drivers/staging/rtl8188eu/include/rtw_recv.h:#define SN_LESS(a, b)              (((a - b) & 0x800) != 0)
> drivers/staging/rtl8188eu/include/rtw_recv.h:#define SN_EQUAL(a, b)     (a == b)
> 
> Reordering works, perhaps it's just a question of
> whether it's the most likely result of the test.
> 
> This is in a while loop.
> 
> If the expected test is really the most likely that
> SN_LESS is true, then perhaps this loop could be
> something like:
> 
> 		if (SN_LESS(pnextattrib->seq_num, pattrib->seq_num)) {
> 			plist = plist->next;
> 			continue;
> 		}
> 		if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
> 			return false;
> 		break;
> 	}
> 
> The real question is whether or not that's more readable.
> 

It's not clear to me that any of these are more readable than the other.

I see that someone broke the staging/rtl8712 version of this driver in
June.  See commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary
else after return statement.").  That patch went through LKML instead of
going through the driver-devel list...  :/

regards,
dan carpenter

