Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3C2BBA88
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgKUAI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgKUAIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:08:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D6C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:08:53 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so15900266lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PONzCKvr+vwt6Flh5wCrTZaAerJA45zVvmdcMNuJ7vs=;
        b=bbxfmC8eTRqjVK5ZEjTEUJxgrpO0kFVf9/uaSgCzhVMht34nhcdL+ZW4ekpzcvrIMO
         9G9gVesVNgsLfz8U1zun2zlQ6o1rW+PWPK5QLzF3yfRYlcmgfUNtISGccc6TFlKxNAtJ
         ewPxxLZFrlhcvMfHsn86USwX6n9sMnGcjDpCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PONzCKvr+vwt6Flh5wCrTZaAerJA45zVvmdcMNuJ7vs=;
        b=QP+i8OdC1iIJtOfA+VH87PjIlt2E8j0A4uuS99DZ7uPI0NTAj7ez/LiyuyhtOerPEo
         kt3bJC83axVTBhRuIOyq+5+vIqsLD+Qq8KKfZtBLV+Vv65RcM+HNS0MkRTMdFMVas3BS
         i+WsQu42wYlrZ8vNSJO5+3sKv8mki5ut3YRto5zsPggAsuFnKKJefMJF69ApDlESD8TA
         sILbkaJYKKRxhleg2PEsHBNZxRY5cSRL4Kyd+/I8rR1vwY6j41uCT2U3UVYwczcRzRaO
         2oEmYrgci+xUIl5VFj1xvHhd2RZ2bnw5B+xw3pRKwHsbtahb42I6kpXtd9HK85eYggqS
         PFUw==
X-Gm-Message-State: AOAM532HjORpoK06AuJcwKllNmrwzlFzgWXhwvL0qWa0SvrS2bHT3nve
        WHvCZ+XneTtQp8fNaqqtki2XV1IErxUt8cZD0R1UDg==
X-Google-Smtp-Source: ABdhPJz4f0EWNC9BPY5Uq5ljrszSEuayardlmsA6lhGiyhp+CrxylzMiqBzF8AiYbAUAJdiVhGw27qnABItZDvOG/lg=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr8636915lfg.562.1605917331662;
 Fri, 20 Nov 2020 16:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org> <deea0ee7-85f4-1f3a-9737-1dba98aa8278@fb.com>
In-Reply-To: <deea0ee7-85f4-1f3a-9737-1dba98aa8278@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:08:40 +0100
Message-ID: <CACYkzJ7Oi8wXf=9a-e=fFHJirRbD=u47z+3+M2cRTCy_1fwtgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] ima: Implement ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> > index c5bc947a70ad..add7fcb32dcd 100755
> > --- a/scripts/bpf_helpers_doc.py
> > +++ b/scripts/bpf_helpers_doc.py
> > @@ -478,6 +478,7 @@ class PrinterHelpers(Printer):
> >               'struct tcp_request_sock',
> >               'struct udp6_sock',
> >               'struct task_struct',
> > +            'struct inode',
>
> This change (bpf_helpers_doc.py) belongs to patch #2.

Indeed, I missed it during a rebase. Thanks!


>
> >               'struct path',
> >               'struct btf_ptr',
> >       }
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2d1af8899cab..1dd2123b5b43 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -501,37 +501,17 @@ int ima_file_check(struct file *file, int mask)
> >   }
> >   EXPORT_SYMBOL_GPL(ima_file_check);
> >
> > -/**
> > - * ima_file_hash - return the stored measurement if a file has been hashed and
> > - * is in the iint cache.
> > - * @file: pointer to the file
> > - * @buf: buffer in which to store the hash
> > - * @buf_size: length of the buffer
> > - *
> > - * On success, return the hash algorithm (as defined in the enum hash_algo).
> > - * If buf is not NULL, this function also outputs the hash into buf.
> > - * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> > - * It generally just makes sense to pass a buffer capable of holding the largest
> > - * possible hash: IMA_MAX_DIGEST_SIZE.
> > - * The file hash returned is based on the entire file, including the appended
> > - * signature.
> > - *
> > - * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> > - * If the parameters are incorrect, return -EINVAL.
> > - */
> > -int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> >   {
> > -     struct inode *inode;
> >       struct integrity_iint_cache *iint;
> >       int hash_algo;
> >
> > -     if (!file)
> > +     if (!inode)
> >               return -EINVAL;
>
> Based on original code, for ima_file_hash(), inode cannot be NULL,
> so I prefer to remove this change here and add !inode test in
> ima_inode_hash.

Makes sense. Thanks!

>
>
> >

[...]


> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> > +{
>
> Add
>         if (!inode)
>                 return -EINVAL;

Done.

>
>
> > +     return __ima_inode_hash(inode, buf, buf_size);
> > +}
> > +EXPORT_SYMBOL_GPL(ima_inode_hash);
> > +
> >   /**
> >    * ima_post_create_tmpfile - mark newly created tmpfile as new
> >    * @file : newly created tmpfile
> >
