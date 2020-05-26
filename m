Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0321BCC05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgD1TCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 15:02:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgD1TCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:02:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIxHSA091425;
        Tue, 28 Apr 2020 19:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+5iXYoqsuyxXZ24Vp+LdjRiIUsJCP86KqCL8PYesp/w=;
 b=umkbl7GvWWTOdwT/RqYhC/dBjta460HKqs/eqkjEg2nXysNvtKNYE6xA4VVhcOLvf7Mk
 hO0Du1BmMf+KBFoLJQS0fz/7Tgpbc07hqJ4n4DjerHGWrUyiUKzpxZDv+11y2i9J8k4u
 qSgnEEFUBrB9iiHtwfk+ylq++IHECXmP0jhY0BsJmI780PPmZqc0nv8kRGghsc6slK0y
 chRsuUoJYrMEgPSec7WsIwXhKzrIVgjKaGMKNUYI6dkjLpN0E8ceOVU5XR47iJ1Hyhkw
 d1JQn7FpZdX4NzACpSIlZvrTSf9rbpaKw2pR23ibHQWO4JdOVqSLLiE8XSEpmnqBL4Wq XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p0780j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:02:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIufcA157860;
        Tue, 28 Apr 2020 19:00:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30mxpgqsff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:00:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SJ05pw019518;
        Tue, 28 Apr 2020 19:00:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 12:00:04 -0700
Date:   Tue, 28 Apr 2020 21:59:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-ID: <20200428185957.GL2014@kadam>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
 <20200409102013.GP2001@kadam>
 <20200427083642.GD18436@portage>
 <20200427093306.GU2682@kadam>
 <20200427123625.GE18436@portage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427123625.GE18436@portage>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:36:25PM +0200, Oliver Graute wrote:
> On 27/04/20, Dan Carpenter wrote:
> > On Mon, Apr 27, 2020 at 10:36:42AM +0200, Oliver Graute wrote:
> > > On 09/04/20, Dan Carpenter wrote:
> > > > On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> > > > > From: Oliver Graute <oliver.graute@kococonnector.com>
> > > > > 
> > > > > Set Gamma Values and Register Values for the HSD20_IPS
> > > > > 
> > > > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > > > > ---
> > > > >  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > > > > index 84c5af2dc9a0..b0aa96b703a8 100644
> > > > > --- a/drivers/staging/fbtft/fb_st7789v.c
> > > > > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > > > > @@ -17,8 +17,8 @@
> > > > >  #define DRVNAME "fb_st7789v"
> > > > >  
> > > > >  #define DEFAULT_GAMMA \
> > > > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> > > > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> > > > > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > > > > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> > > > 
> > > > How do you know this won't break someone else's setup?
> > > 
> > > Should I declare an extra define for my values?
> > > 
> > > +#define HSD20_IPS_GAMMA \
> > > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> > > 
> > 
> > That's fine, but it can't be a compile time thing.  Both types of
> > hardware have to be working/available at run time.
> 
> ok, what is the proper way to handover the gamma values during run time?

Can you detect which are appropriate and set that in the probe()
function?

regards,
dan carpenter

