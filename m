Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6583E2C4455
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgKYPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgKYPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:44:27 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B78F20BED;
        Wed, 25 Nov 2020 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319066;
        bh=lwQw4VxI+qLzdC6d0qmVwWceyeh15VhkL2IAaP452qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRxyGDitNEFgww3pT3G1HTIIoLQBJHypdcX43zJb/RVdoqyqHkblINmFE4zdVsBs4
         uFFikXU31yuwKbGaXwz2nmSvnkadfmHCwc61V9m+rH/rB5bQfaJspIkqu3r1aJYa4r
         74N1U2KQIA1Zx25WiOwOcpw5GpCVF7bcJIMa4q+A=
From:   Will Deacon <will@kernel.org>
To:     Wang Qing <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf: remove duplicate check on fwnode
Date:   Wed, 25 Nov 2020 15:44:10 +0000
Message-Id: <160631652907.2329995.10801003859693560401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1604644902-29655-1-git-send-email-wangqing@vivo.com>
References: <1604644902-29655-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 14:41:42 +0800, Wang Qing wrote:
> fwnode is checked IS_ERR_OR_NULL in following check by
> is_of_node() or is_acpi_device_node(), remove duplicate check.

Applied to will (for-next/perf), thanks!

[1/1] perf: remove duplicate check on fwnode
      https://git.kernel.org/will/c/6c8cfbf5db42

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
