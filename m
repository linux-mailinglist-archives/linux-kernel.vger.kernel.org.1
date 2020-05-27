Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C741E5158
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0WiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:38:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA9C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:38:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so12488147pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eb+5CddLVa25XNVlonONbTANA1hlzWybPHX5/YlMRAg=;
        b=QWaohhXI7vTzQW1hXa2jmmmBa0brACBxQIsl8lefEyaqmYxDE3S3Ms+vdC0BFrlFrm
         /gypiaS3ie0c0fRgRR99iYuDdZASJ+XWkTao8u8e5i+tYCbH1KBcSZCRo445dsB6CWXL
         rnEvuUS94keZToK/N++qo7h0DwcqCCNGp/vA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eb+5CddLVa25XNVlonONbTANA1hlzWybPHX5/YlMRAg=;
        b=DF5rAthpu1cIGENJ1v3oxz3UmOutaDCvWM6vB8HiU05FSXvK0dms3IO7rsajKiSXA9
         Z6u4bozNpVq0sJA+aJ5fgnN22h4qxuZ8YFC9nV4q3oEF+r6oE4QbNLnczZIIMwvETprj
         T8aK+Uvo4F+5F+Wtv5TBoDel+rwvyzOytaMtRIwaJDZlCOzdj+rYgJdtmwyeUb/0RpYc
         a5gL8FVqqp8PlCydRzvk/YWX6pSyMDnj09ZtF9bIh/fQT4Sp6GPN7NxGwNS9ZrgOXllx
         bG9yORNolPU5jZ/XoSRkDNPjanWFbZoWpIB7/jm+ZilFJA9oz/1h+EkIweuUbgHkbVrg
         gYbA==
X-Gm-Message-State: AOAM533C4ryn3npXZxKnqwx4YQdawxyuHuZxndm9bjXD+csZ3Zf5NNNo
        YB0yYlaeSFxbcRLURFQ1U019gQ==
X-Google-Smtp-Source: ABdhPJwNlr3Xk8BEC7z5YcbAPjW8w6+3/+dYjwoTeOATU+UCkXCNrTGjHNY+VbH56DdDl559N6CXvg==
X-Received: by 2002:a63:c5a:: with SMTP id 26mr10078pgm.270.1590619080709;
        Wed, 27 May 2020 15:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u20sm3028646pfc.55.2020.05.27.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:37:59 -0700 (PDT)
Date:   Wed, 27 May 2020 15:37:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271537.75548B6@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527220532.jplypougn3qzwrms@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527220532.jplypougn3qzwrms@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:05:32AM +0200, Christian Brauner wrote:
> The main question also is, is there precedence where the kernel just
> closes the file descriptor for userspace behind it's back? I'm not sure
> I've heard of this before. That's not how that works afaict; it's also
> not how we do pidfds. We don't just close the fd when the task
> associated with it goes away, we notify and then userspace can close.

But there's a mapping between pidfd and task struct that is separate
from task struct itself, yes? I.e. keeping a pidfd open doesn't pin
struct task in memory forever, right?

-- 
Kees Cook
