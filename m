Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D63221173
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGOPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:45:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGOPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:45:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BD81FB;
        Wed, 15 Jul 2020 08:45:03 -0700 (PDT)
Received: from bogus (unknown [10.37.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBBC93F792;
        Wed, 15 Jul 2020 08:45:01 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:44:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RESEND][PATCH] hwmon: scmi: fix potential buffer overflow in
 scmi_hwmon_probe()
Message-ID: <20200715154458.GB5402@bogus>
References: <20200715121338.GA18761@e119603-lin.cambridge.arm.com>
 <20200715130043.GA28391@bogus>
 <8e2af192-97c3-bbc6-e9d7-3345b4331b65@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2af192-97c3-bbc6-e9d7-3345b4331b65@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:55:52AM -0700, Guenter Roeck wrote:
> On 7/15/20 6:00 AM, Sudeep Holla wrote:
> > On Wed, Jul 15, 2020 at 01:13:38PM +0100, Cristian Marussi wrote:
> >> SMATCH detected a potential buffer overflow in the manipulation of
> >> hwmon_attributes array inside the scmi_hwmon_probe function:
> >>
> >> drivers/hwmon/scmi-hwmon.c:226
> >>  scmi_hwmon_probe() error: buffer overflow 'hwmon_attributes' 6 <= 9
> >>
> >> Fix it by statically declaring the size of the array as the maximum
> >> possible as defined by hwmon_max define.
> >>
> > 
> > Makes sense to me,
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > There may be other such instances. I am not sure if Guenter has ignored
> > them intentionally or just no one has fixed them so far.
> 
> I am not perfect. No, I have not intentionally ignored anything,
> and I don't recall seeing smatch reports (or this patch) before.
> 

Sorry, it was not complaint, it does sound so now when I read that again.

What I meant is, not everyone likes to fix all the warnings from various
tools and I was just asking if this falls into that category as the
overflow can't happen if we use the standard hwmon_max enums as indicies.

-- 
Regards,
Sudeep
