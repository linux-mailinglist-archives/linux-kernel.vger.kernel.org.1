Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC072881EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgJIGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbgJIGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:03 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:04:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C6yFD157tz9sVD; Fri,  9 Oct 2020 17:03:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
Message-Id: <160222339303.867048.111533174340819831.b4-ty@ellerman.id.au>
Date:   Fri,  9 Oct 2020 17:03:59 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 15:35:38 +0000 (UTC), Christophe Leroy wrote:
> At the time being, an early hash table is set up when
> CONFIG_KASAN is selected.
> 
> There is nothing wrong with setting such an early hash table
> all the time, even if it is not used. This is a statically
> allocated 256 kB table which lies in the init data section.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Setup the early hash table at all time.
      https://git.kernel.org/powerpc/c/69a1593abdbcf03a76367320d929a8ae7a5e3d71

cheers
