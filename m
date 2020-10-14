Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9328E7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgJNU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:27:18 -0400
Received: from foss.arm.com ([217.140.110.172]:58256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgJNU1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:27:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E817BD6E;
        Wed, 14 Oct 2020 13:27:17 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37F523F719;
        Wed, 14 Oct 2020 13:27:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix notifications locking
Date:   Wed, 14 Oct 2020 21:27:10 +0100
Message-Id: <160270712152.50074.11126104112406459334.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201013133109.49821-1-cristian.marussi@arm.com>
References: <20201013133109.49821-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 14:31:09 +0100, Cristian Marussi wrote:
> When a protocol registers its events the notification core takes care to
> re-scan the hashtable of pending event handlers and activate all the
> possibly existent handlers that refer to any of the events just registered
> by the new protocol; when a pending handler becomes active the core takes
> also care to ask the SCMI platform to enable the corresponding events'
> notifications in the SCMI firmware.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix locking in notifications
      https://git.kernel.org/sudeep.holla/c/c7821c2d9c

--

Regards,
Sudeep

