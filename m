Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE62D5954
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgLJLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:35:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389449AbgLJLab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXY6fygz9sXD; Thu, 10 Dec 2020 22:29:49 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a0fc81cd85121407726bcf480fc9a0d8e7617fce.1601549933.git.christophe.leroy@csgroup.eu>
References: <a0fc81cd85121407726bcf480fc9a0d8e7617fce.1601549933.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Remove ifdef in get_vtb()
Message-Id: <160756606995.1313423.6862355589157408479.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:49 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 10:59:20 +0000 (UTC), Christophe Leroy wrote:
> SPRN_VTB and CPU_FTR_ARCH_207S are always defined,
> no need of an ifdef.

Applied to powerpc/next.

[1/1] powerpc/time: Remove ifdef in get_vtb()
      https://git.kernel.org/powerpc/c/c3cb5dbd85dbd9ae51fadf867782dc34806f04d8

cheers
