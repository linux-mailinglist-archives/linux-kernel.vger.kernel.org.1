Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4D2CAFE1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLAWWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:22:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:34510 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLAWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:22:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA8BB750;
        Tue,  1 Dec 2020 22:21:20 +0000 (UTC)
Date:   Tue, 1 Dec 2020 15:21:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 7/7] docs: Document Syscall User Dispatch
Message-ID: <20201201152119.3654ba61@lwn.net>
In-Reply-To: <20201127193238.821364-8-krisman@collabora.com>
References: <20201127193238.821364-1-krisman@collabora.com>
        <20201127193238.821364-8-krisman@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 14:32:38 -0500
Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> Explain the interface, provide some background and security notes.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Nice to see documentation included...:)  One nit:
> ---
> Changes since v7:
>   - Change process -> thread (Florian Weimer)
>   - Drop bogus reference to CONFIG_SYSCALL_USER_DISPATCH (me)
>   - Document the interval as a half-open interval (me)
> ---
>  .../admin-guide/syscall-user-dispatch.rst     | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst

You need to add this file to index.rst in that directory as well so it
gets included in the docs build.

Thanks,

jon
