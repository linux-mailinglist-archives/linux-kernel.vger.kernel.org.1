Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B352ECBD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbhAGIlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:41:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbhAGIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610008778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/gjdBCSmSXKkH6UZrD67rlhCNa+Qh7NKibomcVRCXg=;
        b=GFScFeuiP0gYrwf89SQxpVvkN7S/XrYZeWaNuctCUhlzZJ+/mXobrRkvBx8ZLGeJ2LjUE1
        o8NCxu2SxB0siULJjJcvRpLvPqKmFDekYvvR/aQ7TGghoMG8YJwSnRG3gmgmKXTU4/xWiP
        SHXjJp5FcjJdGbwU/KVjm0uk6kOUJ0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-aD2Rgw5POiCoEGaBgL1UvA-1; Thu, 07 Jan 2021 03:39:37 -0500
X-MC-Unique: aD2Rgw5POiCoEGaBgL1UvA-1
Received: by mail-wr1-f72.google.com with SMTP id g17so2337371wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/gjdBCSmSXKkH6UZrD67rlhCNa+Qh7NKibomcVRCXg=;
        b=lVgYkLQr4e94E+fmB+hCNrlyHJ7yHgikRVtNMrHX49WOwfHxLzR/IxW2Bgr7TjNI0f
         fut1sjNtET3Y7FpHWOlamCGvD3hWZNfQfgvUSGFsO0FHpDv19NjFzKtpJjvGE5wfCptz
         v6vU9o8zMLe2YkdgmXByVsZxieZXS69qsw4fUsYvQdbsOuFSdHIqUoBOvwYwIytxsb+G
         4s0FPO+QTQXqzGDtiPMWpecGTkVOByxw6IbxG7NBGCndtGBhQhGre6U9hRm50vooPpg1
         q4KvghOepzD4q27lFRm/Uzg5FLq8+VolsICfGjFhei2nLthLl91lTUo2G7vNDmNbzYZQ
         DvGQ==
X-Gm-Message-State: AOAM531yCqUNXrHj+A21maUVyehwVcw8XJcKXZ1xUDX4GD9+TigWc3FC
        /hkgK2G5leEqe7J6gEr3j8fZoqDWWWaBc6+UmQHjO8c5EoB7bzO6Q38ua5Jlg0Psa4lQLKwvVMD
        owdMHunaKgxHkT7ME+qPUdda5
X-Received: by 2002:a5d:554e:: with SMTP id g14mr7962488wrw.264.1610008775833;
        Thu, 07 Jan 2021 00:39:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7UTbth5UPeghaUf4Y/9GWuz3fDS27vvZLBin1zacQw3Tp5n2al3IsoTK+x69AxDSZwlgDNg==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr7962459wrw.264.1610008775620;
        Thu, 07 Jan 2021 00:39:35 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id h83sm6923737wmf.9.2021.01.07.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 00:39:34 -0800 (PST)
Date:   Thu, 7 Jan 2021 09:39:32 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Daurnimator <quae@daurnimator.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20210107083932.ho6vo5g5hmdohwqt@steredhat>
References: <20200827145831.95189-1-sgarzare@redhat.com>
 <20200827145831.95189-3-sgarzare@redhat.com>
 <CAEnbY+fS8FXVeouOxN3uohTvo7fBi5r7TQCGBZUmG3MGJhBrYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEnbY+fS8FXVeouOxN3uohTvo7fBi5r7TQCGBZUmG3MGJhBrYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 01:26:41AM +1100, Daurnimator wrote:
>On Fri, 28 Aug 2020 at 00:59, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> +               __u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
>
>Can you confirm that this intentionally limited the future range of
>IORING_REGISTER opcodes to 0-255?
>

It was based on io_uring_probe, so we used u8 for opcodes, but we have 
room to extend it in the future.

So, for now, this allow to register restrictions up to 255 
IORING_REGISTER opcode.

