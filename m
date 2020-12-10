Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA62D54FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgLJIBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:01:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42098 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgLJIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:01:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BA808Z7046402;
        Thu, 10 Dec 2020 08:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=qahWmu7yfkzVAk9fNv3cnE4VKjWf+61A/L9L1BkjeEg=;
 b=xdD3jq2WCyAdlwDDQm0B4lv4ih5tNTqZG2MezTHyT9JGc3ydaCru5ly4pQIcR2059BzU
 dKmmjoyp2snDGRNG25b9NwPUjBVpA9QPTKpfirSd138k0WP0a2Dl/yGrVmjELMM9Y4HH
 +rqfAA3WBHuucz+EC6k9DsijUMJggFFfhTpqQEzlSm+5F5SeAlhIz/sX/sm6YiFf60uk
 XkekeOTl/m40KHM4JpRT60dkj855oKr7LOYUEJEB7PS9yiUo/TWL9xIuZxJm1ePyRQcK
 hzjqX7UbDn6JZA87aX7yYhZpnkFRREkJMApKDgAKsoqBNhm+8X824hBpVoWrBbRwMFn6 bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqc42x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 08:00:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BA7ua2g132306;
        Thu, 10 Dec 2020 08:00:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m41cffn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 08:00:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BA80EAM013160;
        Thu, 10 Dec 2020 08:00:14 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 00:00:13 -0800
Date:   Thu, 10 Dec 2020 11:00:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, "'Rob Herring'" <robh+dt@kernel.org>
Subject: Re: [PATCH] Staging: silabs si4455 serial driver
Message-ID: <20201210080006.GK2767@kadam>
References: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
 <2907305.Mh6RI2rZIc@pc-42>
 <20201209194153.GC30918@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201209194153.GC30918@dincontrollerdev>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:41:53PM +0000, József Horváth wrote:
> > > +static int si4455_get_part_info(struct uart_port *port,
> > > +                               struct si4455_part_info *result)
> > > +{
> > > +       int ret;
> > > +       u8 dataOut[] = { SI4455_CMD_ID_PART_INFO };
> > > +       u8 dataIn[SI4455_CMD_REPLY_COUNT_PART_INFO];
> > > +
> > > +       ret = si4455_send_command_get_response(port,
> > > +                                               sizeof(dataOut),
> > > +                                               dataOut,
> > > +                                               sizeof(dataIn),
> > > +                                               dataIn);
> > 
> > Why not:
> > 
> 
> I changed all like this in my code already. I test it, and I'll send it again.
> 
> Ps.: For my eyes is better to read line or list, reading table is harder :)
> 
> 	line(arg1, arg2, arg3, arg4);
> 
> 	list(arg1,
> 		arg2,
> 		arg3,
> 		arg4);
> 
> 	table(arg1, arg2,
> 		arg3, arg4);
> 

Use spaces to make arguments have to line up properly.
`checkpatch.pl --strict` will complain if it's not done.

	table(arg1, arg2,
	      arg_whatver, foo);
[tab][space x 7]arg_whaver, foo);

But I think Jérôme's main point was to get rid of the dataOut buffer and
use "result" directly.

> 
> >        ret = si4455_send_command_get_response(port,
> >                                               sizeof(*result), result,
> >                                               sizeof(dataIn), dataIn);
> > 
> > > +       if (ret == 0) {
> > > +               result->CHIPREV = dataIn[0];
> > > +               memcpy(&result->PART, &dataIn[1],sizeof(result->PART));
> > > +               result->PBUILD = dataIn[3];
> > > +               memcpy(&result->ID, &dataIn[4], sizeof(result->ID));
> > > +               result->CUSTOMER = dataIn[6];
> > > +               result->ROMID = dataIn[7];
> > > +               result->BOND = dataIn[8];
> > 
> > ... it would avoid all these lines.
> > 

regards,
dan carpenter

