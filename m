Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD19C221019
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGOPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:00:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61560C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so2206528pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fR6dbzH+dt2SEyGVkXPzqeJIOxjozyDdDFXnWvcFfX8=;
        b=dZ1/RMvVMw39VXexb8tF5pKBAs9eG1auhY0F1a3hrpry2k+MwNS+NfYPBJn4l/OyOl
         MMGxILx7NUe1DtKUCsjo6iqwgNfj8rPmMOE9ImNGsHhvhZ6li/EFGieZMFIn5OpEDXV7
         ut4LgorSf+/UYrIkxLpqE1DSUXjPhJWohxSA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fR6dbzH+dt2SEyGVkXPzqeJIOxjozyDdDFXnWvcFfX8=;
        b=bvXvhdHQuMytk4xpyugcF9itl+FLWzTYqjZiqjY0IwY6dYKuhvCmp2d17fs/x0NC4F
         IL2hCkiuHrxiud5ImcSc3hOwr8tDYUxSsiFOnsmKJ0+S9LL+Le398mJAY14FF2MGShXg
         8Vj93NQVZy46oM3migQv+HAm//5my97w+Y4PTES2AEJReWBkGMPEXibMlKJNpAZy/tNy
         Yn+P2rKFA4KOlI+Utlhq0GgxBkUlRNdZbxhRHjbjYFEFBgjmGEhI9x4ZDiaRbic+CAGb
         ZwO7pW23CpKOmKquuFaHv5i4diBTcHVHuTeWvczoW5tB+R0NF94Iv8ul5snxwitkl3Od
         9Log==
X-Gm-Message-State: AOAM533N/GO1XKVojnOM392L0VOTnAYfupAmFjwNOtdLiI3nVGo+hJO+
        FjyuZjYDrWX+AaWiY93+B8DYHQ==
X-Google-Smtp-Source: ABdhPJypnXERMxHttwqG67BS2VGWnOLjufZ/tc6bZRGQt5L3sS8EuZ6AokDXU5Pm9inEKXvID0wnEA==
X-Received: by 2002:aa7:9736:: with SMTP id k22mr8906785pfg.62.1594825218717;
        Wed, 15 Jul 2020 08:00:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm2543656pje.55.2020.07.15.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:00:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:00:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007150758.3D1597C6D@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064248.GH32470@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:42:48AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > +static int count_strings_kernel(const char *const *argv)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!argv)
> > > +		return 0;
> > > +
> > > +	for (i = 0; argv[i]; ++i) {
> > > +		if (i >= MAX_ARG_STRINGS)
> > > +			return -E2BIG;
> > > +		if (fatal_signal_pending(current))
> > > +			return -ERESTARTNOHAND;
> > > +		cond_resched();
> > > +	}
> > > +	return i;
> > > +}
> > 
> > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > refactor that too? (And maybe rename it to count_strings_user()?)
> 
> Liks this?
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/35a3129dab5b712b018c30681d15de42d9509731

Heh, yes please. :) (Which branch is this from? Are yours and Eric's
tree going to collide?)

-- 
Kees Cook
