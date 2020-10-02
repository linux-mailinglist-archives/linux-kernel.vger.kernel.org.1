Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F94280EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgJBIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgJBIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:20:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A8D207F7;
        Fri,  2 Oct 2020 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601626813;
        bh=nNjOEAmXenV7kByqYczREIpR5MzajAytxxtfDgky/b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+DPBeGHoTMPbUfdsfcn7j4RvdBEomDvKcjosTJ+vKLcyQhu7cOr4fDs13Xb3twX0
         ef8G6rIVcTBjwe9ZbdeTRiZGSbtCUVZHFoxMPS70c6oDW7oIcZPew1JqlQEy/h/0cs
         adHpIMHvPuanQP0MBym48WngG9cb+s868hTpj8LM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kOGIW-00GeG7-2n; Fri, 02 Oct 2020 09:20:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@android.com,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] KVM: arm64: Pass level hint to TLBI during stage-2 permission fault
Date:   Fri,  2 Oct 2020 09:20:01 +0100
Message-Id: <160162675379.1930042.14641926420921373250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930131801.16889-1-will@kernel.org>
References: <20200930131801.16889-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, dbrazdil@google.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dennis@kernel.org, catalin.marinas@arm.com, tj@kernel.org, kernel-team@android.com, cl@linux.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 14:18:01 +0100, Will Deacon wrote:
> Alex pointed out that we don't pass a level hint to the TLBI instruction
> when handling a stage-2 permission fault, even though the walker does
> at some point have the level information in its hands.
> 
> Rework stage2_update_leaf_attrs() so that it can optionally return the
> level of the updated pte to its caller, which can in turn be used to
> provide the correct TLBI level hint.

Applied to next, thanks!

[1/1] KVM: arm64: Pass level hint to TLBI during stage-2 permission fault
      commit: b259d137e91d80bf92eac453ffab179eb7941ede

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


