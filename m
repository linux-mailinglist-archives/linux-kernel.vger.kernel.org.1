Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7B26DA31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIQLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgIQL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:44 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DCC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:26 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSX4Wz4z9sVK; Thu, 17 Sep 2020 21:27:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <2d89732a9062b2cf2651728804e4b8f6c9b9358e.1597643164.git.christophe.leroy@csgroup.eu>
References: <2d89732a9062b2cf2651728804e4b8f6c9b9358e.1597643164.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Replace #ifdef CONFIG_KALLSYMS by IS_ENABLED()
Message-Id: <160034201527.3339803.14616472266009491663.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:24 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:44 +0000 (UTC), Christophe Leroy wrote:
> The #ifdef CONFIG_KALLSYMS encloses some printk which can
> compile in all cases.
> 
> Replace by IS_ENABLED().

Applied to powerpc/next.

[1/1] powerpc/process: Replace #ifdef CONFIG_KALLSYMS by IS_ENABLED()
      https://git.kernel.org/powerpc/c/8f020c7ca300fd60374f0347814c92ea513c24da

cheers
