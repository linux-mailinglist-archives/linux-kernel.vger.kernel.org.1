Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4138F2CAD83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgLAUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbgLAUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amfBnaeUotmB7/il2H7oWwrZJeIKyDFcSTqRbwNFqsI=;
        b=Qm0vCbeNTcrfv99uKEHFv+/DubOdw8bxGkWZGDZVgPJRTyWXrGYCwBPy9KR8g40OdV78GG
        y0vV/kogcXb4kwbJJ9rWO7E+e0FprQ2fDJU2DusRtGFt1uscwZ1kES+K4Yi8DnsetJbVBz
        9U+cioUjH1aTf8fTnK8zGwb2bGTdZGM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-qp9AFBUaNUmg-4NPWLKpBA-1; Tue, 01 Dec 2020 15:37:18 -0500
X-MC-Unique: qp9AFBUaNUmg-4NPWLKpBA-1
Received: by mail-ed1-f72.google.com with SMTP id w24so2039391edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=amfBnaeUotmB7/il2H7oWwrZJeIKyDFcSTqRbwNFqsI=;
        b=bBYSv4CC3sa1UePOorH/935oqAEpM59pOrKJZZ5gxNyn3ZVuxPxR0+IOd/Mtg75Ztv
         tHa5nCIL19Zoyp2nv1HOP1wa4Hn4tGxEfuZGVvfxF5pEINlRIMA/ntBwPSi16zn9Dem6
         m1XWXXX8DgCqKjzusY5f6wWC3prN/AE3qyE7cNxCg27TlgRpGn6AuwmMxPgKHs/2sP5h
         FNaoQv71cDlxvpMPr2IlUi5PfnbPeEso0zX9FJ7bCpWs5H+r4RjhrrTCrEkW+V1lvIHk
         TM35uBsovjwRAZFcyT9mbsTKn3x8ruEkjl4qT/Od0FVWAIvIdjM74oGj8TmjKhV19cVC
         hUSg==
X-Gm-Message-State: AOAM531rdl+jmUvxSmAs/yTP/n7IysUp0qWtDJC545ymeCjnZIdytoRv
        x7bvS1XOBGruartkjJFRN1lOuTeITbdp5KCHyV+4ODa5Q2dzeXO9PJID5IpViXHE2wTXPbaLSfL
        C+oQsIWW2tpMntR0c2F9oIW2S
X-Received: by 2002:a17:906:e81:: with SMTP id p1mr4869090ejf.494.1606855036723;
        Tue, 01 Dec 2020 12:37:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm0kjn87rkYSgj4f0Z10VM296Jj9OqfFNO8Y43EOkM7Io+QtfZDXI/gLsI6cGKvHKlIG3Gng==
X-Received: by 2002:a17:906:e81:: with SMTP id p1mr4869076ejf.494.1606855036536;
        Tue, 01 Dec 2020 12:37:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m7sm350381ejo.125.2020.12.01.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:37:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 628FB182EF0; Tue,  1 Dec 2020 21:37:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] fs: 9p: add generic splice_read file
 operations
In-Reply-To: <20201201153950.GA20545@nautica>
References: <20201201135409.55510-1-toke@redhat.com>
 <20201201145728.GA11144@nautica> <20201201151658.GA13180@nautica>
 <87mtyx1rem.fsf@toke.dk> <20201201153950.GA20545@nautica>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 21:37:15 +0100
Message-ID: <87eek91cw4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote on Tue, Dec 01, 2020:
>> > This made me test copy_file_range, and it works with both as well (used
>> > not to)
>> >
>> > interestingly on older kernels this came as default somehow? I have
>> > splice working on 5.4.67 :/ so this broke somewhat recently...
>>=20
>> Huh, no idea; this is my first time digging into filesystem code, I
>> normally do networking and BPF :)
>
> In case anyone else wants to know, this broke in 5.10-rc1 with
> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
>
> So really a recent regression, good catch :)

Thanks - and what a lucky coincidence that I happened upon this now so
it can be fixed before 5.10-final :)

-Toke

