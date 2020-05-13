Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC641D0616
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEMEg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 00:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgEMEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 00:36:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:36:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1549931pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2A2BUe5JINIQtBy3JK/lJQriURGohduNoyDL50A04h8=;
        b=m7kYNQo4ygmDCPVbZMwAHrpO/rY4PFXXVwJ3BSZLi4ZgQAEblpbeFdtLDjGRTM3cau
         mSTuPluaRhsFW+Y3IXDs9XR5NC7wmDrD+XpeIUWf7jhGtYJmScqdAJxqUw/oQE5u3LF7
         gbsW0yr4EnnGYuNFzOxZ3vYLvqdcAScK8fh5XBlQWzd5j/RXjSrtYEDnEXCHWnEqkZY+
         0DaKEjGSxt/ECD6kzknzQXK2ol7mtNnhdjuxxW/eVUqWpAnfYmzor+SBcayNHahO+VUA
         NDeaCfYlk904RSQs8RrGaKXelg44CeDIgVDnXbYOrzHXo7FvfGKBqkpYJDpalKSoXrFl
         Uc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2A2BUe5JINIQtBy3JK/lJQriURGohduNoyDL50A04h8=;
        b=Rp/YmaTPF8YT4G+NMo1z+uWv736OnaRuuVWGThxCoLV6xJMnaN+5wAypWEWvjN0LEf
         +w+eXeEaQCvzua5pQjk5aeaJttF6UauM9Zy8mZw+69HY4jHR0O2lk6ciwQBJ4anvP3j2
         EsUL4N+kVxjv/F0sN1FKNpWyL7KO2Sl/dTkQRiNJGOctVBuR0Cyryr9+iuNW/FGv5s7C
         PnVDP924i5MbdWDCGI5xX6gM5jin2NmmTfCNJJZ1/3nwymG5Ps9Gjwts/ymDLTSImUR3
         ERXp3KGJMjxN8jub3X7pKLVHypN2LBhErDx2nIbTDHsFkonSCrrfterKqOJ2JjysHP5B
         qgMA==
X-Gm-Message-State: AGi0PubpCIKInMQ+4UdP0XjXKG1IYOhtvffmArPtKgGGm2ZxgnWaDvDr
        eadI+fghYPLOJtruj7q7Jgw=
X-Google-Smtp-Source: APiQypIbw+/ucdBGA3C+rdA25/MRn1nA+fnLyG5Xw7JW2bfFKGtGaprjgC/tJhlJ5zv4XPUo1h1jHw==
X-Received: by 2002:a63:da10:: with SMTP id c16mr22829320pgh.208.1589344587146;
        Tue, 12 May 2020 21:36:27 -0700 (PDT)
Received: from localhost (61-68-214-199.tpgi.com.au. [61.68.214.199])
        by smtp.gmail.com with ESMTPSA id x185sm13349333pfx.155.2020.05.12.21.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 21:36:26 -0700 (PDT)
Date:   Wed, 13 May 2020 14:36:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/crash: Use NMI context for printk when
 starting to crash
To:     Alexios Zavras <alexios.zavras@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200512214533.93878-1-leobras.c@gmail.com>
In-Reply-To: <20200512214533.93878-1-leobras.c@gmail.com>
MIME-Version: 1.0
Message-Id: <1589344247.2akwhmzwhg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Leonardo Bras's message of May 13, 2020 7:45 am:
> Currently, if printk lock (logbuf_lock) is held by other thread during
> crash, there is a chance of deadlocking the crash on next printk, and
> blocking a possibly desired kdump.
>=20
> At the start of default_machine_crash_shutdown, make printk enter
> NMI context, as it will use per-cpu buffers to store the message,
> and avoid locking logbuf_lock.

printk_nmi_enter is used in one other place outside nmi_enter.

Is there a different/better way to handle this? What do other=20
architectures do?

Other subsystems get put into an nmi-mode when we call nmi_enter
(lockdep, ftrace, rcu etc). It seems like those would be useful for=20
similar reasons, so at least explaining why that is not used in a=20
comment would be good.

Aside from that, I welcome any effort to make our crashes more reliable
so thanks for working on this stuff.

Thanks,
Nick

>=20
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
>=20
> ---
> Changes since v1:
> - Added in-code comment explaining the need of context change
> - Function moved to the start of default_machine_crash_shutdown,
>   to avoid locking any printk on crashing routine.
> - Title was 'Use NMI context for printk after crashing other CPUs'
>=20
> ---
>  arch/powerpc/kexec/crash.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index d488311efab1..c9a889880214 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -311,6 +311,9 @@ void default_machine_crash_shutdown(struct pt_regs *r=
egs)
>  	unsigned int i;
>  	int (*old_handler)(struct pt_regs *regs);
> =20
> +	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
> +	printk_nmi_enter();
> +
>  	/*
>  	 * This function is only called after the system
>  	 * has panicked or is otherwise in a critical state.
> --=20
> 2.25.4
>=20
>=20
