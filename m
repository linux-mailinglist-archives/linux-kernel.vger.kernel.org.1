Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF22C0393
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgKWKng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:43:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgKWKng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:43:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A4E5101E;
        Mon, 23 Nov 2020 02:43:35 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DED6D3F70D;
        Mon, 23 Nov 2020 02:43:33 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, peter.hilber@opensynergy.com,
        egranata@google.com, jbhayana@google.com,
        james.quinlan@broadcom.com, mikhail.golubev@opensynergy.com,
        Jonathan.Cameron@Huawei.com, lukasz.luba@arm.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v4 0/6] SCMIv3.0 Sensor Extensions
Date:   Mon, 23 Nov 2020 10:43:30 +0000
Message-Id: <160612810471.1279460.7076576026595323961.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119174906.43862-1-cristian.marussi@arm.com>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:49:00 +0000, Cristian Marussi wrote:
> this series is meant to add support for the new SCMI Sensor Protocol
> features defined by the upcoming SCMIv3.0 specification, whose BETA
> release is available at [1].
> 
> The series is currently based on for-next/scmi [2] on top of:
> 
> commit b141fca08207 ("firmware: arm_scmi: Fix missing destroy_workqueue()")
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/6] firmware: arm_scmi: Rework scmi_sensors_protocol_init
      https://git.kernel.org/sudeep.holla/c/f25fb6de67
[2/6] firmware: arm_scmi: Add SCMI v3.0 sensors descriptors extensions
      https://git.kernel.org/sudeep.holla/c/1fe00b8b42
[3/6] hwmon: (scmi) Update hwmon internal scale data type
      https://git.kernel.org/sudeep.holla/c/d7971d57d2
[4/6] firmware: arm_scmi: Add SCMI v3.0 sensors timestamped reads
      https://git.kernel.org/sudeep.holla/c/e2083d3673
[5/6] firmware: arm_scmi: Add SCMI v3.0 sensor configuration support
      https://git.kernel.org/sudeep.holla/c/7b83c5f410
[6/6] firmware: arm_scmi: Add SCMI v3.0 sensor notifications
      https://git.kernel.org/sudeep.holla/c/e3811190ac

--
Regards,
Sudeep

