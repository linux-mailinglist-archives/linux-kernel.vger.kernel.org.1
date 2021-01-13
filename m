Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A52F4892
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAMKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:23:43 -0500
Received: from foss.arm.com ([217.140.110.172]:33754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbhAMKXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:23:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 015351042;
        Wed, 13 Jan 2021 02:22:57 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44C933F66E;
        Wed, 13 Jan 2021 02:22:56 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:22:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix call site of notifications exit
Message-ID: <20210113102254.gxyqiujrdj2563pa@bogus>
References: <20210112191326.29091-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112191326.29091-1-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 07:13:26PM +0000, Cristian Marussi wrote:
> Call scmi_notification_exit() only when SCMI platform driver instance has
> been really successfully removed.
>

Doesn't this deserve Fixes tag BTW ? Just send the tag if required, I can
fold it in.

-- 
Regards,
Sudeep
