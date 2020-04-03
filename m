Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D319DF65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDCUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:31:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34997 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:31:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id k5so4107029pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h+4rOvQDjxWrBvyyY+SKSV4pxBwK/BDmxBdErknAJSY=;
        b=HPyRIShNVQvCeSZsbkndpk2o1v1cbbt/7NLqYUl0WMc+qhiVlhViSQBZWdb0ECkz6y
         3fjnSLNlj+CR2SQVYQWDtq4BMTPSkRCcMVVEatjnxcF1qHEW60QaSL02EvVoXvDouRvz
         OE1e41l8GpWcwAJp8Eedlp+wrRqnbrUMHoRW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+4rOvQDjxWrBvyyY+SKSV4pxBwK/BDmxBdErknAJSY=;
        b=A4kqNIN3fO5eF8vrpBpv0/LIOLVpG3+BIHymebJGqsYRQj3SPG95ND1OLoEcKAW3wo
         wpw8100PDlcb6VA1caZO562KdYBFdSBjy7XjH5YNIIBNTIvlf40z7MeW9izGh9OOl3se
         KNWvh82Adde7AHM7sSnJjTefvXLMDTu2z6nm9RwQ+O0dKwN/Doj4V3KKHVQ+pQ/rqlqJ
         SCjxuUfXegD+9dMMVbBHgKrWMMwM88mT8gVU+5R+vHXdqlTJc1X0vGomIHxK3uK7QR6+
         LoTDXiaThnlcgqyQjzXKER7m4DuZ20YpBNPLiSVl6J64+PVup53D+PpfpOgIAJc/aMqA
         I/6Q==
X-Gm-Message-State: AGi0PubiTGlbUEVJ3Ys4Q9Vfk1FCXYycDsRLoMgCd6RqyoEKd8cWb/m3
        lKyRtdkgH3u6v/U6TU2tBG2peUsrEbg=
X-Google-Smtp-Source: APiQypJ4z6/hSoM1skJKzvjuLceVWkQ9HGPBReQqEb5ukIlVP3z0QYbV8IQS8U8sbYpEBfkBf9epzA==
X-Received: by 2002:a62:750c:: with SMTP id q12mr9934247pfc.304.1585945881087;
        Fri, 03 Apr 2020 13:31:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o29sm6475384pfp.208.2020.04.03.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:31:20 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:31:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <202004031325.45B4E401@keescook>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:13:03PM +0200, Peter Zijlstra wrote:
> We're very close to enforcing W^X memory, refuse to load modules that
> violate this principle per construction.

Yikes. I never even considered modules could be built WX :( Yes please,
let's do this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
