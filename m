Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB99301194
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAWAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbhAWAUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:20:15 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77452C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:19:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g3so10123667ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfCPgwbDQ2zzbDSEoclzTqKS1zYPv0ytUlrcQe/OBoE=;
        b=UfUV1EiDPpBD7xiZ2g4mXwFPOLvTdXTuSEkTGiaKPUodn+lIBjG2IFhQyg2gWBS7xh
         cqq6cHioV/fhEULHj3EcMn++AKzronK6cwSl0MSwh6Ky9pwQDuXP/RelOIFJm0nzhdKO
         ++dk1k97U0F0FvnQXD5ZCFXIV6VuBfnsYBIU5PNZao7eJn6zoFJLU0C7pY/ECr2lAggB
         6FKJ/2F/vHKdaSrVx/PvGC97CNlVyJssxeom7Y0A0A4ycK5UXsF2uPZ+Ait7EfaskEPf
         wh5qVKnCiE+0H2Fst4qUDRsZW67NtYT5A3FdQ5/W3oNMsEim3Xo8FyYl7/oja0ccZKV/
         FEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfCPgwbDQ2zzbDSEoclzTqKS1zYPv0ytUlrcQe/OBoE=;
        b=G7kGkQ33J3yDWeHZFRciuyIbSQBwashjnAugYBWGZftX7D1Iqq+FKYMd+lFtF/zWCq
         7fvrF08s4iMJn5y5ZwKJKUzdgvDhKRlnL7s8KLOSFdKn5vpHdjD24AMBC1g2xsXSRXaU
         sGLu5fG6yErnoPn8Xlmquye2Nx4IJTt4vkj0nWSnVeK7bAvL6oITj4EwLi0q2Gdn12p+
         90qPxbDri3VaKRyvtmnrLesqIP+QnGUfFILTaDQrEEarY4KMXEFieb70oRg4UgJo8cYG
         sLod6H0X1crRRf5sD5jmrx0iS8VMr5z/pqzQUykLZ2cJ1p3x8JjsvpFpcZ7zraY9A4gp
         IxUw==
X-Gm-Message-State: AOAM530FQ9rp7ZfEwu9VRmM2uHYYBtSaitEM0dABUcT0YnF4FZhlIbaK
        wDQ/RBr5s1FAQYMQ8Fwk8rHczKIAL0KI/tCjq2iskg==
X-Google-Smtp-Source: ABdhPJwcaAALh20qpm/P2hnaGk9SZMP47G7yyxYbSF3m1mhbFzvHblbl4+1Rthi6UFuVaHtPhx6kjh2dsQ5cq2Y7MRs=
X-Received: by 2002:a17:906:94d3:: with SMTP id d19mr247386ejy.383.1611361174244;
 Fri, 22 Jan 2021 16:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-3-pasha.tatashin@soleen.com> <66f0c5c6-4926-fd0a-8210-40b3e71b9fe6@arm.com>
In-Reply-To: <66f0c5c6-4926-fd0a-8210-40b3e71b9fe6@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 19:18:58 -0500
Message-ID: <CA+CK2bAG9r0i41btjxmwK8hMro4AcqY8KMn1qxFH=NKaDPnmLQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/18] arm64: hibernate: move page handling function to
 new trans_pgd.c
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:00 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Now, that we abstracted the required functions move them to a new home.
> > Later, we will generalize these function in order to be useful outside
> > of hibernation.
>
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you,
Pasha
