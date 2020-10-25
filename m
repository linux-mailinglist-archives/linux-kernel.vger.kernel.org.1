Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769929808C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767577AbgJYFva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 01:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767570AbgJYFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 01:51:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9030C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 22:51:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n18so8444096wrs.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 22:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EyC1wUuJoNDGVTQiSISpNVOiUpZLJk9AxlNcup9iaro=;
        b=eC3f2v9+iVx4V90rHSU094lMV9oUz8YymCBBWRM3mLplBLmXIp2OmdQTfCGT5vNMjr
         BxHntbhaaRpv5sRq0GXmnFs/fRTbdyuOKlEHiBl8NUdGKSFg9Q76eUUFwB661+xtQuJ6
         tXSHrJJrI3um7fKHC7r5GZgGx+YYTRmo1OkrGZZoLCL9ELW2HJn6Plag3jx+Upabdrz/
         7Uf4/tlCVnTy5WNuxARhy51sVu4YozGAMsGR9wc04DrUxeUQTbZf8lfxGKFvbHpuTc84
         iLThgNBKsPpmFayS3pNtW+ugWn0NXJL6eGdoqRQ3YdAMVCaKNcR7VthU8V9WQ89JGTWJ
         2KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EyC1wUuJoNDGVTQiSISpNVOiUpZLJk9AxlNcup9iaro=;
        b=MGrcApBIb6JxyccYKM0M9BNTqMsnAi9p1pVJxALWNidTw2frTfIbBGJ5rpzdlH8IeL
         Rv/TaJFfrA2J+KT2DAypzIFozQh/0/bUPGK9AgkoaIt+DqBLQ+qqFCdX8wbCJXNLaEak
         iTl/8WbUcToKNwVKV3WJx7VruOejpH2wkUT9qMASPwhtYMKdaNr/4TRreffOADPDYtyS
         9REPkW2H0pIbUeAVkO5sBWyoebjGZwtsJA5Q/9h2UcHnesQig1PSJLt6Po78koVwUguw
         tY1sHyeoCn8gBh1JqDg4eHVd2UuphnwImuLdX1dgRKhBG6ldJjD7iIFTO7wiVfg1qi46
         v6yw==
X-Gm-Message-State: AOAM532NpYZjZmUdN28iZQgEEu/ND1fxFwEW3zjH66xnG1IJbnrHsmKq
        IcaGTbS0onWhB+ynHAH4YuI4uZbqJTs=
X-Google-Smtp-Source: ABdhPJzrHchsx+qXnogtQWwtYHc7ZUvhGj0qp0FywB/bwATQWhB2XnOY74QhFrFV/eswfSHDBKCJ1Q==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr10918334wrp.367.1603605088206;
        Sat, 24 Oct 2020 22:51:28 -0700 (PDT)
Received: from felia ([2001:16b8:2d75:ef00:cd2e:52e:ef1c:926])
        by smtp.gmail.com with ESMTPSA id v123sm13559348wme.7.2020.10.24.22.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 22:51:27 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sun, 25 Oct 2020 06:51:19 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Aditya <yashsri421@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
In-Reply-To: <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010250627370.6697@felia>
References: <20201023133828.19609-1-yashsri421@gmail.com> <alpine.DEB.2.21.2010232104150.11676@felia> <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com> <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Oct 2020, Joe Perches wrote:

> On Sat, 2020-10-24 at 18:54 +0530, Aditya wrote:
> > > Would you like to work on 
> > > further rules that can be improved with your evaluation approach?
> > 
> > Yes, I would like work on further rules.
> 
> Some generic ideas:
> 
> How about working to reduce runtime and complexity by
> making the rules extensible or separable at startup.
> 
> Maybe move each existing rules into a separate
> directory as an individual file and aggregate them at
> checkpatch startup.
> 
> Maybe look at the existing rules that do not have a
> $fix option and add them as appropriate.
>

I certainly support working on fixes.

I have this crazy dream that:

We can identify a set of rules and clear automatic fixes that
maintainers can simply run this script over the patches they pick
up when they pick them up.
Realistically in an easy interactive mode that works with the maintainers' 
workflow, so they simply confirm the automatic fixes where the script 
cannot be 100% sure that the quick fix is the right thing to do.

I think for commit message fixes that would be very nice.
E.g., correcting URLs, normalizing tags, correcting obvious typos.
 
> You could fix the multiline indentation where the
> current warning and fix is only for a single line
> 
> 	value = function(arg1,
> 		arg2,
> 		arg3);
> 
> where checkpatch emits only single warning and fix
> for the line with arg2, but not the line with arg3);
> 
> Maybe try to make the coding styles supported more
> flexible:
> 
> Allow braces in different places, support different
> tab indentation sizes, spacing rules around operators,
> function definition layouts, etc.
> 
>

This is a nice idea as well. And I recommend to do this kind of research 
looking at checkpatch and clang-format; both will not be the 'final tools' 
but I think if you can identify a good mix and combination of those two 
tools, we will get a good step forward of documenting the 
commonalities and differences of coding styles in the different 
subcommunities (the preferences of specific maintainers and subsystems).

A last nice idea to consider:

I would like to have an interactive checkpatch.pl mode where an authors
can say that they ran checkpatch.pl, seen the warning and errors 
reported, but disagree and comment why they disagree. Then this kind of
information is added to the patch in a non-disturbing area of the patch
and we can pick up and aggregate that information from the patches to see
the complaints, false positives to address or suggestions which rules
should be disabled for some subcommunities.

Aditya, your task is now to make those ideas more specific and write down 
a one to two page project proposal for the mentorship. It can be to some 
extent in bullet points as long as it is roughly understandable to all of 
us what you plan and would like to do.

With that proposal accepted, you have shown to be applicable to the 
mentorship program here and we take care of the last organisational points 
before the start.

Lukas
