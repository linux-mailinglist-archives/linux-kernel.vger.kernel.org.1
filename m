Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DAE1CC482
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEIUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:19:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D5C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 13:19:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so5306910ljl.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=J2julx2hs6owd62n+pd2JYhe6q2QsRo1OXAtwsVsruYMJBpnQ8uiFOlguFDfLik7YZ
         rMAAv0+dFxD8QskYZi9nLX3zKberv3nFnMQyidnzE4Vpn2PvYCSA06ICHQfTj4koWuUf
         oYf9h4WDijg//VNKhtCcE35X/HOZG3u0J2S3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=ITR8u0hhnk4iNt9WoJ8QNcJOiTMqNSKHxSUxqngkuFxLVwXweLcWhVyFNLqyO0doO2
         kiXcON0USLvXk54BiRy69uxJc9X0t1DsySw2LkXsKpoWbjynTHfx7jA++nPjauO67cAl
         TtatCFNuzbj7zW3pmkPCJ2Fjmtfcp0LOtRwhFDI5hPdF8wGi3OqmDYOI6cGCGVNK4I9x
         /o9zJVpGyoJojkhlMJLr/Mse5yNDQ9cjb1p0GyluKRhtmmLIxFcs5pRrxc+Aks5rali0
         pEI+Lpn+eW6n0UuzeIuv8NT7WGhWAJvFssogHWgjSXoZPVdsb77JwQ7CKoLStrtbtT//
         Hftw==
X-Gm-Message-State: AOAM532OwoG6MnCZixVrdc5RGL1uPXOWYFf6UjAWDoxl0ppcyf3XGyg6
        mUAysQpDI/9xd06rqiOHwCvTlPBWyFY=
X-Google-Smtp-Source: ABdhPJzWlGM1/vLonKwPqkrA/cRbhtEIPTy9cJR0sWEZua1bp+CsOANpzgt3CUEtP4BPYgXrtY6KWQ==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr5648830ljh.83.1589055595988;
        Sat, 09 May 2020 13:19:55 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x83sm4995304lfa.65.2020.05.09.13.19.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:19:55 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y4so5294101ljn.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:19:54 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5609189lji.201.1589055594669;
 Sat, 09 May 2020 13:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com> <878si0yijd.fsf@x220.int.ebiederm.org>
In-Reply-To: <878si0yijd.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 1:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I agree something needs to be renamed, to remove confusion.

Yeah, the alternative is to rename the capability version. I don't
care much which way it goes, although I do think it's best to call out
explicitly that the security hook functions get only the "primary"
executable brpm info.

Which is why I'd prefer to just rename all those low-level security
cases. It makes for a slightly bigger patch, but I think it makes for
better readability, and makes it explicit that that hook is literally
just for the primary executable, not for the interpreter or whatever.

               Linus
