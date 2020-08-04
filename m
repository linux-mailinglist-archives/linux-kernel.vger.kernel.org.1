Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFC23B55A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHDHG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:06:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:06:26 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p8so13090789vsm.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNn+QJsZyJEIY4atBkbvkSPk2NvJPQW/iKso3++vDyE=;
        b=NzmY7W9cY2+pdV6WoPDEaVC6+5v/JHjLil+1hUMDCbQ5CrKzMBlIzcJUdbj8GqcPfD
         FW12VNde4ccGMkvFqmd+uhrrjdTDjsmGkhxxzbm/USSoi9EeCItqYXTsaohC70w2rr0K
         mED0Yj/a74t3ijgKH++93px1W4SUIuC3833/6/ojHzFtLSpDldRX0f4pRTQr5lcyUuj7
         8DPZ7OA0e15P+Vs+3rjDcSUP9vmfCfCAgy+yrJw3JDY5urdxYkdKHV2lmVqdtKw9Vpor
         rGcrkwFRxx8qaGdwIZiCWtOPbNs6hvrvD88vhaz1HPYl8BPpUpdqLMVbJHStNf7c/ZzA
         V2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNn+QJsZyJEIY4atBkbvkSPk2NvJPQW/iKso3++vDyE=;
        b=GDniQLZ7imG+D6JReKE3SUOCKDEt49WaO1aVd87nkcXR7Xho+j2WAqvmVq5EU0wiaf
         UpK/PVbu/L6AlnaDVRUM7JwbUZlii2yYa0/g5QDYb8Lav+HWvW9n8LkERIkN5OifLrnx
         JJ9JbZGQ7h3EPVHDtoIscHEViSUAO6vDSvUFowhziUHwwgEXBTErPw12m8JdlWrQLlrj
         uQMNeiUUugET/y+NjKQlJ/numw+ikus0tJx38V1Oc7WofDAy2o9KkZxnNM6YRBPQ/0S/
         1fGL/bTUu8v7sfZlWhbScEQeaDnKlt226xM4LvkyycwWihvXsivTmEJBTUKAObhlYsQa
         eQrQ==
X-Gm-Message-State: AOAM532nU33Cq1Vlps40QZ41oNXJkcNeD+CiZI2hhUs6f0nZgA6VaoBZ
        MGLWMX9KWbO+caYR390rW8m1XWq0srZeUQd3JfvZWQ==
X-Google-Smtp-Source: ABdhPJyOAcTgDh3kOnxr392bqo6QFKUHYjDT4QS17mG81EF46lmGVnWTn3Yrh9wPwdC1pYx1Ti4kslnb1ehFoeyBeUA=
X-Received: by 2002:a67:69c3:: with SMTP id e186mr3342999vsc.20.1596524785810;
 Tue, 04 Aug 2020 00:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
 <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
In-Reply-To: <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 4 Aug 2020 09:05:49 +0200
Message-ID: <CA+FuTSeCFn+t55R8G54bFt4i8zP_gOHT7eZ5TeqNmcX5yL3tGw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     Xie He <xie.he.0141@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't like the idea to get rid of the 1-byte header.
> This header is also used in userspace, for example when using a tun/tap
> interface for an XoT (X.25 over TCP) application. A change would
> therefore have very far-reaching consequences.

That's no longer the plan of record.

> BTW: The linux x25 mailing list does not seem to work anymore. I've been
> on it for some time now, but haven't received a single email from it.
> I've tried to contact owner-linux-x25@vger.kernel.org, but only got an
> "undeliverable" email back.

That is odd. It is a vger hosted list.

I'm not subscribed, but indeed the spinics archive ends in 2009 and
the other archive link resolves to something that is definitely not
X.25 related.

http://vger.kernel.org/vger-lists.html#linux-x25

> It would be great if you could add me to CC list of all versions of your
> patches, so I don't need to "google" for any further related mails.
>
> So, what's the latest version of the patch now, which you want me to
> review?

http://patchwork.ozlabs.org/project/netdev/patch/20200802195046.402539-1-xie.he.0141@gmail.com/
