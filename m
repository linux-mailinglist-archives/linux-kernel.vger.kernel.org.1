Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60B2B2621
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:00:38 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:00:38 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so5102990pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmGncwYFUvMs6I+eFXEBgHlp3fnbadm1lmVPKMGl9W8=;
        b=usPrvtFP0mjVTGhG9cOFApqky0N+toPMIZu+IpepobuQ5dM96VP5NgRcWslMI8H/rn
         AkhcQMvh1SHojptjsFXvFcDZE+lxt82u10QvfX4tmuv4O7EDUwhaG1vBvNx0vX1RBw3A
         RsQzYIhquP12BJPyPyc7DVTjFSb+fByhR7UkkzD6VNN/GmJIlrc76vJrUo2v8NdN4lj3
         zQ+WicrHJc24kzxFgXp/r5uX8m9DnhSfaig8rsbRTyo0v69oHxLiOE3eF7PpzqBOo/OU
         nOqH7ZjfKZjujs6dldp7ZaQrr88SIxfn40NfXdM5trQ4OM9jeT5htISNn+KfSPyxGWAE
         kgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmGncwYFUvMs6I+eFXEBgHlp3fnbadm1lmVPKMGl9W8=;
        b=m8tm4f6Nq+8cM6GX8VXXFmbEcUKhB1gXVZSZnP5jLVR7+NKpTvEX0N7Vwc3hBdEpwL
         kb7EgW+F58DnZ92/Yo3VszIe1/VoXzFkVOS9kIxwmVmIYjNKYIc46n4RlnmKPB8z/4zX
         3m739sOXO/pT4OyqhUZDZxSO+QuU5ucHEDynBxAli7KfZLNbohr4D2Hxi97b8nJTmjs1
         VjlD0voHlMqj0OhBtm+1BRYYG46RSE8Gx4K63pRGHv/F+MUFDWFQPbB+UvrhcQA3k8Li
         egMVzxySet7z3H5ggOb0rO+cx96WvsOaRZAAOiopXo5CsFvFW376n0PoNol7M4pFmo7C
         ah/g==
X-Gm-Message-State: AOAM532zeK5tAx21uiLKFRpUNxCVrLpTcWKdjVYSxEAU6jyBRVws73RX
        vjotdt0ZkmWVTqbyiXZhPbecO2WeHvMuYbp2R5/aNQ==
X-Google-Smtp-Source: ABdhPJwCl8e37GFMxJhbQtFHBN3V/f1ns+lkfkgVBmhfxlpkW7L5oUSEgM6J7WyTuM5iIGnjdMA5NZLB4zM9wXacaow=
X-Received: by 2002:a17:902:ee85:b029:d6:c43e:2321 with SMTP id
 a5-20020a170902ee85b02900d6c43e2321mr3313392pld.29.1605301237814; Fri, 13 Nov
 2020 13:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
 <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
 <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com> <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
In-Reply-To: <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Nov 2020 13:00:26 -0800
Message-ID: <CAKwvOdn9-B=CGa5t1diymfU8Cqpa3o2zDfmmi=PYvTeAmC8Bxw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:14 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Thank you for the explicit diagnostics observed.  Something fishy is
> > going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC to
> > handle include/linux/compiler_attributes.h.
> >
> > The C preprocessor should make it such that MSVC never sees
> > `__attribute__` or `__fallthrough__`; that it does begs the question.
> > That would seem to imply that `#if __has_attribute(__fallthrough__)`
> > somehow evaluates to true on MSVC, but my godbolt link shows it does
> > not.
> >
> > Could the upstream ACPICA project be #define'ing something that could
> > be altering this? (Or not #define'ing something?)
> >
> > Worst case, we could do as Joe Perches suggested and disable
> > -Wfallthrough for drivers/acpi/acpica/.
>
> I agree, something is fishy. MSVC has several flags for conformance
> and extensions support, including two full C preprocessors in newer
> versions; which means we might be missing something, but I don't see
> how the code in compiler_attributes.h could be confusing MSVC even in
> older non-conforming versions.

unless
```
# define fallthrough                    __attribute__((__fallthrough__))
```
was copy and pasted into the code, rather than #including the whole header?

-- 
Thanks,
~Nick Desaulniers
