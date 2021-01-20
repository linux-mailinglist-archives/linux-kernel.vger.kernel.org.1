Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B52FD123
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhATNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbhATMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:20:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:19:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j12so2059604pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=COIdadyAc0KasazuxdtV82/SR7CU94i37uQ5r5jLtHA=;
        b=xhTgHel9PKJYcH21ircOSeC0ASkjim5drLjjjpbtlk07lnDVRQZ6nLhp4X8HxYtyFv
         TxNWZEpOLe2vQ2H18aVyRxvCksY9qspzkSxPa7SYlONw39VPbqIaR391Kcc9I4ZdGbbU
         SUwCw5wNAdHADAnhhpP0nb3QpggfmgEquHHcKKz/ysevH8ani0ojvASA6z17gQueQ+6M
         UGF8iSV5SK7x60hER6eZL5Pw5OMgj6trP0L8taKNQ/FPwYz8S/Z9WP5j/iDpJnBd7Wii
         9N7hPKgL5CI7iBcMt9lGUSOic96ZGAAQJ2ew5Xqsf6TgPposrIKCUYAZRS0fOHi49iBM
         5JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=COIdadyAc0KasazuxdtV82/SR7CU94i37uQ5r5jLtHA=;
        b=GhtU6B494PBey7Adhjz+c9UZ2LCn7r16Cin8a4tp5GABQTqWLz1AqkSmxRIjlTqQCS
         V9iCqj4op8sJ0FYwqU9+3r+DlbJ7sWsD6B4QWzrXl4c7xsNBTFn3vI+hM5jQlR7x/fTb
         Pwm8rHPtVEACvrL1qf4VTBPUFCO27kxn+X3brkGApMb/1m8Vbx2z/r9Dlegpi04o/Y8e
         UuXTIgDMjfGsfDwykP9g/k2nok41bSRpSmsgfFQqUMs6HhqS6T6FjnNjftcx2Z/6VB6f
         5xCZtzBCrwM7wjBEOfa+DvICxsVA6M9GMm5qj/3BkYhKFs5/Z1nSC1Rle8mfqVQD03Rf
         sgpA==
X-Gm-Message-State: AOAM533tRO8NZBNqcB0NrZOSM7zIANmEsC+qnJJkPai88u3Mn5+W+w+p
        i6Y7ZwoyxFoFDHAtNv3nBlTofxzcLao8eg==
X-Google-Smtp-Source: ABdhPJwCX6wli26Hr26dGn9SnSDEneX+VkZGrenF7B62bnECpehuH+Tf86YGzM4Fu+LNKHgkPG/gGg==
X-Received: by 2002:a17:90b:1489:: with SMTP id js9mr5549773pjb.13.1611145166520;
        Wed, 20 Jan 2021 04:19:26 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:69ca:537f:1d38:5dfe? ([2601:646:c200:1ef2:69ca:537f:1d38:5dfe])
        by smtp.gmail.com with ESMTPSA id e21sm2168906pgv.74.2021.01.20.04.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 04:19:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
Date:   Wed, 20 Jan 2021 04:19:24 -0800
Message-Id: <F60CEFE2-22A4-405A-9BBC-7D84AFDA07C5@amacapital.net>
References: <20210120115324.GE825@zn.tnic>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?utf-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20210120115324.GE825@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 20, 2021, at 3:53 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Tue, Jan 19, 2021 at 09:38:59AM -0800, Andy Lutomirski wrote:
>> Currently, requesting kernel FPU access doesn't distinguish which parts o=
f
>> the extended ("FPU") state are needed.  This is nice for simplicity, but
>> there are a few cases in which it's suboptimal:
>>=20
>> - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
>>   not use legacy 387 state.  These users want MXCSR initialized but don't=

>>   care about the FPU control word.  Skipping FNINIT would save time.
>>   (Empirically, FNINIT is several times slower than LDMXCSR.)
>>=20
>> - Code that wants MMX doesn't want or need MXCSR initialized.
>>   _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
>>   initializing MXCSR will fail.
>>=20
>> - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
>>   dynamic states will need special handling.
>>=20
>> This patch adds a more specific API that allows callers specify exactly
>> what they want.
>=20
> Same nitpicks:
>=20
> https://lkml.kernel.org/r/20210119110834.GH27433@zn.tnic

I would have sworn I fixed those.  Sorry!

>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
