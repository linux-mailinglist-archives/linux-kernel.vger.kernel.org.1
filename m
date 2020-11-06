Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8F2A9988
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgKFQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFQfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:35:31 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7B521556;
        Fri,  6 Nov 2020 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604680531;
        bh=0wCWpAcIHmBZ8yj4LMDQrJn2YVM8psFMGCTOMTg3pjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwTM2TDFzuMMUG4CzOaHC4OMdPkhbVE+ZqHMLqy1BQTXaKgbRmUy31T5q9Syd6zzv
         xaSx4JeZeXJ7aLtou2VJGGBLXUO+afxrfSvCy0itTcBajVK4K9OO7dhaLRE43vGY8N
         EriscBXfkyPlcsDw6uY8lI9Y5ff0eXp98BfH+D18=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kb4i1-008FRC-01; Fri, 06 Nov 2020 16:35:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Andrew Jones <drjones@redhat.com>, kvmarm@lists.cs.columbia.edu,
        Gavin Shan <gshan@redhat.com>
Cc:     xu910121@sina.com, Dave.Martin@arm.com, will@kernel.org,
        shan.gavin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix build error in user_mem_abort()
Date:   Fri,  6 Nov 2020 16:35:20 +0000
Message-Id: <160468048426.137782.4397939179876151819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103003009.32955-1-gshan@redhat.com>
References: <20201103003009.32955-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvmarm@lists.cs.columbia.edu, gshan@redhat.com, xu910121@sina.com, Dave.Martin@arm.com, will@kernel.org, shan.gavin@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 11:30:09 +1100, Gavin Shan wrote:
> The PUD and PMD are folded into PGD when the following options are
> enabled. In that case, PUD_SHIFT is equal to PMD_SHIFT and we fail
> to build with the indicated errors:
> 
>    CONFIG_ARM64_VA_BITS_42=y
>    CONFIG_ARM64_PAGE_SHIFT=16
>    CONFIG_PGTABLE_LEVELS=3
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Fix build error in user_mem_abort()
      commit: faf000397e7f103df9953a312e1df21df1dc797f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


