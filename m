Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC30B299A09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394964AbgJZW7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:59:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393384AbgJZW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:59:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so5450502pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2rK/Of0WiuHYD9FFK0xFIIBHXzWWKf/GF6CaoAKhi7k=;
        b=KHfHv2Di0sGKLZSKyaTjvWAM7dc8mzSm7Coa/rUW/4AN1SMnO1ZHiW4hp01+GkQV+S
         ISgKfXjDv+y1MrC7lmY3fyAt1e1GHXjHYaeaHZgDjHB4eDsW1AAztlH70o3vVJW24seI
         HzdAr3RmlKOSi3KqOdWs4gpIjSPpOg1XpyTQlNqpNrYgF7m0laP1Apg08scR4wfKxjAR
         DhjBAlpqiSUYhVwgfWMqTriaEWqixF/foByxWbLTCVSKpXvvDOcPO70d01wQUV1bEEVf
         TzfvArhrKfxQY5DwmEJ73jFflGxTNjZIPusFHBSdciK10UdUe4JebN5kvEnva/DxhO+n
         shzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2rK/Of0WiuHYD9FFK0xFIIBHXzWWKf/GF6CaoAKhi7k=;
        b=fOvco9v92HDCSWgFZoosqOcBbj72gmNXUivr6a9eGqO0pnR+Cim0bMAv6aZTd5oxRo
         ALPC8sz5G8xOBnktz8uGliEE7q4kR+poG1Y9Am9MlGpqNRtLZaBwiHvet7cl9girxYkP
         oW7GelC/uH4ddCZPg0f670n7M2ST5tILNquJvdWfF5twwEP3NKvVbO8+4sq6cQqLKTK9
         wbLBCs2gcVj2EKi9A/pxNbHAHYgJwo3eEHOulYK8mwTJ/AFDnJ8j5DYaEXl9P77CKon3
         VH3DCf91apmf5AJtdCNjVvVfJaLlv5yGVTRyUI4G/MTR16H7thRSMlE1Zib3+6vYe5Ub
         mTZQ==
X-Gm-Message-State: AOAM531FA5gx039P31bZD13YtLivECJu1qdu9OV6aZW3EStcYJzzFiAS
        glDaMcZuwwC3eDp42azpIHeq+A==
X-Google-Smtp-Source: ABdhPJxdZ9ahVkNLc4s51Ze8FYwPnT3P4jHeIwL+eCMOHBC5VdKZAK9mDF+XHItA3wLxaM3PYuSaJg==
X-Received: by 2002:a17:90a:dc85:: with SMTP id j5mr18214212pjv.38.1603753179292;
        Mon, 26 Oct 2020 15:59:39 -0700 (PDT)
Received: from ?IPv6:2600:1012:b062:b558:54e1:d677:9f91:a6a4? ([2600:1012:b062:b558:54e1:d677:9f91:a6a4])
        by smtp.gmail.com with ESMTPSA id y124sm12776291pfy.28.2020.10.26.15.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 15:59:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Date:   Mon, 26 Oct 2020 15:59:35 -0700
Message-Id: <4B39703F-280C-4AED-B4BB-047BD216B792@amacapital.net>
References: <20201026105128.GA30004@wind.enjellic.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Neil Horman <nhorman@redhat.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
In-Reply-To: <20201026105128.GA30004@wind.enjellic.com>
To:     "Dr. Greg" <greg@enjellic.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 26, 2020, at 3:51 AM, Dr. Greg <greg@enjellic.com> wrote:
>=20
> =EF=BB=BFOn Sat, Oct 24, 2020 at 08:33:21AM -0700, Andy Lutomirski wrote:
>=20
> The easiest way to generically block dynamic code loading is to not
> allow the ENCLS[EAUG] instruction to be executed, the purpose of which
> is to augment a defined but sparse ELRANGE with additional physical
> pages from the EPC.  It doesn't require ->mprotect or anything else,
> just a physical decision by the OS to not allow execution of that
> instruction.

I=E2=80=99m pretty sure that one can dynamically load code without EAUG. It
would require preallocation, but I can=E2=80=99t see why EAUG changes anythi=
ng from a security policy perspective.

>=20
> All of which is consistent with my recomendation for a global disable
> knob on the kernel command-line for sites that do not want to tolerate
> completely anonymous code execution.
>=20
> Since this driver does not yet support EDMM, the most immediate
> situation that we are dealing with are the potential security
> implications of SGX2 ENCLU instructions being executed inside of an
> enclave.  The most principal issue is the ENCLU[EMODPE] instruction
> that allows a running enclave to extend the current permissions of a
> page.
>=20
> I've been assuming that Sean's desire for ->mprotect is to block the
> ability of an initialized enclave, on a non-EDMM enabled driver, to
> collaborate with its untrusted component to self-modify its page
> permissions and thus allow execution of code that the operating system
> has no visibility into.  That would make far more sense then the
> notion of someone trying to create an LSM that makes page by page
> security decisions.

If you remove every mention of EDMM from that description, and you realize t=
hat the ability for LSMs to implement this sort of policy is basically the s=
ame as for the core SGX code to do so, then I agree.

The addition of EDMM will not change anything here per se, except that we=E2=
=80=99re a lot more likely to encounter enclaves doing interesting things wi=
th EMODPE once EDMM is enabled.

>=20
> The open question in all of this is that the EDMM paper, as well as
> the SDM, indicate the effects of an ENCLU[EMODPE] are immediate inside
> of a running enclave.  I'm assuming that this does NOT mean that once
> a context of execution is running in enclave mode it would be capable
> of evading standard page protections but the 'immediate' is somewhat
> disquieting and probably deserves clarification, despite Dave Hansen's
> adament concerns about discussing the instruction... :-)

If EMODPE writes an entry into the TLB that violates PTE permissions, then w=
e have a real problem. I would be very surprised if this were to be the case=
.
