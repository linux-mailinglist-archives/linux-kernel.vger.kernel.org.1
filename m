Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF52126D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgGBOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:48:15 -0400
Received: from foss.arm.com ([217.140.110.172]:59374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbgGBOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D5931B;
        Thu,  2 Jul 2020 07:46:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0CC63F68F;
        Thu,  2 Jul 2020 07:46:57 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/panic: Unify all three existing notifier blocks
Date:   Thu,  2 Jul 2020 15:46:44 +0100
Message-Id: <159370110901.31751.16839966979398690035.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1593405511-7625-1-git-send-email-anshuman.khandual@arm.com>
References: <1593405511-7625-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 10:08:31 +0530, Anshuman Khandual wrote:
> Currently there are three different registered panic notifier blocks. This
> unifies all of them into a single one i.e arm64_panic_block, hence reducing
> code duplication and required calling sequence during panic. This preserves
> the existing dump sequence. While here, just use device_initcall() directly
> instead of __initcall() which has been a legacy alias for the earlier. This
> replacement is a pure cleanup with no functional implications.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/panic: Unify all three existing notifier blocks
      https://git.kernel.org/arm64/c/638d50313009

-- 
Catalin

