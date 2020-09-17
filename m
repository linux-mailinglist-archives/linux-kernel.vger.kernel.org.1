Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E126DACF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIQLyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgIQL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:44 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6BC061353
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSW22w3z9sVN; Thu, 17 Sep 2020 21:27:23 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ac8da0e3baa91dda805e1e492fd65aecd90c1fb5.1597643156.git.christophe.leroy@csgroup.eu>
References: <ac8da0e3baa91dda805e1e492fd65aecd90c1fb5.1597643156.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Replace an #ifdef CONFIG_PPC_47x by IS_ENABLED()
Message-Id: <160034201470.3339803.3613969304863849846.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:23 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:41 +0000 (UTC), Christophe Leroy wrote:
> isync() is always defined, no need for an #ifdef.
> 
> Replace it by IS_ENABLED(CONFIG_PPC_47x).

Applied to powerpc/next.

[1/1] powerpc/process: Replace an #ifdef CONFIG_PPC_47x by IS_ENABLED()
      https://git.kernel.org/powerpc/c/04d476bfbb06426fef2985c8e53578bb04596a6f

cheers
