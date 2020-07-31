Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E072F234260
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgGaJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgGaJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:21:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34192C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:21:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so4192338ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNrpXoN0P7Mw0lDt7PtL/XatWZHmnShSjWiq3ODdZQ4=;
        b=W8rDMRmVvDEfiMxVSsc0Ry+ZIZvEJDoUHD/XK9c6dGxB5rJYdWq8Th1/LAZTaiQCYC
         pb/YQ0gEAv1CNWhjD/qgrbxiq37mnqInHyZrBBtwm6yhaCm0Xbzgd8zet0tKCHLNnYXl
         ceWYTQy7CfHX1M7tezpJJUpATZQHf7CQ0ve/a2NpksQoGjz+7TbAcputXAhJAEZt7I98
         q5L+vJQQXt7y/Bb/RjuFJRRndLkLBxvTDoJ5zgLxaqtASfg+gD4XCxTnYtTPk0X6Us94
         vl3UPgV9KpgRa0z9A/JsA5cEWzXqNoc92I06OehYRzF6osx/3WzPsUNVPteJ+gAKn5qE
         IZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dNrpXoN0P7Mw0lDt7PtL/XatWZHmnShSjWiq3ODdZQ4=;
        b=kUZ7fSsqpeVWxxmJNqxp33sXDMR5shdW9G8qgtFGKakI8LDbj4OS/OuoBlkqDf99cP
         kAYp49vSB+1fPwUDihIA1/S8xMdKhLYxOGmEW5yod85u0QjxUPP57Qxo37qNeNVu3y1Z
         asrtjjJenHWyXO6Uu1XmFE6DwZ2gC15LgbgwvnozLKeR0iTnlLdErp4sqjEEsSBWAhxn
         g3tbdAiYQWjy3jg2bVJqbM5kBwAb88Yd+QFgp3RqbZESvANjCxsL3ClmDKHpYt2SGFKR
         OK+7849BPM+wf/jXDTe8t/u0tXdTGWVnCo+S1TFOQxFP2KuXnRRTY6XOQBxlAxjvOdvw
         wxtA==
X-Gm-Message-State: AOAM5320lgbo3cr43vEFYFVqpA1BOHjSWKG/jPJOQ2jevWtaNgtDU1Ia
        h6ZDsFnBMct4xy1NPt0dmGk=
X-Google-Smtp-Source: ABdhPJyoHgKwGuOqlVKlywxoBoE3NxNmtPffJ/2SwIbf3MB9FzpYde1gUCFSGbCwWng6GuOh3hEWLg==
X-Received: by 2002:a17:906:1106:: with SMTP id h6mr3165422eja.200.1596187308997;
        Fri, 31 Jul 2020 02:21:48 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s4sm8736775ejx.94.2020.07.31.02.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 02:21:48 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:21:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] x86/kaslr: Cleanup and small bugfixes
Message-ID: <20200731092146.GB2956@gmail.com>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
 <20200728225722.67457-1-nivedita@alum.mit.edu>
 <20200730180224.GA1203420@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730180224.GA1203420@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> On Tue, Jul 28, 2020 at 06:57:01PM -0400, Arvind Sankar wrote:
> > v2->v3:
> > - Fix the first patch: command line size should be strlen + 1 to account
> >   for terminating NUL. Avoid calling add_identity_map if cmdline was
> >   NULL, though it should do nothing in that case anyway.
> 
> Hi Ingo, I noticed that WIP.x86/kaslr and x86/kaslr both have the v2
> version of the first patch. That has a bug in the cmd_line_size
> calculation (missing the +1).

Indeed, well spotted. I rebased the affected 4 patches in x86/kaslr 
and used the opportunity to add Kees's Reviewed-by to the first 4 
patches as well.

I've zapped tip:x86/kaslr for now and put the whole series into 
tip:WIP.x86/kaslr, will move it into tip:x86/kaslr for a v5.9 merge 
once Kees is happy with the latest version.

Kees, AFAICS your type truncation and patch split-up review 
suggestions were resolved in v3?

Thanks,

	Ingo
