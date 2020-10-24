Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605FC297D26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761742AbgJXPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761722AbgJXPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:33:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC0C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:33:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lt2so782495pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ib38EIy6KqLbCzhDsFX9vIfwgtD2o848KUSoNeoy71c=;
        b=dnxfuBjwv5FMkjO6AewL+ulzI0aF/VKrEXZJMr5COvNpsmDT169bdMvM7NAFMy0AIP
         0cezUlAz0CdahUo02n5yI84ygZcW1WzrfudsjVjy2QhGQDcYEBHYMUEA4XX45C+72HZZ
         IX2k9rwBSrfDIkWxLLEnSgidw4Dn7VrnIUQmJOJFx3ZzrYyJ5teVXBFatRNCLdBFwPYD
         v3Gg8TmHdCOkTiD1waFy2JeJ3ybGwd8THrbi5b7w4f3pW731xWrvSHtV101NC/4hXHti
         C/OwfdP+LB+qYDi3Smw4SRTYyH35q5L6ZUX28af4OWofwyLnsPXNJMySEhXS3stk3u4X
         Dajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ib38EIy6KqLbCzhDsFX9vIfwgtD2o848KUSoNeoy71c=;
        b=lzPdnLbIifTW/RZQTdQUZiwi1mDPxOUI0ZN1AKsE8YWnPqo90nJTGgiou/wmLrKJFn
         Hvm3cqOFgmRDc8/Q+AuKQecMzrBw+VHnisYn+dFej1+IYQemFlWlSbngfxTPtjS357p7
         Px7bPZEtsHoVrFr0MQCqs7thxIuXmfRRTYYFFDAO/otZShA8zrZ6GI+AW+rXiuHPy2f0
         lXN6ORjuCciGXdb/5RufK63DA1UA2jm4Xs5tHM2Vy/aawOFVa1xi3T2rjq1bC0helI54
         6U24GGsOyxv3SzKGSAx5yvIIP5zdhOTQb4n4On0zo13l+zW2k0UwcgysYUNWvYBpSsqu
         DXPg==
X-Gm-Message-State: AOAM531Yi8JuPv+DTlaus0jPgQYHLIcUx13KSjo9ZwiUYmUKLY4tnx0v
        t2q1oZreDPhtKtxvUPK8LdKOFg==
X-Google-Smtp-Source: ABdhPJxBA1OZyZqcMV9ibL2S2g7SlFm4DL6rpdLSEd4A7N/ilAKtfPy3sv5WE+u1iBrACANzMleOVw==
X-Received: by 2002:a17:90a:191b:: with SMTP id 27mr9285727pjg.115.1603553604710;
        Sat, 24 Oct 2020 08:33:24 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:21c5:78e1:e2a4:4021? ([2601:646:c200:1ef2:21c5:78e1:e2a4:4021])
        by smtp.gmail.com with ESMTPSA id 8sm6351973pfn.54.2020.10.24.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 08:33:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Date:   Sat, 24 Oct 2020 08:33:21 -0700
Message-Id: <3655FF47-15D7-4433-81B7-FC070E32B541@amacapital.net>
References: <20201024143744.GA17727@wind.enjellic.com>
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
In-Reply-To: <20201024143744.GA17727@wind.enjellic.com>
To:     "Dr. Greg" <greg@enjellic.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2020, at 7:38 AM, Dr. Greg <greg@enjellic.com> wrote:
>=20

>=20
> I can't bring myself to believe that LSM's are going to be written
> that will be making enclave security decisions on a page by page
> basis.  Given what I have written above, I think all of this comes
> down to giving platform administrators one of three decisions, in
> order of most to least secure:
>=20
> 1.) Block dynamic code loading and execution.
>=20

I don=E2=80=99t understand what you=E2=80=99re trying to say. Unless we=E2=80=
=99re going to split enclaves into multiple VMAs with different permissions,=
 how do you expect to block dynamic code loading unless you have separate RW=
 and RX pages?  That would be =E2=80=9Cpage-by-page=E2=80=9D, right?

> 2.) Block access to RWX pages.
>=20
> 3.) The wild west - no restrictions on enclave page protection manipulatio=
n.
>=20
> =46rom a security perspective I would argue for the wisdom of making
> option 1 unconditional via a kernel command-line parameter.
>=20
> It may be that ->mprotect is the right mechanism to implement this.
> If that is the case, frame the discussion and documentation so that it
> reflects the actual security threat and the consideration and means
> for dealing with it.
>=20
> Hopefully all of this is useful to the stakeholders in this
> technology.
>=20
> Have a good weekend.
>=20
> Dr. Greg
>=20
> As always,
> Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
> Enjellic Systems Development, LLC     IOT platforms and edge devices.
> 4206 19th Ave. N.
> Fargo, ND  58102
> PH: 701-281-1686                      EMAIL: greg@enjellic.com
> --------------------------------------------------------------------------=
----
> "Politics is the business of getting power and privilege without possessin=
g
> merit."
>                                -- P.J. O'Rourke
