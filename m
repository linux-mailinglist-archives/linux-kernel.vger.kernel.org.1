Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB35B2FB242
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhASG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:59:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34826 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbhASG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:57:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J6sehl183902;
        Tue, 19 Jan 2021 06:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=0DjTgPBITUx3Qit6GSaE+pViT+fZ29UMvupzGI/onqk=;
 b=gsVxJcgsr+bgEE1ofT/a4a+bStxS1lmSIDdpRNewVMXhT7N+Uv2yBcjPTqEzGDy0gSrH
 tyH0ejMSW1uOfGtKaOFwZCMtQ4c8HshjZA6X5opG2a5TK1P5Eq6npQXB2JjG6unYeylm
 SBSmP2Z+usYlrAcm80F0wFJrrfrgSL+rjewFDs5lt8y38TLckzCXOV+BiZ8kss4GKXdW
 38jSFvpasllpFv+V6KLHR3fU3xaZTJTwX2vHvRRPL03kD+qJqqFbaGlPAttnL/18iVjf
 gUbEyTWg45iIO/rEHt6mU43FVfM9EOHWuKtxeBA6XjKJtqMAxhy+v2HUu8Shjxh4eBe4 kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 363nnafv3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 06:56:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J6tImT048760;
        Tue, 19 Jan 2021 06:56:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3649wr05np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 06:56:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10J6udWm014364;
        Tue, 19 Jan 2021 06:56:39 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 22:56:39 -0800
Date:   Tue, 19 Jan 2021 09:56:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: hikey9xx: phy-hi3670-usb3.c:
 hi3670_is_abbclk_seleted() returns bool
Message-ID: <20210119065630.GE2696@kadam>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
 <d1e0d94381e214157545d6808835fdfe99448f76.1610645385.git.mchehab+huawei@kernel.org>
 <d9ebc10ac5c4ba5231ed50ef0d2a15f424547736.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9ebc10ac5c4ba5231ed50ef0d2a15f424547736.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:56:41AM -0800, Joe Perches wrote:
> On Thu, 2021-01-14 at 18:35 +0100, Mauro Carvalho Chehab wrote:
> > Instead of using 1/0 for true/false, change the type to boolean
> > and change the returned value.
> []
> > diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
> []
> > @@ -326,24 +326,24 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
> >  	return ret;
> >  }
> > 
> > -static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
> > +static bool hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
> 
> Presumably this should be "selected" not "seleted"
> 
> >  {
> >  	u32 reg;
> > 
> >  	if (!priv->sctrl) {
> >  		dev_err(priv->dev, "priv->sctrl is null!\n");
> > -		return 1;
> > +		return true;
> >  	}
> > 
> >  	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
> >  		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
> > -		return 1;
> > +		return true;
> >  	}
> > 
> >  	if ((reg & USB_CLK_SELECTED) == 0)
> > -		return 1;
> > +		return true;
> > 
> > -	return 0;
> > +	return false;
> >  }
> 
> 	if (foo)
> 		return true;
> 	return false;
> 
> should generally be consolidated into a single test.

I quite prefer the original format, but you're right about the return
looking reversed.  Using "return !!(reg & USB_CLK_SELECTED);" is
especially problematic.  I like !! but Linus has commented a couple
times that he doesn't like !!.

regards,
dan carpenter


