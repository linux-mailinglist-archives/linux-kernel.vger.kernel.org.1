Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88F6301192
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAWATj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbhAWASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:18:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87850C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:18:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so10082683ejf.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6x810WVM6FZYFEzW2fUC98e5QYQGNnAmOehq0zJoIw=;
        b=EGGEcwKJ3BKLkVEYsZS8LsW5FhSkNlOdi8yBHO4sTYVWz4bqSD/iwXKiszrceCLbRY
         5LVeag9nKtnrFKCBDF0AfKeCyUOt+n3SSXjsrpUdvbd70jUPB2qVgW38qccEhVeIpU9p
         Z+rGHyHW0DpN3z9B/16Qbfg4juKbWoMlIubEH7H7uz0uS7CE865gnvDX8aSMW+96uhfW
         BVF+dqK7UE4+sREmGuWZJS76JOCGOFAHaG/YScHT2YGGp/56OF26CG1eWf79e/TpsmEJ
         DtsbtGj4T7P9/4AE8HF2JDMfHa8aH2kpFJv6ECtGKNLgrw2R92w0jV7e9bfn/4pMIXNu
         NTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6x810WVM6FZYFEzW2fUC98e5QYQGNnAmOehq0zJoIw=;
        b=YuuBoG4PZMvrvHBFH7Cx/SN/p4ZNg0nrCe71eO5xNNcfaJft/OcBLsb27kguRgsd7p
         ao4D1rPq03FrC5MLTUqky7H1Cx5AodKlK6xOt1Ov0UggY6YwBuxX1NzPs42uu7gV3OK/
         JU9y7O3Z/nrr3qN8MPaVXA6vcdCCSnpMp6PVQc9AoqPEbXOldAKBINdh3XzNWVNzwFZ0
         cI0Lt4ZSMea0O490QgEFWxTyOn0//0ejzGmZOt6Bh0imOft4vSc41hARH8aezsgh9T1+
         o/FYfK4n1XONyzLWCBwe4Oq0uRa4AjCJ3dA/u9tesPqaQJdMKjNkp9K/IJudn+/CQ8p2
         qfUw==
X-Gm-Message-State: AOAM532mg+zZWhcZtFWyajaH1RAe9D4ycYkhwvNi34vEdlMEcx2tTLX4
        jS9HyUlpbJhklwBIWr6ZTb+XA15lsKbiSTV7QlRq3A==
X-Google-Smtp-Source: ABdhPJxiXSEN2bR+UpsXy3eNDvn65pxqjqwICxHaHqyD51T8gF2jcSqAVbhLNn0YAApFFv2gVMAbt+TdOhJL6UEtrW8=
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr626390ejc.519.1611361082273;
 Fri, 22 Jan 2021 16:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-2-pasha.tatashin@soleen.com> <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
In-Reply-To: <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 19:17:26 -0500
Message-ID: <CA+CK2bCRhS9dozo0jf9mUp6woJh6_8NLLcqMdY4yHc6+mX2bXQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/18] arm64: kexec: make dtb_mem always enabled
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
> > Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
> > enabled. This adds ugly ifdefs to c files.
>
> ~s/dtb_mem/ARCH_HAS_KIMAGE_ARCH/ ?
> dtb_mem is just one member of struct kimage_arch.
>
>
> > Always enabled dtb_mem, when it is not used, it is NULL.
> > Change the dtb_mem to phys_addr_t, as it is a physical address.
>
> Regardless,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you.

Pasha

>
>
> Thanks,
>
> James
