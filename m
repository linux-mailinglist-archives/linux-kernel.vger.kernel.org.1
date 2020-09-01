Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D382588E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIAHTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:19:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:19:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79176AD29;
        Tue,  1 Sep 2020 07:19:11 +0000 (UTC)
Date:   Tue, 1 Sep 2020 09:19:08 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] Fixup for "powerpc/vdso: Provide
 __kernel_clock_gettime64() on vdso32"
Message-ID: <20200901071908.GF29521@kitsune.suse.cz>
References: <7b3e35bdf93b93f3f1f0dcb4e1f373ce3b8a0035.1598938114.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b3e35bdf93b93f3f1f0dcb4e1f373ce3b8a0035.1598938114.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can you add Fixes: ?

Thanks

Michal

On Tue, Sep 01, 2020 at 05:28:57AM +0000, Christophe Leroy wrote:
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/vdso/gettimeofday.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
> index 59a609a48b63..8da84722729b 100644
> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -186,6 +186,8 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
>  #else
>  int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
>  			     const struct vdso_data *vd);
> +int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
> +			       const struct vdso_data *vd);
>  int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
>  			    const struct vdso_data *vd);
>  #endif
> -- 
> 2.25.0
> 
