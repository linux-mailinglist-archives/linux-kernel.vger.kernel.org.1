Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0357626DA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIQLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgIQL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:47 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2FC061355
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:28 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSQ31nsz9sTv; Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <f0cb2a5477cd87d1eaadb128042e20aeb2bc2859.1598860677.git.christophe.leroy@csgroup.eu>
References: <f0cb2a5477cd87d1eaadb128042e20aeb2bc2859.1598860677.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Fix random segfault when freeing hugetlb range
Message-Id: <160034201310.3339803.17054626930223445609.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 07:58:19 +0000 (UTC), Christophe Leroy wrote:
> The following random segfault is observed from time to time with
> map_hugetlb selftest:
> 
> root@localhost:~# ./map_hugetlb 1 19
> 524288 kB hugepages
> Mapping 1 Mbytes
> Segmentation fault
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Fix random segfault when freeing hugetlb range
      https://git.kernel.org/powerpc/c/542db12a9c42d1ce70c45091765e02f74c129f43

cheers
