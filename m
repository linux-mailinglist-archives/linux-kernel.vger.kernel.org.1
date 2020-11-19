Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059022B9A46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgKSR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:59:46 -0500
Received: from foss.arm.com ([217.140.110.172]:36530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbgKSR7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:59:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4EB1595;
        Thu, 19 Nov 2020 09:59:45 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8907C3F70D;
        Thu, 19 Nov 2020 09:59:43 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:59:41 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, egranata@google.com,
        jbhayana@google.com, peter.hilber@opensynergy.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/6] hwmon: scmi: update hwmon internal scale data type
Message-ID: <20201119175941.3pqqtoj3sd7itmkg@bogus>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
 <20201119174906.43862-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119174906.43862-4-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, Nov 19, 2020 at 05:49:03PM +0000, Cristian Marussi wrote:
> Use an int to calculate scale values inside scmi_hwmon_scale() to match
> the updated scale data type in struct scmi_sensor_info.
>

You were not cc-ed in previous versions unfortunately. I plan to take this
along with the rest of SCMI changes if you are fine with this change and
provide Ack/Review. Sorry for the rush.

-- 
Regards,
Sudeep
