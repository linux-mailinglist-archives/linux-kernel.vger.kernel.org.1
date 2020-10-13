Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDC28CBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgJMKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:45:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgJMKpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:45:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4266F31B;
        Tue, 13 Oct 2020 03:45:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39CDC3F73C;
        Tue, 13 Oct 2020 03:45:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
Date:   Tue, 13 Oct 2020 11:45:36 +0100
Message-Id: <160258579513.51857.17355432234754504187.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 16:37:18 +0200, Etienne Carriere wrote:
> Remove the IDR replacement that prevent initializing an SCMI protocol
> when it has already been initialized. This is needed when there are
> several SCMI agents that do implement a given SCMI protocol unless
> what only the related SCMI protocol communication is initialized only
> for first probed agent.

I am picking up 4-5.

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[4/5] firmware: arm_scmi: Expand SMC/HVC message pool to more than one
      https://git.kernel.org/sudeep.holla/c/7adb2c8aaa
[5/5] firmware: arm_scmi: Fix ARCH_COLD_RESET
      https://git.kernel.org/sudeep.holla/c/45b9e04d5b

--

Regards,
Sudeep

