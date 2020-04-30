Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5757B1BEE59
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 04:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgD3Ceo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgD3Ceo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:34:44 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4AEC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:34:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49CKGQ4ZsBz9sRY;
        Thu, 30 Apr 2020 12:34:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588214078;
        bh=BCi4c4G/ZA+9mO7Of96Qiajv3+eSTHs7JkDfkYQrlss=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WBBHx9n9lJB5ghHEmLoQc/ndI+TE1BPqxe8vSOjeC45nb3lFf2k0AMXBBL6OQnEBX
         h7xYd9osHiC0kFJcAf39tG76Pf8UELx65k2BDL+Oo2Tl0y05j1fiJtgHLRVASvMG7A
         FwctvR5cuOxfITfXOsV8+w6eo558jf8H0jUk108No0lHZkAiT+Nyn/tuR7TIuKQIs3
         XY3PbTnCEyrTEQKMFfqwRSXnK/Udph2u6EzvETGGJUNnG7OVewxdpo5QlHsYFN6JXz
         gEWP6L/DmMUuOTnvr29OLGtVWh1qkjvpSif2RtQAD9Hg7M4zcC7PpMYTkXQARL+VRb
         rjJPdDYfz/bFw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Track and expose idle PURR and SPURR ticks
In-Reply-To: <20200423100213.GA23192@in.ibm.com>
References: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com> <04b5e2fa-089f-93c9-cde9-33a930455bb2@linux.ibm.com> <20200423100213.GA23192@in.ibm.com>
Date:   Thu, 30 Apr 2020 12:34:52 +1000
Message-ID: <871ro5g0qb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Mon, Apr 20, 2020 at 03:46:35PM -0700, Tyrel Datwyler wrote:
>> On 4/7/20 1:47 AM, Gautham R. Shenoy wrote:
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > 
>> > Hi,
>> > 
>> > This is the fifth version of the patches to track and expose idle PURR
>> > and SPURR ticks. These patches are required by tools such as lparstat
>> > to compute system utilization for capacity planning purposes.
...
>> > 
>> > Gautham R. Shenoy (5):
>> >   powerpc: Move idle_loop_prolog()/epilog() functions to header file
>> >   powerpc/idle: Store PURR snapshot in a per-cpu global variable
>> >   powerpc/pseries: Account for SPURR ticks on idle CPUs
>> >   powerpc/sysfs: Show idle_purr and idle_spurr for every CPU
>> >   Documentation: Document sysfs interfaces purr, spurr, idle_purr,
>> >     idle_spurr
>> > 
>> >  Documentation/ABI/testing/sysfs-devices-system-cpu | 39 +++++++++
>> >  arch/powerpc/include/asm/idle.h                    | 93 ++++++++++++++++++++++
>> >  arch/powerpc/kernel/sysfs.c                        | 82 ++++++++++++++++++-
>> >  arch/powerpc/platforms/pseries/setup.c             |  8 +-
>> >  drivers/cpuidle/cpuidle-pseries.c                  | 39 ++-------
>> >  5 files changed, 224 insertions(+), 37 deletions(-)
>> >  create mode 100644 arch/powerpc/include/asm/idle.h
>> > 
>> 
>> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>
> Thanks for reviewing the patches.
>
>> 
>> Any chance this is going to be merged in the near future? There is a patchset to
>> update lparstat in the powerpc-utils package to calculate PURR/SPURR cpu
>> utilization that I would like to merge, but have been holding off to make sure
>> we are synced with this proposed patchset.
>
> Michael, could you please consider this for 5.8 ?

Yes. Has it been tested on KVM at all?

cheers
