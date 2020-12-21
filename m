Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D42DFFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLUSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:34:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63314 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgLUSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:34:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLIJekM091767;
        Mon, 21 Dec 2020 13:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YU06tA5Y+2CkSqIdHmYkXHp40yKZjqBBZKZGBv97pUI=;
 b=JCZt9joueI/Bfc/wnqQU6OlNktUFAyjGqq/X83RQ33BliRau0qR1Qor0I8mejFBnqS8W
 mSPvyGgUY2MAegM+Zd0+3R8McvwaXbnHLhHUDLkJkgvBsc9kKYubNurxHQPE6dMDHRKn
 BUYO+apN8pBdyTkK3HOUJpGDW+xO2zOLdni/Auu8lgAX9GCvmMdF0WuJMBdjY4+NBt3i
 fsX/l0X5xGqXan825tqXQpbJfOaaxDTIXDh0yqc/M4zuiVNmTEw+sKGTQyS8G2gs8sqp
 wRQnkdbMXjFy/IPcCD3Dv68yRgQY2kKw2aYy796TWYzTydVz+0j99ee5RdrBzkSe8+PG Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35k0vwrabh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 13:34:02 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLINsK1106818;
        Mon, 21 Dec 2020 13:34:02 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35k0vwrab4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 13:34:02 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BLIRdHG021966;
        Mon, 21 Dec 2020 18:33:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 35h958sa07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 18:33:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BLIX03024248626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 18:33:00 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE66136055;
        Mon, 21 Dec 2020 18:33:00 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585D6136051;
        Mon, 21 Dec 2020 18:33:00 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.87.162])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Dec 2020 18:33:00 +0000 (GMT)
Message-ID: <d64b8971e5d14106e3f51fd4f0328762ec35cd7c.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] hwmon: (pmbus) Add a NO_PEC flag to probe chips
 with faulty CAPABILITY
From:   Eddie James <eajames@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com, bjwyman@gmail.com
Date:   Mon, 21 Dec 2020 12:32:59 -0600
In-Reply-To: <f96ded73-93de-dc7d-36af-7f100e71817a@roeck-us.net>
References: <20201221163058.33257-1-eajames@linux.ibm.com>
         <20201221163058.33257-2-eajames@linux.ibm.com>
         <f96ded73-93de-dc7d-36af-7f100e71817a@roeck-us.net>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_10:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-21 at 08:54 -0800, Guenter Roeck wrote:
> On 12/21/20 8:30 AM, Eddie James wrote:
> > Some PMBus chips don't respond with valid data when reading the
> > CAPABILITY register. For instance the register may report that the
> > chip supports PEC when in reality it does not. For such chips, PEC
> > must not be enabled while probing the chip, so add a flag so that
> > device drivers can force PEC off.
> > 
> 
> I think the flag should indicate that the capability register
> shall not be read/used. That the capability register is currently
> only used to check for PEC is secondary. We might,for example,
> start using it to check for alert support or to check the numeric
> format.

OK, that makes sense. I'll rename the flag in v2, how does
PMBUS_NO_CAPABILITY sound?

Thanks for the quick reply,
Eddie

> 
> Thanks,
> Guenter
> 
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >  drivers/hwmon/pmbus/pmbus_core.c |  8 +++++---
> >  include/linux/pmbus.h            | 10 ++++++++++
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c
> > b/drivers/hwmon/pmbus/pmbus_core.c
> > index 192442b3b7a2..3de1657dde35 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -2204,9 +2204,11 @@ static int pmbus_init_common(struct
> > i2c_client *client, struct pmbus_data *data,
> >  	}
> >  
> >  	/* Enable PEC if the controller supports it */
> > -	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> > -	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> > -		client->flags |= I2C_CLIENT_PEC;
> > +	if (!(data->flags & PMBUS_NO_PEC)) {
> > +		ret = i2c_smbus_read_byte_data(client,
> > PMBUS_CAPABILITY);
> > +		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> > +			client->flags |= I2C_CLIENT_PEC;
> > +	}
> >  
> >  	/*
> >  	 * Check if the chip is write protected. If it is, we can not
> > clear
> > diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
> > index 1ea5bae708a1..9bdc8a581b03 100644
> > --- a/include/linux/pmbus.h
> > +++ b/include/linux/pmbus.h
> > @@ -34,6 +34,16 @@
> >   */
> >  #define PMBUS_WRITE_PROTECTED	BIT(1)
> >  
> > +/*
> > + * PMBUS_NO_PEC
> > + *
> > + * Some PMBus chips don't respond with valid data when reading the
> > CAPABILITY
> > + * register. In this case, the register may report that the chip
> > supports PEC
> > + * with bit 7 (PB_CAPABILITY_ERROR_CHECK) when in reality it's not
> > supported.
> > + * For such chips, PEC must not be enabled before probing the
> > chip.
> > + */
> > +#define PMBUS_NO_PEC			BIT(2)
> > +
> >  struct pmbus_platform_data {
> >  	u32 flags;		/* Device specific flags */
> >  
> > 

