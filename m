Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6188A2EF862
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbhAHTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAHTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:49:27 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33BC061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:48:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c13so4209890pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uoA1oF1fF3QZ4WU6vcspUHgnSjM2q/ZwNJX7S6IiCU=;
        b=mA/ok4JjGugI+11xXEd/MfhrJ5Fr/ZVdHI+6yu9bh5+/W8KleQ0QT+HKYI2Zev6S8t
         iKFzAQ3t1cDF29l1ZgHp+9G8J9miMAoQFDY6dJIdjiFDCO1kfgZrGJl3z+2HtXZSqsGY
         t1R5RKeN0WHG6QMqlW25CZhIGOpp7y/OXF+FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uoA1oF1fF3QZ4WU6vcspUHgnSjM2q/ZwNJX7S6IiCU=;
        b=N8N+95VLY+Ic8K1T9tZVCroNaln8BZHbI1hye0XJ9M/BPhJ29KkHbOoOZVASN5949v
         qjapH/dA2Lqhm7DiaymYd2lN4IdooR4HiRTEkwu5QL375w2/g+yQlXPQGyupzIqH0lMA
         Y0/ZpE2a6a2VDL8x+yErAFQXqijwCJ19s8zAaAG4cmAHs0ofyR8cUkdiWyjZKzlnZszj
         /UmsA0LkssVCWzNJlHMiszk/TbQ2QyGwsqcCVYE6zAJFmnEVLixHvPhCwUYYilRnofU4
         6FT6DLY9v5ydD+c9W5r9BZ1VsXxwyTPa/Bzw4CcZohV7loZ2DZHX5uSr4UtcOakktqi0
         Rhbg==
X-Gm-Message-State: AOAM532WO94ivn7agZPZ/TTwiincaoUWQL/nMMbnp22pkD4YVGBxbLnm
        EZTdnHAga4xnTFbRIgmYjHa8Hw==
X-Google-Smtp-Source: ABdhPJx3glw3VPWk4oLRiE3Pb9mtNrtALcYoC3Z9lvJDpbg3c9QV1O9hhpFFgd+VF5Djjn/S08IF1w==
X-Received: by 2002:a63:c207:: with SMTP id b7mr8525350pgd.184.1610135327048;
        Fri, 08 Jan 2021 11:48:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm5697965pju.31.2021.01.08.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:48:45 -0800 (PST)
Date:   Fri, 8 Jan 2021 11:48:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch:
 add a new check for strcpy/strlcpy uses)
Message-ID: <202101081147.E1D29E4C8F@keescook>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
 <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
 <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
 <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
 <202101071310.3AC5F0C4@keescook>
 <9e111f0f673ae6ced12efc01d32eefe8402c7f72.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e111f0f673ae6ced12efc01d32eefe8402c7f72.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:51:31PM -0800, Joe Perches wrote:
> I still like the stracpy variant I proposed:
> 
> https://lore.kernel.org/lkml/24bb53c57767c1c2a8f266c305a670f7@sk2.org/T/#m0627aa770a076af1937cb5c610ed71dab3f1da72
> https://lore.kernel.org/lkml/CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com/
> 
> Linus liked a variant he called copy_string:
> 
> https://lore.kernel.org/lkml/CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com/
> 
> I think the cocci scripts that convert:
> 
> 	strlcpy -> strscpy (only when return value unused)
> 	str<sln>cpy(array, "string") -> stracpy(foo, "string")
> 	s[cn]printf -> sysfs_emit
> 
> would leave relatively few uses of strcpy and sprintf variants and would
> make it much easier to analyze the remainder uses for potential overflows.

I think that would be lovely; yes. :)

-- 
Kees Cook
