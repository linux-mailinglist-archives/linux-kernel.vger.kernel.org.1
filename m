Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614F02F48E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbhAMKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:44:00 -0500
Received: from foss.arm.com ([217.140.110.172]:34048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbhAMKn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:43:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B3651042;
        Wed, 13 Jan 2021 02:43:14 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1C33F66E;
        Wed, 13 Jan 2021 02:43:13 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:43:10 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: fix call site of notifications exit
Message-ID: <20210113104310.GC44413@e120937-lin>
References: <20210112191326.29091-1-cristian.marussi@arm.com>
 <20210113102254.gxyqiujrdj2563pa@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113102254.gxyqiujrdj2563pa@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:22:54AM +0000, Sudeep Holla wrote:
> On Tue, Jan 12, 2021 at 07:13:26PM +0000, Cristian Marussi wrote:
> > Call scmi_notification_exit() only when SCMI platform driver instance has
> > been really successfully removed.
> >
> 
> Doesn't this deserve Fixes tag BTW ? Just send the tag if required, I can
> fold it in.

Yes, sorry

Fixes: 6b8a69131dc63 ("firmware: arm_scmi: Enable notification core")

Thanks

Cristian

> 
> -- 
> Regards,
> Sudeep
