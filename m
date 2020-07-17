Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A187F224626
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGQWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGQWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:06:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B49C0619D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:06:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so7005519pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q5TCCZgzdfgT0G/6PATrZpLazvHyt7WUQKrX1xrUKLk=;
        b=EuxBM1YB0vCqSrSBab3wG4+3G4l3LZB0r/Sy24DYkcIknVoRK1vd5FybG7DBoZMGK3
         /CTYNU5fQj7jzV2LhEHV/rMxebd8TPxLdS/JqIf4QW3G3zlJPlZkenuoPSr3MjLle+Qt
         xVgyLZ3UJBffb9GcM/W4p9s1nh6pIolmqkWH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5TCCZgzdfgT0G/6PATrZpLazvHyt7WUQKrX1xrUKLk=;
        b=ixie5ZT4ELSbo8X5RE4Uf2Dz+TZNKnqxiAf495kkElvegC86JtgDeszuHJMNsephnH
         V3lohUWLrK8ajuO6DnPTCHhgx9RnQreCQpLZ3BMdTQXW6F1MFiVW+9sKZMutZg5/oFiJ
         eAcxLEOJgijzCBx280D4coGeMCcQDKJrY6uVvWneKMqHprYfy7rN+6711r68FJH/yNJU
         0PmPp/ya0WMUr+GeyKsrFvSYkaFQPrH/5KwcHcvG1VmPoLI7ux5/RoMbzP7QuZ64Za6J
         744C4A4S8fHvoi1iD0oKOP2Pv3n1WRss5TzoxHATrve1kaMfcO9F16pGgWHAv9QWxtGc
         7aKA==
X-Gm-Message-State: AOAM531JZZq/Xpx8N23qKwuDGmST5VDUA0l6L9ynsniaDBaQ12AZgkn7
        B1lFuQmnULeyKAH4s0UTVT4pkQ==
X-Google-Smtp-Source: ABdhPJy9/8XCi8iOFM3R8LvinzGsW1RKW4M4ZDH4GQ47QjK1iaaE3UlIgfUhMF6EPqI5aJJtdKAWBw==
X-Received: by 2002:a17:90a:9381:: with SMTP id q1mr4017193pjo.38.1595023574832;
        Fri, 17 Jul 2020 15:06:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n18sm8896320pfd.99.2020.07.17.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 15:06:13 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:06:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
Message-ID: <202007171502.22E12A4E9@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:04:18PM -0700, Scott Branden wrote:
> On 2020-07-17 10:43 a.m., Kees Cook wrote:
> > In preparation for refactoring kernel_read_file*(), remove the redundant
> > "size" argument which is not needed: it can be included in the return
>
> I don't think the size argument is redundant though.
> The existing kernel_read_file functions always read the whole file.
> Now, what happens if the file is bigger than the buffer.
> How does kernel_read_file know it read the whole file by looking at the
> return value?

Yes; an entirely reasonable concern. This is why I add the file_size
output argument later in the series.

> > code, with callers adjusted. (VFS reads already cannot be larger than
> > INT_MAX.)
> > [...]
> > -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> > +	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
>
> Should this be SSIZE_MAX?

No, for two reasons: then we need to change the return value and likely
the callers need more careful checks, and more importantly, because the
VFS already limits single read actions to INT_MAX, so limits above this
make no sense. Win win! :)

-- 
Kees Cook
