Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C528CB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbgJMJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:31:48 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:57145 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391065AbgJMJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:31:47 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 91C852003C07
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 09:31:45 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="lZmItLJu"
Date:   Tue, 13 Oct 2020 09:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602581502;
        bh=Ku7D2Kl8pY22NZRg5M8iLDhANmUh1sZbYLyEYNujI+4=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=lZmItLJuSlVAQM21lsru+jrjTrdFcpt4BEA550wTd45HOEryX0Xf6kPwWsFSmJ4WF
         s2JLX4kTq89KC+90tDpMRg19ajaZ18rgEGVRcNrcFjCNQA/LME3LS5AO3qixBI0II2
         81zbGUMq3XR+o80Bwv+UPh7ehP1JIhfzk05ZwxQY=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] fault-injection: handle EI_ETYPE_TRUE
Message-ID: <6bOOjFIyEwIPNLoY3wMdLuKENpcumphiNztVz7xDofD2Pkyv61mvDghklDSA3xNNCm7pC6XvqNeTCJ7vt1MsjrJZN5i0mbPK7YkE8Jgi1uw=@protonmail.com>
In-Reply-To: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
References: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had some difficulty finding who should receive this patch, and I am not
sure I got it right. Could someone please confirm that any of you
can take this patch, or should I resend it? (In that case, to whom?)


Thank you,
Barnab=C3=A1s P=C5=91cze


> Commit af3b854492f351d1ff3b4744a83bf5ff7eed4920
> ("mm/page_alloc.c: allow error injection")
> introduced EI_ETYPE_TRUE, but did not extend
>
> -   lib/error-inject.c:error_type_string(), and
> -   kernel/fail_function.c:adjust_error_retval()
>     to accommodate for this change.
>
>     Handle EI_ETYPE_TRUE in both functions appropriately by
>
> -   returning "TRUE" in error_type_string(),
> -   adjusting the return value to true (1) in adjust_error_retval().
>
>     Furthermore, simplify the logic of handling EI_ETYPE_NULL
>     in adjust_error_retval().
>
>     Signed-off-by: Barnab=C3=A1s P=C5=91cze pobrn@protonmail.com
>
>
> kernel/fail_function.c | 6 +++---
> lib/error-inject.c | 2 ++
> 2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 63b349168da7..4fdea01c0561 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -37,9 +37,7 @@ static unsigned long adjust_error_retval(unsigned long =
addr, unsigned long retv)
> {
> switch (get_injectable_error_type(addr)) {
> case EI_ETYPE_NULL:
>
> -         if (retv !=3D 0)
>
>
> -         =09return 0;
>
>
> -         break;
>
>
>
> -         return 0;
>
>
>     case EI_ETYPE_ERRNO:
>     if (retv < (unsigned long)-MAX_ERRNO)
>     return (unsigned long)-EINVAL;
>     @@ -48,6 +46,8 @@ static unsigned long adjust_error_retval(unsigned l=
ong addr, unsigned long retv)
>     if (retv !=3D 0 && retv < (unsigned long)-MAX_ERRNO)
>     return (unsigned long)-EINVAL;
>     break;
>
> -   case EI_ETYPE_TRUE:
> -         return 1;
>
>
>     }
>
>     return retv;
>     diff --git a/lib/error-inject.c b/lib/error-inject.c
>     index aa63751c916f..c73651b15b76 100644
>     --- a/lib/error-inject.c
>     +++ b/lib/error-inject.c
>     @@ -180,6 +180,8 @@ static const char *error_type_string(int etype)
>     return "ERRNO";
>     case EI_ETYPE_ERRNO_NULL:
>     return "ERRNO_NULL";
>
> -   case EI_ETYPE_TRUE:
> -         return "TRUE";
>
>
>     default:
>     return "(unknown)";
>     }
>     --
>     2.28.0
>
