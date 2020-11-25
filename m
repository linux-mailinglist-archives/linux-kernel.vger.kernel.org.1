Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114332C4452
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgKYPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731100AbgKYPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:44:17 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B045E206CA;
        Wed, 25 Nov 2020 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319056;
        bh=Kv/Zba9zQeY9VafKZTCpLyOei7XTqTLGHS3YlXU+rmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5egs9W64dLw2eKRgGVpTrdbLoVOw1N/nDUKGpFZD50E52eYZksaswSKSX73q04md
         KXqDX+VD48kQj9PKkEL24T2MLgVYveuBlL95XprpZwraLWXspvyD7k1qqRxFDqS+he
         JBtCx5S6c6ONJceXFlnUe+lRZ/5iOw/6cBgY67tg=
From:   Will Deacon <will@kernel.org>
To:     qiangqing.zhang@nxp.com, zhangshaokun@hisilicon.com,
        mark.rutland@arm.com, Frank.li@nxp.com,
        John Garry <john.garry@huawei.com>, robh+dt@kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        irogers@google.com, jolsa@redhat.com, devicetree@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
Date:   Wed, 25 Nov 2020 15:44:06 +0000
Message-Id: <160631703729.2332128.13220150013299384201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 17:26:17 +0800, John Garry wrote:
> To allow perf tool to identify a specific implementation of a PMU for
> event alias matching and metric support, expose a per-PMU identifier file.
> 
> There is no standard format for the identifier string. It just should be
> unique per HW implementation.
> 
> Typical methods to retrieve the information for the identifier string
> can include:
> - Hardcoding in the driver, matched via DT bindings compat string,
>   ACPI HID, or similar
> - Directly from DT bindings property
> - Read from some HW identification register
> 
> [...]

Applied the hisi and smmu parts to will (for-next/perf), thanks!

[1/4] drivers/perf: hisi: Add identifier sysfs file
      https://git.kernel.org/will/c/ac4511c9364c
[...]
[4/4] perf/smmuv3: Support sysfs identifier file
      https://git.kernel.org/will/c/2c255223362e

I've completely lost track of the imx ddr PMU, so I dropped those parts
(patch 3/4 seemed to remove a compatible string from the driver?).

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
