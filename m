Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6881027B820
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgI1Xac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgI1Xab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:30:31 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2575B2311C;
        Mon, 28 Sep 2020 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331211;
        bh=pgUIZysIK7lf6lo7USrdfGQn+em4Qyd3aAxmmKkexrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7Hd0Rqb/FjcrbpWzQDN9tO2jA3+L1aBo3Z8mTfjE2WJwvjwa11O3OOCK15N4HOB6
         KUnexO3cH0TcDGf8VP/rgq9puXMlr8+8OJzettVB72gowMZ1bZPgM9PgmvcOwlKrxf
         QjpQA62ygR/O97bSl1lM06udouONZzqX0ykfVZbc=
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        james.morse@arm.com, shan.gavin@gmail.com,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v5 00/13] Refactor SDEI client driver
Date:   Mon, 28 Sep 2020 23:13:21 +0100
Message-Id: <160132634376.1851570.16643738826038417970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 23:04:10 +1000, Gavin Shan wrote:
> This series bases on 5.9.rc5 and extracted from (v4) series of "Refactoring
> SDEI client driver", which is prepatory work to support SDEI virtualizaton.
> This series can be checkout from github.
> 
>    git@github.com:gwshan/linux.git (branch: "sdei_client")
> 
> Testing
> =======
> I have the SDEI virtualization code implemented as part of KVM module.
> With that, the SDEI event can be registered/unregistered/enabled/disabled.
> Also, the SDEI event can be injected from host and the guest handler runs
> properly.
> 
> [...]

Applied to arm64 (for-next/sdei), thanks!

[01/13] firmware: arm_sdei: Remove sdei_is_err()
        https://git.kernel.org/arm64/c/5735f5158430
[02/13] firmware: arm_sdei: Common block for failing path in sdei_event_create()
        https://git.kernel.org/arm64/c/119884249fdb
[03/13] firmware: arm_sdei: Retrieve event number from event instance
        https://git.kernel.org/arm64/c/663c0e89c8de
[04/13] firmware: arm_sdei: Avoid nested statements in sdei_init()
        https://git.kernel.org/arm64/c/10fd7c42b795
[05/13] firmware: arm_sdei: Unregister driver on error in sdei_init()
        https://git.kernel.org/arm64/c/63627cae41e3
[06/13] firmware: arm_sdei: Remove duplicate check in sdei_get_conduit()
        https://git.kernel.org/arm64/c/bc110fd32281
[07/13] firmware: arm_sdei: Remove redundant error message in sdei_probe()
        https://git.kernel.org/arm64/c/101119a35ca1
[08/13] firmware: arm_sdei: Remove while loop in sdei_event_register()
        https://git.kernel.org/arm64/c/1bbc75518503
[09/13] firmware: arm_sdei: Remove while loop in sdei_event_unregister()
        https://git.kernel.org/arm64/c/b06146b698e6
[10/13] firmware: arm_sdei: Cleanup on cross call function
        https://git.kernel.org/arm64/c/a27c04e1de87
[11/13] firmware: arm_sdei: Introduce sdei_do_local_call()
        https://git.kernel.org/arm64/c/f4673625a52c
[12/13] firmware: arm_sdei: Remove _sdei_event_register()
        https://git.kernel.org/arm64/c/d2fc580d2dca
[13/13] firmware: arm_sdei: Remove _sdei_event_unregister()
        https://git.kernel.org/arm64/c/4b2b76cbbc8f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
