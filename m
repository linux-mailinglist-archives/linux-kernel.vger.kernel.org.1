Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D138D2614BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgIHQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:35:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbgIHQfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:35:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247A731B;
        Tue,  8 Sep 2020 05:48:22 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 032873F73C;
        Tue,  8 Sep 2020 05:48:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chanho Min <chanho.min@lge.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/6] dt-bindings: Convert SP804 to Json-schema (and fix users)
Date:   Tue,  8 Sep 2020 13:48:17 +0100
Message-Id: <159956909738.1981.16210146390528870384.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828142018.43298-1-andre.przywara@arm.com>
References: <20200828142018.43298-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 15:20:12 +0100, Andre Przywara wrote:
> This is the second attempt at converting the SP804 timer binding to yaml.
> Compared to v1, I forbid additional properties, and included the primecell
> binding. Also the clock-names property is now listed, although without
> further requirements on the names. Changelog below.
> 
> --------------
> The yaml conversion is done in the first patch, the remaining five fix
> some DT users.
> 
> [...]

I have picked one patch for Arm Ltd boards/models.

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] ARM: dts: arm: Fix SP804 users
      https://git.kernel.org/sudeep.holla/c/34a4591871

--

Regards,
Sudeep

