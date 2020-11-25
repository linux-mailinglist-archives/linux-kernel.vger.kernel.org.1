Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB83D2C3F73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKYL6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgKYL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:58:20 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:58:19 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsy71f5z9sW0; Wed, 25 Nov 2020 22:57:58 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org,
        "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>,
        mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
References: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
Subject: Re: [PATCH] powerpc/mm: Fix comparing pointer to 0 warning
Message-Id: <160630540419.2174375.11309649223886745354.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:58 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 10:56:01 +0800, xiakaixu1987@gmail.com wrote:
> Fixes coccicheck warning:
> 
> ./arch/powerpc/mm/pgtable_32.c:87:11-12: WARNING comparing pointer to 0
> 
> Avoid pointer type value compared to 0.

Applied to powerpc/next.

[1/1] powerpc/mm: Fix comparing pointer to 0 warning
      https://git.kernel.org/powerpc/c/b84bf098fcc49ed6bf4b0a8bed52e9df0e8f1de7

cheers
