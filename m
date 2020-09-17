Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3993E26DACC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIQLyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIQL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:44 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53817C061352
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:24 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSV2CjNz9sSn; Thu, 17 Sep 2020 21:27:21 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a1b6ef3d657c8f249193442f56868fc358ea5b6c.1597643160.git.christophe.leroy@csgroup.eu>
References: <a1b6ef3d657c8f249193442f56868fc358ea5b6c.1597643160.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Replace an #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE) by IS_ENABLED()
Message-Id: <160034201508.3339803.13871882374413441129.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:21 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:43 +0000 (UTC), Christophe Leroy wrote:
> The #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE) encloses some
> printk which can be compiled in all cases.
> 
> Replace by IS_ENABLED().

Applied to powerpc/next.

[1/1] powerpc/process: Replace an #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE) by IS_ENABLED()
      https://git.kernel.org/powerpc/c/2ec42996f5b12826466300a755413577b6913206

cheers
