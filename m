Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF672F1E16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbhAKSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:31:37 -0500
Received: from foss.arm.com ([217.140.110.172]:34360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389276AbhAKSbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:31:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89AD9101E;
        Mon, 11 Jan 2021 10:30:50 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 636243F70D;
        Mon, 11 Jan 2021 10:30:49 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     james.quinlan@broadcom.com, Jim Quinlan <jim2101024@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Mon, 11 Jan 2021 18:30:43 +0000
Message-Id: <161038967783.12198.12858396515657491931.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145603.40192-1-jim2101024@gmail.com>
References: <20201222145603.40192-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 09:56:01 -0500, Jim Quinlan wrote:
> v4 -- s/message-serviced/a2p/ in the bindings commit message.
>    -- Changed author/s-o-b/committer email address as my company is now
>       appending boilerplate text to all outgoing emails.
> 
> v3 -- Changed interrupt name from "message-serviced" to "a2p" (RobH)
> 
> v2 -- Correct commit message, s/msg/message/, and remove extra WS on
>       "dt-bindings" commit (Sudeep)
>    -- Change interrupt name to "message-serviced", move irq assignent to end
>       of function. (Sudeep)
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
      https://git.kernel.org/sudeep.holla/c/99a064fb3a
[2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
      https://git.kernel.org/sudeep.holla/c/dd820ee21d

--
Regards,
Sudeep

