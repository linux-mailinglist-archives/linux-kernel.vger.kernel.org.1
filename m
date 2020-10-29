Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300529F6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgJ2VJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJ2VJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:09:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFCE420791;
        Thu, 29 Oct 2020 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604005767;
        bh=bNbPFZ+4DbPibhlFNfuibwuRNeDZSwZ0ygc8fqBSEso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+kQZbYrYBtdwLNzDpLO4xgvoAw33UrM4AZ9Vm3XFrSUqiLsAZz6hSVqxwuqjaGQS
         rkJOWxbt6QipcUUYHIwQz7DFD+WKQP52hhvc6QIWijpQqAGUmzSDT4VqdQ/vKuxN+V
         gkgw64VolyF/d5oAd3iurvvf3VsSAzdRSL2hAdyM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kYFAi-005YNy-Gh; Thu, 29 Oct 2020 21:09:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Gavin Shan <gshan@redhat.com>
Cc:     shan.gavin@gmail.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Failback on unsupported huge page sizes
Date:   Thu, 29 Oct 2020 21:09:15 +0000
Message-Id: <160400571841.9348.15515000266981677007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025230626.18501-1-gshan@redhat.com>
References: <20201025230626.18501-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com, shan.gavin@gmail.com, will@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 10:06:26 +1100, Gavin Shan wrote:
> The huge page could be mapped through multiple contiguous PMDs or PTEs.
> The corresponding huge page sizes aren't supported by the page table
> walker currently.
> 
> This fails the unsupported huge page sizes to the near one. Otherwise,
> the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
> fail back to PMD_SHIFT and PAGE_SHIFT separately.

Applied to next, thanks!

[1/1] KVM: arm64: Use fallback mapping sizes for contiguous huge page sizes
      commit: 2f40c46021bbb3ecd5c5f05764ecccbc276bc690

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


