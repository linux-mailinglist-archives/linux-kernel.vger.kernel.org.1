Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9187226CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgGTQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389038AbgGTQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:58:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696BBC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:58:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s189so10537688pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=43I7clNDsReFiDnQ/eG8o/xxDWM5jfx4yXluLFGgUPg=;
        b=sc9jlE/K1DrDneIJnR6n5x32DQheHojWvPTx4A7npjm875HZtsCBR0i9U4673qY+A8
         3WHkGIO7hvQpDhn8xnJXg6rIYv4iccpNk98bO9LmT8plqMZeN1NMCtxnPXHfu4kQM6lh
         VWdL6N7aXyJ28oOxAHpfRyI2VDi+9eBLPLiFmqckrwIohpK4ofXbR+gAJ5sLhz3Tk46E
         uBfxUgHScO/Gwq07Mku6yJKFfkGiRiDSfFqRTkku9ZHj3rzhUd+OKtX1daAWLdF7b0YB
         RgViOZKZuBEi0A8SR46Q3J+6zgQj/bsKZ9U1WaODjM2qrqOUw83UZuc7Y0Fd4b1bGoCz
         m9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=43I7clNDsReFiDnQ/eG8o/xxDWM5jfx4yXluLFGgUPg=;
        b=VgSal/fJK4E2zQP1WLi0Hx3sCgOyrk4W8pZr3VjIDYawr+EeuBkspQY3yZUUMTzwiB
         BzanisVjxYY28SMcryGpGdko9ZPvBgc+VJiFn4A/Cu8QKxf+cavtLy9b8H+Y8nwhgCF1
         NKO+FUOkFG5xqFsuXYuHaAog/tfnqSK3DiySIS29coUiBf0/UX/6cflllR2FOq10nxBN
         RxWdp2BC9RgbhQ8usIHRChp0dKW+b9tLzj2BpiT4xJC/tNUN0ugc/JFi/QeU5URq6OG3
         e7l7+jRNKsHHmmTyvPxbnouGd56pbozTiYVzixIVhHWY4vKnuBIfAm/FZo+n6Lyclpqi
         ZJyw==
X-Gm-Message-State: AOAM531LBAyBbgj9KqZKxmtgCPuoQMXDWUSsFeVPCxtRtVkIzaKJgDDn
        1LM1oAGnMvWF4EznZJ7nxDGp6A==
X-Google-Smtp-Source: ABdhPJwqbJwpMW1IhTYxfzLesmIFawwVTSzbWgxylzmrSdVa8Tk5mPHoVns2ROD6CM8Hjhjhno57fQ==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr19584029pfc.52.1595264322829;
        Mon, 20 Jul 2020 09:58:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:600f:2f5b:3d86:4df5? ([2601:646:c200:1ef2:600f:2f5b:3d86:4df5])
        by smtp.gmail.com with ESMTPSA id mg17sm95384pjb.55.2020.07.20.09.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:58:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: io_uring vs in_compat_syscall()
Date:   Mon, 20 Jul 2020 09:58:37 -0700
Message-Id: <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
References: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
In-Reply-To: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 7/20/20 12:10 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>=20
>> I just found a (so far theoretical) issue with the io_uring submission
>> offloading to workqueues or threads.  We have lots of places using
>> in_compat_syscall() to check if a syscall needs compat treatmenet.
>> While the biggest users is iocttl(), we also have a fair amount of
>> places using in_compat_task() in read and write methods, and these
>> will not do the wrong thing when used with io_uring under certain
>> conditions.  I'm not sure how to best fix this, except for making sure
>> in_compat_syscall() returns true one way or another for these cases.
>=20
> We can probably propagate this information in the io_kiocb via a flag,
> and have the io-wq worker set TS_COMPAT if that's the case.
>=20

Is TS_COMPAT actually a cross-arch concept for which this is safe?  Having a=
 real arch helper for =E2=80=9Cset the current syscall arch for the current k=
ernel thread=E2=80=9D seems more sensible to me.=20=
