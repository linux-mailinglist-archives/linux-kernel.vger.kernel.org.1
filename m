Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34BE1E12AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgEYQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:30:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:60786 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgEYQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:30:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF4A04A2;
        Mon, 25 May 2020 16:30:05 +0000 (UTC)
Date:   Mon, 25 May 2020 10:30:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: sysctl/kernel: document ngroups_max
Message-ID: <20200525103004.71372d36@lwn.net>
In-Reply-To: <20200518145836.15816-1-steve@sk2.org>
References: <20200518145836.15816-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 16:58:36 +0200
Stephen Kitt <steve@sk2.org> wrote:

> This is a read-only export of NGROUPS_MAX.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> Changes since v1:
>   - drop changes to kernel/sysctl.c
> 
>  Documentation/admin-guide/sysctl/kernel.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 0d427fd10941..5f12ee07665c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -459,6 +459,15 @@ Notes:
>       successful IPC object allocation. If an IPC object allocation syscall
>       fails, it is undefined if the value remains unmodified or is reset to -1.
>  
> +
> +ngroups_max
> +===========
> +
> +Maximum number of supplementary groups, _i.e._ the maximum size which
> +``setgroups`` will accept. Exports ``NGROUPS_MAX`` from the kernel.

Applied, thanks.

jon
