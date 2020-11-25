Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5896A2C3F70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgKYL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:58:12 -0500
Received: from ozlabs.org ([203.11.71.1]:49073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgKYL6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:58:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzt11Fb0z9sWH; Wed, 25 Nov 2020 22:58:00 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     ajd@linux.ibm.com, paulus@samba.org, fbarrat@linux.ibm.com,
        mpe@ellerman.id.au,
        "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>,
        benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
References: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
Subject: Re: [PATCH] powerpc/powernv/sriov: fix unsigned int win compared to less than zero
Message-Id: <160630540323.2174375.1396661836713301035.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:58:00 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 19:19:30 +0800, xiakaixu1987@gmail.com wrote:
> Fix coccicheck warning:
> 
> ./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
> ./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0

Applied to powerpc/next.

[1/1] powerpc/powernv/sriov: fix unsigned int win compared to less than zero
      https://git.kernel.org/powerpc/c/027717a45ca251a7ba67a63db359994836962cd2

cheers
