Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACED1E8DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 07:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgE3FO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3FO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:14:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CAC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:14:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f21so858575pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7S20FztB4K8bcmYO9k53Hoe+v+Wmx6EAuufw39WkQKo=;
        b=foUL+loVA7P01QUxP2qwibaPTEQxpnA3eZ91PRZJqkVbM88euK96+Xf0EgTCxrXOci
         nKNPsdxXbKexE0qIFzfdKF9DxnAk99PU7DzCH87U+Fg7ZO/1jAtxK/hEek9V6+b5aDdi
         rkqM5E8kfurGboZYnL9362P5gipTWx+8LR+Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7S20FztB4K8bcmYO9k53Hoe+v+Wmx6EAuufw39WkQKo=;
        b=A8hrdtMWAb/SoURZZsPPrnYwX1dW2qC1Li3SbOXtU/GLK0aJe/rG0nrt1ESGrQpN3z
         bI2tMCiNaASlbAjrMSIcqR5W8hdy8VqTqaG5ufBVvGtBthfyJTYfFe7Tc/otSsLbvLFv
         VwVMLaSVcBItHiKFlsQ3EBNb6HI2XVI5Th7xD7gpn7uSur9oukWfJ5SqzGhDOWgpuJ3Z
         Ld6hfNOVQrGo7r48B9YPwxPmwIQ9CmptTYS0ZCSj3PoHi17u2iWzx9n8o++weTWYt6FP
         5DSJiiuPuCV5QA1I+676/IIKJcxsW/+cnuDihx7Ef+oaDNT0lJyrJMOZnpevzytOS9eI
         TuBw==
X-Gm-Message-State: AOAM530bhSvuzs1gGiW88zAInh5RmoIGtGbdFMKsojv0K3TpmBVKzM0q
        wEF8R2Wnx8kmZkNHwUuqo2AxAQ==
X-Google-Smtp-Source: ABdhPJwvtIjtj0ltHPZ9EqnzDRVa9H0aDcK9aBn/3aWYzwFSWqn/xilsKXXDpnc8qxo8J6r4JVCmNQ==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr11321164pgd.412.1590815695910;
        Fri, 29 May 2020 22:14:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iq13sm939612pjb.48.2020.05.29.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:14:54 -0700 (PDT)
Date:   Fri, 29 May 2020 22:14:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
Message-ID: <202005292212.021D7D1FF5@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
 <202005291403.BCDBFA7D1@keescook>
 <87k10unm0h.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k10unm0h.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:23:58PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > I wish we had more robust execve tests. :(
> 
> I think you have more skill at writing automated tests than I do.  So
> feel free to write some.

Yeah, my limiting factor is available time. No worries; I didn't mean
it as a request to you -- it was more a commiseration. :)

-- 
Kees Cook
