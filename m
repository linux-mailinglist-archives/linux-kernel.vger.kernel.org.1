Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA12B1D09
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKMOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:20:01 -0500
Received: from foss.arm.com ([217.140.110.172]:38996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:20:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0CF142F;
        Fri, 13 Nov 2020 06:20:00 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BBBB3F6CF;
        Fri, 13 Nov 2020 06:20:00 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware: arm_scmi: fix missing destroy_workqueue()
Date:   Fri, 13 Nov 2020 14:19:50 +0000
Message-Id: <160527711123.401015.10044003512476618871.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110074221.41235-1-miaoqinglang@huawei.com>
References: <20201110074221.41235-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:42:21 +0800, Qinglang Miao wrote:
> destroy_workqueue seems necessary before return from
> scmi_notification_init in the error handling case when
> fails to do devm_kcalloc(). Fix this by simply moving
> devm_kcalloc to the front.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix missing destroy_workqueue()
      https://git.kernel.org/sudeep.holla/c/6bbdb46c4b

--
Regards,
Sudeep
