Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E22C34BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbgKXXla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbgKXXla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:41:30 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B364216C4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606261289;
        bh=L0FKwiVAB8L6G9U71oCLRItFeAo0J1LkvhO7uiabZ78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H8aWtC1fsn0Tync9op8i6xyuQMNC9WiSR8rvuZKKkq2m285iMEqJDMyQguOulYI0V
         5X5ZfmQCQNan57vkgI6G+VTlhYD5chXc8eiTRVC+3qp+AuC32EkH8nXGmSlTl61u0I
         9pTiMZ4tSIJSlnEPAMyrScyZa/2wJSswPNtFMdvM=
Received: by mail-wm1-f41.google.com with SMTP id a65so542945wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:41:29 -0800 (PST)
X-Gm-Message-State: AOAM531LklWfkUS6goArqhb+soQ9JV5qyloU4orQ6a4psRP+VrgQ0oNW
        YM0oQ0xyva33C8GHQAJEEH0Be9D/7yRfIoZPQql+5A==
X-Google-Smtp-Source: ABdhPJwoyYvLlLuYAiqBaQqI87z0+ViNQ6gqP1PcrOn19Oq42jkfsYNJ8thRuv6bUpZwmanHfWfR27AQ+kjUJEXRvzU=
X-Received: by 2002:a1c:9dd7:: with SMTP id g206mr805847wme.49.1606261287952;
 Tue, 24 Nov 2020 15:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-23-chang.seok.bae@intel.com> <CALCETrXBRATBVySDM9f0H-+gD37n7=CsNLWa446eLHi1mjokGw@mail.gmail.com>
 <CAJvTdKng_WMrmO_KtkuCxvvzGZ_HLcd84u2SwJiD_UJivb4Yaw@mail.gmail.com>
In-Reply-To: <CAJvTdKng_WMrmO_KtkuCxvvzGZ_HLcd84u2SwJiD_UJivb4Yaw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Nov 2020 15:41:16 -0800
X-Gmail-Original-Message-ID: <CALCETrX_1RkatiJxScjXhA38KTHvgrDxtj_e1YUs6fLTeHZufw@mail.gmail.com>
Message-ID: <CALCETrX_1RkatiJxScjXhA38KTHvgrDxtj_e1YUs6fLTeHZufw@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 24, 2020, at 10:51 AM, Len Brown <lenb@kernel.org> wrote:
>
> =EF=BB=BFOn Fri, Nov 20, 2020 at 12:03 AM Andy Lutomirski <luto@kernel.or=
g> wrote:
>>
>>> On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com>=
 wrote:
>>> "xstate.enable=3D0x60000" will enable AMX on a system that does NOT hav=
e AMX
>>> compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new en=
ough
>>> to support this feature).
>>>
>>
>> What's the purpose of xstate.enable?  I can't really imagine it's
>> useful for AMX.  I suppose it could be useful for hypothetical
>> post-AMX features, but that sounds extremely dangerous.  Intel has
>> changed its strategy so many times on XSTATE extensibility that I find
>> it quite hard to believe that supporting unknown states is wise.
>
> Not hypothetical -- there are subsequent hardware features coming that
> will use the same
> exact XSTATE support that this series puts in place for AMX.
>
> We know that when those features ship in new hardware, there will be
> a set of customers who want to exercise those features immediately,
> but their kernel binary has not yet been re-compiled to see those
> features by-default.
>
> The purpose of "xstate.enable" is to empower those users to be able to
> explicitly enable support using their existing binary.
>
> You are right -- the feature isn't needed to enable AMX, unless somebody =
went to
> the trouble of building a kernel with the AMX source update, but chose
> to disable
> AMX-specific recognition, by-default.
>
>

We may want to taint the kernel if one of these flags is used because,
frankly, Intel=E2=80=99s track record is poor. Suppose we get a new feature
with PKRU-like semantics -- switching it blindly using
XSAVE(C,S,OPT,whatever) would simply incorrect. And XFD itself has
problems =E2=80=94 supposedly it=E2=80=99s difficult or impossible to virtu=
alize. It
wouldn=E2=80=99t utterly shock me if Intel were to drop IA32_XFD_ERR and
replace it with a new mechanism that=E2=80=99s less janky.

So this whole thing makes me quite nervous.

(I'm not a virtualization expert, but AIUI IA32_XFD_ERR has some
issues.  If it's too late to fix those issues, Intel could probably
get away with completely dropping IA32_XFD_ERR from the spec -- OSes
can handle AMX just fine without it.  Then the next XFD-able feature
could introduce a new improved way of reporting which feature
triggered #NM.)
