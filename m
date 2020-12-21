Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8D2E0044
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgLUSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgLUSqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:46:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8DC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:45:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o13so26113161lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1NJtCKrT5aOW2x87MSIaGkuS9YMPQEi6Wvh0DzkfmQ=;
        b=WGQF0hLI1ONKDp8qNn8LUAsqCC/F9IKlBvHTrClCmrxDT9zLY1ZU6+ec+NQhNtzVvu
         FZqiru3fCqV5YvtYbFUpd13yXtge52/4d057zJrIp/0LjcPjEv9j78X3/PRSi24uDQJ3
         7Hn655r/YAKN9E2BdIZdODUXJ3Ws6w164XMv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1NJtCKrT5aOW2x87MSIaGkuS9YMPQEi6Wvh0DzkfmQ=;
        b=laCUbQW8cpcFQARf5ATdz0Dg5una3euEP7jz1PkHvSQcxVeXAGqh/8G0394BG+uh3+
         aPMRSq4ps15+5MKlXvkx7E20Wa/gvP7HifNXMZ1dJsfL3xuKSxiW+PxPrf3L8FeljavJ
         z3Roe6acTDey1Knw8B9g98xuYYBDNcqlWwPhmu7jOPyWJRmUfINqhovQa6e5AV2iZ6jD
         vRmsnDgUbe+uyy9e+mcpJNH5BEsYDJ9DFnY0XEwxLtAQUFzyzIA+E4x+1QLXigycF93i
         EJAHOY1zpAzR9j4fGdgcSW8ZSajESA1sI4pYCc+aRLvY8NeX/7eaZ+yXzPTap1lPbJfc
         ofNA==
X-Gm-Message-State: AOAM532b0p4V+0urL0jILrA5QxG47RVfAdHZfhwTnde5x3iAVt2FLVbS
        vsP2ThNDLNWpVoDV+JnLxo2LxvR72UE6tQ==
X-Google-Smtp-Source: ABdhPJwlasBwO5U5r2FqZJIe9qP5VxNxDIqbE+cg8EwvhxHfJc0wTVdnNaS3fdx5VEEkWZnni6ItoQ==
X-Received: by 2002:a19:804a:: with SMTP id b71mr6879431lfd.504.1608576323123;
        Mon, 21 Dec 2020 10:45:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w202sm2161471lff.182.2020.12.21.10.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:45:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id h22so16565103lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:45:22 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr8326818ljj.220.1608576321880;
 Mon, 21 Dec 2020 10:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20201221015214.3466681-1-sboyd@kernel.org>
In-Reply-To: <20201221015214.3466681-1-sboyd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 10:45:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJUQz6hoosBKpKtupiix1pAS6GCd1bPVK5nW8umPFzAw@mail.gmail.com>
Message-ID: <CAHk-=wiJUQz6hoosBKpKtupiix1pAS6GCd1bPVK5nW8umPFzAw@mail.gmail.com>
Subject: Re: [GIT PULL] clk changes for the merge window
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 5:52 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

Of 134 non-merge commits, 22 were committed in the last 48 hours.

I took this, but I'm somewhat pissed off about this. And the next
person who does this to me will get a blunt reply to just go and hide
in a cold, dark ditch somewhere, because between family xmas prep and
people who do things too late, I know which one matters more.

             Linus
