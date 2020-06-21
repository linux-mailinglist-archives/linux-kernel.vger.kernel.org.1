Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24592202A06
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgFUKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 06:12:50 -0400
Received: from ozlabs.org ([203.11.71.1]:48309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 06:12:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49qSz26L3Vz9sSf;
        Sun, 21 Jun 2020 20:12:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592734367;
        bh=73EbSfvdEUAjZq8zN7sj/qvkEAt7r5fJFhwHZNeTzu0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WhFX2fQgf6uDTODIOOxw/m/EruopCUcZCSs/OEXJ0WOd0qMcPw6MiLC7IpFFjXlAc
         8A2ldVoheZHjDS97QRZaJ4ww7+ZLkwQIBzpj5/JKyDp+khBOoh1illuoGXyLazZhYZ
         0+rWo8qRleqFLcNsCgLK+glSwrwtCsGj06469NEkONPvfKuALmKUeqQ0gKPGZbBAPc
         B1y3xPef5+MWWbkDRx4RkljHxsZdEquDiS+K2X+QWZFEpEhlZyDyMueAGNCPVnaE+1
         BYLXJSeZ08/wzor7UBVa746JWY3FieFXDuHagS02YEdPkF0RxLhzlImphatw2h95sr
         MPBHNE2kSr2PA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        linuxppc-dev@ozlabs.org
Cc:     linux-arch@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 1/2] powerpc/syscalls: Use the number when building SPU syscall table
In-Reply-To: <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
References: <20200616135617.2937252-1-mpe@ellerman.id.au> <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
Date:   Sun, 21 Jun 2020 20:13:17 +1000
Message-ID: <875zbkd8w2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 16 Jun 2020 23:56:16 +1000, Michael Ellerman wrote:
>> Currently the macro that inserts entries into the SPU syscall table
>> doesn't actually use the "nr" (syscall number) parameter.
>> 
>> This does work, but it relies on the exact right number of syscall
>> entries being emitted in order for the syscal numbers to line up with
>> the array entries. If for example we had two entries with the same
>> syscall number we wouldn't get an error, it would just cause all
>> subsequent syscalls to be off by one in the spu_syscall_table.
>> 
>> [...]
>
> Applied to powerpc/fixes.
>
> [1/2] powerpc/syscalls: Use the number when building SPU syscall table
>       https://git.kernel.org/powerpc/c/1497eea68624f6076bf3eaf66baec3771ea04045
> [2/2] powerpc/syscalls: Split SPU-ness out of ABI
>       https://git.kernel.org/powerpc/c/35e32a6cb5f694fda54a5f391917e4ceefa0fece

Patch 2 dropped.

cheers
