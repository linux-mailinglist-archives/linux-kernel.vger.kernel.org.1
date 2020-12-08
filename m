Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC892D3698
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgLHW5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLHW5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:57:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:56:44 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r24so659007lfm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dp63dIdRcJ+RLwNco+dq+wSG9tRy12b3KCEuVvbzzL8=;
        b=LhNqYMYEDwYKbHkLZ330pI728saYOj9rxKzqq4j1aGuQmsKxAeEGqoVNujajZbkkmQ
         CRMFF7OWR2loXvYd7gVB2TcOB9g60xRH/EEhVLhSbBWqeao2CwGTCFuIpvf1aeYyl94K
         PmZNAPNRCemrWOyyf+xxHNkCZjddQnjYUHrLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dp63dIdRcJ+RLwNco+dq+wSG9tRy12b3KCEuVvbzzL8=;
        b=T+j3+GAcprKETdjD67OUnDVoCtSExMgsEBIGRPFQy9HG7P7vi3inaN3l0ieOUBiikT
         QQRtfPNX2UA7/g7De+iuEtjR/6AhBhvVnCnK8Nk/BfTJpi5D6BMdD5bPMCvpflbPyJyn
         5CKHQJund7NUGh+LmAWzP4/46QtxGc+l2lC/Z6t3YyZt0QH6Kno6tNbptwmSg98P2IC4
         g1WMHE8+vFKyJFyWnoHzIuAaM0tpBiLpzVUE8ZzpPZHeVuAGAbKWmBlBYdMKqbkkQY65
         Cl5QhJ243BJBqhWR6FiFHZ1pj3rBLG2N3hSGVxsPUdQbu0uBnR7xdIa5AELfmtIRUuXH
         iymA==
X-Gm-Message-State: AOAM532GjKuXmLbH+BhY5eLGnH7PC+HtqfrZXbpde81F8EZI45Yx48aD
        VuwuhmAa/7jtDsu2rHKmujUpqTP6IfeJTQ==
X-Google-Smtp-Source: ABdhPJznvdtlbwq9tgsY3O8dCQG01ui4zAdvWMQwzqIz0GkS4rk4o2RyZ7Jhod5WodEyYyx4yZYK8w==
X-Received: by 2002:ac2:511b:: with SMTP id q27mr4725721lfb.322.1607468202543;
        Tue, 08 Dec 2020 14:56:42 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o21sm24463lfc.153.2020.12.08.14.56.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 14:56:41 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 23so637589lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:56:41 -0800 (PST)
X-Received: by 2002:ac2:4831:: with SMTP id 17mr11506247lft.487.1607468200941;
 Tue, 08 Dec 2020 14:56:40 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com> <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com> <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2012082339470.16458@hadrien> <ca63ada5-76a6-dae9-e759-838386831f83@kernel.dk>
 <yq1mtynud0n.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1mtynud0n.fsf@ca-mkp.ca.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 14:56:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCChtPRmGZqZM8XeCAFhfRzX8ts4RFKeXgGUyuNtWGMQ@mail.gmail.com>
Message-ID: <CAHk-=whCChtPRmGZqZM8XeCAFhfRzX8ts4RFKeXgGUyuNtWGMQ@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Julia Lawall <julia.lawall@inria.fr>,
        John Garry <john.garry@huawei.com>,
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

On Tue, Dec 8, 2020 at 2:54 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Oh, I just realized the megaraid patch went in through block.

I'll take this as an "ack" for the revert, though ;)

          Linus
