Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E62FC317
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbhASWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbhASWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:13:09 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A48C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:12:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z21so13859213pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=3IzHvzx60U8BToASANfwkqezou+71Kd/v35MjMTOVrs=;
        b=L2PoBV8kg4QIH7C1ebmqFycQ3e/Ra8TGEHlm9/oOMQn9t7fUXML2pwYmqbKb0GrmiN
         6q+i/mjUw4xxMXemEvYF6d4VVqi3qV/S4UgnYM1dJnGvrIbvSPS//4V+zTPK94n5TGYl
         VyQZLFMGv+qfZZdErd2rmGjP4d/f+46UuCP5E7T83BKEQPtlhbWEcWmDWVDalnamvygq
         ZUSriE/U6pwfvaPycX86o4zLqKQN6/91sJ/BHWE+Zs1HqstY6e3yG3dFkuhIsyCDd7Mh
         03nhnlsVEdv6f0TIwoq2SOUCwZ5L5VAtEDTG48F0hkCa7g0fqZ+JKdT5L/yualfpY3ps
         1qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=3IzHvzx60U8BToASANfwkqezou+71Kd/v35MjMTOVrs=;
        b=rU3GcdGEOWtu8JvQAtkaCmgg35cmbUY7Vd5cFcvSoHpoNzyWvaWWE7YoFzQvp8kPqu
         1JZSdD2+nMf0WArZG8dSDPxX5Z7MFWSrIrjgbKHivxwhXuGJgTKnwGW+X2zuqENOq6m+
         yQcgmfOb8fGpAMshvEdRET0rJMEgPJiSaotOVsFz9EQzn9RZFy18m+J9SZ9NxiaSvqqz
         1Ro1KZ7e6rBwMt73nfAmbNlIGTp0KyRPwwUSpaxTuyMVofCb77kNhDj4y1u6FltgnVTl
         waw8qaVbYSWr+tKqCmBsDgAKwYjqRDJTPJCXVqRddV1im4QBEZCqkZc+MaDCVJUZvV6s
         cJxQ==
X-Gm-Message-State: AOAM5320cjrbAyD95QeEa0IXMpHrAiCD6B1kcH4/2aOba6SxjUkmB6P4
        aULlSq/MsyD1xiH6sFaDhj4=
X-Google-Smtp-Source: ABdhPJzwvlG/lbi3NUBTcP9yCSDu2ZsDYylRCRZW4nK+M/id/ACGCe0H5paLjCVMZbqrnVCQPu5jyg==
X-Received: by 2002:a63:5952:: with SMTP id j18mr6436595pgm.29.1611094348548;
        Tue, 19 Jan 2021 14:12:28 -0800 (PST)
Received: from localhost ([116.12.58.169])
        by smtp.gmail.com with ESMTPSA id 141sm108267pfa.65.2021.01.19.14.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 14:12:27 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jiri Slaby" <jirislaby@kernel.org>
Subject: Re: Splicing to/from a tty
From:   "Oliver Giles" <ohw.giles@gmail.com>
To:     "Robert Karszniewicz" <r.karszniewicz@phytec.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 11:09:18 +1300
Message-Id: <C8NH7QWZG2CR.3RT2AKK0ESMYE@oguc>
In-Reply-To: <9d3baff9-5d4a-4308-9556-8dd037c2fe4b@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 20, 2021 at 5:56 AM NZDT, Robert Karszniewicz wrote:
>
> I have bisected this issue down to this commit:
> 4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter
> ops")
>
> Another case I've also noticed is writing to a serial connection:
> kernel write not supported for file /ttymxc0 (pid: 252 comm: cat)
>

Tangentially, I hit the same thing when hacking on this. Here's a diff
making the implementation match the comment:

--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -541,7 +541,7 @@ ssize_t __kernel_write(struct file *file, const void *b=
uf, size_t count, loff_t
         * Also fail if ->write_iter and ->write are both wired up as that
         * implies very convoluted semantics.
         */
-       if (unlikely(!file->f_op->write_iter || file->f_op->write))
+       if (unlikely(file->f_op->write_iter && file->f_op->write))
                return warn_unsupported(file, "write");
=20
        init_sync_kiocb(&kiocb, file);

