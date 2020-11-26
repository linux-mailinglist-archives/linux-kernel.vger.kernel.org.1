Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2462C4EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgKZGUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbgKZGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:20:49 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231FFC061A04
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:20:49 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id y74so1116944oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=;
        b=ezaCvQHNP4rXVlX6xgXScBgYsPbPPYeNewlmWmduFOZEwCAQiePxmYmVXxRNWIAKBj
         npE5+8DtXXxl5lIDZZS0EJDFMin+cuNhqnF9GVWXdwt95ToczUH17XgI/N/f5RDdgVTk
         K20LAvN4Q8KwIAWKWxz7lhuudgoUDjDQNgOQ9wCJS5pv4UlJ8k6N+hip7il4Tw3qlp8b
         FAv350pYhHk1L7GaNKcFbR2Ti54nHn0eqb/zzb9ABRY2bdSGl5MHh8QN5HMKW/YmAQsN
         F/W7hV8uygULP8RYNfy2hBUXjRLteBmuEIR1j5uixtkiJBAM3lzJbujbvujPp0OydxG5
         21dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=;
        b=C+m5o4QdaNn3hub5Sooo1bgwxso6ujy1ko3rD+rizeTdZbInux8lC0q0VvLvWLsMvt
         sQ3y3MjJNYAX14YwZyvaajURsWvbhLnKMps4mZQj58ChS46ThqD152yReYQMnV0Sfw9J
         XZ0wUbxyTdxm0TrLuDiy+LjOEgSGtk4ubO6l6NLmGLe6kcb2AoGhvi/iodEU6DylbpHU
         35knrk2Jp8I/TPjizqbg3q86Xvw3a2NqZDNc054Udr0FNFjSRz6n6YQHUVxTavSFnNDn
         4Th0PdbZ2urPW2iuDoMHeg9QFGm7CiMNtZPzGdf3B78860cePOBcbPNoILoiKJdou2bv
         qpAw==
X-Gm-Message-State: AOAM530ZkMuWHYPXX8JdAEjX94r7PbMaRDpIaZ3YDJWA3zPT9DdaE1zy
        ha5PXHZq7H7T+3GndNbP8ulfPNXmL3iJ0T7CG9/BMQ==
X-Google-Smtp-Source: ABdhPJyKkUGNp5ptVTQH/y3fdaO8WHD96bnV/Avp1SQ7JFU5f6ksIk+NGtCwlONjNfoJPAp1skv4dkqV7brJ0Qje4qs=
X-Received: by 2002:a05:6808:8c8:: with SMTP id k8mr1163796oij.84.1606371648249;
 Wed, 25 Nov 2020 22:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20201119060904.463807-1-drosen@google.com> <20201119060904.463807-3-drosen@google.com>
 <20201122051218.GA2717478@xiangao.remote.csb> <X7w9AO0x8vG85JQU@sol.localdomain>
 <877dqbpdye.fsf@collabora.com>
In-Reply-To: <877dqbpdye.fsf@collabora.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 25 Nov 2020 22:20:37 -0800
Message-ID: <CA+PiJmQ8-Qxu7yNWBvRLAeGa31PT5=hsYCcoW9QKsKnJQXqnMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fscrypt: Have filesystems handle their d_ops
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This change has the side-effect of removing the capability of the root
> directory from being case-insensitive.  It is not a backward
> incompatible change because there is no way to make the root directory
> CI at the moment (it is never empty). But this restriction seems
> artificial. Is there a real reason to prevent the root inode from being
> case-insensitive?

> I don't have a use case where I need a root directory to be CI.  In
> fact, when I first implemented CI, I did want to block the root directory
> from being made CI, just to prevent people from doing "chattr +F /" and
> complaining afterwards when /usr/lib breaks.
>
> My concern with the curent patch was whether this side-effect was
> considered, but I'm happy with either semantics.
>
> --
> Gabriel Krisman Bertazi

That's just from the lost+found directory right? If you remove it you
can still change it, and then add the lost+found directory back. Isn't
that how it works currently? I definitely didn't intend to change any
behavior around non-encrypted casefolding there.

I should look at what fsck does if you do that and have a LoSt+fOuNd folder...


-Daniel Rosenberg
