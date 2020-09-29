Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0B27BA57
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgI2Bh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgI2Bh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:37:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:37:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d13so2508256pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5NPObd62S6aBUFhQDjWfIQs23I/Y2IDiU6H1RNmK13s=;
        b=WJ1q7OFPBQmaPBAuQv1cuQ1jqGuJUbyiza+3H3+5zHx34lFbUrydjc70ppNBxmY5ZU
         1KWPSFDT0UEAEURObrsKVN8A2K5ouY8hMdEQKHZBDc2bwNBmSUAruDRqXPpEgeJANYXQ
         okHjxUheB+c8HzhvQyVhEcbRccfh+CrvsEg2HZlYfLqaku2S1zFfaDypxp/f38jrKYaW
         Ug31t+mfiuaWVhaYYqlExyiZFffjJQ31w5dbdVtt6ZUNTqN4UNVGx9u/wTVA7RfZUI+Q
         oqOVutNXs8c0JXlKcwiS8dlClx2nSAyAWPS75do9EmENmM7EOzaMXVYd+WUr1zdH8Tgr
         m2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5NPObd62S6aBUFhQDjWfIQs23I/Y2IDiU6H1RNmK13s=;
        b=KQwU7B4475vTM9NCArBa65ATylS07jtZpwMs51yT9QeijxGdceponJFvOckjOeUc5v
         42rDRNYSHrOO9lUqUvjuNZLK1H8E+XZqbk7J95DKHSSjKgg0y4C96Fj3WxrjrnDFmEGa
         SJwdSmP4O3EqkeDZL25ZsiRyXTRYN0FEtgyxKZzTn/DD9aEJvqzzgOAztX/pQp2TWOg1
         li6gRt5pei8ndiJjLNhzj3IMwH1mWjm5V7g493oAJAgMNetEF72S8eHosv8ywmsynpg9
         YQaDcHCo2Q84UlLvxYGFhsuAK6Gkqb2+tlrVvZ4PsuCL5/czF5a3/bmj3ta28JaYFdar
         M8oA==
X-Gm-Message-State: AOAM533IpyZfPGG0Bfh5VFU8Ynvt0M3lKTyMUwH23TGEQENn/jZNl1Ak
        j2lOvHbo9fewcb4Ov0u4stwTuA==
X-Google-Smtp-Source: ABdhPJyk1bXdJLUhnY4m021GAUsK4cpkqpHatCZw4JcZmn3VvGTxOHf0m0r7lBHR4ZLMLZpkATlk6g==
X-Received: by 2002:a63:4854:: with SMTP id x20mr1452634pgk.220.1601343477985;
        Mon, 28 Sep 2020 18:37:57 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1921:87c6:634:c91c? ([2601:646:c200:1ef2:1921:87c6:634:c91c])
        by smtp.gmail.com with ESMTPSA id s2sm2394079pjg.52.2020.09.28.18.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 18:37:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Date:   Mon, 28 Sep 2020 18:37:54 -0700
Message-Id: <E16AF0FA-3017-4323-BDD9-56DCA33CED74@amacapital.net>
References: <20200928201959.GA3856@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
In-Reply-To: <20200928201959.GA3856@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 28, 2020, at 1:20 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.=
com> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 28, 2020 at 12:45:27PM -0700, Dave Hansen wrote:
>>> On 9/28/20 12:32 PM, Jarkko Sakkinen wrote:
>>> My problem is that I fully agree what you say in your description but
>>> disagree on that EMODPE should not be mentioned.
>>=20
>> I'll just be very clear: I'm not willing to ack any patch with a
>> changelog that has more than a passing mention of EMODPE.
>>=20
>> Do what you think is best, but if sticking to your guns may deplete the
>> pool of folks willing to ack your patch.
>=20
> I do see it mentioned in other responses too in this thread, and not
> just mine.
>=20
> And here is even a request to get it to the changelog:
>=20
> https://lore.kernel.org/linux-sgx/1B23E216-0229-4BDD-8B09-807256A54AF5@ama=
capital.net/
>=20
> I'm absolutely fine not to mention EMODPE but after re-reading the
> thread, it is not like there is one voice on it. I don't really
> care all that much whether it is mentioned or not but there should
> be some reasonable logic behind the decision.

I don=E2=80=99t personally care that much about EMODPE but, you could probab=
ly get the point across with something like:

SGX=E2=80=99s EPCM permission bits do not obviate the need to enforce these r=
ules in the PTEs because enclaves can freely modify the EPCM permissions usi=
ng EMODPE.

IOW, EMODPE is not really special here; rather, EMODPE=E2=80=99s existence d=
emonstrates that EADD / EEXTEND are not special.
