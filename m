Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198082CA812
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392157AbgLAQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392148AbgLAQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:20:12 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:19:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r20so1515245pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=RQ6eP3x8Uql6SRukMHpaq5iPlo49Hd61yi+R2fWW3RY=;
        b=U6lsyaByXZzf1zyz35LEgwPLFUGh/BibapC2vLzymKB8UB2iqC8wm/57yrzhFkGp8m
         FOMmfX+AZjr4b4ilHoCQdE7NxQLunEfC8+wKjcQeGWh0SSxOKnY+iLRkdR+w1FiEfRXw
         PK3IUk6Fb3BlVLb1AeFwn9mg1gjTC02FHhmntNXXjZuy5yObRMBg1pDllKx3QE9LZLK5
         z18h4cEaDICpl2FgsPHTCc1NxKJGWNcKuev8awRXKOEbVMATagsxdQg/LeQ4RnWkruoO
         Z9pdG4qObH81odhABf3M03879GLCjhqXhnZ2+wI8B1ohhXv96HP30f129yHn7dZwnBa0
         /GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=RQ6eP3x8Uql6SRukMHpaq5iPlo49Hd61yi+R2fWW3RY=;
        b=St8es70bLDyRL4ikfEoCLe8pFh2+UT3cSygvI9AtA8QaMjBXTSJVgBt+Vck8zdHqK2
         fXNu5wq89ZdvLPfnsa30RRpZqPMmO/H9E222Lg5SfDBda9kd43Eu/OT6POI2/Taae76L
         oU/PfuSW7Z0jMTthpSz/IDgUkd0FZFankiVFArXY92oqsdmvrFlbBiUixj7Bbpji+Gyp
         lST2nrMbejeACjEyeUt9oVsLg3WcwfMv5IggT/FAwxHwBPtgANekKZARH+9r6sdzV4l7
         LCbsKJvqR3Tn8j0JRjKP96AR8C5hlCERqqQmhTgGV4TM5Objv94G1+AQ/ppX40IQJ1NH
         5zIw==
X-Gm-Message-State: AOAM5309fXu0gIq0nBQatNzy8yarKFI1TI4vQkhnru+iVFFmWUH8i0Pr
        5sITZbVcUx7XUqcY7JZkQAJEjw==
X-Google-Smtp-Source: ABdhPJwZEm7FtvajqOgtJKdiPRxGmk1eLHI5zv3Mf2umHLLW6cpc4t2btmabaHgu9fez5PDPji40Xg==
X-Received: by 2002:a17:90a:1182:: with SMTP id e2mr3225390pja.152.1606839571725;
        Tue, 01 Dec 2020 08:19:31 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1cf2:4039:af4e:499? ([2601:646:c200:1ef2:1cf2:4039:af4e:499])
        by smtp.gmail.com with ESMTPSA id 3sm214147pfv.92.2020.12.01.08.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 08:19:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] RFC: Precise TSC migration
Date:   Tue, 1 Dec 2020 08:19:29 -0800
Message-Id: <FB43C4E2-D7C4-430B-9D6B-15FA59BB5286@amacapital.net>
References: <874kl5hbgp.fsf@nanos.tec.linutronix.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <874kl5hbgp.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 1, 2020, at 6:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Mon, Nov 30 2020 at 16:16, Marcelo Tosatti wrote:
>> Not really. The synchronization logic tries to sync TSCs during
>> BIOS boot (and CPU hotplug), because the TSC values are loaded
>> sequentially, say:
>>=20
>> CPU        realtime    TSC val
>> vcpu0        0 usec        0
>> vcpu1        100 usec    0
>> vcpu2        200 usec    0
>=20
> That's nonsense, really.
>=20
>> And we'd like to see all vcpus to read the same value at all times.
>=20
> Providing guests with a synchronized and stable TSC on a host with a
> synchronized and stable TSC is trivial.
>=20
> Write the _same_ TSC offset to _all_ vcpu control structs and be done
> with it. It's not rocket science.
>=20
> The guest TSC read is:
>=20
>    hostTSC + vcpu_offset
>=20
> So if the host TSC is synchronized then the guest TSCs are synchronized
> as well.
>=20
> If the host TSC is not synchronized, then don't even try.

This reminds me: if you=E2=80=99re adding a new kvm feature that tells the g=
uest that the TSC works well, could you perhaps only have one structure for a=
ll vCPUs in the same guest?

>=20
> Thanks,
>=20
>        tglx
