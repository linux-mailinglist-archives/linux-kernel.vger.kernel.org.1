Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7526DA33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIQLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIQL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:44 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC4C061354
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:27 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSY1vLWz9sVV; Thu, 17 Sep 2020 21:27:25 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3612a8f8aaca16de3fc414a7e66293319d6e213c.1597643147.git.christophe.leroy@csgroup.eu>
References: <3612a8f8aaca16de3fc414a7e66293319d6e213c.1597643147.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Tag an #endif to help locate the matching #ifdef.
Message-Id: <160034201546.3339803.1252084823343319379.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:25 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:45 +0000 (UTC), Christophe Leroy wrote:
> That #endif is more than 100 lines after the matching #ifdef,
> and there are several #ifdef/#else/#endif inbetween.
> 
> Tag it as /* CONFIG_PPC_BOOK3S_64 */ to help locate the
> matching #ifdef.

Applied to powerpc/next.

[1/1] powerpc/process: Tag an #endif to help locate the matching #ifdef.
      https://git.kernel.org/powerpc/c/60d62bfd24efce1a595d259100b8a4e7a489e834

cheers
