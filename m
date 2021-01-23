Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D230119A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAWAVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbhAWAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:21:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:21:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g1so8550348edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nnkYAh0L/ZOt41YSqEc/4PkBzB75o3gfMS38t+KmWU=;
        b=IaLx77hycXOwCqovLzQ7YvrFexC52irwGgi6tcKyXzab4SXkSQqyMemkr2jdwC8gZ8
         fEEcPA/J4ALz8K4F9fdX9V0ybWsWSh8TOIVqLPE/pb9cdtrZI3HUonzjTNP4Bk9j/ZST
         IbUcBRB7F/4y+vjPTqPdavVySRFBFGL8tNM4iZL4wvEcWQ1Kv2JBIqjGH49ULwexU9FB
         EMSfRV460rrhJ7mEm1vVmyjMT9J31aYkXIyA0QVAMXVFhJ2G8NBtOitDU4Srp/dcvekq
         ybrCALablQypI+eED0Lt6EJR+JA/GhnWn3OwAF7UdRX6SKCIPQUzyaTmroMxap0cK4VN
         1nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nnkYAh0L/ZOt41YSqEc/4PkBzB75o3gfMS38t+KmWU=;
        b=OXsdYmuLjfpcu+jw+Wq2yqHhjTlMAvnJXgKu/wG47cPe27vHbGgIp1ZRHOTTUPfVph
         C1PEQRfSWQL+C8E0Vyvx9Zlrgz7jNcgNsRmKGNBU6xy5TPhxuOSeo3fjMiyocALEwqRP
         Zo2GtjyqL3L5Qyk3Xq7TfFjx+XacsTsBai+tsivgq9mvLRBtHZh9x1yYJ+FT0kA8KLOz
         Ga3pKzmS3ClD4e/+WR0UOcndMki2L8QboAabOnTDhXAfKJh9tVQrRsLAUWYRXv4qx/9M
         rADn9NJK6htFl0qibGVh6NAuub/lsf7sYSUiTbj1wQsiy3llpRnwiESIzvKoTKFZmPYO
         /vkg==
X-Gm-Message-State: AOAM5308I4pktRKs8l7nYcrYVN7AOJpsGj2/bpEeP902HPNaSBwJ+vAo
        t61VGq/Fx261+gvhhXGrPdyr3aeaGYnjBoKtVdo60Q==
X-Google-Smtp-Source: ABdhPJx+Du8+ny/fj8QpRwAJ4VXar8iUbw7JmWuU8x2DHeSXqV5DYf6FvKExqKp5LoNLjNBLtXE0YcsKJul62KnevQQ=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr5138364edd.62.1611361267296;
 Fri, 22 Jan 2021 16:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-5-pasha.tatashin@soleen.com> <82db4b88-7e69-9298-f1cb-d3afcd29b1ae@arm.com>
In-Reply-To: <82db4b88-7e69-9298-f1cb-d3afcd29b1ae@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 19:20:31 -0500
Message-ID: <CA+CK2bAEOx8JWZYpLzNRWNbny=gg+Hz89ajdxUnjKanZjUaROQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] arm64: trans_pgd: pass allocator trans_pgd_create_copy
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

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Make trans_pgd_create_copy and its subroutines to use allocator that is
> > passed as an argument
>
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you,
Pasha
