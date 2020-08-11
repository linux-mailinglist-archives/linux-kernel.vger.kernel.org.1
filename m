Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528CC2421D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHKVTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:19:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5395C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:19:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so15152008ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=B37Vu6gJyZiMc+9rfRlkcU20N9U10pvTExHnPuibbYthtQqVMegykJE7HYcY2zldNY
         5gxGBXFItNBRH8z/eG/knEXfMsho/PZusS91v/AIuz6EknTOjHM1WbX1WJwE9Kjez0Pq
         BW2ud3bdkqnIsddUMftapP9Lsi2ETAl3njB+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=swEINOYayaMjCt30JZeDZaxCl9eV3+A/c/aXcVPFBtRJo8ZrHm5XNGSfHEL9KMvKK5
         p77FPsfRvhOANFbNmW2TnbN2o7Sxm7oArxQl/XEb8USX1mVvgh35f+eZhsxL1le+XGFb
         F5nkkeYh1/lxpTb3/S17WdUxns4tAjqYufdLyMYLeFp0odNKNDXbPOfZ1ahepuISNMcI
         R4JRWONbDfQPAB9aKrwKoR42dr7iRPDrrp1FJIzI6E+n1QK8tBhyi+aETr7dkp64ShdA
         YWSkjjd7x72604aEPBSjhfs2NADzURmybZfX/d3XEsFpKAIlFvt5ncrMEQnQKVRh86nO
         EO5w==
X-Gm-Message-State: AOAM533spfLw9yuWJORPNnUvUyhiI4WWNe7PpIlBJnDWxj7ZGHCJPTwA
        pFTMhZXH41lNnnuGXPHKRoLFD20sjZ4=
X-Google-Smtp-Source: ABdhPJw0mIUFb/uofpCjEVsbXjdhtK0J7pH0aZMVEA2afzIUUA+6DQV4JjJb8NF2CovK9vdbRQPI6Q==
X-Received: by 2002:a05:651c:1134:: with SMTP id e20mr4163820ljo.40.1597180739651;
        Tue, 11 Aug 2020 14:18:59 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p9sm10278085ljg.76.2020.08.11.14.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:18:58 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t6so15141126ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:18:58 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3970905ljf.285.1597180737731;
 Tue, 11 Aug 2020 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com> <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
In-Reply-To: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 14:18:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So that's where O_ALT comes in.   If the application is consenting,
> then that should prevent exploits.   Or?

If the application is consenting AND GETS IT RIGHT it should prevent exploits.

But that's a big deal.

Why not just do it the way I suggested? Then you don't have any of these issues.

              Linus
