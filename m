Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1127DC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgI2XIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:08:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:60712 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI2XIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:08:22 -0400
X-Greylist: delayed 3645 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 19:08:20 EDT
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08TM1uZE008150;
        Tue, 29 Sep 2020 17:02:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 08TM1tBn008147;
        Tue, 29 Sep 2020 17:01:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 29 Sep 2020 17:01:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] powerpc: Remove PowerPC 601
Message-ID: <20200929220155.GV28786@gate.crashing.org>
References: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu> <00a6948d659e017f8ca63437d1384222c3aede57.1601359702.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a6948d659e017f8ca63437d1384222c3aede57.1601359702.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 06:09:21AM +0000, Christophe Leroy wrote:
> Powerpc 601 is 25 years old.

So is 603, but that one is still used!  :-)

> It is not selected by any defconfig.
> 
> It requires a lot of special handling as it deviates from the
> standard 6xx.
> 
> Retire it.

That is fine with me of course.  If I get a vote at all for this!

Thanks,


Segher
