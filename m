Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B090F2CE1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbgLCWn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbgLCWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:43:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF5C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:42:46 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so4354413ljo.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6HZoKAKXfWMxfU/sB53UHJz3iKRYedHUIbkt4F2tQ4=;
        b=FXgEvTiozWuHL7VjqfhnP5ZwC5eh3FdULVsXN1geI/iVQtMvQF2Fn/djko7AgtjOsu
         W1ePOh4ZVfJc0ryBDq7ChRIzm4UlWYKPrE0K4/utf36lE99NqnvgFNAc8ViCZ+W34tEz
         Lm26XV7aiEIgXhwFrMHVq8zRRMImUv7lVMg+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6HZoKAKXfWMxfU/sB53UHJz3iKRYedHUIbkt4F2tQ4=;
        b=UeUw5XU5A8miyvyjRAVLL8XhWAeeYwEAE0tGjxad36ejUA6mONWdHU1kKR8U9Ew8jr
         wJXEGln+d4rhycU+HCDQzo3OYwpwdyrIXMGDXoS/cxducAIx/kF+DFaT0q9aglNvRGa0
         S8imXAItbxptjcywKWzmyTp6SgnCYw2tbPNLINzqwXpV5SC2pndMJbgPg36msi8dzcav
         PnA5Yvo9821oc190YV6dya1DtzacmXwhXDHtDBrOMwzNKcs7WbAKy3nNPIqz35Ss+tVu
         Ybr19ILG0kc6AMwdiySZ/8exptjX/mJipxK1HQxQYacTjIN6GI0sbmLvV6p9B3Vnx44X
         JfQg==
X-Gm-Message-State: AOAM532XoYGLrciu9UEFwttisSP1EwvWHEXCuK+N8OhDBlfnKU+oWahn
        SpWkPvn4avIbLV6arqr33g86mi2aT4DIAg==
X-Google-Smtp-Source: ABdhPJzt5f8dt4e85e03GfT3ByZ4a9XfLdxZxhDa3AcniSgInn2LJrm7y1qdKuHbfGLHfmrNZ3vvkQ==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr2137133lji.319.1607035364851;
        Thu, 03 Dec 2020 14:42:44 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s19sm902588ljs.17.2020.12.03.14.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 14:42:43 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a9so5113310lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:42:43 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr2076947lfy.352.1607035362851;
 Thu, 03 Dec 2020 14:42:42 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tut2bqik.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 14:42:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
Message-ID: <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 12:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The simplest and most robust solution appears to be making
> exec_update_mutex a read/write lock and having everything execept for
> exec take the lock for read.

Looks sane to me.

I'd like the locking people to look at the down_read_*() functions,
even if they look simple. Adding Waiman and Davidlohr to the cc just
in case they would look at that too, since they've worked on that
code.

            Linus
