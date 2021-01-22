Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC630300C98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbhAVT0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbhAVSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:43:35 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D3C061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:42:52 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h11so3548850vsa.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQ94cMMY2wJZ02bDEQhrKD3tBdrmXB7f97ooLXkrbTQ=;
        b=N5L2BsJ1QX6yeiIPK7tfQrlbUtQn8fcirbI6nPvVuK5UXrTQInFZGO6puP/YKNEIGg
         H9iokwBGet1zvFEv/30JOid2vxMO3vGorJvn1lsoktepiDjBvBu8PGIhTPY97HF+nMGw
         5OB9aiGZkPFuuvGasRsjibKN8dGMdIU3rmVVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQ94cMMY2wJZ02bDEQhrKD3tBdrmXB7f97ooLXkrbTQ=;
        b=n4iap8FPN61yT072eT6aWMV7U1TXwb4XENYo3NUZ9ou/b1keNG1sobIxrw1naozbfU
         hchXR4/yJjentiEI7ZH28p/yJSc+qc2Gp8TGvl7LjDl/xhFdCqdVw31uBFVQ4nNB5Ecu
         DqEeXlREpeZJoY9C4pD/oYcJGYMokd43eeRLwNfR4nmv/f4/nl/1/S2VsQTQo/HJKnfr
         pMLUTaMVjcUGNxe0sD6eIRJFH8u+kryf2IOFwKum2cmtDTc2My+GvYWx/dfYehdjruWU
         AwwdKJ2Y5GR6Qw+Te6WJhZ95ywEQqUE/sB6g4Rwt52yRU9ULt2//7ffyHqLZmil8EwQv
         7vYg==
X-Gm-Message-State: AOAM533Wk3ixhXlxJp/lIrklcLwsrfVBcoroeeJy4RJrlNaPxSAT/2i4
        jcKhWhMStNZv96UPPGJBw5ZkTaPiM0yunA==
X-Google-Smtp-Source: ABdhPJyFzmoZMySpJRikU2B8DHaydbB+atkDkjjTXH6dpA3RIjN8FE1+TliqLoRmucvCCwCFVElZMw==
X-Received: by 2002:a67:c89b:: with SMTP id v27mr2020477vsk.5.1611340971651;
        Fri, 22 Jan 2021 10:42:51 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id k4sm1221053vsk.5.2021.01.22.10.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:42:50 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id p20so3552986vsq.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:42:50 -0800 (PST)
X-Received: by 2002:a05:6102:109:: with SMTP id z9mr1614866vsq.34.1611340970333;
 Fri, 22 Jan 2021 10:42:50 -0800 (PST)
MIME-Version: 1.0
References: <1611053418-29283-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1611053418-29283-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jan 2021 10:42:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vrf4v0DKfZ7BAjW3ODoYeuwDu8L0S1kOMbbG+=WiVOnQ@mail.gmail.com>
Message-ID: <CAD=FV=Vrf4v0DKfZ7BAjW3ODoYeuwDu8L0S1kOMbbG+=WiVOnQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Simplify kdb commands registration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 19, 2021 at 2:50 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Simplify kdb commands registration via using linked list instead of
> static array for commands storage.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c    | 78 ++++++++++--------------------------------
>  kernel/debug/kdb/kdb_private.h |  1 +
>  2 files changed, 20 insertions(+), 59 deletions(-)

Wow, nice.  It should have been done this way from the start!  ;-)


> @@ -1011,7 +1005,7 @@ int kdb_parse(const char *cmdstr)
>                 ++argv[0];
>         }
>
> -       for_each_kdbcmd(tp, i) {
> +       list_for_each_entry(tp, &kdb_cmds_head, list_node) {
>                 if (tp->cmd_name) {

So I think here (and elsewhere in this file) you can remove this "if
(...->cmd_name)" stuff now, right?  That was all there because the old
"remove" used to just NULL out the name to handle gaps and that's no
longer possible.  If you are really paranoid you could error-check
kdb_register_flags()


> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -174,6 +174,7 @@ typedef struct _kdbtab {
>         short    cmd_minlen;            /* Minimum legal # command
>                                          * chars required */
>         kdb_cmdflags_t cmd_flags;       /* Command behaviour flags */
> +       struct list_head list_node;

nit: every other entry in this struct has a comment but not yours..


Other than those small nits I think this is a great improvement, thanks!

-Doug
