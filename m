Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DCE233266
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgG3MuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:50:22 -0400
Received: from ozlabs.org ([203.11.71.1]:39773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3MuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:50:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BHVcs2W6Vz9sSd; Thu, 30 Jul 2020 22:50:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200727224201.GA10133@embeddedor>
References: <20200727224201.GA10133@embeddedor>
Subject: Re: [PATCH][next] powerpc: Use fallthrough pseudo-keyword
Message-Id: <159611327982.1601380.9594499163506768565.b4-ty@ellerman.id.au>
Date:   Thu, 30 Jul 2020 22:50:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 17:42:01 -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Applied to powerpc/next.

[1/1] powerpc: Use fallthrough pseudo-keyword
      https://git.kernel.org/powerpc/c/5e66a0cb5fbdc76f9ad86a1e8f43256dbad29ef7

cheers
