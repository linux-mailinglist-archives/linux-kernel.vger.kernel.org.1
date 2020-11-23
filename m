Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027C2C10F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbgKWQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:42:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgKWQmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:42:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3094D1396;
        Mon, 23 Nov 2020 08:42:20 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77E523F718;
        Mon, 23 Nov 2020 08:42:19 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: remove residual _le structs naming
Date:   Mon, 23 Nov 2020 16:42:13 +0000
Message-Id: <160614966102.1284573.1127838863836084762.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123162008.35814-1-cristian.marussi@arm.com>
References: <20201123162008.35814-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 16:20:08 +0000, Cristian Marussi wrote:
> For sake of consistency, remove any residual naming based on _le suffixes
> in SCMI Sensors Protocol, since little endianity is already assumed across
> all of SCMI implementation and, as such, all currently existent names do
> not explicitly state their endianness.
> 
> No functional change.


Applied to sudeep.holla/linux (for-linux-next), thanks!

[1/1] firmware: arm_scmi: Remove residual _le structs naming
      https://git.kernel.org/sudeep.holla/c/e945927dc7

--
Regards,
Sudeep

