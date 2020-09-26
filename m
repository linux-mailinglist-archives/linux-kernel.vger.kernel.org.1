Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91DB27968D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgIZEPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgIZEPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:15:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B2DC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:15:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v14so477569pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KUTsQ4cRgo7tcvKxTzbTra/DQ+skBopOu8YgTTZQp+o=;
        b=BWnMfRXUFKWpwia+E3QCxxaGzaHx+nORFT5Orpdeojhqss9dXtuYypFi6XTnsJ3WjW
         WEkjoK65wFyrvC73Uj4kbseBI6mjY8eI00R1vA7WhobCZE/0rP0GNtVPhFli7UV8Dl/h
         byjFxzHO9ScP+K55Ql6Rk8wrBGTASEGmQ12Kb9PNQ7J90+N7zvbXrlNrBQFcJJV8S2rn
         xUTWlqa18psooaWuTDDBTjmNpwjnO0T8EU6JYdLZpmN++wFoU6QFG7eeYK1CWTGKq17K
         RP1E8gLbK+aIf5TJRRCKDWGWep7Saozz5gdF6pyCSCrIAFp0gSKBE91tdnp4Y5Np7IuE
         b1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KUTsQ4cRgo7tcvKxTzbTra/DQ+skBopOu8YgTTZQp+o=;
        b=Lb01EvSK+bR1lUNDDtVJk0ogPmKB9QBkI/0CioU3784wzkGoF2yiqwuFsSQK2n2YwV
         XUoaCXHaU6fGlbnm6MwM5tl/L5+Glpi+ibHitxn27yMnr9K1HAk830T9ck94BeNLJf5f
         aems4VAy7Gdraws32cwokOqhK0dmtee9KPe0JcqQIp19xoXomUkc1WkW/otxFvybcTYN
         LFeIBU+Y50eSugbza25CosvkHrJNvLvCW5+Y11C5XlFIcCkU07MlAm/SvsikSW1otLVT
         kEilvO2XsWi1PEade7tuJFpMppviqu6/m97Cwf0wCH4zJZmubxDu6H1zT/w2jPn3HOcn
         z2Xw==
X-Gm-Message-State: AOAM532dGOnD64WDY2p4qZsvDBoYGzsE8uB24F+5Yi82RKUuyNo1/mql
        v4RFDHZFBiUnnEkeBwj7xlG2eQ==
X-Google-Smtp-Source: ABdhPJzsb5zohq/TAtZ5fioaotDPmq8e15jJlMaKFeemNTlWPQEVFAiwftJs/1T1diVswdmRcQu08g==
X-Received: by 2002:a17:902:b18f:b029:d2:1ec0:4161 with SMTP id s15-20020a170902b18fb02900d21ec04161mr2444866plr.58.1601093722526;
        Fri, 25 Sep 2020 21:15:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:c200:1ef2:65a8:3322:5d17:ae5b])
        by smtp.gmail.com with ESMTPSA id gg19sm505756pjb.49.2020.09.25.21.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 21:15:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Date:   Fri, 25 Sep 2020 21:15:19 -0700
Message-Id: <2321E653-F629-44D7-91C3-F42F42AF4EF6@amacapital.net>
References: <230ce6da-7820-976f-f036-a261841d626f@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
In-Reply-To: <230ce6da-7820-976f-f036-a261841d626f@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 25, 2020, at 12:53 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 9/25/20 12:43 PM, Sean Christopherson wrote:
>>> That means that the intent argument (SGX_PROT_*) is currently unused.
>> No, the intent argument is used (eventually) by SGX's ->mprotect()
>> implementation, i.e. sgx_mprotect() enforces that the actual protections a=
re a
>> subset of the declared/intended protections.
>>=20
>> If ->mprotect() is not merged, then it yes, it will be unused.
>=20
> OK, I think I've got it.
>=20
> I think I'm OK with adding ->mprotect().  As long as folks buy into the
> argument that intent needs to be checked at mmap() time, they obviously
> need to be checked at mprotect() too.
>=20
> Jarkko, if you want to try and rewrite the changelog, capturing the
> discussion here and reply, I think I can ack the resulting patch.  I
> don't know if that will satisfy the request from Boris from an ack from
> a "mm person", but we can at least start there. :)

I think I agree. ->mprotect seems reasonable to me.

FWIW, I don=E2=80=99t think I should ack this particular thing =E2=80=94 it w=
as, to a decent extent, my suggestion in the first place, so I=E2=80=99m bia=
sed. I think it turned into something reasonable, and the ->mprotect mechani=
sm seems easily supportable and plausibly useful for other purposes down the=
 road.

>=20
> Please be judicious in what you include in the changelog.  There's been
> a lot of detritus in them.  Let's keep it as short, sweet, simple and on
> topic as we can.
