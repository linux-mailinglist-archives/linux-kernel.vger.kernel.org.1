Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86D2EB531
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbhAEWH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbhAEWH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:07:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A528B22EBF;
        Tue,  5 Jan 2021 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884435;
        bh=tsheRUiuvVXoAiX6SgiMXhmYuf9QGk7UvV4pmxzSUbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W40u7p8GiX2ojjXhVZV3jacLPbHw+9iWZAuRtnNsZcnUkILt74wXGO7nxoTHirp+V
         7nNcX7rV0NyW5xc9sgbL6ddKhhgysMhvf/BkeHGenLnQ+3MeUzLBw6Gzzzi6oY779Q
         EEG4B2fmSmCQHoPcBmgl2zvEOtv2JR0t8QSJIOKUNHexJzl1qgNx+MYv0Bj5PTZBxz
         uRG3QuKRoOUg3A+7G9i+bp+N/5E3XsFWkNiHEtKuUIZubIBayOw0Cc1Y83gE8AhQaO
         WNdv16PvziQUv+TxcRCvG/pA+ZtjH7/Gjmdw6iXPDcDT69RXbmt7S74Vxs9cnrjGVX
         ZhZYFui+RfhbQ==
From:   Will Deacon <will@kernel.org>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: fix 'domain' typos
Date:   Tue,  5 Jan 2021 22:07:03 +0000
Message-Id: <160987253811.25749.17357875257993494998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201222164232.88795-1-sgarzare@redhat.com>
References: <20201222164232.88795-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 17:42:32 +0100, Stefano Garzarella wrote:
> Replace misspelled 'doamin' with 'domain' in several comments.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/iova: fix 'domain' typos
      https://git.kernel.org/arm64/c/6775ae901ffd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
