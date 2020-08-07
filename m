Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABABE23E60C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 04:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHGCsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 22:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGCsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:48:06 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70EAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 19:48:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BN8tB6BBWz9sSG;
        Fri,  7 Aug 2020 12:48:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596768484;
        bh=QRFFwrvNL4FQDFGUBy0JNMwo3nFLA/HqutlnKQMVW/o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dhSh9I1ri2FonyuPHS/F8UsbU8YslpXWUgV+59aSU8izqPVZFcVvvnqQn2xdP2TOY
         /RNDUiRCh7JFN5Ycv2Vx9h9uIEFeiNelm5CPpExh8U3MorVo6DwOAHE5df+cpiAa0M
         D6QK6DJxooFTd+QQiyNGHp35grROU/viuDczCAGWbt4VaLN50ua6psx3Fb835VATuX
         jRnDln6aEFGMumoNnnPqIOjZI8HnuVBT0Hnp+ia1iWj8j5jXQvTnecpxJmQAmbMmJ8
         UAoVjxITQZEF6QXJvoXvado7Os8gzW5Lfk0cnHoOubk/C835T30YoX5ikWeBGiMYNF
         LjFr4F0o7llPQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/signal: Move and simplify get_clean_sp()
In-Reply-To: <20200806092547.GA2544@infradead.org>
References: <04169f40c09682ce5747518268ca84285bc17fbc.1596703345.git.christophe.leroy@csgroup.eu> <20200806092547.GA2544@infradead.org>
Date:   Fri, 07 Aug 2020 12:48:01 +1000
Message-ID: <87k0ybxjby.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> On Thu, Aug 06, 2020 at 08:50:20AM +0000, Christophe Leroy wrote:
>> get_clean_sp() is only used in kernel/signal.c . Move it there.
>> 
>> And GCC is smart enough to reduce the function when on PPC32, no
>> need of a special PPC32 simple version.
>
> What about just open coding it in the only caller, which would seem even
> cleaner?

+1

cheers
