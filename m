Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2335A2D352D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgLHV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLHV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:26:22 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EFBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:25:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id q8so22036935ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAt6SR54pfO6r6IYwitLEIY1X0vGqJNiQs3ra1/Xs4I=;
        b=N3XcvG71up8pI7MNyZXvuWhjPZGymShTsiqNrSDaH/wJvGTfFOt9MdyHVSy8SHtQMJ
         YW8SfVvGRX1xIZGT3xTYidoIUPeU7QmbggBvhbB7/SXWeWhH+pNDSkZRtRYIvYMLTUl+
         U+b/c6y5qX3l+nOVC3pae7YGo3zpp3RBxZJws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAt6SR54pfO6r6IYwitLEIY1X0vGqJNiQs3ra1/Xs4I=;
        b=FQAmsfiKUga7lMZgjns0mR5xww1MmEvyD3QP/4JJyOoBhCK4y1M2SMLabA+Yr3YmB1
         9N+iwkWF+jo6b5z7cRLUBDcEslvCvVgtlKGXzHBfjQaI7FpFZRZC7KmURq2Etk567M9o
         9qR1Nv1us4wWhqiAvtQTv7bBgBDalTV8Sw776keyxsgQr0pyqFK0BS6AP6Q2UpYf2aRD
         ibwmPZ2GBA8oi5I62eNGRQGfCLdKWfyM+J/G65CtF0kYxWLjkW5WBKp8SCgLNQBK0r/E
         JNHIQa7nJ0vZ/l/HiBFSltZ69KnrqXN3+gryd5ZgS7P5K/Wf75v1UukKeEkw3z23tIN3
         ZKPA==
X-Gm-Message-State: AOAM531r9hXZ0On/xWtUd9scudXeswtuH1kh6xpiUKTz7p/DLEgioxGt
        bVICc7u6iV8v/WK6uLZqdznnoe9Pb8alSQ==
X-Google-Smtp-Source: ABdhPJwi/IPCpdcYx0Lq0jPW9nmoYDU+s199tQ+DQoXr0CWD8Izb1q5bsfHtCnsp0R27Z2GexL7MKw==
X-Received: by 2002:a05:651c:3db:: with SMTP id f27mr1241831ljp.494.1607462739643;
        Tue, 08 Dec 2020 13:25:39 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n10sm1331688ljg.139.2020.12.08.13.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:25:38 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q8so22036805ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:25:38 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr1137779ljj.220.1607462738309;
 Tue, 08 Dec 2020 13:25:38 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com> <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com> <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 13:25:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=Xs6K7-Yj83yoGr=z5fTw+=MUHrLpFJZ0FOeHA2fjuA@mail.gmail.com>
Message-ID: <CAHk-=wi=Xs6K7-Yj83yoGr=z5fTw+=MUHrLpFJZ0FOeHA2fjuA@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Just re-sending with Jens added back - he's been on a couple of the
emails, but wean't on this one. Sorry for the duplication ]

On Tue, Dec 8, 2020 at 1:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Dec 8, 2020 at 1:14 PM John Garry <john.garry@huawei.com> wrote:
> >
> > JFYI, About "scsi: megaraid_sas: Added support for shared host tagset
> > for cpuhotplug", we did have an issue reported here already from Qian
> > about a boot hang:
>
> Hmm. That does sound like it might be it.
>
> At this point, the patches from Ming Lei seem to be a riskier approach
> than perhaps just reverting the megaraid_sas change?
>
> It looks like those patches are queued up for 5.11, and we could
> re-apply the megaraid_sas change then?
>
> Jens, comments?
>
> And Julia - if it's that thing, then a
>
>     git revert 103fbf8e4020
>
> would be the thing to test.
>
>            Linus
