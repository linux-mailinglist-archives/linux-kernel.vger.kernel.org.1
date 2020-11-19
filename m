Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46312B90B7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKSLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKSLLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:11:24 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:11:24 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so374975plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UfLyjkfwBrBUnjzFIrrwPghdB/OgyfJa54TI3oCwR5M=;
        b=FE98KhE/zieVucMJBIqQZyiC/wDqGqm71dFG662oU6gzFe2rvQi62sHw585ekHW7uh
         T599Ft4t1FzLd8vdfqseckUNGKB6ulFnFvOMqXwIY+KOCLV3buh42pMmamEFHSod7Hg9
         CrKXc9HIxVKY7OkDFCMbZ69uCrBsI3mALkbC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfLyjkfwBrBUnjzFIrrwPghdB/OgyfJa54TI3oCwR5M=;
        b=UWY/bb4RNlYbFW2IldyeOEODmlPvl5rrom/LgXH2yCQ/r4OwwLQTrCHSJvE+xhX1fs
         tqU6VV57ea8NTkdZIQNPq+5J9cKcTlndD+qWmgrgSyASOZNVRTWyyts5WSeruqFwt4iX
         h5wseqmKeWa0uERo0GrCq53v1qZFT69Ix8fL5T/ldHQ9zvMhI9G+aI1B+sAEgZw86OTV
         ah/DkuZRrZRZDXVLeDxWVYcunmgwgGG1bFtbbSvIStbmmNwARDsAznjZ4dp3u1Vbv/gh
         6PR9/L1WcsJBaN6isUoBZ53ixdkgcbSnpLgp7qBN9fyBQMywTA3Jres+wgg1TU2xSeJP
         dIug==
X-Gm-Message-State: AOAM530H5PBeSQOcGfOK97Ia5/vn+LeNCsvMJ1mscBU5/XJofWmxCjYS
        no6Ukfqb0Hhd9H7s7/VIKMUfdA==
X-Google-Smtp-Source: ABdhPJwHSKho56JhQCiK8W7N6LRUdOD6WeIS/qfA/t4A3sSnrHlOR60hyE8u0yo2noX8XFZStWtLnA==
X-Received: by 2002:a17:902:778d:b029:d6:489c:67ee with SMTP id o13-20020a170902778db02900d6489c67eemr8644110pll.52.1605784284295;
        Thu, 19 Nov 2020 03:11:24 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id l76sm614091pfd.82.2020.11.19.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:11:23 -0800 (PST)
Date:   Thu, 19 Nov 2020 03:11:22 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute
 file for partners and cables
Message-ID: <20201119111122.GA3891271@google.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
 <20201118185350.GB3652649@google.com>
 <20201119110506.GA3774817@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119110506.GA3774817@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,
 
On Thu, Nov 19, 2020 at 01:05:06PM +0200, Heikki Krogerus wrote:
> On Wed, Nov 18, 2020 at 10:53:50AM -0800, Prashant Malani wrote:
> > > +What:		/sys/class/typec/<port>-cable/product_type
> > > +Date:		December 2020
> > > +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > +Description:	USB Power Delivery Specification defines a set of product types
> > > +		for the cables. This file will show the product type of the
> > > +		cable if it is known. If the product type of the cable is not
> > > +		visible to the device driver, this file will not exist.
> > > +
> > > +		When the cable product type is detected, uvevent is also raised
> > > +		with PRODUCT_TYPE showing the product type of the cable.
> > > +
> > > +		Valid values:
> > > +
> > > +		========================  ==========================
> > > +		undefined		  -
> > > +		active			  Active Cable
> > > +		passive			  Passive Cable
> > > +		========================  ==========================
> > 
> > There exists a /sys/class/typec/<port>-cable/type attribute (connected
> > to the "active" field in struct typec_cable [1]), which is supposed
> > to be populated by the Type C port driver. Won't the newly introduced
> > attribute duplicate the same information as "type"?
> 
> True. So we don't need add this for the cable separately. I'll just
> modify the code so that it considers also the response to Discover
> Identity command if we have access to it.
> 
> Would it be OK if we name the file "type" instead of "product_type"
> also with the partners?

That makes the naming consistent. Sounds good to me :)

Best regards,

-Prashant
