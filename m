Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E49268293
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgINCXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgINCXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:23:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57600C061787
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 19:23:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so11274446pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=S0bpuER8lp5sCLLApRh4TVdUkMZpH/s2SiKWUHdd/Wk=;
        b=LRzvtOfwJ7mfIhgSbAsvzmuhWDE8s77+SaIA0kP0jk8Gnpo3YDH/L4C0TXTxgvw4r+
         dY/cr/G+b8g0plhTdbrvKRH7VTYJt7ihYowjwdm7nT6Tqlzi65h0Oua7J7+rhwdn3LSD
         6IK3SYBnhGoU+0TW8AkndZLAkgIlgMpCmIQ6PchAWQWEv1hHb5MnWS1/hF8r0L7WWlte
         OtNw8rlDhA86kAcfLZ9iGmcZrbVs0JglpASNtrpZpwzB8odjb7d9Mc4ptPtcweP4cPop
         KXTR53OEfsdbiZ8BWxdwYhwNk0WPl9ULx0+gsu6DjyQLXkYUvbeDvjnmYnHvZ5KkXo7R
         02uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=S0bpuER8lp5sCLLApRh4TVdUkMZpH/s2SiKWUHdd/Wk=;
        b=CtjcCgvFyVSW1dtDKilfCK/sLu1k8GQcbJQkeKBMyH3DJ4n9KES5hZBwVQGzZ8eD5j
         WdkaLfA/jZygvdwNldQVWPDdK9PvqwQcUFEykwXweuQkZmmgAZ5B9mR4Jf6uxjy3Ddqx
         9OS09yq902YRYoW0yYx2mXjSPzoW5UZF2je6Ieqxbm/YD27LmJXFrh4myMdoLzct6EOV
         PdtYIbGhFjtop+bgL1ssspst+KFJ3HEUuBrxPfymuzsdU/gm2sE4vhten8to6POEOd/6
         XPq3xjr+2Nc4dtJ6lrlUcD/sOv0B9DcXm8JiOQQs6GPe+E0/krvVjR0gXqTNmKg5Zh4p
         V8pg==
X-Gm-Message-State: AOAM533jTlTq7L5thC959alwUKwRuudHImc5XVrolLeS6tU1pr4S3Upo
        ZFI+nkWktmSIC4EXjFb/Ni056GqMY5Q=
X-Google-Smtp-Source: ABdhPJzM7aIfTnbjIRE8UmEylrMp0SwQ8IXrxRm//8Gh+7Y6sS/1zl/nUnchfjLUAnSctnC/0GY+mQ==
X-Received: by 2002:a17:902:b7c7:b029:d1:cc21:9c38 with SMTP id v7-20020a170902b7c7b02900d1cc219c38mr1129143plz.21.1600050187733;
        Sun, 13 Sep 2020 19:23:07 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id h14sm8854048pfe.67.2020.09.13.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 19:23:06 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:23:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 4/5] powerpc/fault: Avoid heavy
 search_exception_tables() verification
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
        <b07bac7a882c69deb9e6c8f234a68b3022f29072.1596734105.git.christophe.leroy@csgroup.eu>
        <871rjb5vv4.fsf@linux.ibm.com>
        <1ded5e11-a9e0-a98f-295c-c623e0a5ed36@csgroup.eu>
In-Reply-To: <1ded5e11-a9e0-a98f-295c-c623e0a5ed36@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1600048261.m5q9cmngxb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of September 9, 2020 4:20 pm:
>=20
>=20
> Le 09/09/2020 =C3=A0 08:04, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>=20
>>> search_exception_tables() is an heavy operation, we have to avoid it.
>>> When KUAP is selected, we'll know the fault has been blocked by KUAP.
>>> Otherwise, it behaves just as if the address was already in the TLBs
>>> and no fault was generated.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/mm/fault.c | 20 +++++---------------
>>>   1 file changed, 5 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>>> index 525e0c2b5406..edde169ba3a6 100644
>>> --- a/arch/powerpc/mm/fault.c
>>> +++ b/arch/powerpc/mm/fault.c
>>> @@ -214,24 +214,14 @@ static bool bad_kernel_fault(struct pt_regs *regs=
, unsigned long error_code,
>>>   	if (address >=3D TASK_SIZE)
>>>   		return true;
>>>  =20
>>> -	if (!is_exec && (error_code & DSISR_PROTFAULT) &&
>>> -	    !search_exception_tables(regs->nip)) {
>>> +	// Read/write fault blocked by KUAP is bad, it can never succeed.
>>> +	if (bad_kuap_fault(regs, address, is_write)) {
>>>   		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - e=
xploit attempt? (uid: %d)\n",
>>> -				    address,
>>> -				    from_kuid(&init_user_ns, current_uid()));
>>> -	}
>>> -
>>> -	// Fault on user outside of certain regions (eg. copy_tofrom_user()) =
is bad
>>> -	if (!search_exception_tables(regs->nip))
>>> -		return true;
>>=20
>> We still need to keep this ? Without that we detect the lack of
>> exception tables pretty late.
>=20
> Is that a problem at all to detect the lack of exception tables late ?
> That case is very unlikely and will lead to failure anyway. So, is it=20
> worth impacting performance of the likely case which will always have an=20
> exception table and where we expect the exception to run as fast as=20
> possible ?
>=20
> The other architectures I have looked at (arm64 and x86) only have the=20
> exception table search together with the down_read_trylock(&mm->mmap_sem)=
.

Yeah I don't see how it'd be a problem. User could arrange for page=20
table to already be at this address and avoid the fault so it's not the=20
right way to stop an attacker, KUAP is.

Thanks,
Nick
