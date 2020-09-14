Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D1268502
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:59224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgINGgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29F31D6E;
        Sun, 13 Sep 2020 23:36:21 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201F13F73B;
        Sun, 13 Sep 2020 23:36:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v6 0/3] SCMI System Power Support
Date:   Mon, 14 Sep 2020 07:36:13 +0100
Message-Id: <160006520686.28306.13796510777414837604.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907174657.32466-1-cristian.marussi@arm.com>
References: <20200907174657.32466-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 18:46:54 +0100, Cristian Marussi wrote:
> this series wants to add the core SCMI System Power support and related
> events' handling logic: the protocol support itself is trivial and boils
> down to some bare initializations and supporting one SCMI System Power
> notification event meant to carry platform-originated System transition
> requests. This is patch [1/3].
> 
> Patch [2/3] simply adds a new System Power device name to the core driver.
> 
> [...]

As mentioned earlier, I am picking up only scmi firmware driver related
changes, we need more review or feedback on the user interface part.

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] firmware: arm_scmi: Add system power protocol support
      https://git.kernel.org/sudeep.holla/c/a880305512
[2/2] firmware: arm_scmi: Add SCMI device for system power protocol
      https://git.kernel.org/sudeep.holla/c/481f6ccf39

--

Regards,
Sudeep

