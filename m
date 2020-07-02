Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F9212223
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGBLYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:24:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgGBLYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:24:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF4C1FB;
        Thu,  2 Jul 2020 04:24:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E7C3F71E;
        Thu,  2 Jul 2020 04:24:16 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing PLT counting
Date:   Thu,  2 Jul 2020 12:24:10 +0100
Message-Id: <159368896834.26148.7850220822704601386.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623011803.91232-1-saravanak@google.com>
References: <20200623011803.91232-1-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 18:18:02 -0700, Saravana Kannan wrote:
> When loading a module, module_frob_arch_sections() tries to figure out
> the number of PLTs that'll be needed to handle all the RELAs. While
> doing this, it tries to dedupe PLT allocations for multiple
> R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> R_AARCH64_JUMP26 relocations.
> 
> To make checks for duplicates easier/faster, it sorts the relocation
> list by type, symbol and addend. That way, to check for a duplicate
> relocation, it just needs to compare with the previous entry.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/module: Optimize module load time by optimizing PLT counting
      https://git.kernel.org/arm64/c/d4e0340919fb

-- 
Catalin

