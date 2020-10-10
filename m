Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836A28A440
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgJJWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731319AbgJJTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:09:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED339C08E750
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 09:42:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602347848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Exa4s04Q1qDvNYBJlfTMMv9Ahu3ShSZgxxlQG5SBMpM=;
        b=JYiDSgbELJOX8mGTXpBfycwLiqyr0VtxL4zCHAMG60V8tDwhz42XUuzaD9Wyx7hJCFpDHf
        o6ezZl4PItKfz531POh/m/Mm4K9MFszeNud39rUXzTFDZXQJOB/VOv1x5GHDkphcofjOtk
        mcfsOR/8zEeLmuMPdugMteMmwKsm2u5ZZyo3Ff0KQnF+AAGXqAi2L6Exvu+VKWbco6IED+
        IP7F/7xWuiMITNZPnoDclgWOl/Ikt7huuz9GTBRO0ZVXtHmLV+LrPm7yx4wXS++EGvh3rs
        LCszEHB1mdvnsjrqTA9o9SV30ICAwbQekEqXfTH3AODZW7//ag2pQITORaPQyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602347848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Exa4s04Q1qDvNYBJlfTMMv9Ahu3ShSZgxxlQG5SBMpM=;
        b=jrQVflegs6ESlv9SGYR1oaSd131N8p+yDGRWf4ltiuVbLMrJpzJ3U1AQPhZgk8ind6gQr+
        0MCte9of3L/ovADQ==
To:     Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
In-Reply-To: <3bb1af44-4245-365d-8ef4-ce17debc476f@aisec.fraunhofer.de>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de> <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de> <20201009132815.5afulu5poh5ti57m@wittgenstein> <20201010071914.GA135401@gmail.com> <3bb1af44-4245-365d-8ef4-ce17debc476f@aisec.fraunhofer.de>
Date:   Sat, 10 Oct 2020 18:37:27 +0200
Message-ID: <871ri6rq9k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On Sat, Oct 10 2020 at 13:50, Michael Wei=C3=9F wrote:
> On 10.10.20 09:19, Andrei Vagin wrote:
>> And I think we need to consider an option to not change getbootime64 and
>> apply a timens offset right in the show_stat(fs/proc/stat.c)
>> function.

That's what I meant and failed to express correctly.

> Since the problems in softirq context mentioned from Thomas,
> I would agree to Andrei's option to just patch proc/stat.c and leave
> getboottime64 unchanged.
>
> Digging around in the kernel tree, I just found /proc/stat as the only
> place where boottime is exposed to userspace, thus it seems a valid
> option.

Yes, I thought about a wrapper function which adds the namespace offset,
but as it is the only place, open coding is fine.

Thanks,

        tglx
