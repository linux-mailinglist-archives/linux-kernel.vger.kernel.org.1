Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AF2A71DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgKDXgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgKDXgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:36:25 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0192FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:36:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CRNMT3KkJz9sPB;
        Thu,  5 Nov 2020 10:36:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604532981;
        bh=tvf1yvsQMnkIfDvVfNZUhP9qZGxh2S8Or2/lDBF1aOI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XdXW2pCMgVmKFvXcjiUbZo2ARcycAwcoCf4vOBZDhVoZ84vVSBrmHJYwYhMqGatny
         oQvrtmfOvkkCxdZJBFj7d9NG1fVfYLj69/zRctymbln+Yr76SUvwPVmKnRk9oi5LsX
         bImBBk8dlc8WtzAjBBPX8cm82M91Txb6600UEzGdplO43LLcpWWmdtTi/0EBa6hvGU
         nH7XcL94NmPayMLRJlqI8nJC5iciUIM1npRz1N7y+ldbAkiZzW4EPx2Oxc2t2Rfze6
         rXLrJ7/LSzTyQ7gQ5MQ/a+rU6yxTzzUXFWTJ9AalLFRik5kQWxR73Dbp+QFfH+hp16
         7dwR1o9Q02J7g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lee Jones <lee.jones@linaro.org>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 31/36] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
In-Reply-To: <20201104193549.4026187-32-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org> <20201104193549.4026187-32-lee.jones@linaro.org>
Date:   Thu, 05 Nov 2020 10:36:19 +1100
Message-ID: <87r1p8u230.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for =E2=
=80=98hvc_vio_init_early=E2=80=99 [-Wmissing-prototypes]
>  385 | void __init hvc_vio_init_early(void)
>  | ^~~~~~~~~~~~~~~~~~
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/powerpc/include/asm/hvconsole.h     | 3 +++
>  arch/powerpc/platforms/pseries/pseries.h | 3 ---
>  arch/powerpc/platforms/pseries/setup.c   | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

> diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/=
asm/hvconsole.h
> index 999ed5ac90531..936a1ee1ac786 100644
> --- a/arch/powerpc/include/asm/hvconsole.h
> +++ b/arch/powerpc/include/asm/hvconsole.h
> @@ -24,5 +24,8 @@
>  extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
>  extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
>=20=20
> +/* Provided by HVC VIO */
> +extern void hvc_vio_init_early(void);

extern isn't needed, but don't feel you need to respin just to drop it.

cheers
