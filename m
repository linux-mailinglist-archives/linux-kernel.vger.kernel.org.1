Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C012D5952
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgLJLfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:35:40 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbgLJLab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXW44Hqz9sWr; Thu, 10 Dec 2020 22:29:47 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <d01d7613664fafa43de1f1ae89924075bc24241c.1602489931.git.christophe.leroy@csgroup.eu>
References: <d01d7613664fafa43de1f1ae89924075bc24241c.1602489931.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: MMU_FTR_NEED_DTLB_SW_LRU is only possible with CONFIG_PPC_83xx
Message-Id: <160756607062.1313423.10978525634640096668.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:47 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:05:49 +0000 (UTC), Christophe Leroy wrote:
> Only mpc83xx will set MMU_FTR_NEED_DTLB_SW_LRU and its
> definition is enclosed in #ifdef CONFIG_PPC_83xx.
> 
> Make MMU_FTR_NEED_DTLB_SW_LRU possible only when
> CONFIG_PPC_83xx is set.

Applied to powerpc/next.

[1/1] powerpc/mm: MMU_FTR_NEED_DTLB_SW_LRU is only possible with CONFIG_PPC_83xx
      https://git.kernel.org/powerpc/c/b68e3a3dff97bdc1cba79dc5f80cede8a2419cac

cheers
