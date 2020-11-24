Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCA2C3184
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgKXT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbgKXT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:58:57 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F1C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:57 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f18so5495091ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnTZSzBIyjU9PpIl1apgb/bDzJCEsK97HPAlhzqIwxU=;
        b=GPWJ31WhJ4LVRmSqiU+JVKe78pq6ZXde7uLsZ0plweQCmRERXzSvr+si4jmurmXs9H
         u43k37FLkfk9mPwY0rxF2DUa4bs8nxwvWddk6+Xpkmpot4unWdte/W6+GSgtzMXF7XOw
         o3RVW9BHUWPoV3Ek5GQtOs+NRrueTsDhOyj5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnTZSzBIyjU9PpIl1apgb/bDzJCEsK97HPAlhzqIwxU=;
        b=qSdwA10RlC2cLTxCjSzxjOPz1TaIr5hcNsFiLX0BqzKbLHFfJyzYabNmWwMb8R4Dxv
         iwZdy155w4w8tyRAd774xy13w9Hiq8IbCPZBDpQ/aQTuT9umQPPx10DEkpu/durOAiYj
         dhw6QOZvZ5pQYBEPBZcRfsstvOD6/TlL2sjDJ50OZEUIj2q2nWWW+sJWJMKcI7LMmCKK
         K/KsOOE+xQamNIzUw6qdYfvh23QERSk0yQy+m1RxBeJc7LGSZsG0wkSMHfT6+NUeXUtH
         dVdTaU6Soz9189ss0PVBCoSCKLot1wBuHU3pt1OuHIgKPf+tXNzedmnxLDEGNAGqBFxj
         Kr6A==
X-Gm-Message-State: AOAM533lTzzjJgp7CQZvVseWhPJp2/8Zm5G61GHAztgMMQWMwEi3xAJP
        8BFUCUquwPpu0MA2IulCjrDlTAzQ+SQbCg==
X-Google-Smtp-Source: ABdhPJxGQJsXVIyklRS+r0w4q4uChbi9Bt03HkBU8Vu1pcnQ18zF0aPoxd0mohCTWvJOqGU94ZtNOg==
X-Received: by 2002:a2e:9244:: with SMTP id v4mr2555731ljg.438.1606247934737;
        Tue, 24 Nov 2020 11:58:54 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v9sm1840160lfd.287.2020.11.24.11.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:58:53 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y10so7985035ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:53 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr2663178ljp.285.1606247932705;
 Tue, 24 Nov 2020 11:58:52 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn42r0n7.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 11:58:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
Message-ID: <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:55 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> If cell happens to be dead we can remove a fair amount of generic kernel
> code that only exists to support cell.

Even if some people might still use cell (which sounds unlikely), I
think we can remove the spu core dumping code.

       Linus
