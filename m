Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069752D49AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbgLITAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:00:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48962 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLITAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:00:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9IjOq0045047;
        Wed, 9 Dec 2020 18:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=PgT2/93EN84M8NSGkshAq+MsD4BsuPDACePGpoLziCc=;
 b=vRgVLL5cjgZdwMiEAn600T9ENdrZLcNdcZVBBCd0fEUPxfTSWuETveTAPCZ4PLnyyUo6
 DN9aUOsyhFmacxq6qWMqZ1zszu8hRGiukuyKcdU7+wLzyL5dNoXgEWcMc3cv9NmTo5Kl
 4wVEo0+ow6GvFP1/Y6WKefVcjAHFvKoPzrMOkuBo2DYFdaA+8DOVsvSOb+B3VyDYtmLx
 mJgyIEfi+aq2asRSPnY5J1XxEdaoOGs+wsIAA7+9+gyCL86u+2qbZFvuJdVN/qNfaxNC
 fOARs5tvbzKtn4FrTjE1/AuA0h5eDQokcf2g4QxnmJBkMqZsQnyGRIWmjbutbAWSH62r 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqc1xxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 18:59:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9IiY8V053493;
        Wed, 9 Dec 2020 18:59:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 358m40pqbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 18:59:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9IxSUo015465;
        Wed, 9 Dec 2020 18:59:30 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 10:59:27 -0800
Date:   Wed, 9 Dec 2020 21:59:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] Staging: silabs si4455 serial driver
Message-ID: <20201209185920.GI2789@kadam>
References: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
 <20201209124206.GG2767@kadam>
 <20201209185613.GB30918@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201209185613.GB30918@dincontrollerdev>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:56:13PM +0000, József Horváth wrote:
> Thank you for your suggestions. I made the canges suggested by you.
> 
> I'll test the driver in my development environment, then I'll come
> back with a new patch soon.

Take your time.  No rush.

> 
> I set up a mail client on my linux dev environment, I hope my
> mails/patches/codes will be in proper quality in the future.

No problem at all.  Part of getting used to the process.

regards,
dan carpenter

