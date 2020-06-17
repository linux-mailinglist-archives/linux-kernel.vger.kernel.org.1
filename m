Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5041FCF34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFQON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFQON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:13:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:13:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49n6VR1MmCz9sRf;
        Thu, 18 Jun 2020 00:13:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592403200;
        bh=iKIq8vuYeYX0Liw4N1hUdZiiIKKAWR4aRgSKwYCo4VU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SxAHuubOLTxXEBrKZxUGgkOv8/nYpMumvh7ICW2/2wVzLDnDbDd6MLaJ8ygYP5CBc
         3RzbyVwNnFrQhvPChoX94B0TVOMOjbHKC3OPSSoZscEyAmtIbsfIfen2waMuGmx01A
         mUt6pGk7kzqo+FzmX89QPR97jG6AnB/MNDDeNCjg0Fvl3fOelQk8w8pI1WJWJvQYNm
         06ipbGO6rHZs/5xywfkrK3cFItbvH9K9MsnPtQipCZa64HA/H5//iunD4Xw0Hyx1sJ
         Fv0imAEyiD/9VTj4mmRZMfJIMglU0jbeXswqj1HjOzwOIorDnwsH49nAH+jK0WNuSX
         RSuTm1LS9eJTA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Fix build failure with v5.8-rc1
In-Reply-To: <cover.1592225557.git.christophe.leroy@csgroup.eu>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
Date:   Thu, 18 Jun 2020 00:13:45 +1000
Message-ID: <871rmdeq5i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
> {READ,WRITE}_ONCE() memory accesses") leads to following build
> failure on powerpc 8xx.

I've put this in my fixes branch.

cheers
