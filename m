Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7032F1A16CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDGU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:27:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43750 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:27:49 -0400
Received: by mail-il1-f193.google.com with SMTP id g15so4553426ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iLGzcOj0i6IhfKXOkbbCjFFFTb9Eq4X0i6RrvSaiIuc=;
        b=O+Xs4edEibivypwS2nzt++g33I0S22oG9q1nEPqQ2F5NI132SbWl6FEzY4UMeiDvv4
         55dDgRkw8amW7kbc6Q+MbmTEdTe5Dr63TrmPSLSwhFQwk+eG7ZL8CPGEo24iZcA/0D1b
         Xkpstmhywe4n2+4ZWYlgwUb6dlBk+UcuWGAZ2KEnf5XO8psrNoSLRly/J4m887H8nkXL
         yYRh3xlt5RAY71Ukkie1Wz26UuIehWC67khGX/lNmEyf0n41jELfI1oaMOmSoSP5ALWQ
         IPWRREVLXVg+NrSbpzDTk5IioiD27WaPQBaiCU0wsRT0ISDq1sM7Id8qxQZdeqbwu1ya
         wx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iLGzcOj0i6IhfKXOkbbCjFFFTb9Eq4X0i6RrvSaiIuc=;
        b=NY1yGI8bLv52/znOuGstYdPxQ2DzcpYmu6WWr/cuBqOkuyp+HJE+2REu5EJGgjGO9T
         7KjPuIARzwzdTkLT/O08Mr544zqOLDOoV90UFNF0texG9cwFP6rxTm8yrQ355ugPugxd
         h+NRDRns90wC1HnJuOjiI1rW11d2VYt71+G2zYVPmMfkBmbyDAsQ+GVCG8B+Jd1qEaki
         JV7EQ/e0+EMZlyPCoBs+ep/5Lh+uYVdJuZbtw+JzS7FOvqAloEGKPBN+RYf2JhdDMnG+
         pR9hDU1v5ZwFztloxLOpIy/WqvN3Yp+XuHaNhR6tRRIm2pUSRK+RTo7/vgMZTqBOs/9w
         2XjQ==
X-Gm-Message-State: AGi0PuYPE5oDU1b8SvvK4qgbqSbiJr3kKzhbKzgK0JsxQUoZltXAfWJM
        nQ8yU8fnJmZ5iQMK3Dn73eE=
X-Google-Smtp-Source: APiQypI3vNVBUmbtv/FLN1rb18EIq7DAQOvifzFXGukh1zv11Wiwoqd4T6wCaD1Q3CFqX7MLl7OcFw==
X-Received: by 2002:a92:8659:: with SMTP id g86mr3963135ild.96.1586291268421;
        Tue, 07 Apr 2020 13:27:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4700:9b2:1d50:a6a4:b3be:b3e4? ([2601:647:4700:9b2:1d50:a6a4:b3be:b3e4])
        by smtp.gmail.com with ESMTPSA id m14sm7629066ilr.16.2020.04.07.13.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:27:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20200407193853.GP2452@worktop.programming.kicks-ass.net>
Date:   Tue, 7 Apr 2020 13:27:45 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 7, 2020, at 12:38 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Apr 07, 2020 at 11:55:21AM -0700, Nadav Amit wrote:
>>> On Apr 7, 2020, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> Since we now have infrastructure to analyze module text, disallow
>>> modules that write to CRn and DRn registers.
>>=20
>> Assuming the kernel is built without CONFIG_PARAVIRT, what is the =
right way
>> for out-of-tree modules to write to CRs? Let=E2=80=99s say CR2?
>=20
> Most of them there is no real justification for ever writing to. CR2 I
> suppose we can have an exception for given a sane rationale for why
> you'd need to rewrite the fault address.

For the same reason that KVM writes to CR2 - to restore CR2 before =
entering
a guest, since CR2 not architecturally loaded from the VMCS. I suspect =
there
are additional use-cases which are not covered by the kernel interfaces.

