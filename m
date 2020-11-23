Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F72C02E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgKWKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:00:27 -0500
Received: from foss.arm.com ([217.140.110.172]:39518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgKWKA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:00:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5BA101E;
        Mon, 23 Nov 2020 02:00:26 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16253F70D;
        Mon, 23 Nov 2020 02:00:24 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:00:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, egranata@google.com,
        jbhayana@google.com, peter.hilber@opensynergy.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 3/6] hwmon: scmi: update hwmon internal scale data type
Message-ID: <20201123095958.3k7nosdbwvwkxbzb@bogus>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
 <20201119174906.43862-4-cristian.marussi@arm.com>
 <20201121165903.GA111877@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121165903.GA111877@roeck-us.net>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 08:59:03AM -0800, Guenter Roeck wrote:
> On Thu, Nov 19, 2020 at 05:49:03PM +0000, Cristian Marussi wrote:
> > Use an int to calculate scale values inside scmi_hwmon_scale() to match
> > the updated scale data type in struct scmi_sensor_info.
> > 
> > Cc: linux-hwmon@vger.kernel.org
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks.

> [ Assuming this will be pushed togesther with the other patches in the series ]
>

Yes I am planning to take as part of the series.

-- 
Regards,
Sudeep
