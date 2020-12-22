Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE02DDA64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgLQUzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgLQUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:55:41 -0500
X-Gm-Message-State: AOAM531tvzCkmQkC5hsiMGHijpye4D6G1cMRL2bQmdOkYGRAvWjq0x/2
        UEOm8jtofxT/rde6qJ9BEis14fQKcXwQaV+l+Cegyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608238501;
        bh=j6GmibYzc7mQabW9Jo+ZodqqvNf0SKFcf0HnL/RxL64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K8Ws0N0Dx5S3ffwsKvdfGtI8kPHe95I/1MIJXbTlzMRPRMXeZdf9rGXhxM9eHusWz
         aFRUWhRlLLzi/B/oVUh6riI8fjGCdat54dwKQDvnZsqzuizeXWnOdkt7E5sXNPY++k
         uQKAi43tbYU+FBwKR/DgvdHUHhxR4BRAoUJnuKicrzcYSwGKPX78QfTQOwJdpLEtW6
         3UZ4ffcuMMxmI+hHDqhzYGL92aSvrU0s7xc5jVCigmHdw3dP/SyifEWTJGSOfS3Uri
         XvlePVQdeM4tccDGB6JWvRkYWGcg3bSfCNBzUL0JgZZefldGk7PmutTQQFQMopQ3hF
         fwng1NeMmnD/A==
X-Google-Smtp-Source: ABdhPJziDYyWijk3+B63Kq1ka2KB1sjgmpOL8Lao1HOEPY+Agckn8z39OdblYSmrrPWA0s4rnWzHwWH9Mj9VbN+3hj0=
X-Received: by 2002:a1c:6741:: with SMTP id b62mr1091491wmc.21.1608238499179;
 Thu, 17 Dec 2020 12:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20201216174146.10446-1-chang.seok.bae@intel.com> <20201216174146.10446-8-chang.seok.bae@intel.com>
In-Reply-To: <20201216174146.10446-8-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 17 Dec 2020 12:54:47 -0800
X-Gmail-Original-Message-ID: <CALCETrWbuf6jJU_wfKwuCL97SZhXd9Vqfd8RhdO1uwLZKMM=Fw@mail.gmail.com>
Message-ID: <CALCETrWbuf6jJU_wfKwuCL97SZhXd9Vqfd8RhdO1uwLZKMM=Fw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 9:46 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Key Locker (KL) is Intel's new security feature that protects the AES key
> at the time of data transformation. New AES SIMD instructions -- as a
> successor of Intel's AES-NI -- are provided to encode an AES key and
> reference it for the AES algorithm.
>
> New instructions support 128/256-bit keys. While it is not desirable to
> receive any 192-bit key, AES-NI instructions are taken to serve this size.
>
> New instructions are operational in both 32-/64-bit modes.
>
> Add a set of new macros for the new instructions so that no new binutils
> version is required.
>
> Implemented methods are for a single block as well as ECB, CBC, CTR, and
> XTS modes. The methods are not compatible with other AES implementations as
> accessing an encrypted key instead of the normal AES key.
>
> setkey() call encodes an AES key. User may displace the AES key once
> encoded, as encrypt()/decrypt() methods do not need the key.
>
> Most C code follows the AES-NI implementation. It has higher priority than
> the AES-NI as providing key protection.

What does this patch *do*?

IKL gives a few special key slots that have certain restrictions and
certain security properties.  What can you use them for?  With this
series installed, what is the user-visible effect?  Is there a new
API?  Do you use them with the netlink user crypto interface?  Do you
use them for encrypting disks?  Swap?  How?  How do you allocate,
reset, and free keys?  Who has permissions to use them?
