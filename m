Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B21B1229
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDTQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 12:46:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTQqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:46:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB80F31B;
        Mon, 20 Apr 2020 09:46:39 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7C2C3F73D;
        Mon, 20 Apr 2020 09:46:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] SCMI various fixes to Response handling code
Date:   Mon, 20 Apr 2020 17:46:32 +0100
Message-Id: <158740098699.27780.4591369317008505933.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420152315.21008-1-cristian.marussi@arm.com>
References: <20200420152315.21008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 16:23:11 +0100, Cristian Marussi wrote:
> Hi
>
> This serie bring a few fixes related to handling of responses in some
> corner cases; renaming also .clear_notification() into clear_channel(),
> being indeed a method of general utility not strictly related to
> notifications. (and needed by these same fixes)
>
> [...]

Applied, thanks!

[1/4] firmware: arm_scmi: Rename .clear_notification() transport_ops
      commit: 87dff4e63cf2910f2e4a32d1cb3e4a1a25406eb7
[2/4] firmware: arm_scmi: Clear channel on reception of unexpected responses
      commit: b37f5cc8d243479d7572445010fb6c9a4dff6dc4
[3/4] firmware: arm_scmi: Clear channel for delayed responses
      commit: d04fb2b2ddefad7c00edd29c1ed40188ce8f12a2
[4/4] firmware: arm_scmi: Fix handling of unexpected delayed responses
      commit: c5bceb98ce0e4ae8057a386c5171a868213fe226

--
Regards,
Sudeep

