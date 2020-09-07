Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F71260640
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgIGV0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 17:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgIGV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:26:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A192145D;
        Mon,  7 Sep 2020 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599513992;
        bh=KiptKZYdVLVO19im8+lCMKIpUT5APbo1h5x6MhPE00M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0uKcJcxL7cyGodFpBaM+kyi+IYlvQGiLvsS6rF7vje4tbIT7xHaSNuTP1T/0H9rR
         EMoYz+lW6B6RTlqlDNul7ATXXhVi/e5Hg/qejcWjsV+fbeNoIobWkaeH0wFDTpBYtb
         D26HvYc+UTNIxufs9xDqt9f/Wb4CL//S3mIKAXJA=
Date:   Mon, 7 Sep 2020 22:26:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
Message-ID: <20200907212626.GC13815@willie-the-truck>
References: <20200902225911.209899-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:59:04PM -0700, Nick Desaulniers wrote:
> Adds a compile time #error to compiler-clang.h setting the effective
> minimum supported version to clang 10.0.1. A separate patch has already
> been picked up into the Documentation/ tree also confirming the version.

Modulo my horrible grammar nit on the last patch:

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will
