Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9491CFB13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgELQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgELQlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:41:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358EC206CC;
        Tue, 12 May 2020 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301677;
        bh=/h+BjbrzgGeDhsiGKpUvA6FFy3TUGTG2vxMTGOywkYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWpg8cTNOfcXaIyWaGjOdHQOrDnXxKemlvvmykHNcWBtPTrK15+e9dMQb6++lsaiX
         olVbMKrDMtvhpFoHIv1AAlYmUUL863WvfqBrVRn/p+O3bMa54RVc9jkyC/IeZE+rMA
         elCsQ/0ZOWyM98rphseCmdjeCFRESgd83CnCD7qI=
Date:   Tue, 12 May 2020 19:41:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kasan: add missing functions declarations to kasan.h
Message-ID: <20200512164113.GM4814@unreal>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <45b445a76a79208918f0cc44bfabebaea909b54d.1589297433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b445a76a79208918f0cc44bfabebaea909b54d.1589297433.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:33:21PM +0200, Andrey Konovalov wrote:
> KASAN is currently missing declarations for __asan_report* and
> __hwasan* functions. This can lead to compiler warnings.
>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/kasan.h | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>

Thanks,
Tested-by: Leon Romanovsky <leon@kernel.org>
