Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60D32B7412
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKRCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:00:28 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgKRCA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:00:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CbQxj3Rtgz9sRR;
        Wed, 18 Nov 2020 13:00:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605664826;
        bh=nr5e0b6T3DWeie6oub3dZMpbfzhN8bOBT6lbYrV32f0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jGoJJV/S5AG9ERDPEYUS4pO19ELzVyTInXfjxdPh1RaUeCWhDPzXo5M8Ep5jRxkl8
         9v/olVjtGG9Qy6KFDyQ9YEytgiLHcn9UvH/UXnJ4/UL0xevZfJbkvrDsF3wJF6ngyI
         ZMud+51LoySuJRcuOCMEiqd02lx7xBEcMo7yckiZN4rv9QFThAXHV3uFhVNH5dU1yP
         SjOYpPsY7G/iSb1fQs+vK6oNtsNXwsLffJodCszooAnhWihpRwFickdiBiPXXyWrkR
         kLC32PvO+1/9EJDOP3B3dzc8fPaLFgowBWv2BUBC1nWsrhujshRF41ceFUQIBETV08
         HPRvD8HacEdTg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2 7/8] powerpc/mm: remove linear mapping if __add_pages() fails in arch_add_memory()
In-Reply-To: <dac16bcc-8e37-8cb2-ac61-912a17ab5985@redhat.com>
References: <20201111145322.15793-1-david@redhat.com> <20201111145322.15793-8-david@redhat.com> <20201117155125.GF15987@linux> <dac16bcc-8e37-8cb2-ac61-912a17ab5985@redhat.com>
Date:   Wed, 18 Nov 2020 13:00:22 +1100
Message-ID: <87ft572zm1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> On 17.11.20 16:51, Oscar Salvador wrote:
>> On Wed, Nov 11, 2020 at 03:53:21PM +0100, David Hildenbrand wrote:
>>> Let's revert what we did in case seomthing goes wrong and we return an
>> "something" :-)
>
> Thanks! :)
>
> @Michael, I assume if I don't have to resend, this can be fixed up?

Yep, I fixed it up.

cheers
