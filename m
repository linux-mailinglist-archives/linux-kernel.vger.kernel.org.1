Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABBC2C6BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgK0T0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgK0TNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:13:32 -0500
Received: from localhost.localdomain (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA81221F1;
        Fri, 27 Nov 2020 19:12:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Date:   Fri, 27 Nov 2020 19:12:43 +0000
Message-Id: <160650434702.20875.12520970127987518808.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 14:15:55 -0500, Tyler Hicks wrote:
> Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> config option can be used to extend the kernel command line parameters,
> specified by the bootloader, with additional command line parameters
> specified in the kernel configuration.
> 
> This option addresses the following use cases:
> 
> [...]

Applied to arm64 (for-next/cmdline-extended), thanks!

[1/2] arm64: kaslr: Refactor early init command line parsing
      https://git.kernel.org/arm64/c/52ec03f75d59
[2/2] arm64: Extend the kernel command line from the bootloader
      https://git.kernel.org/arm64/c/1e40d105dae5

-- 
Catalin

