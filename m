Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397BA26AA24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgIOQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbgIOQQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:16:13 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7778C2068D;
        Tue, 15 Sep 2020 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186538;
        bh=tbMgTczNIfMiTd+8wBo4e/8BX/EZRu318VNd+A+yKjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFQ8RGHViBPJYkT8Txm2ks9UIuOUSaFvvEOG/acfCNhc6DvUa52ujwYmCv1fxs/n5
         oxKofbWCpCzvowJ4mADzwiHmVZ2KB9mJ6UI214QKrJp2/eYdnW/Fa6iEE2gRrYuUjM
         Zh/yj5oKPArIRInBERknv7g/qdCZCyOIzTVVeRFg=
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, patches@amperecomputing.com,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] perf: arm_dsu: Support DSU ACPI devices
Date:   Tue, 15 Sep 2020 17:15:31 +0100
Message-Id: <160018150231.4070142.8062150711434424721.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1600106656-9542-1-git-send-email-tuanphan@os.amperecomputing.com>
References: <1600106656-9542-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 11:04:16 -0700, Tuan Phan wrote:
> Add support for probing device from ACPI node.
> Each DSU ACPI node and its associated cpus are inside a cluster node.

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_dsu: Support DSU ACPI devices
      https://git.kernel.org/will/c/2b694fc92a34

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
